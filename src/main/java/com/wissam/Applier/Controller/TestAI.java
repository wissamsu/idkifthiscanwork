package com.wissam.Applier.Controller;

import java.util.Set;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.wissam.Applier.AiTooling.AiTools;
import com.wissam.Applier.Automation.ApplyAuto;
import com.wissam.Applier.Model.User;
import com.wissam.Applier.Repository.UserRepository;

import lombok.RequiredArgsConstructor;

/**
 * TestAI
 */
@RestController
@RequestMapping("/testAi")
@RequiredArgsConstructor
public class TestAI {

  private final ChatClient chatClient;
  private final AiTools aiTools;
  private final ApplyAuto applyAuto;
  private final UserRepository userRepository;

  private final Set<UUID> running = ConcurrentHashMap.newKeySet();

  @PostMapping(value = "/greenhouse")
  public void automateGreenHouse(@AuthenticationPrincipal OidcUser oidcUser) {

    User user2 = userRepository.findByEmail(oidcUser.getEmail())
        .orElseThrow(() -> new IllegalArgumentException("User not found"));

    if (!running.add(user2.getId())) {
      return;
    }
    try {
      for (int i = 0; i < 100; i++) {
        applyAuto.skimJobsGreenHouse(user2, aiTools.urlToMultipartFile(user2.getResumeLink()));
      }
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  @PostMapping(value = "/handshake")
  public void automate(@AuthenticationPrincipal OidcUser oidcUser) {
    User user2 = userRepository.findByEmail(oidcUser.getEmail())
        .orElseThrow(() -> new IllegalArgumentException("User not found"));
    try {
      applyAuto.skimJobs(user2, aiTools.urlToMultipartFile(user2.getResumeLink()));
    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  @PostMapping(path = "/pdf", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
  public String postMethodName(MultipartFile file, String question) {
    return chatClient.prompt(aiTools.getResumeText(file) + question).call()
        .content();
  }

}
