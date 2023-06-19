package dev.mvc.recipe;

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
import dev.mvc.member.MemberProc;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.recom.RecomProcInter;
import dev.mvc.recom.RecomVO;
import dev.mvc.reply.ReplyDAOInter;
import dev.mvc.reply.ReplyProcInter;
import dev.mvc.reply.ReplyVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class RecipeCont {
  private static final ReplyVO ReplyVO = null;

@Autowired
  @Qualifier("dev.mvc.admin.AdminProc") 
  private AdminProcInter adminProc;
  
  @Autowired
  @Qualifier("dev.mvc.item.ItemProc") 
  private ItemProcInter itemProc;
  
  @Autowired
  @Qualifier("dev.mvc.recipe.RecipeProc") 
  private RecipeProcInter recipeProc;
  
  @Autowired
  @Qualifier("dev.mvc.recom.RecomProc")
  private RecomProcInter recomProc;
  
  @Autowired
  @Qualifier("dev.mvc.reply.ReplyProc")
  private ReplyProcInter replyProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  public RecipeCont () {
    System.out.println("-> RecipeCont created.");
  }
  
  // 등록 폼, recipe 테이블은 FK로 Itemno를 사용함.
  // http://localhost:9091/recipe/create.do  X
  // http://localhost:9091/recipe/create.do?itemno=1
  // http://localhost:9091/recipe/create.do?itemno=2
  // http://localhost:9091/recipe/create.do?itemno=3
  @RequestMapping(value="/recipe/create.do", method = RequestMethod.GET)
  public ModelAndView create(int itemno) {
//  public ModelAndView create(HttpServletRequest request,  int itemno) {
    ModelAndView mav = new ModelAndView();

    ItemVO itemVO = this.itemProc.read(itemno); // create.jsp에 카테고리 정보를 출력하기위한 목적
    mav.addObject("itemVO", itemVO);
//    request.setAttribute("itemVO", itemVO);
    
    mav.setViewName("/recipe/create"); // /webapp/WEB-INF/views/recipe/create.jsp
    
    return mav;
  }
  
  /**
   * 등록 처리 http://localhost:9091/recipe/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/recipe/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, HttpSession session, RecipeVO recipeVO,ReplyVO replyVO) {
    ModelAndView mav = new ModelAndView();

    if (memberProc.isMember(session)) { // 회원으로 로그인 한 경우
      int memberno = (int)session.getAttribute("memberno");
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 시작
      // ------------------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image
      String file1saved = "";   // 저장된 파일명, image
      String thumb1 = "";     // preview image

      String upDir =  Recipe.getUploadDir();
      System.out.println("-> upDir: " + upDir);
      
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = recipeVO.getFile1MF();
      
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
      recipeVO.setMemberno(memberno);
      recipeVO.setFile1(file1);   // 순수 원본 파일명
      recipeVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
      recipeVO.setThumb1(thumb1);      // 원본이미지 축소판
      recipeVO.setSize1(size1);  // 파일 크기
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 종료
      // ------------------------------------------------------------------------------
      
      // Call By Reference: 메모리 공유, Hashcode 전달
      int cnt = this.recipeProc.create(recipeVO); 
      
      // ------------------------------------------------------------------------------
      // PK의 return
      // ------------------------------------------------------------------------------
      // System.out.println("--> recipeno: " + recipeVO.getRecipeno());
      // mav.addObject("recipeno", recipeVO.getRecipeno()); // redirect parameter 적용
      // ------------------------------------------------------------------------------
      
      if (cnt == 1) {
        this.itemProc.update_cnt_add(recipeVO.getItemno()); //item테이블 글 수 증가
          mav.addObject("code", "create_success");
          
          // itemProc.increaseCnt(recipeVO.getItemno()); // 글수 증가
      } else {
          mav.addObject("code", "create_fail");
      }
      mav.addObject("cnt", cnt); // request.setAttribute("cnt", cnt)
      
      // System.out.println("--> itemno: " + recipeVO.getItemno());
      // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
      mav.addObject("itemno", recipeVO.getItemno()); // redirect parameter 적용

      mav.addObject("url", "/recipe/msg"); // msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/recipe/msg.do"); 

    } else {
      mav.setViewName("/member/login_need"); // /WEB-INF/views/admin/login_need.jsp
    }
    
    
    return mav; // forward
  }
  
  /**
   * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
   * @return
   */
  @RequestMapping(value="/recipe/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  }
  /**
   * 전체 카테고리 글 목록, http://localhost:9091/recipe/list_by_itemno_search_paging.do
   * @return
   */
  @RequestMapping(value="/recipe/list_all.do", method=RequestMethod.GET)
  public ModelAndView list_all() {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<RecipeVO> list = this.recipeProc.list_all();
    mav.addObject("list", list);
    
    mav.setViewName("/recipe/list_all"); // /webapp/WEB-INF/views/recipe/list_all.jsp
    
    return mav;
  }
//  /**
//   * 특정 카테고리 글 목록, http://localhost:9091/recipe/list_by_itemno_search_paging.do
//   * @return
//   */
//  @RequestMapping(value="/recipe/list_by_itemno.do", method=RequestMethod.GET)
//  public ModelAndView list_by_itemno(int itemno) {
//    ModelAndView mav = new ModelAndView();
//    
//    ItemVO itemvo = this.itemProc.read(itemno);
//    mav.addObject("itemVO", itemvo);
//    
//    
//    
//    ArrayList<recipeVO> list = this.recipeProc.list_by_itemno(itemno);
//    mav.addObject("list", list);
//    
//    mav.setViewName("/recipe/list_by_itemno"); // /webapp/WEB-INF/views/recipe/list_all_itemno.jsp
//    
//    return mav;
//  }
  
  // http://localhost:9091/recipe/read.do
  /**
   * 조회
   * @return
   */
  @RequestMapping(value="/recipe/read.do", method=RequestMethod.GET )
  public ModelAndView read(int recipeno, ReplyVO replyVO, RecomVO recomVO, HttpSession session) {
    ModelAndView mav = new ModelAndView();

    RecipeVO recipeVO = this.recipeProc.read(recipeno);
   
    String title = recipeVO.getTitle();
    String article = recipeVO.getArticle();
    
    title = Tool.convertChar(title);  // 특수 문자 처리
    article = Tool.convertChar(article); 
    
    recipeVO.setTitle(title);
    recipeVO.setArticle(article);  
    
    long size1 = recipeVO.getSize1();
    recipeVO.setSize1_label(Tool.unit(size1));    
    
    mav.addObject("recipeVO", recipeVO); // request.setAttribute("recipeVO", recipeVO);

    ItemVO itemVO = this.itemProc.read(recipeVO.getItemno()); // 그룹 정보 읽기
    mav.addObject("itemVO", itemVO); 
    
    //회원번호 : memberno -> 
    MemberVO memberVO = this.memberProc.read(recipeVO.getMemberno());
    String mname = memberVO.getMname();
    mav.addObject("mname", mname);

    mav.setViewName("/recipe/read"); // /WEB-INF/views/recipe/read.jsp
    // 댓글 조회
   
    ArrayList<ReplyVO> list = this.replyProc.list_by_reply_paging(replyVO);
    mav.addObject("list", list);
    String paging = replyProc.pagingBox(replyVO.getRecipeno(), replyVO.getNow_page(),"read.do");
    mav.addObject("paging", paging);
    //this.replyProc.replycnt_update(recipeno);

    ReplyVO replycnt = this.replyProc.replycnt(recipeno);
    mav.addObject("replycnt", replycnt);
    
    int cnt = this.recipeProc.cnt_add(recipeno);
    mav.addObject("cnt", cnt);
    
    // 좋아요 관련 시작
    
    //좋아요 갯수 확인
    int recom_cnt = this.recomProc.cnt(recipeno);
    mav.addObject("recom_cnt", recom_cnt);
    
    // 좋아요 확인
    if (memberProc.isMember(session)) {
      int memberno = (int) (session.getAttribute("memberno"));
      recomVO.setMemberno(memberno);
      
      int check_cnt = this.recomProc.check(recomVO);
      mav.addObject("check", check_cnt);
      
    }


    return mav;
  }
  

  /**
   * Youtube 등록/수정/삭제 폼
   *   // http://localhost:9091/recipe/youtube.do
   * @return
   */
  @RequestMapping(value="/recipe/youtube.do", method=RequestMethod.GET )
  public ModelAndView youtube(int recipeno) {
    ModelAndView mav = new ModelAndView();

    RecipeVO recipeVO = this.recipeProc.read(recipeno);
    mav.addObject("recipeVO", recipeVO); // request.setAttribute("recipeVO", recipeVO);

    ItemVO itemVO = this.itemProc.read(recipeVO.getItemno());
    mav.addObject("itemVO", itemVO); 

    mav.setViewName("/recipe/youtube"); // /WEB-INF/views/recipe/read.jsp
        
    return mav;
  }
  
  
  /**
   * Youtube 등록/수정/삭제 처리
   * http://localhost:9091/recipe/map.do
   * @param recipeVO
   * @return
   */
  @RequestMapping(value="/recipe/youtube.do", method = RequestMethod.POST)
  public ModelAndView youtube_update(RecipeVO recipeVO) {
    ModelAndView mav = new ModelAndView();
    
    if (recipeVO.getYoutube().trim().length() > 0) {
      
    // youtube 영상의 크기를 width 기준 640 px로 변경 
    String youtube = Tool.youtubeResize(recipeVO.getYoutube());
    recipeVO.setYoutube(youtube);
    }
    
    this.recipeProc.youtube(recipeVO);

    // youtube 크기 조절
    // <iframe width="1019" height="573" src="https://www.youtube.com/embed/Aubh5KOpz-4" title="교보문고에서 가장 잘나가는 일본 추리소설 베스트셀러 10위부터 1위까지 소개해드려요?" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
    
    
    mav.setViewName("redirect:/recipe/read.do?recipeno=" + recipeVO.getRecipeno()); 
    // /webapp/WEB-INF/views/recipe/read.jsp
    
    return mav;
  }
   
  /**
   * 목록 + 검색 + 페이징 지원
   * http://localhost:9091/recipe/list_by_itemno.do?itemno=1&word=스위스&now_page=1
   * 
   * @param itemno
   * @param word
   * @param now_page
   * @return
   */
  @RequestMapping(value = "/recipe/list_by_itemno.do", method = RequestMethod.GET)
  public ModelAndView list_by_itemno_search_paging(RecipeVO recipeVO) {
    ModelAndView mav = new ModelAndView();

    // 검색된 전체 글 수
    int search_count = this.recipeProc.search_count(recipeVO);
    mav.addObject("search_count", search_count);
    
    
    // 검색 목록: 검색된 레코드를 페이지 단위로 분할하여 가져옴
    ArrayList<RecipeVO> list = recipeProc.list_by_itemno_search_paging(recipeVO);
    mav.addObject("list", list);

    ItemVO itemVO = itemProc.read(recipeVO.getItemno());
    mav.addObject("itemVO", itemVO);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
     * 18 19 20 [다음]
     * @param itemno 카테고리번호
     * @param now_page 현재 페이지
     * @param word 검색어
     * @return 페이징용으로 생성된 HTML/CSS tag 문자열
     */
    String paging = recipeProc.pagingBox(recipeVO.getItemno(), recipeVO.getNow_page(), recipeVO.getWord(),"list_by_itemno.do");
    mav.addObject("paging", paging);

    // mav.addObject("now_page", now_page);
    
    mav.setViewName("/recipe/list_by_itemno_search_paging");  // /recipe/list_by_itemno_search_paging.jsp

    return mav;
  }
 

  /**
   * 목록 + 검색 + 페이징 +  Grid(갤러리) 지원
   * http://localhost:9091/recipe/list_by_itemno_grid.do?itemno=1&word=스위스&now_page=1
   * 
   * @param itemno
   * @param word
   * @param now_page
   * @return
   */
  @RequestMapping(value = "/recipe/list_by_itemno_grid.do", method = RequestMethod.GET)
  public ModelAndView list_by_itemno_search_paging_grid(RecipeVO recipeVO) {
    ModelAndView mav = new ModelAndView();
    
    // 검색된 전체 글 수
    int search_count = this.recipeProc.search_count(recipeVO);
    mav.addObject("search_count", search_count);

    // 검색 목록
    ArrayList<RecipeVO> list = recipeProc.list_by_itemno_search_paging(recipeVO);
    mav.addObject("list", list);

    ItemVO itemVO = itemProc.read(recipeVO.getItemno());
    mav.addObject("itemVO", itemVO);

    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
     * 18 19 20 [다음]
     * @param itemno 카테고리번호
     * @param now_page 현재 페이지
     * @param word 검색어
     * @return 페이징용으로 생성된 HTML/CSS tag 문자열
     */
    String paging = recipeProc.pagingBox(recipeVO.getItemno(), recipeVO.getNow_page(), recipeVO.getWord(), "list_by_itemno_grid.do");
    mav.addObject("paging", paging);

    // mav.addObject("now_page", now_page);
    
    mav.setViewName("/recipe/list_by_itemno_search_paging_grid");  // /recipe/list_by_itemno_search_paging_grid.jsp

    return mav;
  }
  
  /**
   * 수정 폼
   * http://localhost:9091/recipe/update_text.do?recipeno=1
   * 
   * @return
   */
  @RequestMapping(value = "/recipe/update_text.do", method = RequestMethod.GET)
  public ModelAndView update_text(int recipeno) {
    ModelAndView mav = new ModelAndView();
    
    RecipeVO recipeVO = this.recipeProc.read(recipeno);
    mav.addObject("recipeVO", recipeVO);
    
    ItemVO itemVO = this.itemProc.read(recipeVO.getItemno());
    mav.addObject("itemVO", itemVO);
    
    mav.setViewName("/recipe/update_text"); // /WEB-INF/views/recipe/update_text.jsp
    // String article = "장소:\n인원:\n준비물:\n비용:\n기타:\n";
    // mav.addObject("article", article);

    return mav; // forward
  }
  
  /**
   * 패스워드 확인
   * http://localhost:9091/recipe/password_check.do?recipeno=1&passwd=123
   * @return
   */
  @RequestMapping(value="/recipe/password_check.do", method=RequestMethod.GET )
  public ModelAndView password_check(RecipeVO recipeVO) {
    ModelAndView mav = new ModelAndView();
    
    int cnt = this.recipeProc.password_check(recipeVO);
    System.out.println("-> cnt:" + cnt);
    
    if(cnt == 0) {
    mav.setViewName("recipe/passwd_check"); // /WEB-INF/views/recipe/read.jsp
        
    }
    return mav;
  }
  
  
  /**
   * 수정 처리
   * http://localhost:9091/recipe/update_text.do?recipeno=1
   * 
   * @return
   */
  @RequestMapping(value = "/recipe/update_text.do", method = RequestMethod.POST)
  public ModelAndView update_text(HttpSession session, RecipeVO recipeVO) {
    ModelAndView mav = new ModelAndView();
    
    if(this.adminProc.isAdmin(session)) {
      this.recipeProc.update_text(recipeVO);
      
      mav.addObject("recipeno", recipeVO.getRecipeno());
      mav.addObject("itemno", recipeVO.getItemno());
      mav.setViewName("redirect:/recipe/read.do");
    }else {
      if(this.recipeProc.password_check(recipeVO) == 1) {
        this.recipeProc.update_text(recipeVO);
      
      // URL에 파라미터의 전송
      // mav.setViewName("redirect:/recipe/read.do?recipeno=" + recipeVO.getRecipeno() + "&itemno=" + recipeVO.getItemno());             
  
      // mav 객체 이용
      mav.addObject("recipeno", recipeVO.getRecipeno());
      mav.addObject("itemno", recipeVO.getItemno());
      mav.setViewName("redirect:/recipe/read.do");
      } else {
        mav.addObject("url", "recipe/passwd_check"); 
        mav.setViewName("redirect:/recipe/msg.do"); 
      }
    }
    
    mav.addObject("now_page", recipeVO.getNow_page());
    
    return mav; // forward
  }
  
  
  /**
   * 파일 수정 폼
   * http://localhost:9091/recipe/update_file.do?recipeno=1
   * 
   * @return
   */
  @RequestMapping(value = "/recipe/update_file.do", method = RequestMethod.GET)
  public ModelAndView update_file(int recipeno) {
    ModelAndView mav = new ModelAndView();
    
    RecipeVO recipeVO = this.recipeProc.read(recipeno);
    mav.addObject("recipeVO", recipeVO);
    
    ItemVO itemVO = this.itemProc.read(recipeVO.getItemno());
    mav.addObject("itemVO", itemVO);
    
    mav.setViewName("/recipe/update_file"); // /WEB-INF/views/recipe/update_file.jsp

    return mav; // forward
  }
  
  /**
   * 파일 수정 처리 http://localhost:9091/recipe/update_file.do
   * 
   * @return
   */
  @RequestMapping(value = "/recipe/update_file.do", method = RequestMethod.POST)
  public ModelAndView update_file(HttpSession session, RecipeVO recipeVO) {
    ModelAndView mav = new ModelAndView();
    
    if (this.adminProc.isAdmin(session)) {
      // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
      RecipeVO recipeVO_old = recipeProc.read(recipeVO.getRecipeno());
      
      // -------------------------------------------------------------------
      // 파일 삭제 코드 시작
      // -------------------------------------------------------------------
      String file1saved = recipeVO_old.getFile1saved();  // 실제 저장된 파일명
      String thumb1 = recipeVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
      long size1 = 0;
         
      // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/recipe/storage/
      // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/recipe/storage/"; // 절대 경로
      String upDir = Recipe.getUploadDir(); // C:\\kd\\deploy\\resort_v2sbm3c\\recipe\\storage\\
      
      Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
      Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료 시작
      // -------------------------------------------------------------------
          
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image

      // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/recipe/storage/
      // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/recipe/storage/"; // 절대 경로
          
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = recipeVO.getFile1MF();
          
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
          
      recipeVO.setFile1(file1);
      recipeVO.setFile1saved(file1saved);
      recipeVO.setThumb1(thumb1);
      recipeVO.setSize1(size1);
      // -------------------------------------------------------------------
      // 파일 전송 코드 종료
      // -------------------------------------------------------------------
          
      this.recipeProc.update_file(recipeVO); // Oracle 처리

      mav.addObject("recipeno", recipeVO.getRecipeno());
      mav.addObject("itemno", recipeVO.getItemno());
      

      mav.setViewName("redirect:/recipe/read.do"); // request -> param으로 접근 전환
                
    } else {
      mav.addObject("url", "/admin/login_need"); // login_need.jsp, redirect parameter 적용
      mav.setViewName("redirect:/recipe/msg.do"); // GET
    }
    
    // redirect 하게 되면 데이터가 삭제됨
    mav.addObject("now_page", recipeVO.getNow_page());

    return mav; // forward
  }   

  /**
   * 삭제 폼
   * @param recipeno
   * @return
   */
  @RequestMapping(value="/recipe/delete.do", method=RequestMethod.GET )
  public ModelAndView delete(int recipeno) { 
    ModelAndView mav = new  ModelAndView();
    
    // 삭제할 정보를 조회하여 확인
    RecipeVO recipeVO = this.recipeProc.read(recipeno);
    mav.addObject("recipeVO", recipeVO);
    
    ItemVO itemVO = this.itemProc.read(recipeVO.getItemno());
    mav.addObject("itemVO", itemVO);
    
    mav.setViewName("/recipe/delete");  // /webapp/WEB-INF/views/recipe/delete.jsp
    
    return mav; 
  }
  
  /**
   * 삭제 처리 http://localhost:9091/recipe/delete.do
   * 
   * @return
   */
  @RequestMapping(value = "/recipe/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RecipeVO recipeVO) {
    ModelAndView mav = new ModelAndView();
    
    // -------------------------------------------------------------------
    // 파일 삭제 코드 시작
    // -------------------------------------------------------------------
    // 삭제할 파일 정보를 읽어옴.
    RecipeVO recipeVO_read = recipeProc.read(recipeVO.getRecipeno());
        
    String file1saved = recipeVO.getFile1saved();
    String thumb1 = recipeVO.getThumb1();
       
    String uploadDir = Recipe.getUploadDir();
    Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
    Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
    // -------------------------------------------------------------------
    // 파일 삭제 종료 시작
    // -------------------------------------------------------------------
        
    this.recipeProc.delete(recipeVO.getRecipeno()); // DBMS 삭제
    
    this.itemProc.update_cnt_sub(recipeVO.getItemno());
        
    // -------------------------------------------------------------------------------------
    // 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
    // -------------------------------------------------------------------------------------    
    // 마지막 페이지의 마지막 10번째 레코드를 삭제후
    // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
    // 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
    int now_page = recipeVO.getNow_page();
    if (recipeProc.search_count(recipeVO) % Recipe.RECORD_PER_PAGE == 0) {
      now_page = now_page - 1;
      if (now_page < 1) {
        now_page = 1; // 시작 페이지
      }
    }
    // -------------------------------------------------------------------------------------

    mav.addObject("itemno", recipeVO.getItemno());
    mav.addObject("now_page", now_page);
    mav.setViewName("redirect:/recipe/list_by_itemno_grid.do"); 
    
    return mav;
  }   
  
  //http://localhost:9091/recipe/count_by_itemno.do?itemno=1
  @RequestMapping(value = "/recipe/count_by_itemno.do", method = RequestMethod.POST)
  public String count_by_itemno(int itemno) {
    System.out.println("-> count : " + this.recipeProc.count_by_itemno(itemno));
    
    return "";
  }
  // http://localhost:9091/recipe/delete_by_itemno.do?itemno=1
  // 파일 삭제 -> 레코드 삭제
  @RequestMapping(value = "/recipe/delete_by_itemno.do", method = RequestMethod.GET)
  public String delete_by_itemno(int itemno) {
    ArrayList<RecipeVO> list = this.recipeProc.list_by_itemno(itemno);
    
    for(RecipeVO recipeVO : list) {
      // -------------------------------------------------------------------
      // 파일 삭제 시작
      // -------------------------------------------------------------------
      String file1saved = recipeVO.getFile1saved();
      String thumb1 = recipeVO.getThumb1();
      
      String uploadDir = Recipe.getUploadDir();
      Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
      Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
      // -------------------------------------------------------------------
      // 파일 삭제 종료
      // -------------------------------------------------------------------
    }
    
    System.out.println("-> count: " + this.recipeProc.delete_by_itemno(itemno));
    
    return "";
  
  }
   //조회수
  
   @RequestMapping(value = "/recipe/cnt_add.do", method = RequestMethod.GET)
   public ModelAndView cnt_add(int recipeno) {
  
     ModelAndView mav = new ModelAndView();
  
     int cnt = this.recipeProc.cnt_add(recipeno);
  
     if (cnt == 1) {
  
       mav.setViewName("redirect:/index.do");
     } else {
  
       mav.addObject("code", "cnt_add_fail");
       mav.setViewName("/recipe/msg");
     }
  
     mav.addObject("cnt", cnt);
  
     return mav;
 }
   
    //좋아요Y(추천수, 따봉)
   
   @RequestMapping(value = "/recipe/recom_y.do", method = RequestMethod.GET)
   public ModelAndView recom_y(int memberno) {
       ModelAndView mav = new ModelAndView();

       int cnt = this.recipeProc.recom_y(memberno);

       if (cnt == 1) {
         
           mav.setViewName("redirect:/recipe/read.do");

       } else {
           mav.addObject("code", "recom_add_fail");
           mav.setViewName("/recipe/msg");
       }

       mav.addObject("cnt", cnt);

       return mav;
   }
   
 //좋아요N(추천수, 따봉)
   
   @RequestMapping(value = "/recipe/recom_n.do", method = RequestMethod.GET)
   public ModelAndView recom_n(int memberno) {
       ModelAndView mav = new ModelAndView();

       int cnt = this.recipeProc.recom_y(memberno);

       if (cnt == 1) {
         
           mav.setViewName("redirect:/recipe/read.do");

       } else {
           mav.addObject("code", "recom_add_fail");
           mav.setViewName("/recipe/msg");
       }

       mav.addObject("cnt", cnt);

       return mav;
   }
  
   
}
  