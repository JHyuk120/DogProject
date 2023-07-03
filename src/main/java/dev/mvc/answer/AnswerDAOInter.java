package dev.mvc.answer;

import java.util.ArrayList;

import dev.mvc.notice.NoticeVO;
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
  
  /**
   * 삭제
   * @param answer_no
   * @return 삭제된 레코드 갯수
   */
  public int delete(int answer_no);
  
  /**
   * 글 수정
   * @param answerVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(AnswerVO answerVO);
 
  /**
   * 패스워드 확인
   * @param noticeVO
   * @return 처리된 레코드 갯수
   */
  public int password_check(AnswerVO answerVO);
  
  
}