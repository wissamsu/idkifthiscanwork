package com.wissam.Applier;

import java.util.List;
import java.util.Random;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.microsoft.playwright.Browser;
import com.microsoft.playwright.Browser.NewContextOptions;
import com.microsoft.playwright.BrowserContext;
import com.microsoft.playwright.BrowserType.LaunchOptions;
import com.microsoft.playwright.Page;
import com.microsoft.playwright.Playwright;
import com.microsoft.playwright.assertions.PlaywrightAssertions;

import lombok.extern.slf4j.Slf4j;

/**
 * PlaywrightOktaLoginTest
 */
@SpringBootTest
@Slf4j
public class PlaywrightOktaLoginTest {

  @Autowired
  ConfigProperties configProps;

  static Playwright playwright;
  static Browser browser;
  BrowserContext context;
  Page page;

  @BeforeAll
  static void launchBrowser() {
    int randomSlowMo = new Random().nextInt(2000);
    playwright = Playwright.create();
    browser = playwright.chromium().launch(new LaunchOptions().setHeadless(true).setSlowMo(randomSlowMo)
        .setArgs(List.of("--disable-blink-features=AutomationControlled")));
  }

  @AfterAll
  static void closeBrowser() {
    browser.close();
    playwright.close();
  }

  @BeforeEach
  public void newContext() {
    context = browser.newContext(new NewContextOptions().setViewportSize(1920, 1080)
        .setUserAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
            + "(KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36")
        .setLocale("en-US")
        .setTimezoneId("America/New_York"));
    page = context.newPage();
  }

  @AfterEach
  public void closeContext() {
    context.close();
  }

  @Test
  public void oktaLoginTest(){
    page.navigate("https://app.joinhandshake.com/access");
      page.getByPlaceholder("email").fill(configProps.email());
      page.getByText("Continue with email").click();
      page.getByText("Continue to").click();
      page.locator("input[placeholder]").fill(configProps.email());
      page.locator("input[type='submit']").click();
      page.getByText("Verify with your password").waitFor();
      page.locator("input[placeholder]").fill(configProps.password());
      page.locator("input[type='submit']").click();
      page.locator("a[aria-label='Select to get a push notification to the Okta Verify app.']").click();
      page.waitForTimeout(10000);
      log.info(page.url());
      PlaywrightAssertions.assertThat(page).hasURL("https://app.joinhandshake.com/home");
  }

}
