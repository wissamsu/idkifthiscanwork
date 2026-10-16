package com.wissam.Applier.Obj;

import java.util.List;

import com.microsoft.playwright.Locator;

/**
 * MultiChoiceQuestion
 */
public record MultiChoiceQuestion(String question, List<String> choices, Locator label) {

}
