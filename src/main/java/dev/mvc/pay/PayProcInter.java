package dev.mvc.pay;

import java.util.List;

public interface PayProcInter {

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
