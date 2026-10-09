package com.wissam.Applier.AiTooling;

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
