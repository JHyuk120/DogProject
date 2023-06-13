package dev.mvc.qna;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dev.mvc.notice.NoticeVO;

public interface QnaProcInter {
  
  /**
   * 등록
   * @param qnaVO
   * @return
   */
  public int create(QnaVO qnaVO);
  
  /**
   * 전체보기
   * @return
   */
  
  public ArrayList<QnaVO> list_all();
  
  
  /**
   * 조회
   * @param qnano
   * @return
   */
  public QnaVO read(int qnano);
  
  /**
   * 특정 카테고리의 검색된 글목록
   * @return
   */
  public ArrayList<QnaVO> list_by_search(QnaVO QnaVO);
  
  /**
   * 검색 수
   * @return
   */
  public int search_count(QnaVO qnaVO);
  
  /**
   * 특정 카테고리의 검색된 페이지 목록
   * @return
   */
  public ArrayList<QnaVO> list_by_search_paging(QnaVO naVO);

  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param cateno          카테고리번호 
   * @param search_count  검색(전체) 레코드수 
   * @param now_page      현재 페이지
   * @param word 검색어
   * @param list_file 파일 목록
   * @return 페이징 생성 문자열
   */ 
  public String pagingBox(int now_page, String word, String list_file);
  
  /**
   * 패스워드 확인
   * @param qnaVO
   * @return 처리된 레코드 갯수
   */
  public int password_check(QnaVO qnaVO);
  
  /**
   * 글 정보 수정
   * @param noticeVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(QnaVO qnaVO);
 
  /**
   * 삭제
   * @param noticeno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int noticeno);
  


}