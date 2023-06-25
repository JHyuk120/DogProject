package dev.mvc.recipe;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import dev.mvc.recipe.RecipeVO;

public interface RecipeDAOInter {
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
   * 좋아요 ++
   * @param itemno
   * @return
   */
  public int recom_add (int recipeno);
  
  /**
   * 좋아요--
   * @param itemno
   * @return
   */
  public int recom_sub (int recipeno);
  
  /**
   * 관리자가 보는 좋아요 많은 레시피
   * @return
   */
  public ArrayList<RecipeVO> adminList();
  
  /**
  멤버가 좋아요 누른 레시피
  @param memberno
  @return
  */
  public ArrayList<RecipeVO> memberList(int memberno);

}