package com.wissam.Applier.Automation;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.microsoft.playwright.Locator;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.options.LoadState;
import com.wissam.Applier.Selectors;
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

  public void skimJobs(User user, MultipartFile file) {
    if (user.getResumeLink() == null) {
      throw new RuntimeException("Resume link is null");
    }
    Page page = loginAuto.oktaLogin(user);
    page.navigate("https://wvu.joinhandshake.com/job-search/query=java");
    Locator jobsList = page.locator(selectors.jobsList());
    int numberOfPages = Integer.parseInt(page.locator(selectors.numberOfPages()).nth(3).textContent());
    for (int j = 1; j < numberOfPages; j++) {
      page.navigate("https://wvu.joinhandshake.com/job-search/11425383?page=" + j + "&per_page=25");
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
  }

  public void normalApply(Page page, User user, MultipartFile file) {
    page.locator(selectors.normalApplyButton()).first().click();
    automationHelper.attachFiles(page, user);
    automationHelper.fillAnswers(page, user, page.locator(selectors.contentBox()), file);
    automationHelper.submitAndBypass(page);
  }

  public boolean withdrawApplication(Page page, User user) {
    if (page.getByText("Withdraw Application").count() > 0) {
      return true;
    }
    return false;
  }
}
