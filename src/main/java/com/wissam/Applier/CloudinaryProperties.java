package com.wissam.Applier;

import org.springframework.boot.context.properties.ConfigurationProperties;

/**
 * CloudinaryProperties
 */
@ConfigurationProperties(prefix = "cloudinary")
public record CloudinaryProperties(String cloudName,
    String apiKey,
    String apiSecret) {

}
