package dev.mvc.goods;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;


import javax.servlet.http.Cookie;
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
import dev.mvc.goods.Goods;
import dev.mvc.goods.GoodsProcInter;
import dev.mvc.goods.GoodsVO;
import dev.mvc.item.ItemProcInter;
import dev.mvc.item.ItemVO;
import dev.mvc.member.MemberProcInter;
import dev.mvc.member.MemberVO;
import dev.mvc.reply.ReplyVO;
import dev.mvc.review.ReviewProcInter;
import dev.mvc.review.ReviewVO;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;
@Controller
public class GoodsCont {
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc") 
  private AdminProcInter adminProc;
  
  @Autowired
  @Qualifier("dev.mvc.item.ItemProc") 
  private ItemProcInter itemProc;
  
  @Autowired
  @Qualifier("dev.mvc.goods.GoodsProc") 
  private GoodsProcInter goodsProc;
  
  @Autowired
  @Qualifier("dev.mvc.review.ReviewProc")
  private ReviewProcInter reviewProc;
  
  @Autowired
  @Qualifier("dev.mvc.member.MemberProc")
  private MemberProcInter memberProc;
  
  public GoodsCont () {
    System.out.println("-> GoodsCont created.");
  }
  
  // 등록 폼, goods테이블은 FK로 itemno를 사용함.
  // http://localhost:9091/goods/create.do?itemno=1
  @RequestMapping(value="/goods/create.do", method = RequestMethod.GET)
  public ModelAndView create(int itemno) {
//  public ModelAndView create(HttpServletRequest request,  int itemno) {
    ModelAndView mav = new ModelAndView();

    ItemVO itemVO = this.itemProc.read(itemno);
    mav.addObject("itemVO", itemVO);
//    request.setAttribute("itemVO", itemVO);
    
    mav.setViewName("/goods/create"); // /webapp/WEB-INF/views/goods/create.jsp
    
    return mav;
  }
  
  /**
   * 등록 처리 http://localhost:9093/goods/create.do
   * 
   * @return
   */
  @RequestMapping(value = "/goods/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request, HttpSession session, GoodsVO goodsVO) {
    ModelAndView mav = new ModelAndView();
    
    if (adminProc.isAdmin(session)) { // 관리자로 로그인한경우
      
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 시작
      // ------------------------------------------------------------------------------
      String file1 = "";          // 원본 파일명 image
      String file1saved = "";   // 저장된 파일명, image
      String thumb1 = "";     // preview image
      
      int price = goodsVO.getPrice();  // 정가
      int dc = goodsVO.getDc();
      int saleprice = (int)(price - (price * (dc / 100.0)));// 할인된 금액//saleprice = price - price * (dc / 100)
      int point = (int)( saleprice * (2 / 100.0)); //포인트
     
      String upDir =  Goods.getUploadDir();
      System.out.println("-> upDir: " + upDir);
      
      // 전송 파일이 없어도 file1MF 객체가 생성됨.
      // <input type='file' class="form-control" name='file1MF' id='file1MF' 
      //           value='' placeholder="파일 선택">
      MultipartFile mf = goodsVO.getFile1MF();
      
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
      goodsVO.setFile1(file1);   // 순수 원본 파일명
      goodsVO.setFile1saved(file1saved); // 저장된 파일명(파일명 중복 처리)
      goodsVO.setThumb1(thumb1);      // 원본이미지 축소판
      goodsVO.setSize1(size1);  // 파일 크기
      goodsVO.setSaleprice(saleprice);
      goodsVO.setPoint(point);
      // ------------------------------------------------------------------------------
      // 파일 전송 코드 종료
      // ------------------------------------------------------------------------------
      
      // Call By Reference: 메모리 공유, Hashcode 전달
      int adminno = (int)(session.getAttribute("adminno"));
      goodsVO.setAdminno(adminno);
      int cnt = this.goodsProc.create(goodsVO); 
      
      // ------------------------------------------------------------------------------
      // PK의 return
      // ------------------------------------------------------------------------------
      // System.out.println("--> goodsno: " + goodsVO.getGoodsno());
      // mav.addObject("goodsno", goodsVO.getGoodsno()); // redirect parameter 적용
      // ------------------------------------------------------------------------------
      
      if (cnt == 1) {
        this.itemProc.update_cnt_add(goodsVO.getItemno());
        mav.addObject("code", "create_success");
          // itemProc.increaseCnt(goodsVO.getItemno()); // 글수 증가
      } else {
          mav.addObject("code", "create_fail");
      }
       // request.setAttribute("cnt", cnt)
      
      // System.out.println("--> itemno: " + goodsVO.getItemno());
      // redirect시에 hidden tag로 보낸것들이 전달이 안됨으로 request에 다시 저장
      mav.addObject("itemno", goodsVO.getItemno()); // redirect parameter 적용
      
      mav.addObject("url", "/goods/msg"); // msg.jsp, redirect parameter 적용
      mav.setViewName("redirect:/goods/msg.do"); 

      
    } else {
      mav.addObject("url", "/admin/login_need");
      mav.setViewName("redirect:/goods/msg.do"); 
    }
   
    return mav; // forward
  }
  
