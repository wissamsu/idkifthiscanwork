package com.wissam.Applier;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * Selectors
 */
@ConfigurationProperties(prefix = "selectors")
public record Selectors(String jobsList,
    String quickApplyButton,
    String easyApplyResumeUpload,
    String numberOfPages,
    String normalApplyButton) {
}
