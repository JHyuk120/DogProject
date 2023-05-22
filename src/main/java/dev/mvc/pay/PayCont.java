package dev.mvc.pay;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;

@Controller
public class PayCont {
  @Autowired
  @Qualifier("dev.mvc.pay.PayProc")
  private PayProcInter payProc;

  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;

  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
//등록품  http://localhost:9093/pay/payment.do
  @RequestMapping(value = "/pay/payment.do", method = RequestMethod.GET)
  public ModelAndView payment(HttpSession session) {

    ModelAndView mav = new ModelAndView();
    
    int memberno = 0;
    
    if (this.memberProc.isMember(session) == true) {
      memberno = (int)session.getAttribute("memberno");
      MemberVO memberVO = this.memberProc.read(memberno);
      mav.addObject("memberVO", memberVO);
      
      mav.setViewName("/pay/payment");
      
    } else {
      mav.setViewName("/member/login_need");
    }

    return mav;
  }

//등록 처리
  @RequestMapping(value = "/pay/payment.do", method = RequestMethod.POST)
  public ModelAndView payment(HttpSession session, PayVO payVO) {

    ModelAndView mav = new ModelAndView();
    
    if (this.memberProc.isMember(session) == true) {
      int cnt = this.payProc.payment(payVO);

      if (cnt == 1) {
        mav.setViewName("/pay/msg");
        mav.addObject("code", "payment_success");
      } else {

        mav.addObject("code", "payment_fail");
      }

      mav.addObject("cnt", cnt);
    } else {
      mav.setViewName("/member/login_need");
    }

    return mav;
  }
}
