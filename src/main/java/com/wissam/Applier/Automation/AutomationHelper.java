package com.wissam.Applier.Automation;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.regex.Pattern;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.microsoft.playwright.FileChooser;
import com.microsoft.playwright.Locator;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.TimeoutError;
import com.microsoft.playwright.options.AriaRole;
import com.microsoft.playwright.options.FilePayload;
import com.microsoft.playwright.options.WaitForSelectorState;
import com.wissam.Applier.AiTooling.AiTools;
import com.wissam.Applier.Model.Answers;
import com.wissam.Applier.Model.User;
import com.wissam.Applier.Repository.AnswersRepository;

import lombok.RequiredArgsConstructor;

/**
 * AutomationHelper
 */
@Component
@RequiredArgsConstructor
public class AutomationHelper {

  private final HttpClient http = HttpClient.newHttpClient();
  private final ConcurrentHashMap<String, FilePayload> resumeCache = new ConcurrentHashMap<>();
  private final ChatClient chatClient;
  private final AiTools aiTools;
  private final AnswersRepository answersRepo;

  public FilePayload loadResume(String resumeUrl) {
    return resumeCache.computeIfAbsent(resumeUrl, url -> {
      try {
        HttpResponse<byte[]> res = http.send(
            HttpRequest.newBuilder(URI.create(url)).GET().build(),
            HttpResponse.BodyHandlers.ofByteArray());

        if (res.statusCode() != 200) {
          throw new IllegalStateException("Could not download resume: HTTP " + res.statusCode());
        }

        String fileName = url.substring(url.lastIndexOf('/') + 1);
        return new FilePayload(fileName, "application/pdf", res.body());
      } catch (Exception e) {
        throw new RuntimeException(e);
      }
    });
  }

  public void attachFiles(Page page, User user) {
    Locator combos = page.getByPlaceholder(Pattern.compile("^Search your"));

    int guard = 0;
    while (combos.count() > 0 && guard++ < 10) {
      int before = combos.count();
      Locator combo = combos.first();
      combo.click();

      String listboxId = combo.getAttribute("aria-controls");
      Locator firstOption = page.locator("#" + listboxId).getByRole(AriaRole.OPTION).first();

      boolean hasOption;
      try {
        firstOption.waitFor(new Locator.WaitForOptions()
            .setState(WaitForSelectorState.VISIBLE)
            .setTimeout(2000));
        hasOption = true;
      } catch (TimeoutError e) {
        hasOption = false;
      }

      if (hasOption) {
        firstOption.click();
      } else {
        page.keyboard().press("Escape"); // close the empty dropdown
        Locator uploadBtn = page.getByRole(AriaRole.BUTTON,
            new Page.GetByRoleOptions().setName("Upload new")).first();
        FileChooser chooser = page.waitForFileChooser(() -> uploadBtn.click());
        chooser.setFiles(loadResume(user.getResumeLink()));
      }

      for (int t = 0; t < 20 && combos.count() >= before; t++) {
        page.waitForTimeout(500);
      }
    }
  }

