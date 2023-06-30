package dev.mvc.dogProject;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.item.ItemProcInter;
import dev.mvc.item.ItemVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.recipe.RecipeProcInter;
import dev.mvc.recipe.RecipeVO;
import dev.mvc.recommend.RecommendProcInter;
import dev.mvc.recommend.RecommendVO;


// Setvlet으로 작동함, GET/POST등의 요청을 처리함.
@Controller
public class HomeCont {
  
  @Autowired
  @Qualifier("dev.mvc.item.ItemProc")
  private ItemProcInter itemProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;

  @Autowired
  @Qualifier("dev.mvc.recipe.RecipeProc")
  private RecipeProcInter recipeProc;
  
  @Autowired
  @Qualifier("dev.mvc.recommend.RecommendProc")
  private RecommendProcInter recommendProc;
  
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }
  
  // http://localhost:9093/
  // http://localhost:9093/index.do
  @RequestMapping(value= {"/", "/index.do"}, method=RequestMethod.GET)
  public ModelAndView home(HttpSession session) {
    ModelAndView mav = new ModelAndView();
    // spring.mvc.view.prefix=/WEB-INF/views/
    // spring.mvc.view.suffix=.jsp
    if (memberProc.isMember(session)) {
        int memberno = (int) session.getAttribute("memberno");
        int cnt = this.recommendProc.recommend_cnt(memberno);
        System.out.println("cnt : " + cnt);
        if (cnt != 0 ) {
            int itemno = this.recommendProc.recommend_read(memberno);
            mav.addObject("itemno", itemno);
            ArrayList<RecommendVO> list = this.recommendProc.recommend(itemno);
            mav.addObject("list", list);
            mav.setViewName("/index");
        } else {
            mav.addObject("memberno", memberno);
            mav.setViewName("redirect:http://15.164.233.43:8000/ais/recommend_form/?memberno="+memberno);
        }
        
    } else {
        mav.setViewName("/index");
    }
     // /WEB-INF/views/index.jsp
    ArrayList<RecipeVO>recom_list = this.recipeProc.recom_list();
    mav.addObject("recom_list", recom_list);
    ArrayList<RecipeVO>new_list = this.recipeProc.new_list();
    mav.addObject("new_list", new_list); 
    return mav;
  }
  
 // http://localhost:9093/menu/top.do
 @RequestMapping(value= {"/menu/top.do"}, method=RequestMethod.GET)
 public ModelAndView top(HttpSession session) {
   ModelAndView mav = new ModelAndView();
      
   ArrayList<ItemVO> list_f = this.itemProc.list_all();
   mav.addObject("list_f", list_f);
   
   ArrayList<ItemVO> list_y = this.itemProc.list_all_y();
   mav.addObject("list_y", list_y);
   
   if (memberProc.isMember(session)) {
     int memberno = (int) (session.getAttribute("memberno"));
     MemberVO memberVO = this.memberProc.read(memberno);
     mav.addObject("memberVO", memberVO);
   }
   
   mav.setViewName("/menu/top"); // /WEB-INF/views/menu/top.jsp
   
   return mav;
 }
 
 // http://localhost:9093/main/main.do
 @RequestMapping(value= {"/main/main.do"}, method=RequestMethod.GET)
 public ModelAndView main(HttpSession session) {
   ModelAndView mav = new ModelAndView();
   
   if (memberProc.isMember(session)) {
     int memberno = (int) (session.getAttribute("memberno"));
     MemberVO memberVO = this.memberProc.read(memberno);
     int itemno = this.recommendProc.recommend_read(memberno);
     ArrayList<RecommendVO> rlist = this.recommendProc.recommend(itemno);
     
     mav.addObject("rlist", rlist);
     
     mav.addObject("memberVO", memberVO);
   }
   
   mav.setViewName("/main/main"); // /WEB-INF/views/menu/top.jsp
   
   return mav;
 }
 
  
}