  /**
   * POST 요청시 JSP 페이지에서 JSTL 호출 기능 지원, 새로고침 방지, EL에서 param으로 접근
   * @return
   */
  @RequestMapping(value="/goods/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();

    mav.setViewName(url); // forward
    
    return mav; // forward
  } 
  
  /**
   * 전체 목록, http://localhost:9091/goods/list_all.do
   * @return
   */
  @RequestMapping(value="/goods/list_all.do", method=RequestMethod.GET)
  public ModelAndView list_all() {
    ModelAndView mav = new ModelAndView();
    
    ArrayList<GoodsVO> list = this.goodsProc.list_all();
    mav.addObject("list", list);
    
    mav.setViewName("/goods/list_all"); // /webapp/WEB-INF/views/goods/list_all.jsp
    
    return mav;
  }
  
//  /**
//   * 특정 카테고리의 등록된 글목록
//   * http://localhost:9091/goods/list_by_itemno.do?itemno=1
//   * http://localhost:9091/goods/list_by_itemno.do?itemno=2
//   * http://localhost:9091/goods/list_by_itemno.do?itemno=3
//   * @return
//   */
//  @RequestMapping(value="/goods/list_by_itemno.do", method=RequestMethod.GET)
//  public ModelAndView list_by_itemno(int itemno) {
//    ModelAndView mav = new ModelAndView();
//    
//    ItemVO itemVO = this.itemProc.read(itemno);
//    mav.addObject("itemVO", itemVO);
//        
//    ArrayList<GoodsVO> list = this.goodsProc.list_by_itemno(itemno);
//    mav.addObject("list", list);
//    
//    mav.setViewName("/goods/list_by_itemno"); // /webapp/WEB-INF/views/goods/list_by_itemno.jsp
//    
//    return mav;
//  }
  
//http://localhost:9091/goods/read.do
/**
 * 조회
 * @return
 */
  @RequestMapping(value="/goods/read.do", method=RequestMethod.GET )
  public ModelAndView read(HttpServletRequest request, HttpSession session,int goodsno, ReviewVO reviewVO) {
    ModelAndView mav = new ModelAndView();

    GoodsVO goodsVO = this.goodsProc.read(goodsno);
    
    String gname = goodsVO.getGname();
    String content = goodsVO.getContent();
    
    gname = Tool.convertChar(gname);  // 특수 문자 처리
    content = Tool.convertChar(content); 
    
    goodsVO.setGname(gname);
    goodsVO.setContent(content);
    
    
    
    long size1 = goodsVO.getSize1();
    goodsVO.setSize1_label(Tool.unit(size1));    
    
    mav.addObject("goodsVO", goodsVO); // request.setAttribute("goodsVO", goodsVO);

    ItemVO itemVO = this.itemProc.read(goodsVO.getItemno()); // 그룹 정보 읽기
    mav.addObject("itemVO", itemVO); 
    
    // 회원 번호: adminno -> 
    String mname = this.adminProc.read(goodsVO.getAdminno()).getMname();
    mav.addObject("mname", mname);

    mav.setViewName("/goods/read"); // /WEB-INF/views/goods/read.jsp
    
    ArrayList<ReviewVO> list = this.reviewProc.list_by_review_paging(reviewVO);
    String paging = reviewProc.pagingBox(reviewVO.getGoodsno(), reviewVO.getNow_page(),"read.do");
    mav.addObject("paging", paging);
    mav.addObject("list", list);
 
    // 게시물 별 리뷰 평점
    float ratingAVG = this.reviewProc.ratingAVG(goodsno);
    mav.addObject("ratingAVG", ratingAVG);

    // 게시물 별 리뷰 수
   int reviewcnt =  this.reviewProc.review_count(goodsno);
   mav.addObject("reviewcnt", reviewcnt);
   
    return mav;
}

 
 /**
  * 목록 + 검색 + 페이징 지원 + Cooike
  * http://localhost:9093/goods/list_by_itemno.do?itemno=1&word=스위스&now_page=1
  * 
  * @param itemno
  * @param word
  * @param now_page
  * @return
  */
 @RequestMapping(value = "/goods/list_by_itemno_search_paging_cart.do", method = RequestMethod.GET)
 public ModelAndView list_by_itemno_search_paging(
                            HttpServletRequest request,GoodsVO goodsVO) {

  
   ModelAndView mav = new ModelAndView();

   // 검색된 전체 글 수
   int search_count = this.goodsProc.search_count(goodsVO);
   mav.addObject("search_count", search_count);
   
   // 검색 목록: 검색된 레코드를 페이지 단위로 분할하여 가져옴
   ArrayList<GoodsVO> list = goodsProc.list_by_itemno_search_paging(goodsVO);
   mav.addObject("list", list);

   ItemVO itemVO = itemProc.read(goodsVO.getItemno());
   mav.addObject("itemVO", itemVO);

   /*
    * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
    * 18 19 20 [다음]
    * @param itemno 카테고리번호
    * @param search_count 검색(전체) 레코드수
    * @param now_page 현재 페이지
    * @param word 검색어
    * @return 페이징용으로 생성된 HTML/CSS tag 문자열
    */
   String paging = goodsProc.pagingBox(goodsVO.getItemno(), goodsVO.getNow_page(), goodsVO.getWord(), "list_by_itemno_search_paging_cart.do");
   mav.addObject("paging", paging);

   // mav.addObject("now_page", now_page);
   
   mav.setViewName("/goods/list_by_itemno_search_paging_cart");  // /goods/list_by_itemno_search_paging.jsp
  
   //장바구니에 상품 등록전 로그인 폼 출력 관련 쿠키
   Cookie[] cookies = request.getCookies();
   Cookie cookie = null;

   String ck_id = ""; // id 저장
   String ck_id_save = ""; // id 저장 여부를 체크
   String ck_passwd = ""; // passwd 저장
   String ck_passwd_save = ""; // passwd 저장 여부를 체크

   if (cookies != null) {  // Cookie 변수가 있다면
     for (int i=0; i < cookies.length; i++){
       cookie = cookies[i]; // 쿠키 객체 추출
       
       if (cookie.getName().equals("ck_id")){
         ck_id = cookie.getValue();                                 // Cookie에 저장된 id
       }else if(cookie.getName().equals("ck_id_save")){
         ck_id_save = cookie.getValue();                          // Cookie에 id를 저장 할 것인지의 여부, Y, N
       }else if (cookie.getName().equals("ck_passwd")){
         ck_passwd = cookie.getValue();                          // Cookie에 저장된 password
       }else if(cookie.getName().equals("ck_passwd_save")){
         ck_passwd_save = cookie.getValue();                  // Cookie에 password를 저장 할 것인지의 여부, Y, N
       }
     }
   }
   
   System.out.println("-> ck_id  : " + ck_id);
   
   mav.addObject("ck_id", ck_id); 
   mav.addObject("ck_id_save", ck_id_save);
   mav.addObject("ck_passwd", ck_passwd);
   mav.addObject("ck_passwd_save", ck_passwd_save);
   
   
   return mav;
 }
 
