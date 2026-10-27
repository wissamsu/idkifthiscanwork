package com.wissam.Applier.Automation;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Arrays;
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

  public void attachFilesGreenHouse(Page page, User user) {
    var resume = loadResume(user.getResumeLink());
    Locator buttons = page.locator("button[aria-label^='Attach']");

    for (int i = 0; i < 5 && buttons.count() > 0; i++) { // cap of 5 prevents an infinite loop
      FileChooser chooser = page.waitForFileChooser(() -> buttons.first().click());
      chooser.setFiles(resume);
      page.waitForTimeout(500); // let the form re-render
    }
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
        page.keyboard().press("Escape");
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

  public void fillAnswersGreenHouse(Page page, User user, Locator contentBox, MultipartFile resume) {
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
      Answers answerFound = answersRepo.findFirstByUser_IdAndQuestion(user.getId(), question)
          .orElseGet(() -> {
            Answers empty = new Answers();
            empty.setAnswer("");
            return empty;
          });

      if (page.locator("input[type='text'][id='" + id + "']").count() > 0) {
        if (!answerFound.getAnswer().isBlank() && page.locator("input[type='text'][id='" + id + "']").isEnabled()) {
          page.locator("input[type='text'][id='" + id + "']").fill(answerFound.getAnswer().strip());
          continue;
        }
        String answer = chatClient.prompt().system(base + "Reply with ONLY the value for the field, no sentence.")
            .user(question)
            .call()
            .content();
        System.out.println(answer);
        if (!answer.isBlank() && page.locator("input[type='text'][id='" + id + "']").isEnabled()) {
          Answers answerAdd = Answers.builder().user(user).question(question).answer(answer).build();
          answersRepo.save(answerAdd);
          page.locator("input[type='text'][id='" + id + "']").fill(answer.strip());
        }
      } else if (page.locator("input[type='tel'][id='" + id + "']").count() > 0) {
        if (!answerFound.getAnswer().isBlank() && page.locator("input[type='tel'][id='" + id + "']").isEnabled()) {
          page.locator("input[type='tel'][id='" + id + "']").fill(answerFound.getAnswer().strip());
          continue;
        }
        String answer = chatClient.prompt().system(base + "Reply with ONLY the value for the field, no sentence.")
            .user(question)
            .call()
            .content();
        System.out.println(answer);
        if (!answer.isBlank() && page.locator("input[type='tel'][id='" + id + "']").isEnabled()) {
          Answers answerAdd = Answers.builder().user(user).question(question).answer(answer).build();
          answersRepo.save(answerAdd);
          page.locator("input[type='tel'][id='" + id + "']").fill(answer.strip());
        }
      } else if (page.locator("input[role='combobox'][aria-labelledby='" + id + "-label'][id^='react-select-']")
          .count() > 0) {
        Locator combobox = page
            .locator("input[role='combobox'][aria-labelledby='" + id + "-label'][id^='react-select-']");

        String saved = answerFound.getAnswer().strip();

        // the menu only exists while open
        combobox.click();
        String listboxId = combobox.getAttribute("aria-controls");
        Locator listbox = page.locator("[id='" + listboxId + "']");
        Locator allOptions = listbox.locator("[role='option']");

        boolean hasPreloadedOptions;
        try {
          allOptions.first().waitFor(new Locator.WaitForOptions().setTimeout(2000));
          hasPreloadedOptions = true;
        } catch (com.microsoft.playwright.TimeoutError e) {
          hasPreloadedOptions = false;
        }

        if (!hasPreloadedOptions) {
          // typeahead (e.g. Location): type a query, then pick from the results
          String query = saved;
          if (query.isBlank()) {
            query = chatClient.prompt()
                .system(base
                    + "Reply with ONLY with a direct answer for this field for example if the question asks for candidate's location or city and state,answer like like 'Beckley, WV'. No sentence.")
                .user(question)
                .call()
                .content()
                .strip();
          }

          combobox.pressSequentially(query, new Locator.PressSequentiallyOptions().setDelay(80));

          // candidates: full text, then just the part before the first comma
          String city = query.contains(",") ? query.substring(0, query.indexOf(',')).strip() : query;
          List<String> attempts = city.equals(query) ? List.of(query) : List.of(query, city);

          boolean picked = false;
          for (String attempt : attempts) {
            if (!attempt.equals(query)) {
              // retype with the shorter text
              combobox.press("Control+A");
              combobox.press("Backspace");
              combobox.pressSequentially(attempt, new Locator.PressSequentiallyOptions().setDelay(80));
            }

            try {
              // wait for a real option; "Loading..." and "No options" are not role=option
              allOptions.first().waitFor(new Locator.WaitForOptions().setTimeout(8000));
            } catch (com.microsoft.playwright.TimeoutError e) {
              continue; // nothing came back, try the shorter query
            }

            // prefer an option containing the city, else take the first
            Locator best = allOptions.filter(new Locator.FilterOptions().setHasText(city));
            if (best.count() > 0) {
              best.first().click();
            } else {
              allOptions.first().click();
            }
            picked = true;
            answersRepo.save(Answers.builder().user(user).question(question).answer(attempt).build());
            break;
          }

          if (!picked) {
            System.out.println("Skipping '" + question + "': no suggestions for '" + query + "'");
            combobox.press("Escape");
            continue;
          }
          continue;
        }

        // preloaded list (e.g. Country)
        String answer = saved.replaceAll("\\s*\\+\\d+$", "");

        if (answer.isBlank()) {
          List<String> options = allOptions.allInnerTexts().stream()
              .map(o -> o.strip().replaceAll("\\s*\\+\\d+$", ""))
              .toList();

          answer = chatClient.prompt()
              .system(base + "Reply with ONLY one of these options, exactly as written: "
                  + String.join(" | ", options)
                  + ". Pick the country the candidate lives in or is applying from.")
              .user(question)
              .call()
              .content()
              .strip();
        }

        List<String> texts = allOptions.allInnerTexts();
        int idx = -1;
        for (int i = 0; i < texts.size(); i++) {
          String name = texts.get(i).strip().replaceAll("\\s*\\+\\d+$", "");
          if (name.equalsIgnoreCase(answer)) {
            idx = i;
            break;
          }
        }

        if (idx == -1) {
          System.out.println("Skipping '" + question + "': no country option matched '" + answer + "'");
          combobox.press("Escape");
          continue;
        }

        answersRepo.save(Answers.builder().user(user).question(question).answer(answer).build());
        allOptions.nth(idx).click();
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

      String answer = answersRepo.findFirstByUser_IdAndQuestion(user.getId(), question)
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
    for (Locator group : contentBox.locator("fieldset.checkbox").all()) {
      System.out.println("reached");
      // skip groups that already have a selection
      if (group.locator("input[type='checkbox']:checked").count() > 0)
        continue;

      String question = group.locator("legend").innerText()
          .replaceAll("\\s+", " ")
          .replaceAll("\\s*\\(required\\)\\s*$", "")
          .replaceAll("\\s*\\*$", "") // legend ends with the required asterisk
          .strip();

      Locator optionlabels = group.locator("label");
      List<String> options = optionlabels.allInnerTexts().stream()
          .map(String::strip)
          .toList();

      boolean checkAll = question.toLowerCase().contains("which location");

      String answer;
      List<String> wanted;

      if (checkAll) {
        // always select every location option, no model call needed
        wanted = options;
        answer = String.join(" | ", options);
      } else {
        answer = answersRepo.findFirstByUser_IdAndQuestion(user.getId(), question)
            .map(Answers::getAnswer)
            .map(String::strip)
            .orElse("");

        if (answer.isBlank()) {
          answer = chatClient.prompt()
              .system(base
                  + "Reply with ONLY the option(s) to check, exactly as written, separated by ' | '. "
                  + "Options: " + String.join(" | ", options)
                  + ". Pick one unless the question clearly calls for several. "
                  + "If the resume does not contain the answer, reply with the best case answer.")
              .user(question)
              .call()
              .content()
              .strip();
        }

        wanted = Arrays.stream(answer.split("\\|"))
            .map(String::strip)
            .toList();
      }

      Locator inputs = group.locator("input[type='checkbox']");
      boolean any = false;
      for (int i = 0; i < options.size(); i++) {
        String opt = options.get(i);
        if (wanted.stream().anyMatch(w -> w.equalsIgnoreCase(opt))) {
          Locator lbl = optionlabels.nth(i);
          lbl.scrollIntoViewIfNeeded();
          lbl.click();

          // fall back to JS if the click didn't register
          if (!inputs.nth(i).isChecked()) {
            inputs.nth(i).evaluate(
                "el => { el.checked = true;"
                    + " el.dispatchEvent(new Event('input', {bubbles:true}));"
                    + " el.dispatchEvent(new Event('change', {bubbles:true})); }");
          }
          any = true;
        }
      }

      if (!any) {
        System.out.println("Skipping '" + question + "': answer was '" + answer + "'");
        continue;
      }

      answersRepo.save(Answers.builder().user(user).question(question).answer(answer).build());
    }
    Locator consentBoxes = contentBox.locator(
        "input[type='checkbox'][required]:not(fieldset input)");
    for (Locator box : consentBoxes.all()) {
      if (box.isChecked())
        continue;

      String boxId = box.getAttribute("id");
      Locator lbl = contentBox.locator("label[for='" + boxId + "']");
      lbl.scrollIntoViewIfNeeded();
      lbl.click();

      // fall back to JS if the click didn't register
      if (!box.isChecked()) {
        box.evaluate(
            "el => { el.checked = true;"
                + " el.dispatchEvent(new Event('input', {bubbles:true}));"
                + " el.dispatchEvent(new Event('change', {bubbles:true})); }");
      }
      System.out.println("consent checked: " + boxId + " -> " + box.isChecked());
    }
    page.getByText("Submit application").click();
    page.waitForTimeout(1000);
    page.getByText("Browse more jobs").click();
    page.waitForTimeout(1000);
    System.out.println("applied to job");
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
      Answers answerFound = answersRepo.findFirstByUser_IdAndQuestion(user.getId(), question)
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

      String answer = answersRepo.findFirstByUser_IdAndQuestion(user.getId(), question)
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
