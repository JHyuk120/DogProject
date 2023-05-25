package dev.mvc.cart;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.member.MemberProcInter;

@Controller
public class CartCont {
  @Autowired //자동생성
  @Qualifier("dev.mvc.cart.cartProc")
  private CartProcInter cartProc; //cartProc 객체 자동생성후 할당
  
  @Autowired //자동생성
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc; //cartProc 객체 자동생성후 할당
  
  public CartCont() {
    System.out.println("-> CartCont created");
  }
  
  //장바구니 담기 폼
  //http://localhost:9093/cart/insert.do
  @RequestMapping(value="/cart/insert.do",method=RequestMethod.GET)
  public ModelAndView insert(HttpSession session) {
    System.out.println("->CateCont insert()");
    ModelAndView mav = new ModelAndView();
    
    if(this.memberProc.isMember(session) == true) {
      mav.setViewName("/cart/insert"); //실제접근 주소: /WEB-INF/views/cart/insert.jsp    
    }else {
      mav.setViewName("/member/login_need"); ///WEB-INF/views/cart/member.jsp   
    }
    return mav;
    
    
    
  }

}
