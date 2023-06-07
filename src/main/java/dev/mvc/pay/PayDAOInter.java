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

}
