package dev.mvc.review;

import java.util.ArrayList;

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
       /**
        * 
       * 리뷰 수정 폼
       * http://localhost:9093/review/update.do?
       * @param session
       * @param reviewVO
       * @param contentsVO
       * @return
       */
      @RequestMapping(value="/review/update.do", method=RequestMethod.GET)
      public ModelAndView review_update (int reviewno, int goodsno, ReviewVO reviewVO ){ 
          ModelAndView mav = new ModelAndView();
          
          GoodsVO goodsVO = this.goodsProc.read(goodsno);
          mav.addObject("goodsVO", goodsVO);
          
          ReviewVO review2VO = this.reviewProc.review_read(reviewno);
          mav.addObject("reviewVO", review2VO);
          
          
          // 댓글 조회`
          ArrayList<ReviewVO> list = this.reviewProc.list_by_review_paging(reviewVO);
          mav.addObject("list", list);
          String paging = reviewProc.pagingBox(reviewVO.getGoodsno(), reviewVO.getNow_page(),"read.do");
          mav.addObject("paging", paging);
          

        mav.setViewName("/review/review_update");
        return mav;
      }
      /**
       * 
      * 리뷰 수정 처리
      * http://localhost:9093/reply/reply_update.do?
      * @param session
      * @param reviewVO
      * @param contentsVO
      * @return
      */
      @RequestMapping(value = "/review/update.do", method = RequestMethod.POST)
      public ModelAndView review_update(HttpSession session, ReviewVO reviewVO, int goodsno) {
          ModelAndView mav = new ModelAndView();
          //현재 로그인된 id
          String currentUserId = (String) session.getAttribute("id");
          ReviewVO reviewVOmid = this.reviewProc.review_read(reviewVO.getReviewno());
          
           // 아이디 확인
          if (reviewVOmid != null && reviewVOmid.getMid().equals(currentUserId)) {
              this.reviewProc.review_update(reviewVO);
              mav.addObject("reviewno", reviewVO.getReviewno());
              mav.addObject("goodsno", goodsno);
              mav.setViewName("redirect:/goods/read.do");
          } else {
              mav.setViewName("./reply/login_need");
          }
          return mav;
      }
      /**
       * 리뷰 삭제
       * @param session
       * @param reviewVO
       * @param goodsno
       * @param reviewno
       * @return
       */
      @RequestMapping(value = "/review/delete.do", method = RequestMethod.GET)
      public ModelAndView review_delete(HttpSession session, ReviewVO reviewVO, int goodsno, int reviewno) {
          ModelAndView mav = new ModelAndView();
          //현재 로그인된 id
          String currentUserId = (String) session.getAttribute("id");
          ReviewVO reviewVOmid = this.reviewProc.review_read(reviewVO.getReviewno());
          
           // 아이디 확인
          if (reviewVOmid != null && reviewVOmid.getMid().equals(currentUserId)) {
              this.reviewProc.review_delete(reviewno);
              mav.addObject("reviewno", reviewVO.getReviewno());
              mav.addObject("goodsno", goodsno);
              mav.setViewName("redirect:/goods/read.do?goodno="+goodsno);
          } else {
              mav.setViewName("./reply/login_need");
          }
          return mav;
      }
      
             
       
        
    }

