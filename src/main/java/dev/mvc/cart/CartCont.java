package dev.mvc.cart;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.goods.GoodsProcInter;
import dev.mvc.member.MemberProcInter;

@Controller
public class CartCont {
  @Autowired //자동생성
  @Qualifier("dev.mvc.cart.cartProc")
  private CartProcInter cartProc; //cartProc 객체 자동생성후 할당
  
  @Autowired //자동생성
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc; //cartProc 객체 자동생성후 할당
  
  @Autowired //자동생성
  @Qualifier("dev.mvc.goods.GoodsProc")
  private GoodsProcInter goodsProc; //cartProc 객체 자동생성후 할당
  
  public CartCont() {
    System.out.println("-> CartCont created");
  }
  
  //장바구니 담기 폼
  //http://localhost:9093/cart/insert.do
  /**
   * Ajax 등록 처리
   * INSERT INTO cart(cartno,  memberno, goodsno,cnt, rdate)
   * VALUES(cart_seq.nextval,#{memberno},#{goodsno},#{cnt},sysdate)
   * @param categrpVO
   * @return
   */
  @RequestMapping(value="/cart/insert.do",method=RequestMethod.POST)
  @ResponseBody
  public String insert(HttpSession session, int goodsno) {
    //System.out.println("->CateCont insert()");
    CartVO cartVO = new CartVO();
    cartVO.setGoodsno(goodsno); //상품번호

    int memberno = (Integer)session.getAttribute("memberno");
    cartVO.setMemberno(memberno); //회원번호
    
    cartVO.setCnt(1); //최초 구매 수량을 1개로 지정
    
    int cnt = this.cartProc.insert(cartVO); //등록 처리
    
    JSONObject json = new JSONObject();
    json.put("cnt", cnt); // 1: 정상 등록

 // System.out.println("-> cartCont create: " + json.toString());
    
    return json.toString();
    
  }

}
