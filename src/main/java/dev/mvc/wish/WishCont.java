package dev.mvc.wish;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.goods.GoodsProcInter;
import dev.mvc.goods.GoodsVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.recipe.RecipeVO;



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
    
    if(memberProc.isMember(session)) {//회원로그인 되어있을 경우
      int memberno = (int)(session.getAttribute("memberno"));//회원번호 가져옴
      wishVO.setMemberno(memberno); //wishVO에 넣어줌
      int check = this.wishProc.check(wishVO);
      
      if(check != 1) {//선택 되어지지 않아 있을 경우
       int cnt = this.wishProc.create(wishVO);
       
       if(cnt == 1) {
         mav.addObject("goodsVO",goodsVO);
        // this.goodsProc.wish_add(goodsVO.getGoodsno());// 수 늘려
         //int mycnt = this.wishProc.mycnt(goodsVO.getGoodsno());
        // mav.addObject("mycnt",mycnt);
         mav.setViewName("redirect:/goods/read.do?goodsno=" + goodsVO.getGoodsno());//새로고침
    
       }else {
         mav.addObject("code", "create_fail");
       }
      }else {
        int delete_wisih = this.wishProc.delete(wishVO);
        
        mav.addObject("goodsVO", goodsVO);
        //this.goodsProc.wish_sub(goodsVO.getGoodsno());
        mav.setViewName("redirect:/goods/read.do?goodsno=" + goodsVO.getGoodsno());        
       
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
  
  /**
   * memberlist에서 삭제
   */
  @RequestMapping(value = "/wish/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpSession session, WishVO wishVO) {
    ModelAndView mav = new ModelAndView();
    
    int memberno = (int)(session.getAttribute("memberno"));//회원번호 가져옴
    wishVO.setMemberno(memberno); //wishVO에 넣어줌
    int check = this.wishProc.check(wishVO);

    
    int delete_wish = this.wishProc.delete(wishVO);
    
    mav.setViewName("redirect:/wish/memberList.do?memberno=" +memberno);        

    return mav; // forward
  }
  
  /**
   * 오류 메시지
   * @param url
   * @return
   */
  @RequestMapping(value = "/wish/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward

    return mav; // forward
  }
 

  /**
  
  회원이 찜한 재료 항목
  @param session
  @return
  */
  @RequestMapping(value = "/wish/memberList.do", method = RequestMethod.GET)
  public ModelAndView memberList(int memberno, HttpSession session,WishVO wishVO,GoodsVO goodsVO) {
    ModelAndView mav = new ModelAndView();
    if (memberProc.isMember(session)) {
      ArrayList<GoodsVO> list_m = this.goodsProc.memberList(memberno);
      int mycnt = this.wishProc.mycnt(memberno);
      System.out.println("mycnt:"+mycnt);
      mav.addObject("mycnt", mycnt);
      mav.addObject("list_m", list_m);
      

    }
    return mav;
    
  }
  
  }
