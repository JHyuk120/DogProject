package dev.mvc.cart;

import java.util.ArrayList;

public interface CartDAOInter {
  /**
   * 장바구니 담기
   * @param cartVO
   * @return
   */
  public int insert(CartVO cartVO);
  
  /**
   * memberno 회원 번호별 쇼핑카트 목록 출력
   * @return
   */
  public ArrayList<CartVO> list_by_memberno(int memberno);
  
  /**
   * 장바구니 삭제
   * @param cartVO
   * @return
   */
  public  int delete(int cartno);

}
