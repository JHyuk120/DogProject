package dev.mvc.review;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.goods.GoodsProcInter;
import dev.mvc.goods.GoodsVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.recipe.RecipeVO;
import dev.mvc.reply.ReplyVO;

@Controller
public class ReviewCont {

    @Autowired
    @Qualifier("dev.mvc.review.ReviewProc")
    private ReviewProcInter reviewProc;
    @Autowired
    @Qualifier("dev.mvc.member.MemberProc")
    private MemberProcInter memberProc;
    @Autowired
    @Qualifier("dev.mvc.goods.GoodsProc")
    private GoodsProcInter goodsProc;
    
    public ReviewCont() {
        System.out.println("-> ReviewCont created");
    }
        /**
         * 리뷰 처리
         * @param session
         * @param reviewVO
         * @param goodsVO
         * @return
         */
       @RequestMapping(value="/review/create.do", method=RequestMethod.POST)
       public ModelAndView review_create (HttpSession session,ReviewVO reviewVO, GoodsVO goodsVO){ 
           ModelAndView mav = new ModelAndView();
           
           int cnt=this.reviewProc.review_create(reviewVO);
         if(memberProc.isMember(session)) {
             if (cnt == 1) {
                 // 별점 평균 계산 
                 this.reviewProc.ratingAVG_cal(reviewVO.getGoodsno());
                 // 업데이트된 별점 평균 조회
                 float ratingAVG = this.reviewProc.ratingAVG(goodsVO.getGoodsno());
                 
                 mav.addObject("ratingAVG", ratingAVG);
                 mav.addObject("goods", goodsVO);
                 mav.setViewName("redirect:/goods/read.do?goodsno=" + goodsVO.getGoodsno());
             } else {
               mav.addObject("code", "review_create_fail");
             }
         }else {
             mav.addObject("url", "/member/login_need"); 
             mav.setViewName("redirect:/review/msg.do"); 
         }
         return mav;
       }

       
        
    }