 /**
  * 목록 + 검색 + 페이징 + 그리드(Grid)
  * http://localhost:9091/goods/list_by_itemno_grid.do?itemno=1&word=스위스&now_page=1
  * 
  * @param itemno
  * @param word
  * @param now_page
  * @return
  */
 @RequestMapping(value = "/goods/list_by_itemno_grid.do", method = RequestMethod.GET)
 public ModelAndView list_by_itemno_search_paging_grid(GoodsVO goodsVO,ReviewVO reviewVO) {

   ModelAndView mav = new ModelAndView();

   // 검색된 전체 글 수
   int search_count = this.goodsProc.search_count(goodsVO);
   mav.addObject("search_count", search_count);
   
   // 검색 목록
   ArrayList<GoodsVO> list = goodsProc.list_by_itemno_search_paging(goodsVO);
   mav.addObject("list", list);

   ItemVO itemVO = itemProc.read(goodsVO.getItemno());
   mav.addObject("itemVO", itemVO);

   /*
    * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 현재 페이지: 11 / 22 [이전] 11 12 13 14 15 16 17
    * 18 19 20 [다음]
    * @param itemno 카테고리번호
    * @param search_count 검색(전체) 레코드수
    * @param now_page 현재 페이지
    * @param word 검색어
    * @return 페이징용으로 생성된 HTML/CSS tag 문자열
    */
   String paging = goodsProc.pagingBox(goodsVO.getItemno(), goodsVO.getNow_page(), goodsVO.getWord(), "list_by_itemno_grid.do");
   mav.addObject("paging", paging);

   // mav.addObject("now_page", now_page);
   
   mav.setViewName("/goods/list_by_itemno_search_paging_grid");  // /goods/list_by_itemno_search_paging_grid.jsp
    ArrayList<ReviewVO> reviewList = new ArrayList<>();
    
    for (GoodsVO goods : list) {
        int goodsno = goods.getGoodsno();
  
        ReviewVO review = new ReviewVO(); // 리뷰 정보를 담을 ReviewVO 객체 생성
    
        int reviewcnt = this.reviewProc.review_count(goods.getGoodsno());
        review.setReviewcnt(reviewcnt);
  
        Float ratingValue = this.reviewProc.ratingAVG(goods.getGoodsno());
        review.setRatingAvg(ratingValue);
  
        reviewList.add(review); // 리뷰 정보를 리스트에 추가
    }
    
    mav.addObject("reviewList", reviewList); 
    
       return mav;
     }
     
 
 /**
  * 수정 폼
  * http://localhost:9091/goods/update_text.do?goodsno=1
  * 
  * @return
  */
 @RequestMapping(value = "/goods/update_text.do", method = RequestMethod.GET)
 public ModelAndView update_text(int goodsno) {
   ModelAndView mav = new ModelAndView();
   
   GoodsVO goodsVO = this.goodsProc.read(goodsno);
   mav.addObject("goodsVO", goodsVO);
   
   ItemVO itemVO = this.itemProc.read(goodsVO.getItemno());
   mav.addObject("itemVO", itemVO);
   
   mav.setViewName("/goods/update_text"); // /WEB-INF/views/goods/update_text.jsp

   return mav; // forward
 }
 
