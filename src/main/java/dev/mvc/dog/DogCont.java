package dev.mvc.dog;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminProcInter;
//import dev.mvc.recipe.Recipe;
//import dev.mvc.recipe.RecipeProcInter;
//import dev.mvc.recipe.RecipeVO;
import dev.mvc.tool.Tool;

@Controller
public class DogCont {
  @Autowired
  @Qualifier("dev.mvc.dog.DogProc")
  private DogProcInter dogProc;
  

  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  private AdminProcInter adminProc;
  

//  @Autowired
//  @Qualifier("dev.mvc.recipe.RecipeProc")
//  private RecipeProcInter recipeProc;

  public DogCont() {
    System.out.println("DogCont created.");
  }

//등록품  http://localhost:9093/dog/create.do
  @RequestMapping(value = "/dog/create.do", method = RequestMethod.GET)
  public ModelAndView create(HttpSession session) {

    ModelAndView mav = new ModelAndView();
    
    if (this.adminProc.isAdmin(session) == true) {
      mav.setViewName("/dog/create");
      
    } else {
      mav.setViewName("/admin/login_need");
    }

    return mav;
  }

//등록 처리
  @RequestMapping(value = "/dog/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpSession session, DogVO dogVO) {

    ModelAndView mav = new ModelAndView();
    
    if (session.getAttribute("admin_id") != null) {
      int cnt = this.dogProc.create(dogVO);

      if (cnt == 1) {
        mav.setViewName("/dog/msg");
        mav.addObject("code", "create_success");
      } else {

        mav.addObject("code", "create_fail");
      }

      mav.addObject("cnt", cnt);
    } else {
      mav.setViewName("/admin/login_need");
    }

    

    return mav;
  }

  // 목록
  @RequestMapping(value = "/dog/list_all.do", method = RequestMethod.GET)
  public ModelAndView list_all(HttpSession session) {

    ModelAndView mav = new ModelAndView();
    
    if (this.adminProc.isAdmin(session) == true) {
      mav.setViewName("/dog/list_all");

      ArrayList<DogVO> list = this.dogProc.list_all();
      mav.addObject("list", list);
      
    } else {
      mav.setViewName("/admin/login_need");
    }

    return mav;
  }

  // 읽기
  @RequestMapping(value = "/dog/read.do", method = RequestMethod.GET)
  public ModelAndView read(HttpSession session, int itemno) {

    ModelAndView mav = new ModelAndView();
    
    if (this.adminProc.isAdmin(session) == true) {
      mav.setViewName("/dog/read");

      DogVO dogVO = this.dogProc.read(itemno);
      mav.addObject("dogVO", dogVO);
      
    } else {
      mav.setViewName("/admin/login_need");
    }

    return mav;
  }

  // 수정폼
  @RequestMapping(value = "/dog/read_update.do", method = RequestMethod.GET)
  public ModelAndView read_update(HttpSession session, int itemno) {

    ModelAndView mav = new ModelAndView();
    
    if (this.adminProc.isAdmin(session) == true) {
      mav.setViewName("/dog/read_update");

      DogVO dogVO = this.dogProc.read(itemno);
      mav.addObject("dogVO", dogVO);

      ArrayList<DogVO> list = this.dogProc.list_all();
      mav.addObject("list", list);
      
    } else {
      mav.setViewName("/admin/login_need");
    }
    
    return mav;
  }

