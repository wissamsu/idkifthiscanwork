package com.wissam.Applier;

import org.springframework.boot.SpringApplication;

public class TestApplierApplication {

  public static void main(String[] args) {
    SpringApplication.from(ApplierApplication::main).with(TestcontainersConfiguration.class).run(args);
  }

}
