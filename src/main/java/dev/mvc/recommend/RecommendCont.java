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
    @Qualifier("dev.mvc.recipe.RecipeProc")
    private RecipeProcInter recipeProc;
    
    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProcInter memberProc;
    
    @RequestMapping(value = "/recommend.do", method = RequestMethod.GET)
    public ModelAndView recommend(HttpSession session) {
        ModelAndView mav = new ModelAndView();
        
        if (memberProc.isMember(session)) {
            int memberno = (int) session.getAttribute("memberno");
            int itemno = this.recommendProc.recommend_read(memberno);

            if (itemno != 0) {
                mav.addObject("itemno", itemno);
                ArrayList<RecommendVO> list = this.recommendProc.recommend(itemno);
                mav.addObject("list", list);
                mav.setViewName("/index");
            } else {
                mav.setViewName("/index");
            }
        } else {
            mav.setViewName("/index");
        }
        
        ArrayList<RecipeVO> recom_list = this.recipeProc.recom_list();
        mav.addObject("recom_list", recom_list);
        ArrayList<RecipeVO> new_list = this.recipeProc.new_list();
        mav.addObject("new_list", new_list);
        
        return mav;
    }

    
}