  public void fillAnswers(Page page, User user, Locator contentBox, MultipartFile resume) {
    String resumeText = aiTools.getResumeText(resume);
    String base = "You fill out job applications for this candidate. "
        + "Use ONLY the resume below. If it does not contain the answer, reply with the best case answer.\n\n"
        + "RESUME:\n" + resumeText + "\n\n";
    Locator labels = contentBox.locator("label:not(.rosetta-radio__label)");
    for (Locator label : labels.all()) {
      String id = label.getAttribute("for");
      if (id == null)
        continue;
      String question = label.innerText().strip()
          .replaceAll("\\s+", " ")
          .replaceAll("\\s*\\(required\\)\\s*$", "");
      Answers answerFound = answersRepo.findAnswerByUser_IdAndQuestion(user.getId(), question)
          .orElseGet(() -> {
            Answers empty = new Answers();
            empty.setAnswer("");
            return empty;
          });

      if (page.locator("input[type='text'][id='" + id + "']").count() > 0) {
        if (!answerFound.getAnswer().isBlank()) {
          page.locator("input[type='text'][id='" + id + "']").fill(answerFound.getAnswer().strip());
          continue;
        }
        String answer = chatClient.prompt().system(base + "Reply with ONLY the value for the field, no sentence.")
            .user(question)
            .call()
            .content();
        System.out.println(answer);
        if (!answer.isBlank()) {
          Answers answerAdd = Answers.builder().user(user).question(question).answer(answer).build();
          answersRepo.save(answerAdd);
          page.locator("input[type='text'][id='" + id + "']").fill(answer.strip());
        }
      } else if (page.locator("[role='combobox'][aria-labelledby='" + id + "-label']").count() > 0) {
        Locator combobox = page.locator("[role='combobox'][aria-labelledby='" + id + "-label']");
        Locator listbox = page.locator("[id='listbox-id-" + id + "']");

        String saved = answerFound.getAnswer().strip();
        String answer = saved;

        if (answer.isBlank()) {
          List<String> options = listbox.locator("[role='option']")
              .allInnerTexts().stream()
              .map(String::strip)
              .filter(o -> !o.equalsIgnoreCase("Select One"))
              .toList();

          answer = chatClient.prompt()
              .system(base + "Reply with ONLY one of these options, exactly as written: "
                  + String.join(" | ", options)
                  + ". If the resume does not contain the answer, reply with the best case answer.")
              .user(question)
              .call()
              .content()
              .strip();

          final String modelAnswer = answer;
          String match = options.stream()
              .filter(o -> o.equalsIgnoreCase(modelAnswer))
              .findFirst().orElse(null);

          if (match == null) {
            System.out.println("Skipping '" + question + "': model answered '" + answer + "'");
            continue;
          }
          answer = match;
        }

        Answers answerAdd = Answers.builder().user(user).question(question).answer(answer).build();
        answersRepo.save(answerAdd);
        combobox.click();
        listbox.getByText(answer, new Locator.GetByTextOptions().setExact(true)).click();
      }
    }
    for (Locator group : contentBox.locator("fieldset.rosetta-radio-group").all()) {
      // skip groups that already have a selection
      if (group.locator("input[type='radio']:checked").count() > 0)
        continue;

      String question = group.locator("legend").innerText()
          .replaceAll("\\s+", " ")
          .replaceAll("\\s*\\(required\\)\\s*$", "")
          .strip();

      List<String> options = group.locator("input[type='radio']").all().stream()
          .map(r -> r.getAttribute("aria-label"))
          .toList();

      String answer = answersRepo.findAnswerByUser_IdAndQuestion(user.getId(), question)
          .map(Answers::getAnswer)
          .map(String::strip)
          .orElse("");

      // no saved answer -> ask the model, constrained to the options
      if (answer.isBlank()) {
        answer = chatClient.prompt()
            .system(base
                + "Reply with ONLY one of these options, exactly as written: "
                + String.join(" | ", options)
                + ". If the resume does not contain the answer, reply with the best case answer.")
            .user(question)
            .call()
            .content()
            .strip();
      }

      final String finalAnswer = answer;

      Answers answerAdd = Answers.builder().user(user).question(question).answer(answer).build();
      answersRepo.save(answerAdd);
      String match = options.stream()
          .filter(o -> o.equalsIgnoreCase(finalAnswer))
          .findFirst().orElse(null);

      if (match == null) {
        System.out.println("Skipping '" + question + "': answer was '" + answer + "'");
        continue;
      }

      String inputId = group.locator("input[type='radio'][aria-label='" + match + "']")
          .getAttribute("id");
      group.locator("label[for='" + inputId + "']").click();
    }
  }

  public Locator findElementFromLabelFor(Page page, Locator label) {
    String targetId = label.getAttribute("for");
    Locator target = page.locator("#" + targetId);
    System.out.println(target.getAttribute("name"));
    return target;
  }

  public void submitAndBypass(Page page) {
    Locator submit = page.getByText("Submit Application");
    submit.click();
    while (submit.isDisabled()) {
      System.out.println("Waiting for button to be enabled");
      page.waitForTimeout(2000);
    }
    int tries = 0;
    while (submit.isVisible() && tries++ < 30) {
      System.out.println("Waiting for submission to finish");
      page.waitForTimeout(1000);
    }

    page.waitForTimeout(3000);
    if (page.getByText("Skip for now").count() > 0) {
      page.getByText("Skip for now").click();
    }
  }

}
