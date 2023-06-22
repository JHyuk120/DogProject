package dev.mvc.qna;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
import dev.mvc.admin.AdminVO;
import dev.mvc.attachfile.AttachfileProcInter;
import dev.mvc.attachfile.AttachfileVO;
import dev.mvc.item.ItemProcInter;
import dev.mvc.item.ItemVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.notice.Notice;
import dev.mvc.notice.NoticeVO;
import dev.mvc.qna.QnaVO;
import dev.mvc.qna.Qna;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class QnaCont {
  
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc") 
  private AdminProcInter adminProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc") 
  private MemberProcInter memberProc;
  
  @Autowired
  @Qualifier("dev.mvc.qna.QnaProc") 
  private QnaProcInter qnaProc;
  
  @Autowired
  @Qualifier("dev.mvc.attachfile.AttachfileProc") 
  private AttachfileProcInter attachfileProc;
  
  public QnaCont () {
    System.out.println("-> QnaCont created.");
  }
  
  //등록품  http://localhost:9093/qna/create.do
  @RequestMapping(value = "/qna/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session, QnaVO qnaVO) {

    ModelAndView mav = new ModelAndView();
    
    if (this.memberProc.isMember(session) == true) {
      mav.setViewName("/qna/create");
      
    } else {
      mav.setViewName("/admin/login_need");
    }

    return mav;
  }
 
  //등록 처리
  @RequestMapping(value = "/qna/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, HttpSession session, QnaVO qnaVO, AttachfileVO attachfileVO) {
    ModelAndView mav = new ModelAndView();

    if (memberProc.isMember(session)) { // 회원으로 로그인한경우
      int memberno = (int)(session.getAttribute("memberno"));
      qnaVO.setMemberno(memberno);
      
      int cnt = this.qnaProc.create(qnaVO); // Call By Reference로 메모리 공유가 일어나 pk값이 저장되어 공유됨.
     
      int qnano = qnaVO.getQnano();
     
    // ---------------------------------------------------------------
    // 파일 전송 코드 시작
    // ---------------------------------------------------------------
    String fname = ""; // 원본 파일명
    String fupname = ""; // 업로드된 파일명
    long fsize = 0;  // 파일 사이즈
    String thumb = ""; // Preview 이미지
    int upload_count = 0; // 정상처리된 레코드 갯수
    
    String upDir = Qna.getUploadDir(); // 경로설정
    System.out.println("-> 파일 업로드: " + upDir);
    
    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
    List<MultipartFile> fnamesMF = attachfileVO.getFnamesMF();
    
    int count = fnamesMF.size(); // 전송 파일 갯수
    if (count > 0) {
      for (MultipartFile multipartFile:fnamesMF) { // 파일 추출, 1개이상 파일 처리
        fsize = multipartFile.getSize();  // 파일 크기
        if (fsize > 0) { // 파일 크기 체크
          fname = multipartFile.getOriginalFilename(); // 원본 파일명
          fupname = Upload.saveFileSpring(multipartFile, upDir); // 파일 저장, 업로드된 파일명
          
          if (Tool.isImage(fname)) { // 이미지인지 검사
            thumb = Tool.preview(upDir, fupname, 200, 150); // thumb 이미지 생성
          }
        }
        
        AttachfileVO vo = new AttachfileVO();
        vo.setQnano(qnano);
        vo.setFname(fname);
        vo.setFupname(fupname);
        vo.setThumb(thumb);
        vo.setFsize(fsize);
        
        // 파일 1건 등록 정보 dbms 저장, 파일이 20개이면 20개의 record insert.
        upload_count = upload_count + attachfileProc.create(vo); 
        System.out.println("경로: " + upDir);
        
      }
    }    
    // -----------------------------------------------------
    // 파일 전송 코드 종료
    // -----------------------------------------------------
           
      // Call By Reference: 메모리 공유, Hashcode 전달
      qnaVO.setMemberno(memberno);      
      
      
      if (cnt == 1) {
        mav.addObject("code", "create_success");
          // itemProc.increaseCnt(goodsVO.getItemno()); // 글수 증가
      } else {
          mav.addObject("code", "create_fail");
      }
      
      mav.addObject("upload_count", upload_count); // redirect parameter 적용
      
      mav.addObject("url", "/qna/msg"); // msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/qna/msg.do"); 

    } else {
      mav.setViewName("/member/login_need"); // /WEB-INF/views/admin/login_need.jsp
    }

    return mav;
  }
    /**
     * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
     * @return
     */
    @RequestMapping(value="/qna/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url){
      ModelAndView mav = new ModelAndView();

      mav.setViewName(url); // forward
      
      return mav; // forward
    }
  
    // QnA 목록
    @RequestMapping(value="/qna/list_all.do", method=RequestMethod.GET)
    public ModelAndView list_all(QnaVO qnaVO) {
      ModelAndView mav = new ModelAndView();
      
      ArrayList<QnaVO> list = this.qnaProc.list_all();
      mav.addObject("list", list);
      
      
      mav.setViewName("/qna/list_all"); // /webapp/WEB-INF/views/qna/list_all.jsp
      
      return mav;
    }
    
    // 조회
    @RequestMapping(value="/qna/read.do", method=RequestMethod.GET )
    public ModelAndView read(int qnano) {
      ModelAndView mav = new ModelAndView();

      QnaVO qnaVO = this.qnaProc.read(qnano);
      
      ArrayList<AttachfileVO> list = this.attachfileProc.read(qnano);
      mav.addObject("list", list);
     
      String title = qnaVO.getTitle();
      String content = qnaVO.getContent();
      
      title = Tool.convertChar(title);  // 특수 문자 처리
      content = Tool.convertChar(content); 
      
      qnaVO.setTitle(title);
      qnaVO.setContent(content);  
      
      mav.addObject("qnaVO", qnaVO); // request.setAttribute("qnaVO", qnaVO);
    
      return mav;
    }
    
    /**
     * 목록 + 검색 + 페이징 지원
     * http://localhost:9091/qna/list_all.do
     * 
     * @param auction_no
     * @param word
     * @param now_page
     * @return
     */
    @RequestMapping(value = "/qna/list_by_search.do", method = RequestMethod.GET)
    public ModelAndView list_by_search_paging(QnaVO qnaVO) {

      ModelAndView mav = new ModelAndView();
      
      //검색된 전체 글 수
      int search_count = this.qnaProc.search_count(qnaVO);
      mav.addObject("search_count", search_count);
      
      // 검색 목록
      ArrayList<QnaVO> list = qnaProc.list_by_search_paging(qnaVO);
      mav.addObject("list", list);
      
      mav.addObject("qnaVO", qnaVO);

      /*
       * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
       * 18 19 20 [다음]
       * @param auction_no 카테고리번호
       * @param search_count 검색(전체) 레코드수
       * @param now_page 현재 페이지
       * @param word 검색어
       * @return 페이징용으로 생성된 HTML/CSS tag 문자열
       */
      String paging = qnaProc.pagingBox(qnaVO.getNow_page(), qnaVO.getWord(), "list_by_search.do");
      mav.addObject("paging", paging);

      // mav.addObject("now_page", now_page);
      
      mav.setViewName("/qna/list_all");  

      return mav;
    }
    
    // 수정폼
    @RequestMapping(value = "/qna/update_text.do", method = RequestMethod.GET)
    public ModelAndView update_text(int qnano) {
      ModelAndView mav = new ModelAndView();
      
      QnaVO qnaVO = this.qnaProc.read(qnano);
      mav.addObject("qnaVO", qnaVO);

      
      mav.setViewName("/qna/update_text"); 

      return mav; // forward
    }
    
    //수정처리
    @RequestMapping(value = "/qna/update_text.do", method = RequestMethod.POST)
    public ModelAndView update_text(HttpSession session, QnaVO qnaVO, AttachfileVO attachfileVO) {
      ModelAndView mav = new ModelAndView();
      
      if(this.qnaProc.password_check(qnaVO) == 1) {
        QnaVO qnaVO_old = qnaProc.read(qnaVO.getQnano());
        ArrayList<AttachfileVO> attachfileVO_old = attachfileProc.read(attachfileVO.getQnano());

        // -------------------------------------------------------------------
        // 파일 삭제 코드 시작
        // -------------------------------------------------------------------
        // 삭제할 파일 정보를 읽어옴.
         ArrayList<AttachfileVO> list = this.attachfileProc.read(attachfileVO.getQnano()); 
         for (int i=0; i < list.size(); i++) {
          attachfileVO = list.get(i);
            
          String fupname = attachfileVO.getFupname();
          String thumb = attachfileVO.getThumb();
           
          String upDir = Qna.getUploadDir(); // 경로설정
     
          Tool.deleteFile(upDir, attachfileVO.getFupname()); // Folder에서 1건의 파일 삭제
          Tool.deleteFile(upDir, attachfileVO.getThumb()); // 1건의 Thumb 파일 삭제
         }
          // -------------------------------------------------------------------
          // 파일 삭제 종료 
          // -------------------------------------------------------------------
         
         String fname = ""; // 원본 파일명
         String fupname = ""; // 업로드된 파일명
         long fsize = 0;  // 파일 사이즈
         String thumb = ""; // Preview 이미지
         int upload_count = 0; // 정상처리된 레코드 갯수
         
         String upDir = Qna.getUploadDir(); // 경로설정
         
         List<MultipartFile> fnamesMF = attachfileVO.getFnamesMF();
         
         int count = fnamesMF.size(); // 전송 파일 갯수
         if (count > 0) {
           for (MultipartFile multipartFile:fnamesMF) { // 파일 추출, 1개이상 파일 처리
             fsize = multipartFile.getSize();  // 파일 크기
             if (fsize > 0) { // 파일 크기 체크
               fname = multipartFile.getOriginalFilename(); // 원본 파일명
               fupname = Upload.saveFileSpring(multipartFile, upDir); // 파일 저장, 업로드된 파일명
             }
           }
         }
         
         attachfileVO.setFname(fname);
         attachfileVO.setFupname(fupname);
         attachfileVO.setThumb(thumb);
         attachfileVO.setFsize(fsize);
        
         // -------------------------------------------------------------------
         // 파일 전송 코드 종료
         // -------------------------------------------------------------------
        
        this.qnaProc.update_text(qnaVO);
        this.attachfileProc.update_file(attachfileVO.getQnano());
        
        mav.addObject("qnano", qnaVO.getQnano());
        
        mav.setViewName("redirect:/qna/read.do");
        
      } else {
        mav.addObject("url", "qna/passwd_check"); 
        mav.setViewName("redirect:/qna/msg.do"); 
      }
        mav.addObject("now_page", qnaVO.getNow_page());
        
      return mav; // forward
    }
    
    // 패스워드 확인
    @RequestMapping(value="/qna/password_check.do", method=RequestMethod.GET )
    public ModelAndView password_check(QnaVO qnaVO) {
      ModelAndView mav = new ModelAndView();
      
      int cnt = this.qnaProc.password_check(qnaVO);
      System.out.println("-> cnt:" + cnt);
      
      if(cnt == 0) {
      mav.setViewName("qna/passwd_check"); // /WEB-INF/views/qna/read.jsp
          
      }
      return mav;
    }
    
    /**
     * 삭제 폼
     * @param qnano
     * @return
     */
    @RequestMapping(value="/qna/delete.do", method=RequestMethod.GET )
    public ModelAndView delete(int qnano) { 
      ModelAndView mav = new  ModelAndView();
      
      // 삭제할 정보를 조회하여 확인
      QnaVO qnaVO = this.qnaProc.read(qnano);
      mav.addObject("qnaVO", qnaVO);

      
      mav.setViewName("/qna/delete");  // /webapp/WEB-INF/views/qna/delete.jsp
      
      return mav; 
    }
    
    /**
     * 삭제 처리 http://localhost:9091/qna/delete.do
     * 
     * @return
     */
    @RequestMapping(value = "/qna/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(HttpServletRequest request, int qnano, AttachfileVO attachfileVO) {
      ModelAndView mav = new ModelAndView();
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
       QnaVO qnaVO = this.qnaProc.read(qnano);
       ArrayList<AttachfileVO> list = this.attachfileProc.read(qnano); 
       for (int i=0; i < list.size(); i++) {
        attachfileVO = list.get(i);
          
      String fupname = attachfileVO.getFupname();
      String thumb = attachfileVO.getThumb();
         
      String upDir = Qna.getUploadDir(); // 경로설정
 
      Tool.deleteFile(upDir, attachfileVO.getFupname()); // Folder에서 1건의 파일 삭제
      Tool.deleteFile(upDir, attachfileVO.getThumb()); // 1건의 Thumb 파일 삭제
      
       }
      // -------------------------------------------------------------------
      // 파일 삭제 종료 
      // -------------------------------------------------------------------
          
      this.qnaProc.delete(qnaVO.getQnano()); // DBMS Q&A삭제
      

      mav.setViewName("redirect:/qna/list_all.do"); 
      
      
      return mav;
    }   
    
  
}
  