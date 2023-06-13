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
   * 특정 카테고리의 검색된 글목록
   * @return
   */
  public ArrayList<NoticeVO> list_by_search(NoticeVO NoticeVO);
  
  /**
   * 검색 수
   * @return
   */
  public int search_count(NoticeVO noticeVO);
  
  /**
   * 특정 카테고리의 검색된 페이지 목록
   * @return
   */
  public ArrayList<NoticeVO> list_by_search_paging(NoticeVO noticeVO);
  
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

  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param search_count  검색(전체) 레코드수 
   * @param now_page      현재 페이지
   * @param word 검색어
   * @param list_file 파일 목록
   * @return 페이징 생성 문자열
   */ 
  public String pagingBox(int now_page, String word, String list_file);
  

}