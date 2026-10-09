package com.wissam.Applier;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Import;

@Import(TestcontainersConfiguration.class)
@SpringBootTest
class ApplierApplicationTests {

  @Test
  void contextLoads() {
    // anything
    System.out.println("test");
  }

}