  // 수정 처리
  @RequestMapping(value = "/dog/update.do", method = RequestMethod.POST)
  public ModelAndView update(HttpSession session, DogVO dogVO) {

    ModelAndView mav = new ModelAndView();
    
    if (session.getAttribute("admin_id") != null) {
      int cnt = this.dogProc.update(dogVO);

      if (cnt == 1) {

        mav.addObject("code", "update_success");
        mav.setViewName("redirect:/dog/list_all.do");
      } else {

        mav.addObject("code", "update_fail");
        mav.setViewName("/dog/msg");
      }

      mav.addObject("cnt", cnt);
      
    } else {
      mav.setViewName("/admin/login_need");
    }

    return mav;
  }

////삭제폼
//  @RequestMapping(value = "/dog/read_delete.do", method = RequestMethod.GET)
//  public ModelAndView read_delete(HttpSession session, int itemno) {
//
//    ModelAndView mav = new ModelAndView();
//    
////    int count_by_itemno = this.recipeProc.count_by_itemno(itemno);
////    mav.addObject("count_by_itemno", count_by_itemno);
//    
//    if (this.AdminProc.isAdmin(session) == true) {
//      mav.setViewName("/dog/read_delete");
//
//      DogVO dogVO = this.dogProc.read(itemno);
//      mav.addObject("dogVO", dogVO);
//
//      ArrayList<DogVO> list = this.dogProc.list_all();
//      mav.addObject("list", list);
//      
//    } else {
//      mav.setViewName("/admin/login_need");
//    }
//    
//
//    return mav;
//  }
//
//  // 삭제 처리
//  @RequestMapping(value = "/dog/delete.do", method = RequestMethod.POST)
//  public ModelAndView delete(HttpSession session, int itemno) {
//
//    ModelAndView mav = new ModelAndView();
//    
//    if (this.AdminProc.isAdmin(session) == true) {
//      
////      ArrayList<RecipeVO> list = this.recipeProc.list_by_itemno(itemno);
////      
////      for (RecipeVO recipeVO : list) {
////        // -------------------------------------------------------------------
////        // 파일 삭제 시작
////        // -------------------------------------------------------------------
////        String file1saved = recipeVO.getFile1saved();
////        String thumb1 = recipeVO.getThumb1();
////        
////        String uploadDir = Recipe.getUploadDir();
////        Tool.deleteFile(uploadDir, file1saved);  // 실제 저장된 파일삭제
////        Tool.deleteFile(uploadDir, thumb1);     // preview 이미지 삭제
////        // -------------------------------------------------------------------
////        // 파일 삭제 종료
////        // -------------------------------------------------------------------
////        
////      }
//      
////      this.recipeProc.delete_by_itemno(itemno);
//     
//      int cnt = this.dogProc.delete(itemno);
//
//      if (cnt == 1) {
//
//        mav.setViewName("redirect:/dog/list_all.do");
//      } else {
//
//        mav.addObject("code", "delete_fail");
//        mav.setViewName("/dog/msg");
//      }
//
//      mav.addObject("cnt", cnt);
//      
//    } else {
//      mav.setViewName("/admin/login_need");
//    }
//
//    return mav;
//  }
  
//삭제폼
  @RequestMapping(value = "/dog/read_delete.do", method = RequestMethod.GET)
  public ModelAndView read_delete(HttpSession session, int itemno) {

    ModelAndView mav = new ModelAndView();
    
    if (this.adminProc.isAdmin(session) == true) {
      mav.setViewName("/dog/read_delete");

      DogVO dogVO = this.dogProc.read(itemno);
      mav.addObject("dogVO", dogVO);

      ArrayList<DogVO> list = this.dogProc.list_all();
      mav.addObject("list", list);
      
    } else {
      mav.setViewName("/admin/login_need");
    }
    

    return mav;
  }

  // 삭제 처리
  @RequestMapping(value = "/dog/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(HttpSession session, int itemno) {

    ModelAndView mav = new ModelAndView();
    
    if (this.adminProc.isAdmin(session) == true) {
      int cnt = this.dogProc.delete(itemno);

      if (cnt == 1) {

        mav.setViewName("redirect:/dog/list_all.do");
      } else {

        mav.addObject("code", "delete_fail");
        mav.setViewName("/dog/msg");
      }

      mav.addObject("cnt", cnt);
      
    } else {
      mav.setViewName("/admin/login_need");
    }

    return mav;
  }