 /**
  * 수정 처리
  * http://localhost:9091/goods/update_text.do?goodsno=1
  * 
  * @return
  */
 @RequestMapping(value = "/goods/update_text.do", method = RequestMethod.POST)
 public ModelAndView update_text(HttpSession session, GoodsVO goodsVO) {
   ModelAndView mav = new ModelAndView();
   
   if (this.adminProc.isAdmin(session)) { //관리자 로그인
     int price = goodsVO.getPrice();  // 정가
     int dc = goodsVO.getDc();
     int saleprice = (int)(price - (price * (dc / 100.0)));// 할인된 금액//saleprice = price - price * (dc / 100)
     int point = (int)( saleprice * (2 / 100.0)); //포인트
     
     System.out.println("가격: "+saleprice);
     goodsVO.setSaleprice(saleprice);
     goodsVO.setPoint(point);
     
     this.goodsProc.update_text(goodsVO);
     
     
     mav.addObject("goodsno", goodsVO.getGoodsno());
     mav.addObject("itemno", goodsVO.getItemno());
     mav.addObject("saleprice", goodsVO.getSaleprice());
     mav.addObject("point", goodsVO.getPoint());
     
     mav.setViewName("redirect:/goods/read.do");
     } else {
         mav.addObject("url", "/admin/login_need");
         mav.setViewName("redirect:/goods/msg.do");  //POST ->  GET -> JSP 출력
     }
   
   mav.addObject("now_page", goodsVO.getNow_page());  // POST -> GET: 데이터 분실이 발생함으로 다시 한 번 데이터 저장해줌.

   // URL에 파라미터의 전송
   // mav.setViewName("redirect:/goods/read.do?goodsno=" + goodsVO.getGoodsno() + "&itemno=" + goodsVO.getItemno());             
   return mav; // forward
   }  
 
 
 /**
  * 파일 수정 폼
  * http://localhost:9091/goods/update_file.do?goodsno=1
  * 
  * @return
  */
 @RequestMapping(value = "/goods/update_file.do", method = RequestMethod.GET)
 public ModelAndView update_file(int goodsno) {
   ModelAndView mav = new ModelAndView();
   
   GoodsVO goodsVO = this.goodsProc.read(goodsno);
   mav.addObject("goodsVO", goodsVO);
   
   ItemVO itemVO = this.itemProc.read(goodsVO.getItemno());
   mav.addObject("itemVO", itemVO);
   
   mav.setViewName("/goods/update_file"); // /WEB-INF/views/goods/update_file.jsp

   return mav; // forward
 }
 
