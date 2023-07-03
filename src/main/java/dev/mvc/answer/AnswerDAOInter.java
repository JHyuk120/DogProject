package dev.mvc.answer;

import java.util.ArrayList;

import dev.mvc.qna.QnaVO;

public interface AnswerDAOInter {
  
  /**
   * 답글 작성
   * @param answerVO
   * @return
   */
  public int create(AnswerVO answerVO);
  
/**
 * 읽기
 * @param answer_no
 * @return
 */
  public AnswerVO read(int answer_no);

  /**
   * 전체보기
   * @return
   */
  
  public ArrayList<AnswerVO> list_all();
}