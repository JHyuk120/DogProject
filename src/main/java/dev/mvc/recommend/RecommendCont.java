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
    
}
