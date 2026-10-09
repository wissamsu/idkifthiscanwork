package com.wissam.Applier.AiTooling;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * TalkToModel
 */
@Configuration
public class TalkToModel {

  @Bean
  ChatClient chatClient(ChatClient.Builder builder) {
    return builder.defaultSystem(
        """
            You are a helpful assistant specializing in giving back nothing else but the simplest answers to questions which most of the time will
            be one word and one number answers like for example if a questions asks for how many years of experience only give the number of years dont say the number then follow by years!""")
        .build();
  }

}
