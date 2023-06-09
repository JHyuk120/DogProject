package dev.mvc.notice;

import java.util.ArrayList;

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
import dev.mvc.item.ItemProcInter;
import dev.mvc.item.ItemVO;
import dev.mvc.notice.NoticeVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class NoticeCont {
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc") 
  private AdminProcInter adminProc;
  
  @Autowired
  @Qualifier("dev.mvc.notice.NoticeProc") 
  private NoticeProcInter noticeProc;
  
  public NoticeCont () {
    System.out.println("-> NoticeCont created.");
  }
  
  //등록품  http://localhost:9093/notice/create.do
  @RequestMapping(value = "/notice/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session, NoticeVO noticeVO) {

    ModelAndView mav = new ModelAndView();
    
    if (this.adminProc.isAdmin(session) == true) {
      mav.setViewName("/notice/create");
      
    } else {
      mav.setViewName("/admin/login_need");
    }

    return mav;
  }
 
  //등록 처리
  @RequestMapping(value = "/notice/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, HttpSession session, NoticeVO noticeVO) {
    ModelAndView mav = new ModelAndView();

    if (adminProc.isAdmin(session)) { // 관리자로 로그인한경우
      
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 시작
      // ------------------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image
      String file1saved = "";   // 저장된 파일명, image
      String thumb1 = "";     // preview image

      String upDir =  Notice.getUploadDir();
      System.out.println("-> upDir: " + upDir);
      
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = noticeVO.getFile1MF();
      
      file1 = Tool.getFname(mf.getOriginalFilename()); // 원본 순수 파일명 산출
      System.out.println("-> file1: " + file1);
      
      long size1 = mf.getSize();  // 파일 크기
      
      if (size1 > 0) { // 파일 크기 체크
        // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
        file1saved = Upload.saveFileSpring(mf, upDir); 
        
        if (Tool.isImage(file1saved)) { // 이미지인지 검사
          // thumb 이미지 생성후 파일명 리턴됨, width: 200, height: 150
          thumb1 = Tool.preview(upDir, file1saved, 200, 150); 
        }
        
      }    
      int adminno = (int)(session.getAttribute("adminno"));
      noticeVO.setAdminno(adminno);
      
      noticeVO.setFile1(file1);   // 순수 원본 파일명
      noticeVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
      noticeVO.setThumb1(thumb1);      // 원본이미지 축소판
      noticeVO.setSize1(size1);  // 파일 크기
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 종료
      // ------------------------------------------------------------------------------
      
      // Call By Reference: 메모리 공유, Hashcode 전달
      int cnt = this.noticeProc.create(noticeVO); 
     
      if (cnt == 1) {
        mav.addObject("code", "create_success");
          // itemProc.increaseCnt(goodsVO.getItemno()); // 글수 증가
      } else {
          mav.addObject("code", "create_fail");
      }
      
      mav.addObject("url", "/notice/msg"); // msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/notice/msg.do"); 

    } else {
      mav.setViewName("/admin/login_need"); // /WEB-INF/views/admin/login_need.jsp
    }
    

    return mav;
  }
    /**
     * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
     * @return
     */
    @RequestMapping(value="/notice/msg.do", method=RequestMethod.GET)
    public ModelAndView msg(String url){
      ModelAndView mav = new ModelAndView();

      mav.setViewName(url); // forward
      
      return mav; // forward
    }
  
    // 공지사항 목록
    @RequestMapping(value="/notice/list_all.do", method=RequestMethod.GET)
    public ModelAndView list_all(NoticeVO noticeVO) {
      ModelAndView mav = new ModelAndView();
      
      ArrayList<NoticeVO> list = this.noticeProc.list_all();
      mav.addObject("list", list);
      
      
      mav.setViewName("/notice/list_all"); // /webapp/WEB-INF/views/notice/list_all.jsp
      
      return mav;
    }
    
    // 조회
    @RequestMapping(value="/notice/read.do", method=RequestMethod.GET )
    public ModelAndView read(int noticeno) {
      ModelAndView mav = new ModelAndView();

      NoticeVO noticeVO = this.noticeProc.read(noticeno);
     
      String title = noticeVO.getTitle();
      String content = noticeVO.getContent();
      
      title = Tool.convertChar(title);  // 특수 문자 처리
      content = Tool.convertChar(content); 
      
      noticeVO.setTitle(title);
      noticeVO.setContent(content);  
      
      long size1 = noticeVO.getSize1();
      noticeVO.setSize1_label(Tool.unit(size1));      
      
      mav.addObject("noticeVO", noticeVO); // request.setAttribute("noticeVO", noticeVO);
    
      int cnt = this.noticeProc.cnt_add(noticeno);
      mav.addObject("cnt", cnt);
      
      return mav;
    }
    
    // 수정폼
    @RequestMapping(value = "/notice/update_text.do", method = RequestMethod.GET)
    public ModelAndView update_text(int noticeno) {
      ModelAndView mav = new ModelAndView();
      
      NoticeVO noticeVO = this.noticeProc.read(noticeno);
      mav.addObject("noticeVO", noticeVO);

      
      mav.setViewName("/notice/update_text"); // /WEB-INF/views/notice/update_text.jsp
      // String article = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
      // mav.addObject("article", article);

      return mav; // forward
    }
    
    //수정처리
    @RequestMapping(value = "/notice/update_text.do", method = RequestMethod.POST)
    public ModelAndView update_text(HttpSession session, NoticeVO noticeVO) {
      ModelAndView mav = new ModelAndView();
      
      if(this.adminProc.isAdmin(session)) {
        this.noticeProc.update_text(noticeVO);
        
        mav.addObject("noticeno", noticeVO.getNoticeno());
        mav.setViewName("redirect:/notice/read.do");
      }else {
        if(this.noticeProc.password_check(noticeVO) == 1) {
          this.noticeProc.update_text(noticeVO);

        // mav 객체 이용
        mav.addObject("noticeno", noticeVO.getNoticeno());
        mav.setViewName("redirect:/notice/read.do");
        } else {
          mav.addObject("url", "notice/passwd_check"); 
          mav.setViewName("redirect:/notice/msg.do"); 
        }
      }
      
      mav.addObject("now_page", noticeVO.getNow_page());
      
      return mav; // forward
    }
    
    // 패스워드 확인
    @RequestMapping(value="/notice/password_check.do", method=RequestMethod.GET )
    public ModelAndView password_check(NoticeVO noticeVO) {
      ModelAndView mav = new ModelAndView();
      
      int cnt = this.noticeProc.password_check(noticeVO);
      System.out.println("-> cnt:" + cnt);
      
      if(cnt == 0) {
      mav.setViewName("notice/passwd_check"); // /WEB-INF/views/notice/read.jsp
          
      }
      return mav;
    }
    
    
    //파일 수정폼
    @RequestMapping(value = "/notice/update_file.do", method = RequestMethod.GET)
    public ModelAndView update_file(int noticeno) {
      ModelAndView mav = new ModelAndView();
      
      NoticeVO noticeVO = this.noticeProc.read(noticeno);
      mav.addObject("noticeVO", noticeVO);
      
      mav.setViewName("/notice/update_file"); // /WEB-INF/views/notice/update_file.jsp

      return mav; // forward
    }
    
    //파일 수정처리
    @RequestMapping(value = "/notice/update_file.do", method = RequestMethod.POST)
    public ModelAndView update_file(HttpSession session, NoticeVO noticeVO) {
      ModelAndView mav = new ModelAndView();
      
      if (this.adminProc.isAdmin(session)) {
        // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
        NoticeVO noticeVO_old = noticeProc.read(noticeVO.getNoticeno());
        
        // -------------------------------------------------------------------
        // 파일 삭제 코드 시작
        // -------------------------------------------------------------------
        String file1saved = noticeVO_old.getFile1saved();  // 실제 저장된 파일명
        String thumb1 = noticeVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
        long size1 = 0;
           
        // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/notice/storage/
        // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/notice/storage/"; // 절대 경로
        String upDir = Notice.getUploadDir(); // C:\\kd\\deploy\\resort_v2sbm3c\\notice\\storage\\
        
        Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
        Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
        // -------------------------------------------------------------------
        // 파일 삭제 종료 시작
        // -------------------------------------------------------------------
            
        // -------------------------------------------------------------------
        // 파일 전송 코드 시작
        // -------------------------------------------------------------------
        String file1 = "";          // 원본 파일명 image

        // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/notice/storage/
        // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/notice/storage/"; // 절대 경로
            
        // 전송 파일이 없어도 file1MF 객체가 생성됨.
        // <input type='file' class="form-control" name='file1MF' id='file1MF' 
        //           value='' placeholder="파일 선택">
        MultipartFile mf = noticeVO.getFile1MF();
            
        file1 = mf.getOriginalFilename(); // 원본 파일명
        size1 = mf.getSize();  // 파일 크기
            
        if (size1 > 0) { // 파일 크기 체크
          // 파일 저장 후 업로드된 파일명이 리턴됨, spring.jsp, spring_1.jpg...
          file1saved = Upload.saveFileSpring(mf, upDir); 
          
          if (Tool.isImage(file1saved)) { // 이미지인지 검사
            // thumb 이미지 생성후 파일명 리턴됨, width: 250, height: 200
            thumb1 = Tool.preview(upDir, file1saved, 250, 200); 
          }
          
        } else { // 파일이 삭제만 되고 새로 올리지 않는 경우
          file1="";
          file1saved="";
          thumb1="";
          size1=0;
        }
            
        noticeVO.setFile1(file1);
        noticeVO.setFile1saved(file1saved);
        noticeVO.setThumb1(thumb1);
        noticeVO.setSize1(size1);
        // -------------------------------------------------------------------
        // 파일 전송 코드 종료
        // -------------------------------------------------------------------
            
        this.noticeProc.update_file(noticeVO); // Oracle 처리

        mav.addObject("noticeno", noticeVO.getNoticeno());
        
        mav.setViewName("redirect:/notice/read.do"); // request -> param으로 접근 전환
                  
      } else {
        mav.addObject("url", "/admin/login_need"); // login_need.jsp, redirect parameter 적용
        mav.setViewName("redirect:/notice/msg.do"); // GET
      }
      
      // redirect 하게 되면 데이터가 삭제됨
      mav.addObject("now_page", noticeVO.getNow_page());

      return mav; // forward
    }   
    
    /**
     * 삭제 폼
     * @param noticeno
     * @return
     */
    @RequestMapping(value="/notice/delete.do", method=RequestMethod.GET )
    public ModelAndView delete(int noticeno) { 
      ModelAndView mav = new  ModelAndView();
      
      // 삭제할 정보를 조회하여 확인
      NoticeVO noticeVO = this.noticeProc.read(noticeno);
      mav.addObject("noticeVO", noticeVO);

      
      mav.setViewName("/notice/delete");  // /webapp/WEB-INF/views/notice/delete.jsp
      
      return mav; 
    }
    
    /**
     * 삭제 처리 http://localhost:9091/notice/delete.do
     * 
     * @return
     */
    @RequestMapping(value = "/notice/delete.do", method = RequestMethod.POST)
    public ModelAndView delete(NoticeVO noticeVO) {
      ModelAndView mav = new ModelAndView();
      
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      // 삭제할 파일 정보를 읽어옴.
      NoticeVO noticeVO_read = noticeProc.read(noticeVO.getNoticeno());
          
      String file1saved = noticeVO.getFile1saved();
      String thumb1 = noticeVO.getThumb1();
         
      String uploadDir = Notice.getUploadDir();
      Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
      Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료 시작
      // -------------------------------------------------------------------
          
      this.noticeProc.delete(noticeVO.getNoticeno()); // DBMS 삭제

      
      return mav;
    }   
    

     //조회수
    
     @RequestMapping(value = "/notice/cnt_add.do", method = RequestMethod.GET)
     public ModelAndView cnt_add(int noticeno) {
    
       ModelAndView mav = new ModelAndView();
    
       int cnt = this.noticeProc.cnt_add(noticeno);
    
       if (cnt == 1) {
    
         mav.setViewName("redirect:/index.do");
       } else {
    
         mav.addObject("code", "cnt_add_fail");
         mav.setViewName("/notice/msg");
       }
    
       mav.addObject("cnt", cnt);
    
       return mav;
   }
    
  
}
  