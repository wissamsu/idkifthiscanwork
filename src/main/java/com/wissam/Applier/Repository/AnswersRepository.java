package com.wissam.Applier.Repository;

import java.util.Optional;
import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.wissam.Applier.Model.Answers;

/**
 * AnswersRepository
 */
@Repository
public interface AnswersRepository extends JpaRepository<Answers, Long> {

  Optional<Answers> findAnswerByUser_IdAndQuestion(UUID userId, String question);

}
