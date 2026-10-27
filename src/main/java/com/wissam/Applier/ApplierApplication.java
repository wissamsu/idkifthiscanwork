package com.wissam.Applier;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.context.properties.ConfigurationPropertiesScan;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync
@ConfigurationPropertiesScan
public class ApplierApplication {

  public static void main(String[] args) {
    SpringApplication.run(ApplierApplication.class, args);
  }

}
