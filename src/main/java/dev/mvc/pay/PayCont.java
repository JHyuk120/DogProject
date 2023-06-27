package dev.mvc.pay;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.cart.CartProcInter;
import dev.mvc.cart.CartVO;
import dev.mvc.detail.DetailProcInter;
import dev.mvc.detail.DetailVO;
import dev.mvc.goods.GoodsProcInter;
import dev.mvc.goods.GoodsVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;



@Controller
public class PayCont {
  @Autowired
  @Qualifier("dev.mvc.pay.PayProc")
  private PayProcInter payProc;
  
  @Autowired
  @Qualifier("dev.mvc.cart.CartProc")
  private CartProcInter cartProc;

  @Autowired
  @Qualifier("dev.mvc.detail.DetailProc")
  private DetailProcInter detailProc;

  @Autowired
  @Qualifier("dev.mvc.goods.GoodsProc")
  private GoodsProcInter goodsProc;

  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
 
  public PayCont() {
    System.out.println("-> PayCont created.");
  }
  
  /**
   * Ajax 기반 회원 조회
// http://localhost:9093/pay/create.do
  /**
  * 등록 폼
  * @return
  */
  @RequestMapping(value="/pay/create.do", method=RequestMethod.GET )
  public ModelAndView create(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    int tot = 0;               // 판매 금액 합계 = 판매 금액(단가) * 수량
    int tot_sum = 0;        // 판매 금액 총 합계 = 판매 금액 총 합계 + 판매 금액 합계
    int point_tot = 0;       // 포인트 합계 = 포인트 합계 + (포인트 * 수량)
    int baesong_tot = 0;   // 배송비 합계
    int total_order = 0;     // 전체 주문 금액
    
    int memberno = (int)session.getAttribute("memberno");
    MemberVO memberVO = this.memberProc.read(memberno);
    mav.addObject("memberVO", memberVO);
    
    // 쇼핑카트에 등록된 상품 목록을 가져옴
    List<CartVO> list = this.cartProc.list_by_memberno(memberno);
    
    for (CartVO cartVO : list) {
      tot = cartVO.getSaleprice() * cartVO.getCnt();  // 판매 금액 합계 = 판매 금액(단가) * 수량
      cartVO.setTot(tot);
      
      // 판매 금액 총 합계 = 판매 금액 총 합계 + 판매 금액 합계
      tot_sum = tot_sum + cartVO.getTot();
      
      // 포인트 합계 = 포인트 합계 + (포인트 * 수량)
      point_tot = point_tot + (cartVO.getPoint() * cartVO.getCnt());
      
    }
    
    if (tot_sum < 30000) { // 상품 주문 금액이 30,000 원 이하이면 배송비 3,000 원 부여
      baesong_tot = 3000;
    }
    
    // 전체 주문 금액 = 판매 금액 총 합계 + 배송비
    total_order = tot_sum + baesong_tot; 
        
    mav.addObject("list", list); // request.setAttribute("list", list);
    
    mav.addObject("tot_sum", tot_sum);     // 판매 금액 총 합계
    mav.addObject("point_tot", point_tot);  // 포인트 합계
    mav.addObject("baesong_tot", baesong_tot);   // 배송비
    mav.addObject("total_order", total_order);  // 전체 주문 금액 
    
    mav.setViewName("/pay/create"); // webapp/WEB-INF/views/pay/create.jsp
      
    return mav; // forward
  }
  
