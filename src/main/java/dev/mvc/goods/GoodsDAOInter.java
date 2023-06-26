package dev.mvc.goods;

import java.util.ArrayList;



public interface GoodsDAOInter {
  
  /**
   * 상품 등록
   * @param goodsVO
   * @return
   */
  public int create(GoodsVO goodsVO);
  
  /**
   * 모든 상품의 등록된 글목록
   * @return 
   */
  public ArrayList<GoodsVO> list_all();
  
  /**
   * 특정 카테고리의 등록된 글목록
   * @return
   */
  public ArrayList<GoodsVO> list_by_itemno(int itemno);
  
  /**
   * 조회
   * @param goodsno
   * @return
   */
  public GoodsVO read(int goodsno);
  
  /**
   * 특정 카테고리의 검색된 글목록
   * @return
   */
  public ArrayList<GoodsVO> list_by_itemno_search(GoodsVO goodsVO);
  
  /**
   * 검색 수
   * @return
   */
  public int search_count(GoodsVO goodsVO);
  
  /**
   * 특정 카테고리의 검색된 페이지 목록
   * @return
   */
  public ArrayList<GoodsVO> list_by_itemno_search_paging(GoodsVO goodsVO);
  
  /**
   * 글(내용) 수정
   * @param goodsVO
   * @return
   */
  public int update_text(GoodsVO goodsVO);
  
  /**
   * 패스워드 검사
   * @param passwd
   * @return
   */
  public int password_check(GoodsVO goodsVO);
  
  /**
   * 파일 정보 수정
   * @param goodsVO
   * @return 처리된 레코드 갯수
   */
  public int update_file(GoodsVO goodsVO);
  
  /**
   * 삭제
   * @param goodsno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int goodsno);
  
  /**
   * 카테고리별 레코드 수
   * @param itemno
   * @return
   */
  public int count_by_itemno(int itemno);
 
  /**
   * 특정 카테고리에 속한 모든 레코드 삭제
   * @param goodsno
   * @return 삭제된 레코드 갯수
   */
  public int delete_by_itemno(int itemno);
  
  /**
   * 찜하기 ++
   * @param itemno
   * @return
   */
  public int wish_add (int goodsno);
  
  /**
   * 찜하기 --
   * @param itemno
   * @return
   */
  public int wish_sub (int goodsno);
  
  /**
   *재료 수량 감소
   * @param goodsno
   * @return
  */
  public int cnt_sub (int goodsno);

  /**
  * 재료 수량 확인
  * @param goodsno
  * @return
  */
  public int g_cnt(int goodsno);
  

  
  
  /**
  회원이 찜한 재료 목록
  @param memberno
  @return
  */
  public ArrayList<GoodsVO> memberList(int memberno);
  
  /**
   * goodsno 출력
   */
  public int select_goodsno(String gname);

}
