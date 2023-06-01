package dev.mvc.pay;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.pay.PayProc")
public class PayProc implements PayProcInter {
  @Autowired
  private PayDAOInter payDAO;


  @Override
  public int create(PayVO payVO) {
    int cnt = this.payDAO.create(payVO);
    
    return cnt;
  }

  
}
