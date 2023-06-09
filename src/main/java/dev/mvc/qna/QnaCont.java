//package dev.mvc.qna;
//
//import java.util.ArrayList;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Qualifier;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.multipart.MultipartFile;
//import org.springframework.web.servlet.ModelAndView;
//
//import dev.mvc.admin.AdminProcInter;
//import dev.mvc.admin.AdminVO;
//import dev.mvc.item.ItemProcInter;
//import dev.mvc.member.MemberProcInter;
//import dev.mvc.qna.QnaVO;
//import dev.mvc.qna.Qna;
//import dev.mvc.reply.ReplyVO;
//import dev.mvc.tool.Tool;
//import dev.mvc.tool.Upload;
//
//@Controller
//public class QnaCont {
//  
//  @Autowired
//  @Qualifier("dev.mvc.admin.adminrProc") 
//  private AdminProcInter adminProc;
//  
//  @Autowired
//  @Qualifier("dev.mvc.member.MemberProc") 
//  private MemberProcInter memberProc;
//  
//  @Autowired
//  @Qualifier("dev.mvc.qna.QnaProc") 
//  private QnaProcInter qnaProc;
//  
//  public QnaCont () {
//    System.out.println("-> QnaCont created.");
//  }
//  
//  //등록품  http://localhost:9093/qna/create.do
//  @RequestMapping(value = "/qna/create.do", method = RequestMethod.GET)
//  public ModelAndView create(HttpSession session, QnaVO qnaVO) {
//
//    ModelAndView mav = new ModelAndView();
//    
//    if (this.memberProc.isMember(session) == true) {
//      mav.setViewName("/qna/create");
//      
//    } else {
//      mav.setViewName("/admin/login_need");
//    }
//
//    return mav;
//  }
// 
//  //등록 처리
//  @RequestMapping(value = "/qna/create.do", method = RequestMethod.POST)
//  public ModelAndView create(HttpServletRequest request, HttpSession session, QnaVO qnaVO) {
//    ModelAndView mav = new ModelAndView();
//
//    if (memberProc.isMember(session)) { // 관리자로 로그인한경우
//      int memberno = (int)(session.getAttribute("memberno"));
//      qnaVO.setMemberno(memberno);
//     
//      
//      // Call By Reference: 메모리 공유, Hashcode 전달
//      int cnt = this.qnaProc.create(qnaVO); 
//     
//      if (cnt == 1) {
//        mav.addObject("code", "create_success");
//          // itemProc.increaseCnt(goodsVO.getItemno()); // 글수 증가
//      } else {
//          mav.addObject("code", "create_fail");
//      }
//      
//      mav.addObject("url", "/qna/msg"); // msg.jsp, redirect parameter 적용
//      mav.setViewName("redirect:/qna/msg.do"); 
//
//    } else {
//      mav.setViewName("/member/login_need"); // /WEB-INF/views/admin/login_need.jsp
//    }
//
//    return mav;
//  }
//    /**
//     * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
//     * @return
//     */
//    @RequestMapping(value="/qna/msg.do", method=RequestMethod.GET)
//    public ModelAndView msg(String url){
//      ModelAndView mav = new ModelAndView();
//
//      mav.setViewName(url); // forward
//      
//      return mav; // forward
//    }
//  
//    // QnA 목록
//    @RequestMapping(value="/qna/list_all.do", method=RequestMethod.GET)
//    public ModelAndView list_all(QnaVO qnaVO) {
//      ModelAndView mav = new ModelAndView();
//      
//      ArrayList<QnaVO> list = this.qnaProc.list_all();
//      mav.addObject("list", list);
//      
//      
//      mav.setViewName("/qna/list_all"); // /webapp/WEB-INF/views/qna/list_all.jsp
//      
//      return mav;
//    }
//    
//    // 조회
//    @RequestMapping(value="/qna/read.do", method=RequestMethod.GET )
//    public ModelAndView read(int qnano) {
//      ModelAndView mav = new ModelAndView();
//
//      QnaVO qnaVO = this.qnaProc.read(qnano);
//     
//      String title = qnaVO.getTitle();
//      String content = qnaVO.getContent();
//      
//      title = Tool.convertChar(title);  // 특수 문자 처리
//      content = Tool.convertChar(content); 
//      
//      qnaVO.setTitle(title);
//      qnaVO.setContent(content);  
//      
//      mav.addObject("qnaVO", qnaVO); // request.setAttribute("qnaVO", qnaVO);
//    
//      return mav;
//    }
//    
//    // 수정폼
//    @RequestMapping(value = "/qna/update_text.do", method = RequestMethod.GET)
//    public ModelAndView update_text(int qnano) {
//      ModelAndView mav = new ModelAndView();
//      
//      QnaVO qnaVO = this.qnaProc.read(qnano);
//      mav.addObject("qnaVO", qnaVO);
//
//      
//      mav.setViewName("/qna/update_text"); // /WEB-INF/views/qna/update_text.jsp
//      // String article = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
//      // mav.addObject("article", article);
//
//      return mav; // forward
//    }
//    
//    //수정처리
//    @RequestMapping(value = "/qna/update_text.do", method = RequestMethod.POST)
//    public ModelAndView update_text(HttpSession session, QnaVO qnaVO) {
//      ModelAndView mav = new ModelAndView();
//      
//      if(this.adminProc.isAdmin(session)) {
//        this.qnaProc.update_text(qnaVO);
//        
//        mav.addObject("qnano", qnaVO.getQnano());
//        mav.setViewName("redirect:/qna/read.do");
//      }else {
//        if(this.qnaProc.password_check(qnaVO) == 1) {
//          this.qnaProc.update_text(qnaVO);
//
//        // mav 객체 이용
//        mav.addObject("qnano", qnaVO.getQnano());
//        mav.setViewName("redirect:/qna/read.do");
//        } else {
//          mav.addObject("url", "qna/passwd_check"); 
//          mav.setViewName("redirect:/qna/msg.do"); 
//        }
//      }
//      
//      mav.addObject("now_page", qnaVO.getNow_page());
//      
//      return mav; // forward
//    }
//    
//    // 패스워드 확인
//    @RequestMapping(value="/qna/password_check.do", method=RequestMethod.GET )
//    public ModelAndView password_check(QnaVO qnaVO) {
//      ModelAndView mav = new ModelAndView();
//      
//      int cnt = this.qnaProc.password_check(qnaVO);
//      System.out.println("-> cnt:" + cnt);
//      
//      if(cnt == 0) {
//      mav.setViewName("qna/passwd_check"); // /WEB-INF/views/qna/read.jsp
//          
//      }
//      return mav;
//    }
//    
//    /**
//     * 삭제 폼
//     * @param qnano
//     * @return
//     */
//    @RequestMapping(value="/qna/delete.do", method=RequestMethod.GET )
//    public ModelAndView delete(int qnano) { 
//      ModelAndView mav = new  ModelAndView();
//      
//      // 삭제할 정보를 조회하여 확인
//      QnaVO qnaVO = this.qnaProc.read(qnano);
//      mav.addObject("qnaVO", qnaVO);
//
//      
//      mav.setViewName("/qna/delete");  // /webapp/WEB-INF/views/qna/delete.jsp
//      
//      return mav; 
//    }
//    
//    /**
//     * 삭제 처리 http://localhost:9091/qna/delete.do
//     * 
//     * @return
//     */
//    @RequestMapping(value = "/qna/delete.do", method = RequestMethod.POST)
//    public ModelAndView delete(QnaVO qnaVO) {
//      ModelAndView mav = new ModelAndView();
//          
//      this.qnaProc.delete(qnaVO.getQnano()); // DBMS 삭제
//      
//      return mav;
//    }   
//    
//  
//}
//  