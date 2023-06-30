package dev.mvc.pay;

import java.util.List;

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


  @Override
  public List<PayVO> pay_list(int memberno) {
    List<PayVO> list = this.payDAO.pay_list(memberno);
    return list;
  }


  @Override
  public int p_delete(int payno) {
    int cnt = this.payDAO.p_delete(payno);
    return cnt;
  }

  
}