  // seq 감소 처리
  @RequestMapping(value = "/dog/update_seqno_decrease.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_decrease(int itemno) {

    ModelAndView mav = new ModelAndView();

    DogVO dogVO = this.dogProc.read(itemno);
    int seqno = dogVO.getSeqno();

    if (seqno > 1) {
      int cnt = this.dogProc.update_seqno_decrease(itemno);

      if (cnt == 1) {

        mav.setViewName("redirect:/dog/list_all.do");
      } else {

        mav.addObject("code", "update_seqno_decrease_fail");
        mav.setViewName("/dog/msg");
      }

    } else {
      mav.setViewName("redirect:/dog/list_all.do");
    }

    return mav;
  }

  // seq 증가 처리
  @RequestMapping(value = "/dog/update_seqno_increase.do", method = RequestMethod.GET)
  public ModelAndView update_seqno_increase(int itemno) {

    ModelAndView mav = new ModelAndView();

    int cnt = this.dogProc.update_seqno_increase(itemno);

    if (cnt == 1) {

      mav.setViewName("redirect:/dog/list_all.do");
    } else {

      mav.addObject("code", "update_seqno_increase_fail");
      mav.setViewName("/dog/msg");
    }

    mav.addObject("cnt", cnt);

    return mav;
  }

  // 공개
  @RequestMapping(value = "/dog/update_visible_y.do", method = RequestMethod.GET)
  public ModelAndView update_visible_y(int itemno) {

    ModelAndView mav = new ModelAndView();

    int cnt = this.dogProc.update_visible_y(itemno);

    if (cnt == 1) {

      mav.setViewName("redirect:/dog/list_all.do");
    } else {

      mav.addObject("code", "update_visible_y_fail");
      mav.setViewName("/dog/msg");
    }

    return mav;
  }

//비공개
  @RequestMapping(value = "/dog/update_visible_n.do", method = RequestMethod.GET)
  public ModelAndView update_visible_n(int itemno) {

    ModelAndView mav = new ModelAndView();

    int cnt = this.dogProc.update_visible_n(itemno);

    if (cnt == 1) {

      mav.setViewName("redirect:/dog/list_all.do");
    } else {

      mav.addObject("code", "update_visible_n_fail");
      mav.setViewName("/dog/msg");
    }

    return mav;
  }

//숨김 목록
  @RequestMapping(value = "/dog/list_all_y.do", method = RequestMethod.GET)
  public ModelAndView list_all_y() {

    ModelAndView mav = new ModelAndView();
    mav.setViewName("/dog/list_all_y");

    ArrayList<DogVO> list_y = this.dogProc.list_all_y();
    mav.addObject("lis_y", list_y);

    return mav;
  }

// cnt 감소 처리
  @RequestMapping(value = "/dog/update_cnt_sub.do", method = RequestMethod.GET)
  public ModelAndView update_cnt_sub(int itemno) {

    ModelAndView mav = new ModelAndView();

    DogVO dogVO = this.dogProc.read(itemno);
    int cntSub = dogVO.getCnt();

    if (dogVO.getCnt() > 0) {
      int cnt = this.dogProc.update_cnt_sub(itemno);

      if (cnt == 1) {

        mav.setViewName("redirect:/dog/list_all.do");
      } else {

        mav.addObject("code", "update_cnt_sub_fail");
        mav.setViewName("/dog/msg");
      }

    } else {
      mav.setViewName("redirect:/dog/list_all.do");
    }

    return mav;
  }

// cnt 증가 처리
  @RequestMapping(value = "/dog/update_cnt_add.do", method = RequestMethod.GET)
  public ModelAndView update_cnt_add(int itemno) {

    ModelAndView mav = new ModelAndView();

    int cnt = this.dogProc.update_cnt_add(itemno);

    if (cnt == 1) {

      mav.setViewName("redirect:/dog/list_all.do");
    } else {

      mav.addObject("code", "update_cnt_add_fail");
      mav.setViewName("/dog/msg");
    }

    mav.addObject("cnt", cnt);

    return mav;
  }

}
