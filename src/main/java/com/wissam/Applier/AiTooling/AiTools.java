package com.wissam.Applier.AiTooling;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.document.Document;
import org.springframework.ai.reader.pdf.PagePdfDocumentReader;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class AiTools {

  private final ChatClient chatClient;

  public MultipartFile urlToMultipartFile(String urlString) throws Exception {
    byte[] bytes = URI.create(urlString).toURL().openStream().readAllBytes();

    String extractedName = urlString.substring(urlString.lastIndexOf('/') + 1);
    final String fileName = (extractedName.isEmpty() || !extractedName.contains("."))
        ? "document.pdf"
        : extractedName;

    return new MultipartFile() {
      @Override
      public String getName() {
        return "file";
      }

      @Override
      public String getOriginalFilename() {
        return fileName;
      } // Now effectively final!

      @Override
      public String getContentType() {
        return "application/pdf";
      }

      @Override
      public boolean isEmpty() {
        return bytes.length == 0;
      }

      @Override
      public long getSize() {
        return bytes.length;
      }

      @Override
      public byte[] getBytes() {
        return bytes;
      }

      @Override
      public InputStream getInputStream() {
        return new ByteArrayInputStream(bytes);
      }

      @Override
      public void transferTo(File dest) throws IOException {
        Files.write(dest.toPath(), bytes);
      }

      @Override
      public void transferTo(Path dest) throws IOException {
        Files.write(dest, bytes);
      }
    };
  }

  public String getResumeText(MultipartFile resume) {
    PagePdfDocumentReader pdfReader = new PagePdfDocumentReader(resume.getResource());
    List<Document> documents = pdfReader.read();

    return documents.stream()
        .map(doc -> doc.getFormattedContent())
        .collect(Collectors.joining("\n"));
  }

  public String postMethodName(MultipartFile file, String question) {
    return chatClient.prompt(getResumeText(file) + question).call()
        .content();
  }
}
