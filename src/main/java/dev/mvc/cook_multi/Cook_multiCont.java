package dev.mvc.cook_multi;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.recipe.RecipeProcInter;
import dev.mvc.tool.Tool;
import dev.mvc.tool.Upload;

@Controller
public class Cook_multiCont {
  @Autowired
  @Qualifier("dev.mvc.cook_multi.Cook_multiProc")
  private Cook_multiProcInter cook_multiProc;
  
  public Cook_multiCont(){
    System.out.println("--> Cook_multiCont created.");
  }
  
//  //http://localhost:9090/resort/cook_multi/create.do
//  /**
//    * 등록 폼
//    * http://localhost:9090/resort/cook_multi/create.do  X
//    * http://localhost:9090/resort/cook_multi/create.do?cateno=2&contentsno=1  O
//    * @return
//    */
//  @RequestMapping(value="/cook_multi/create.do", method=RequestMethod.GET )
//  public ModelAndView create(int contentsno) {
//    ModelAndView mav = new ModelAndView();
//    mav.setViewName("/cook_multi/create"); // webapp/cook_multi/create.jsp
//     
//    return mav;
//  }
//  
//  /**
//   * 등록 처리
//   * @param ra
//   * @param request
//   * @param cook_multiVO
//   * @param categrpno
//   * @return
//   */
//  @RequestMapping(value = "/cook_multi/create.do", method = RequestMethod.POST)
//  public ModelAndView create(HttpServletRequest request, 
//                                           Cook_multiVO cook_multiVO, int cateno) {
//    // System.out.println("--> categrpno: " + categrpno);
//    
//    ModelAndView mav = new ModelAndView();
//    // ---------------------------------------------------------------
//    // 파일 전송 코드 시작
//    // ---------------------------------------------------------------
//    int contentsno = cook_multiVO.getContentsno(); // 부모글 번호
//    String fname = ""; // 원본 파일명
//    String fupname = ""; // 업로드된 파일명
//    long fsize = 0;  // 파일 사이즈
//    String thumb = ""; // Preview 이미지
//    int upload_count = 0; // 정상처리된 레코드 갯수
//    
//    String upDir = Tool.getRealPath(request, "/cook_multi/storage");
//    
//    // 전송 파일이 없어서도 fnamesMF 객체가 생성됨.
//    List<MultipartFile> fnamesMF = cook_multiVO.getFnamesMF();
//    
//    int count = fnamesMF.size(); // 전송 파일 갯수
//    if (count > 0) {
//      for (MultipartFile multipartFile:fnamesMF) { // 파일 추출, 1개이상 파일 처리
//        fsize = multipartFile.getSize();  // 파일 크기
//        if (fsize > 0) { // 파일 크기 체크
//          fname = multipartFile.getOriginalFilename(); // 원본 파일명
//          fupname = Upload.saveFileSpring(multipartFile, upDir); // 파일 저장, 업로드된 파일명
//          
//          if (Tool.isImage(fname)) { // 이미지인지 검사
//            thumb = Tool.preview(upDir, fupname, 200, 150); // thumb 이미지 생성
//          }
//        }
//        cook_multiVO vo = new Cook_multiVO();
//        vo.setContentsno(contentsno);
//        vo.setFname(fname);
//        vo.setFupname(fupname);
//        vo.setThumb(thumb);
//        vo.setFsize(fsize);
//        
//        // 파일 1건 등록 정보 dbms 저장, 파일이 20개이면 20개의 record insert.
//        upload_count = upload_count + cook_multiProc.create(vo); 
//      }
//    }    
//    // -----------------------------------------------------
//    // 파일 전송 코드 종료
//    // -----------------------------------------------------
//    
//    mav.addObject("contentsno", contentsno); // redirect parameter 적용
//    mav.addObject("cateno", cateno); // redirect parameter 적용
//    mav.addObject("upload_count", upload_count); // redirect parameter 적용
//    mav.addObject("url", "create_msg"); // create_msg.jsp, redirect parameter 적용
//    
//    mav.setViewName("redirect:/cook_multi/msg.do"); // 새로고침 방지
//    
//    return mav;
//  }
  
  /**
   * 새로고침을 방지하는 메시지 출력
   * @param memberno
   * @return
   */
  @RequestMapping(value="/cook_multi/msg.do", method=RequestMethod.GET)
  public ModelAndView msg(String url){
    ModelAndView mav = new ModelAndView();
    
    // 등록 처리 메시지: create_msg --> /cook_multi/create_msg.jsp
    // 수정 처리 메시지: update_msg --> /cook_multi/update_msg.jsp
    // 삭제 처리 메시지: delete_msg --> /cook_multi/delete_msg.jsp
    mav.setViewName("/cook_multi/" + url); // forward
    
    return mav; // forward
  }
  
}