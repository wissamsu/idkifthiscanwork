package com.wissam.Applier.Controller;

import org.springframework.http.MediaType;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.oauth2.core.oidc.user.OidcUser;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.wissam.Applier.Model.User;
import com.wissam.Applier.Repository.UserRepository;
import com.wissam.Applier.Service.CloudinaryService;

import lombok.RequiredArgsConstructor;

/**
 * CloudinaryController
 */
@RestController
@RequiredArgsConstructor
@RequestMapping("/cloudinary")
public class CloudinaryController {

  private final CloudinaryService cloudinaryService;
  private final UserRepository userRepo;

  @PostMapping(path = "/resume", consumes = MediaType.MULTIPART_FORM_DATA_VALUE, produces = MediaType.TEXT_PLAIN_VALUE)
  public String uploadResume(@AuthenticationPrincipal OidcUser oidcUser, MultipartFile file) {
    if (oidcUser == null) {
      throw new IllegalArgumentException("User not authenticated");
    }
    User user = userRepo.findByEmail(oidcUser.getEmail())
        .orElseThrow(() -> new IllegalArgumentException("User not found"));
    return cloudinaryService.uploadResume(user, file);
  }

}
