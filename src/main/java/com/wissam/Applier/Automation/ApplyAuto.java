package com.wissam.Applier.Automation;

import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.microsoft.playwright.Locator;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.options.LoadState;
import com.wissam.Applier.Selectors;
import com.wissam.Applier.AiTooling.AiTools;
import com.wissam.Applier.Model.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * ApplyAuto
 */
@Component
@RequiredArgsConstructor
@Slf4j
public class ApplyAuto {

  private final LoginAuto loginAuto;
  private final Selectors selectors;
  private final AutomationHelper automationHelper;
  private final Set<UUID> running = ConcurrentHashMap.newKeySet();
  private final AiTools aiTools;

  public void skimJobs(User user, MultipartFile file) {
    if (user.getResumeLink() == null) {
      throw new RuntimeException("Resume link is null");
    }
    Page page = loginAuto.oktaLogin(user);
    page.navigate("https://wvu.joinhandshake.com/job-search/query=java");
    Locator jobsList = page.locator(selectors.jobsList());
    int numberOfPages = Integer.parseInt(page.locator(selectors.numberOfPages()).nth(3).textContent());
    for (int j = 1; j < numberOfPages; j++) {
      page.navigate("https://wvu.joinhandshake.com/job-search/?query=java&page=" + j + "&per_page=25");
      page.waitForLoadState(LoadState.DOMCONTENTLOADED);
      for (int i = 0; i < jobsList.count(); i++) {
        jobsList.nth(i).click();
        if (withdrawApplication(page, user)) {
          continue;
        }
        if (page.locator(selectors.quickApplyButton()).count() > 0) {
          easyApply(page, user);
          continue;
        }
        if (page.locator(selectors.normalApplyButton()).count() > 0) {
          normalApply(page, user, file);
          continue;
        }
      }
      if (j == numberOfPages - 1) {
        page.close();
        return;
      }
    }
  }

  public void easyApply(Page page, User user) {
    page.locator(selectors.quickApplyButton()).first().click();
    automationHelper.attachFiles(page, user);
    automationHelper.submitAndBypass(page);
    log.info("Application submitted");
  }

  public void normalApply(Page page, User user, MultipartFile file) {
    page.locator(selectors.normalApplyButton()).first().click();
    automationHelper.attachFiles(page, user);
    automationHelper.fillAnswers(page, user, page.locator(selectors.contentBox()), file);
    automationHelper.submitAndBypass(page);
    log.info("Application submitted");
  }

  public boolean withdrawApplication(Page page, User user) {
    if (page.getByText("Withdraw Application").count() > 0) {
      return true;
    }
    return false;
  }

  @Async
  public void skimJobsGreenHouse(User user, MultipartFile resume) {
    if (user.getResumeLink() == null) {
      throw new RuntimeException("Resume link is null");
    }
    Page page = loginAuto.loginGreenHouse(user);
    page.navigate("https://my.greenhouse.io/jobs/search?query=java");

    Locator jobs = page.locator("div[data-provides='search-result']");
    for (Locator job : jobs.all()) {
      job.locator("a").click();
      Locator contentBox = page.locator("div[data-slot='dialog-content']");
      automationHelper.attachFilesGreenHouse(page, user);
      automationHelper.fillAnswersGreenHouse(page, user, contentBox, resume);
      job.scrollIntoViewIfNeeded();
    }
  }

  @Async
  public void runAutomation100Times(User user) {
    if (!running.add(user.getId())) {
      return;
    }

    try {
      for (int i = 1; i <= 100; i++) {
        System.out.println("Running iteration " + i + " of 100 for user: " + user.getId());
        try {
          skimJobsGreenHouse(user, aiTools.urlToMultipartFile(user.getResumeLink()));
        } catch (Exception e) {
          e.printStackTrace();
          break;
        }

        Thread.sleep(2000);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      running.remove(user.getId());
    }
  }

}
