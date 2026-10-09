package com.wissam.Applier.Automation;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.springframework.beans.factory.ObjectProvider;
import org.springframework.stereotype.Component;

import com.microsoft.playwright.Browser;
import com.microsoft.playwright.BrowserContext;
import com.microsoft.playwright.BrowserContext.StorageStateOptions;
import com.microsoft.playwright.Page;
import com.wissam.Applier.Model.User;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * LoginAuto
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class LoginAuto {

  private final ObjectProvider<BrowserContext> contextProvider;
  private final Browser browser;

  public Page oktaLogin(User user) {
    Path statePath = Paths.get(user.getEmail() + ".json");
    BrowserContext context = contextProvider.getObject(browser, statePath);
    Page page = context.newPage();
    try {
      page.navigate("https://wvu.joinhandshake.com/home");
      page.waitForTimeout(5000);
      if (page.url().startsWith("https://wvu.joinhandshake.com/home")) {
        return page;
      }
      context.clearCookies();
      log.info("logging in");
      page.navigate("https://app.joinhandshake.com/access");
      page.getByPlaceholder("email").fill(user.getEmail());
      page.getByText("Continue with email").click();
      page.getByText("Continue to").click();
      page.locator("input[placeholder]").fill(user.getEmail());
      page.locator("input[type='submit']").click();
      page.getByText("Verify with your password").waitFor();
      page.locator("input[placeholder]").fill("Dontplay.12345");
      page.locator("input[type='submit']").click();
      page.locator("a[aria-label='Select to get a push notification to the Okta Verify app.']").click();
      page.waitForTimeout(10000);
      context.storageState(new StorageStateOptions().setPath(statePath));

      return page;
    } catch (Exception e) {
      log.error(e.getMessage());
      context.close();
      throw new RuntimeException("Okta login failed");
    }
  }

}
