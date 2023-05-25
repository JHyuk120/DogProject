package dev.mvc.reply;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.recipe.RecipeVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.recipe.RecipeProcInter;
import dev.mvc.reply.ReplyVO;

@Controller
public class ReplyCont {
    
    @Autowired
    @Qualifier("dev.mvc.recipe.RecipeProc") 
    private RecipeProcInter recipeProc;
    
    @Autowired
    @Qualifier("dev.mvc.reply.ReplyProc")
    private ReplyProcInter replyProc;
    
    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProcInter memberProc;
    
    public ReplyCont() {
        System.out.println("-> ReplyCont created");
    }
    /**
     * 
    * 리뷰 처리
    * @param session
    * @param reviewVO
    * @param contentsVO
    * @return
    */
   @RequestMapping(value="/reply/reply_create.do", method=RequestMethod.POST)
   public ModelAndView reply_create (HttpSession session,ReplyVO replyVO,RecipeVO recipeVO){ 
       
       ModelAndView mav = new ModelAndView();
       int cnt=this.replyProc.reply_create(replyVO);
     if(memberProc.isMember(session)) {
         if (cnt == 1) {
             mav.setViewName("redirect:/recipe/read.do?recipeno=" + recipeVO.getRecipeno());
      
         } else {
           mav.addObject("code", "reply_create_fail");
         }
     }else {
         mav.addObject("url", "/member/login_need"); 
         mav.setViewName("redirect:/reply/msg.do"); 
     }
 //    mav.addObject("cnt", cnt);
//     mav.addObject("url", "/reply/msg");
     
//     mav.setViewName("redirect:/recipe/read.do?recipeno=" + recipeVO.getRecipeno());

     return mav;
   }



}
