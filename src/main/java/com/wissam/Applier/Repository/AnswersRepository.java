package com.wissam.Applier.Repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.wissam.Applier.Model.Answers;

/**
 * AnswersRepository
 */
@Repository
public interface AnswersRepository extends JpaRepository<Answers, Long> {

}