 /**
  * 파일 수정 처리 http://localhost:9091/goods/update_file.do
  * 
  * @return
  */
 @RequestMapping(value = "/goods/update_file.do", method = RequestMethod.POST)
 public ModelAndView update_file(HttpSession session, GoodsVO goodsVO) {
   ModelAndView mav = new ModelAndView();
   
   if (this.adminProc.isAdmin(session)) {
     // 삭제할 파일 정보를 읽어옴, 기존에 등록된 레코드 저장용
     GoodsVO goodsVO_old = goodsProc.read(goodsVO.getGoodsno());
     
     // -------------------------------------------------------------------
     // 파일 삭제 코드 시작
     // -------------------------------------------------------------------
     String file1saved = goodsVO_old.getFile1saved();  // 실제 저장된 파일명
     String thumb1 = goodsVO_old.getThumb1();       // 실제 저장된 preview 이미지 파일명
     long size1 = 0;

     String upDir = Goods.getUploadDir(); // ★ C:/kd/deploy/resort_v2sbm3c/goods/storage/
     
     Tool.deleteFile(upDir, file1saved);  // 실제 저장된 파일삭제
     Tool.deleteFile(upDir, thumb1);     // preview 이미지 삭제
     // -------------------------------------------------------------------
     // 파일 삭제 종료 시작
     // -------------------------------------------------------------------
         
     // -------------------------------------------------------------------
     // 파일 전송 코드 시작
     // -------------------------------------------------------------------
     String file1 = "";          // 원본 파일명 image

     // 완성된 경로 C:/kd/ws_java/resort_v1sbm3c/src/main/resources/static/goods/storage/
     // String upDir =  System.getProperty("user.dir") + "/src/main/resources/static/goods/storage/"; // 절대 경로
         
     // 전송 파일이 없어도 file1MF 객체가 생성됨.
     // <input type='file' class="form-control" name='file1MF' id='file1MF' 
     //           value='' placeholder="파일 선택">
     MultipartFile mf = goodsVO.getFile1MF();
         
     file1 = mf.getOriginalFilename(); // 원본 파일명
     size1 = mf.getSize();  // 파일 크기
         
     if (size1 > 0) { // 폼에서 새롭게 올리는 파일이 있는지 파일 크기로 체크 !!
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
         
     goodsVO.setFile1(file1);
     goodsVO.setFile1saved(file1saved);
     goodsVO.setThumb1(thumb1);
     goodsVO.setSize1(size1);
     // -------------------------------------------------------------------
     // 파일 전송 코드 종료
     // -------------------------------------------------------------------
         
     this.goodsProc.update_file(goodsVO); // Oracle 처리

     mav.addObject("goodsno", goodsVO.getGoodsno());
     mav.addObject("itemno", goodsVO.getItemno());
     
     mav.setViewName("redirect:/goods/read.do"); // request -> param으로 접근 전환
               
   } else {
     mav.addObject("url", "/admin/login_need"); // login_need.jsp, redirect parameter 적용
     mav.setViewName("redirect:/goods/msg.do"); // GET
   }
   // redirect 하게되면 데이터가 전부 삭제됨.
   mav.addObject("now_page", goodsVO.getNow_page());

   return mav; // forward
 }  
 
 
 /**
  * 삭제 폼
  * @param goodsno
  * @return
  */
 @RequestMapping(value="/goods/delete.do", method=RequestMethod.GET )
 public ModelAndView delete(int goodsno) { 
   ModelAndView mav = new  ModelAndView();
   
   // 삭제할 정보를 조회하여 확인
   GoodsVO goodsVO = this.goodsProc.read(goodsno);
   mav.addObject("goodsVO", goodsVO);
   
   ItemVO itemVO = this.itemProc.read(goodsVO.getItemno());
   mav.addObject("itemVO", itemVO);
   
   mav.setViewName("/goods/delete");  // /webapp/WEB-INF/views/goods/delete.jsp
   
   return mav; 
 }
 
 /**
  * 삭제 처리 http://localhost:9091/goods/delete.do
  * 
  * @return
  */
 @RequestMapping(value = "/goods/delete.do", method = RequestMethod.POST)
 public ModelAndView delete(GoodsVO goodsVO) {
   ModelAndView mav = new ModelAndView();
   
   // -------------------------------------------------------------------
   // 파일 삭제 시작
   // -------------------------------------------------------------------
   // 삭제할 파일 정보를 읽어옴.
   GoodsVO goodsVO_read = goodsProc.read(goodsVO.getGoodsno());
       
   String file1saved = goodsVO.getFile1saved();
   String thumb1 = goodsVO.getThumb1();
   String uploadDir = Goods.getUploadDir();
      
   Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
   Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
   // -------------------------------------------------------------------
   // 파일 삭제 종료 
   // -------------------------------------------------------------------
   
   this.goodsProc.delete(goodsVO.getGoodsno()); // DBMS 삭제
   
   this.itemProc.update_cnt_sub(goodsVO.getItemno());    
       
   // -------------------------------------------------------------------------------------
   // 마지막 페이지의 마지막 레코드 삭제시의 페이지 번호 -1 처리
   // -------------------------------------------------------------------------------------    
   // 마지막 페이지의 마지막 10번째 레코드를 삭제후
   // 하나의 페이지가 3개의 레코드로 구성되는 경우 현재 9개의 레코드가 남아 있으면
   // 페이지수를 4 -> 3으로 감소 시켜야함, 마지막 페이지의 마지막 레코드 삭제시 나머지는 0 발생
   int now_page = goodsVO.getNow_page();
   if (goodsProc.search_count(goodsVO) % Goods.RECORD_PER_PAGE == 0) {
     now_page = now_page - 1;  // 삭제 시 DBMS는 바로 적용되나 크롬은 새로고침등의 필요로 단계가 작동 해야함.
     if (now_page < 1) {
       now_page = 1; // 시작 페이지
     }
   }
   // -------------------------------------------------------------------------------------

   mav.addObject("itemno", goodsVO.getItemno());
   mav.addObject("now_page", now_page);
   mav.setViewName("redirect:/goods/list_by_itemno.do"); 
   
   return mav;
 }   
 
 // 특정 카테고리 개수
 // http://localhost:9091/goods/count_by_itemno.do?itemno=1
 @RequestMapping(value = "/goods/count_by_itemno.do", method = RequestMethod.GET)
 public String count_by_itemno(int itemno) {
   System.out.println("-> count: " + this.goodsProc.count_by_itemno(itemno));
   return "";
 }
/**
 * 특정 카테고리에 속한 레코드 삭제
 * @param itemno
 * @return
 */
 // http://localhost:9091/goods/delete_by_itemno.do?itemno=1
 // 파일 삭제 -> 레코드 삭제
 @RequestMapping(value = "/goods/delete_by_itemno.do", method = RequestMethod.GET)
 public String delete_by_itemno(int itemno) {
   ArrayList<GoodsVO> list = this.goodsProc.list_by_itemno(itemno);
   
   for(GoodsVO goodsVO : list) {
     // -------------------------------------------------------------------
     // 파일 삭제 시작
     // -------------------------------------------------------------------
     // 삭제할 파일 정보를 읽어옴.
     String file1saved = goodsVO.getFile1saved();
     String thumb1 = goodsVO.getThumb1();
     String uploadDir = Goods.getUploadDir();
        
     Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
     Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
     // -------------------------------------------------------------------
     // 파일 삭제 종료 
     // -------------------------------------------------------------------
   }
   System.out.println("-> count: " + this.goodsProc.delete_by_itemno(itemno));
   return "";
 }
 
}
