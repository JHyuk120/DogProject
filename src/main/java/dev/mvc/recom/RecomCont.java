package dev.mvc.recom;

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
import dev.mvc.recipe.RecipeProcInter;
import dev.mvc.recipe.RecipeVO;

@Controller
public class RecomCont {

  @Autowired
  @Qualifier("dev.mvc.recom.RecomProc")
  private RecomProcInter recomProc;

  @Autowired
  @Qualifier("dev.mvc.recipe.RecipeProc")
  private RecipeProcInter recipeProc;

  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;

  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;

  public RecomCont() {
    System.out.println("-> RecomCont created");
  }

  /**
   * 좋아요 생성 및 삭제
   * @param session
   * @param recomVO
   * @param recipeVO
   * @return
   */
  @RequestMapping(value = "/recom/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpSession session, RecomVO recomVO, RecipeVO recipeVO) {
    ModelAndView mav = new ModelAndView();

    if (memberProc.isMember(session)) {
      int memberno = (int) (session.getAttribute("memberno"));
      recomVO.setMemberno(memberno);

      int check = this.recomProc.check(recomVO);

      if (check != 1) {
        int cnt = this.recomProc.create(recomVO);

        if (cnt == 1) {
          mav.addObject("recipeVO", recipeVO);
          this.recipeProc.recom_add(recipeVO.getRecipeno());
          mav.setViewName("redirect:/recipe/read.do?recipeno=" + recipeVO.getRecipeno());

        } else {
          mav.addObject("code", "create_fail");

        }
      } else {
        int delete_recom = this.recomProc.delete(memberno);
        
        mav.addObject("recipeVO", recipeVO);
        this.recipeProc.recom_sub(recipeVO.getRecipeno());
        mav.setViewName("redirect:/recipe/read.do?recipeno=" + recipeVO.getRecipeno());
        
      }
    } else if (adminProc.isAdmin(session)) {
      mav.addObject("code", "admin_fail");
      mav.setViewName("redirect:/recom/msg.do");
      
    } else {
      mav.addObject("url", "/member/login_need");
      mav.setViewName("redirect:/recom/msg.do");

    }

    return mav;
  }

  /**
   * 오류 메시지
   * @param url
   * @return
   */
  @RequestMapping(value = "/recom/msg.do", method = RequestMethod.GET)
  public ModelAndView msg(String url) {
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward

    return mav; // forward
  }
  
  /**
   * 관리자가 보는 좋아요가 많은 목록
   * @param session
   * @return
   */
  @RequestMapping(value = "/recom/adminList.do", method = RequestMethod.GET)
  public ModelAndView adminList(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    
    if (adminProc.isAdmin(session)) {
      ArrayList<RecipeVO> list_a = this.recipeProc.adminList();
      mav.addObject("list_a", list_a);
      
    } else {
      mav.addObject("code", "admin_fail");
      mav.setViewName("redirect:/recom/msg.do");
      
    }

    return mav; 
  }
  

}
