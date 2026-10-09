package com.wissam.Applier;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * ConfigProperties
 */
@ConfigurationProperties(prefix = "playwright.test")
public record ConfigProperties(
    String email,
    String password) {
}
