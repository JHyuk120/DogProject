package dev.mvc.pay;

import java.util.List;

public interface PayDAOInter {
  
  /**
   * 
   * @param payVO
   * @return
   */
  public int create(PayVO payVO);
  
  /**
   * 
   * @param memberno
   * @return
   */
  public List<PayVO> pay_list(int memberno);
  
  /**
   * 관리자 주문 삭제
   * @param payno
   * @return
   */
  public int p_delete(int payno);

}
