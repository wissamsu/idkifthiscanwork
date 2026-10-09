package com.wissam.Applier.Configs;

import java.util.Map;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.cloudinary.Cloudinary;
import com.wissam.Applier.CloudinaryProperties;

import lombok.RequiredArgsConstructor;

/**
 * Cloudinary
 */
@Configuration
@RequiredArgsConstructor
public class CloudinaryConfig {

  private final CloudinaryProperties cloudinaryProps;

  @Bean
  Cloudinary cloudinary() {
    return new Cloudinary(Map.of(
        "cloud_name", cloudinaryProps.cloudName(),
        "api_key", cloudinaryProps.apiKey(),
        "api_secret", cloudinaryProps.apiSecret()));
  }

}
