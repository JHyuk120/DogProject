package dev.mvc.cart;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
  
  /**
   * 회원별 목록
   * 할인 금액 합계 = 할인 금액 * 수량
   * 할인 금액 총 합계 = 할인 금액 총 합계 + 할인 금액 합계
   * 포인트 합계 = 포인트 합계 + (포인트 * 수량)
   * 배송비 = 3000
   * 전체 주문 금액 = 할인 금액 총 합계 + 배송비
   * http://localhost:9091/cart/list_by_memberno.do
   * http://localhost:9091/cart/list_by_memberno.do?cateno=
   * http://localhost:9091/cart/list_by_memberno.do?cateno=4
   * @return
   */
  @RequestMapping(value="/cart/list_by_memberno.do", method=RequestMethod.GET )
  public ModelAndView list_by_memberno(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    int tot = 0;               // 할인 금액 합계 = 할인 금액 * 수량
    int tot_sum = 0;        // 할인 금액 총 합계 = 할인 금액 총 합계 + 할인 금액 합계
    int point_tot = 0;       // 포인트 합계 = 포인트 합계 + (포인트 * 수량)
    int baesong_tot = 0;   // 배송비 합계
    int total_order = 0;    // 전체 주문 금액
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      // 목록
      ArrayList<CartVO> list = this.cartProc.list_by_memberno(memberno);
      
      for (CartVO cartVO : list) {
        tot = cartVO.getSaleprice() * cartVO.getCnt();  // 판매 금액 합계 = 판매 금액(단가) * 수량
        cartVO.setTot(tot);
        
        // 판매 금액 총 합계 = 판매 금액 총 합계 + 판매 금액 합계
        tot_sum = tot_sum + cartVO.getTot();
        
        // 포인트 합계 = 포인트 합계 + (포인트 * 수량)
        point_tot = point_tot + (cartVO.getPoint() * cartVO.getCnt());
        
      }
      
      if (tot_sum < 30000) { // 상품 주문 금액이 30,000 원 이하이면 배송비 3,000 원 부여
        if (list.size() > 0) {     // 총 주문 금액이 30,000 이하이면서 상품이 존재한다면 배송비 3,000 할당
          baesong_tot = 3000;
        }
      }
      
      total_order = tot_sum + baesong_tot; // 전체 주문 금액 = 판매 금액 총 합계 + 배송비
          
      mav.addObject("list", list); // request.setAttribute("list", list);
      mav.addObject("tot_sum", tot_sum);     // 판매 금액 총 합계
      mav.addObject("point_tot", point_tot);  // 포인트 합계
      mav.addObject("baesong_tot", baesong_tot);   // 배송비
      mav.addObject("total_order", total_order);  // 전체 주문 금액 
      
      mav.setViewName("/cart/list_by_memberno"); // /WEB-INF/views/categrp/list_by_memberno.jsp
      
    } else { // 회원으로 로그인하지 않았다면
      // http://localhost:9091/member/login.do?return_url=/cart/list_by_memberno.do
      
      mav.addObject("return_url", "/cart/list_by_memberno.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp

    }
    return mav;
  }
  
  /**
   * 상품 삭제
   * http://localhost:9091/cart/delete.do
   * @return
   */
  @RequestMapping(value="/cart/delete.do", method=RequestMethod.POST )
  public ModelAndView delete(HttpSession session, @RequestParam(value="cartno", defaultValue="0") int cartno ) {
    ModelAndView mav = new ModelAndView();
    
    this.cartProc.delete(cartno);      
    mav.setViewName("redirect:/cart/list_by_memberno.do");
    
    return mav;
  }

}
