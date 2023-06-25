package dev.mvc.wish;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.goods.GoodsProcInter;
import dev.mvc.goods.GoodsVO;
import dev.mvc.member.MemberProcInter;



@Controller
public class WishCont {
  
  @Autowired
  @Qualifier("dev.mvc.wish.WishProc")
  private WishProcInter wishProc;
  
  @Autowired
  @Qualifier("dev.mvc.goods.GoodsProc")
  private GoodsProcInter goodsProc;

  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;

  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;
  
  public WishCont() {
    System.out.println("-> WishCont created");    
  }
  /**
   * 찜하기 생성 및 삭제
   * @param session
   * @param wishVO
   * @param goodsVO
   * @return
   */
  @RequestMapping(value = "/wish/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpSession session, WishVO wishVO, GoodsVO goodsVO ) {
    ModelAndView mav = new ModelAndView();
    
    if(memberProc.isMember(session)) {
      int memberno = (int)(session.getAttribute("memberno"));
      int check = this.wishProc.check(wishVO);
      
      if(check != 1) {
       int cnt = this.wishProc.create(wishVO);
       
       if(cnt == 1) {
         mav.addObject("goodsVO",goodsVO);
         this.goodsProc.wish_add(goodsVO.getGoodsno());
         mav.setViewName("redirect:/goods/read.do?goodsno=" + goodsVO.getGoodsno());
    
       }else {
         mav.addObject("code", "create_fail");
       }
      }else {
        int delete_wisih = this.wishProc.delete(memberno);
        
        mav.addObject("goodsVO", goodsVO);
        this.goodsProc.wish_sub(goodsVO.getGoodsno());
        mav.setViewName("redirect:/wish/read.do?wishno=" + wishVO.getWishno());        
       
      }
    }else if(adminProc.isAdmin(session)) {
      mav.addObject("code", "admin_fail");
      mav.setViewName("redirect:/wish/msg.do");
       
    }else {
      mav.addObject("url", "/member/login_need");
      mav.setViewName("redirect:/wish/msg.do");
    }
    return mav;
    
  }
 

}
