package com.wissam.Applier.Service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import com.wissam.Applier.Model.User;
import com.wissam.Applier.Repository.UserRepository;

import lombok.RequiredArgsConstructor;

/**
 * CloudinaryService
 */
@Service
@RequiredArgsConstructor
public class CloudinaryService {

  private final UserRepository userRepo;
  private final Cloudinary cloudinary;

  @Transactional
  public String uploadResume(User user, MultipartFile file) {
    if (file.isEmpty()) {
      throw new IllegalArgumentException("Resume file must not be empty");
    }

    try {
      String original = file.getOriginalFilename();
      String publicId = user.getId() + "/" + sanitize(original);

      var uploadResult = cloudinary.uploader().upload(
          file.getBytes(),
          ObjectUtils.asMap(
              "resource_type", "raw",
              "folder", "resumes",
              "public_id", publicId,
              "use_filename", true,
              "unique_filename", false,
              "overwrite", true));

      String resumeUrl = uploadResult.get("secure_url").toString();
      user.setResumeLink(resumeUrl);
      userRepo.save(user);

      return resumeUrl;

    } catch (Exception e) {
      throw new RuntimeException("Failed to upload resume to Cloudinary", e);
    }
  }

  private String sanitize(String filename) {
    String name = (filename == null || filename.isBlank()) ? "resume.pdf" : filename;
    name = name.replaceAll("[^A-Za-z0-9._-]", "_");
    if (!name.toLowerCase().endsWith(".pdf")) {
      name += ".pdf";
    }
    return name;
  }
}
