package com.wissam.Applier.Automation.Config;

import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.Random;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.context.annotation.Scope;

import com.microsoft.playwright.Browser;
import com.microsoft.playwright.Browser.NewContextOptions;
import com.microsoft.playwright.BrowserContext;
import com.microsoft.playwright.BrowserType.LaunchOptions;
import com.microsoft.playwright.Playwright;

/**
 * PlaywrightConfig
 */
@Configuration
public class PlaywrightConfig {

  Random random = new Random();

  @Bean(destroyMethod = "close")
  Playwright playwright() {
    return Playwright.create();
  }

  @Bean
  @Lazy
  Browser browser(Playwright playwright) {

    int randomSlowMo = random.nextInt(2000);
    return playwright.chromium().launch(new LaunchOptions().setHeadless(false).setSlowMo(randomSlowMo)
        .setArgs(List.of("--disable-blink-features=AutomationControlled")));
  }

  @Bean
  @Scope("prototype")
  BrowserContext browserContext(Browser browser, Path statePath) {
    NewContextOptions options = new NewContextOptions().setViewportSize(1920, 1080)
        .setUserAgent("Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 "
            + "(KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36")
        .setLocale("en-US")
        .setTimezoneId("America/New_York");
    if (statePath != null && Files.exists(statePath)) {
      options.setStorageStatePath(statePath);
    }
    return browser.newContext(options);
  }

}