  // http://localhost:9093/pay/create.do
  /**
   * 주문 결재 등록 처리
   * @param payVO
   * @return
   */
  @RequestMapping(value="/pay/create.do", method=RequestMethod.POST )
  public ModelAndView create(HttpSession session,
                                        PayVO payVO) { // payVO 자동 생성, Form -> VO
    ModelAndView mav = new ModelAndView();
    
    int memberno = (int)session.getAttribute("memberno");
    payVO.setMemberno(memberno); // 회원 번호 저장
    MemberVO memberVO = this.memberProc.read(memberno);
    
  //포인트 사용
    int ptype = payVO.getPtype();
    if (ptype == 3) {
      int amount = payVO.getamount();
      int mpoint = memberVO.getMpoint();
      
      if (amount >= mpoint) {
        amount = amount - mpoint;
        
        payVO.setamount(amount);
        memberVO.setMpoint(0);
        this.memberProc.mpoint_update(memberVO);
        
      } else if (amount < mpoint) {
        mpoint = mpoint - amount;

        payVO.setamount(0);
        memberVO.setMpoint(mpoint);
        this.memberProc.mpoint_update(memberVO);
      }      
    }
    System.out.println("mpoint : " + memberVO.getMpoint());
    //포인트 사용 끝
    
    int cnt = this.payProc.create(payVO);

    /*
    // 주문 결재하고 바로 번호 수집
    <!-- 주문 결재 등록 전 payno를 PayVO에 저장  -->
    <insert id="create" parameterType="dev.mvc.pay.PayVO">
      <selectKey keyProperty="payno" resultType="int" order="BEFORE">
        SELECT pay_seq.nextval FROM dual
      </selectKey>
      
      INSERT INTO pay(payno, memberno, tname, ttel, tzipcode,
                                       taddress1, taddress2, ptype, amount, rdate)
      VALUES (#{payno}, #{memberno}, #{tname}, #{ttel}, #{tzipcode},
                                       #{taddress1}, #{taddress2}, #{ptype}, #{amount}, sysdate)
    </insert>
    */

    int payno = payVO.getPayno(); // 결재 번호 수집
    
    // Detail: 주문 상세 테이블 관련 시작
    DetailVO detailVO = new DetailVO();
    
    if (cnt == 1) { // 정상적으로 주문 결재 정보가 등록된 경우
      // 회원의 쇼핑카트 정보를 읽어서 주문 상세 테이블로 insert
      // 1. cart 읽음, SELECT
      List<CartVO> list = this.cartProc.list_by_memberno(memberno);
      for (CartVO cartVO : list) {
        int goodsno = cartVO.getGoodsno();
        
        // 2. detail INSERT
       detailVO.setMemberno(memberno);
       detailVO.setPayno(payno);
       detailVO.setGoodsno(goodsno);
       detailVO.setCnt(cartVO.getCnt());
       
       GoodsVO goodsVO = this.goodsProc.read(goodsno); // 할인 금액 읽기용 VO
       int tot = goodsVO.getSaleprice() * cartVO.getCnt();  // 할인 금액 합계 = 할인 금액 * 수량
       
       detailVO.setTot(tot); // 상품 1건당 총 결재 금액
       
       // 주문 상태(stateno):  1: 상품 준비중, 2: 배달중, 3: 배달 완료  
       detailVO.setStateno(1); // 신규 주문 등록임으로 1 
       
       this.detailProc.create(detailVO); // 주문 상세 등록
       
    // 결제 한 재료의 양 만큼 남은 재료의 양 줄이기
       int goods_cnt = detailVO.getCnt();

       for (int i = 1; i <= goods_cnt; i ++) {
         this.goodsProc.cnt_sub(goodsno);
       }

      }
      // 포인트 적립
        int point_tot = memberVO.getMpoint();
         
         for (CartVO cartVO : list) {
           // 포인트 합계 = 포인트 합계 + (포인트 * 수량)
           point_tot = point_tot + (cartVO.getPoint() * cartVO.getCnt());
           
           // 3. 주문된 상품 cart에서 DELETE
           int cartno = cartVO.getCartno();
           int delete_cnt = this.cartProc.delete(cartno);
           System.out.println("-> delete_cnt: " + delete_cnt + " 건 주문후 cart에서 삭제됨.");
           
         }
         
         memberVO.setMpoint(point_tot);
         this.memberProc.mpoint_update(memberVO);
         System.out.println("mpoint > " + memberVO.getMpoint());
         // 포인트 적립 끝
         
      
    } else {
      // 결재 실패했다는 에러 페이지등 제작 필요, 여기서는 생략
    }
    
 // Detail: 주문 상세 테이블 관련 종료    
    
    mav.addObject("memberno", memberno);
    
    mav.setViewName("redirect:/pay/pay_list.do");  // 참일 경우만 발생한다고 결정, 에러 페이지 이동 생략 

    return mav; // forward
  }
  
  
  /**
   * 회원별 전체 목록, 로그인이 안되어 있으면 로그인 후 목록 출력
   * http://localhost:9093/pay/pay_list.do 
   * @return
   */
  @RequestMapping(value="/pay/pay_list.do", method=RequestMethod.GET )
  public ModelAndView pay_list(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (session.getAttribute("memberno") != null) { // 회원으로 로그인을 했다면 쇼핑카트로 이동
      int memberno = (int)session.getAttribute("memberno");
      
      List<PayVO> list = this.payProc.pay_list(memberno);
      mav.addObject("list", list); // request.setAttribute("list", list);

      mav.setViewName("/pay/pay_list"); // /views/pay/pay_list.jsp   
      
    } else { // 회원으로 로그인하지 않았다면
      mav.addObject("return_url", "/pay/pay_list.do"); // 로그인 후 이동할 주소 ★
      
      mav.setViewName("redirect:/member/login.do"); // /WEB-INF/views/member/login_ck_form.jsp
    }

    return mav;
  }


}