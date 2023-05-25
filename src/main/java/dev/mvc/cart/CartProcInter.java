package dev.mvc.cart;

public interface CartProcInter {
  /**
   * 장바구니 담기
   * @param cartVO
   * @return
   */
  public int insert(CartVO cartVO);
  
  /**
   * 장바구니 삭제
   * @param cartVO
   * @return
   */
  public  int delete(int cartno);

}
