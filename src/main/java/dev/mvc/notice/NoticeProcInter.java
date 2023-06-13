package dev.mvc.notice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface NoticeProcInter {
  /**
   * 등록
   * @param noticeVO
   * @return
   */
  public int create(NoticeVO noticeVO);
  
  public ArrayList<NoticeVO> list_all();
  
  
  /**
   * 조회
   * @param noticeno
   * @return
   */
  public NoticeVO read(int noticeno);
  
  /**
   * 패스워드 확인
   * @param noticeVO
   * @return 처리된 레코드 갯수
   */
  public int password_check(NoticeVO noticeVO);
  
  /**
   * 글 정보 수정
   * @param noticeVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(NoticeVO noticeVO);
  
  /**
   * 파일 정보 수정
   * @param noticeVO
   * @return 처리된 레코드 갯수
   */
  public int update_file(NoticeVO noticeVO);
 
  /**
   * 삭제
   * @param noticeno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int noticeno);
  
  
  /**
   * 조회수
   * @param itemno
   * @return
   */
  public int cnt_add (int noticeno);

}