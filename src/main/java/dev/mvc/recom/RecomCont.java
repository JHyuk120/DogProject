package dev.mvc.recom;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

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

  public RecomCont() {
    System.out.println("-> RecomCont created");
  }

  @RequestMapping(value = "/recom/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpSession session, RecomVO recomVO, RecipeVO recipeVO) {
    ModelAndView mav = new ModelAndView();
    
   
    
    if (memberProc.isMember(session)) {
      int memberno = (int)(session.getAttribute("memberno"));
      recomVO.setMemberno(memberno);
      
      int cnt = this.recomProc.create(recomVO); 
      
      if (cnt == 1) {
        mav.addObject("recipeVO", recipeVO);
        mav.setViewName("redirect:/recipe/read.do?recipeno=" + recipeVO.getRecipeno());

      } else {
//        mav.addObject("code", "recom_create_fail");

      }
    } else { 
      mav.addObject("url", "/member/login_need");
      mav.setViewName("redirect:/recom/msg.do"); 

    }

    return mav;
  }
  
  @RequestMapping(value="/recom/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  } 
  
  

}
