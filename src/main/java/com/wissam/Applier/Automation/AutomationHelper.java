package com.wissam.Applier.Automation;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Component;

import com.microsoft.playwright.Locator;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.options.FilePayload;
import com.wissam.Applier.Selectors;
import com.wissam.Applier.Model.User;

import lombok.RequiredArgsConstructor;

/**
 * AutomationHelper
 */
@Component
@RequiredArgsConstructor
public class AutomationHelper {

  private final HttpClient http = HttpClient.newHttpClient();
  private final ConcurrentHashMap<String, FilePayload> resumeCache = new ConcurrentHashMap<>();

  private final Selectors selectors;

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
    for (Locator option : page.locator("option[label$='.pdf']").all()) {
      int i = option.count();
      page.locator("Search your").fill("W");
      option.click();
    }

    for (Locator input : page.locator(selectors.easyApplyResumeUpload()).all()) {
      input.setInputFiles(loadResume(user.getResumeLink()));
    }
  }

  public void fillAnswers(Page page, User user) {
    fillAnswers(page, user, null);
  }

  public void fillAnswers(Page page, User user, Locator contentBox) {
    if (contentBox != null) {
      Locator labels = contentBox.locator("label[for]");
      for (Locator label : labels.all()) {
        findElementFromLabelFor(page, label);
      }
    } else {

    }
  }

  public Locator findElementFromLabelFor(Page page, Locator label) {
    String targetId = label.getAttribute("for");
    Locator target = page.locator("#" + targetId);
    System.out.println(target.getAttribute("name"));
    return target;
  }

  public void submitAndBypass(Page page) {
    page.getByText("Submit Application").click();
    page.waitForTimeout(3000);
    if (page.getByText("Skip for now").count() > 0) {
      page.getByText("Skip for now").click();
    }
  }

}
