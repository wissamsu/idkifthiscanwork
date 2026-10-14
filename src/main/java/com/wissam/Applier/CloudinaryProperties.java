package com.wissam.Applier;

import org.springframework.boot.context.properties.ConfigurationProperties;

import jakarta.validation.constraints.NotBlank;

/**
 * CloudinaryProperties
 */
@ConfigurationProperties(prefix = "cloudinary")
public record CloudinaryProperties(@NotBlank(message = "Cloudinary Cloud Name is required") String cloudName,
    @NotBlank(message = "Cloudinary API Key is required") String apiKey,
    @NotBlank(message = "Cloudinary API Secret is required") String apiSecret) {

}
