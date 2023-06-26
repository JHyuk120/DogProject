package dev.mvc.recommend;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.item.ItemProcInter;
import dev.mvc.member.MemberProcInter;
import dev.mvc.recipe.RecipeProcInter;
import dev.mvc.recipe.RecipeVO;

@Controller
public class RecommendCont {
    
    @Autowired
    @Qualifier("dev.mvc.recommend.RecommendProc")
    private RecommendProcInter recommendProc;
    
    @Autowired
    @Qualifier("dev.mvc.item.ItemProc")
    private ItemProcInter itemProc;

    @Autowired
    @Qualifier("dev.mvc.recipe.RecipeProc")
    private RecipeProcInter recipeProc;
    
    @RequestMapping(value = "/recommend.do", method = RequestMethod.GET)
    public ModelAndView recommend(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        int memberno = (int) session.getAttribute("memberno");
        int itemno = this.recommendProc.recommend_read(memberno);
        
        if( itemno != 0) {          
            mav.addObject("itemno", itemno);
            ArrayList<RecommendVO> list = this.recommendProc.recommend(itemno);
            mav.addObject("list", list);
            mav.setViewName("/index"); // JSP 페이지 설정
        } else {
            mav.setViewName("/");
        }
        return mav;
    }

}
