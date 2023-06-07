package dev.mvc.recipe;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface RecipeProcInter {
  /**
   * 등록
   * @param recipeVO
   * @return
   */
  public int create(RecipeVO recipeVO);
  
  public ArrayList<RecipeVO> list_all();
  
  public ArrayList<RecipeVO> list_by_itemno(int itemno);
  
  /**
   * 조회
   * @param recipeno
   * @return
   */
  public RecipeVO read(int recipeno);
  
  
  /**
   * Youtube
   * @param recipeVO
   * @return
   */
  public int youtube(RecipeVO recipeVO);
  
  /**
   * 특정 카테고리의 검색된 글목록
   */
  public ArrayList<RecipeVO> list_by_itemno_search(RecipeVO recipeVO);
  
  /**
   * 검색된 레코드 개수 리턴
   */
  public int search_count(RecipeVO recipeVO);
  
  /**
   * 검색 + 페이징 목록
   * @param map
   * @return
   */
  public ArrayList<RecipeVO> list_by_itemno_search_paging(RecipeVO recipeVO);
  
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
  public String pagingBox(int cateno, int now_page, String word, String list_file);
  
  /**
   * 패스워드 확인
   * @param recipeVO
   * @return 처리된 레코드 갯수
   */
  public int password_check(RecipeVO recipeVO);
  
  /**
   * 글 정보 수정
   * @param recipeVO
   * @return 처리된 레코드 갯수
   */
  public int update_text(RecipeVO recipeVO);
  
  /**
   * 파일 정보 수정
   * @param recipeVO
   * @return 처리된 레코드 갯수
   */
  public int update_file(RecipeVO recipeVO);
 
  /**
   * 삭제
   * @param recipeno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int recipeno);
  
  /**
   * 
   * @param itemno
   * @return
   */
  public int count_by_itemno (int itemno);

  public int delete_by_itemno (int itemno);
  
  /**
   * 조회수
   * @param itemno
   * @return
   */
  public int cnt_add (int recipeno);
  
  /**
   * 추천수(따봉)
   * @param itemno
   * @return
   */
  public int recom_add (int recipeno);


}