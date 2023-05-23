package dev.mvc.dogProject;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.item.ItemProcInter;
import dev.mvc.item.ItemVO;


// Setvlet으로 작동함, GET/POST등의 요청을 처리함.
@Controller
public class HomeCont {
  
  @Autowired
  @Qualifier("dev.mvc.item.ItemProc")
  private ItemProcInter itemProc;
  
  public HomeCont() {
    System.out.println("-> HomeCont created.");
  }
  
  // http://localhost:9093/
  // http://localhost:9093/index.do
  @RequestMapping(value= {"/", "/index.do"}, method=RequestMethod.GET)
  public ModelAndView home() {
    ModelAndView mav = new ModelAndView();
    // spring.mvc.view.prefix=/WEB-INF/views/
    // spring.mvc.view.suffix=.jsp
    mav.setViewName("/index"); // /WEB-INF/views/index.jsp
    
    return mav;
  }
  
  
 // http://localhost:9093/menu/top.do
 @RequestMapping(value= {"/menu/top.do"}, method=RequestMethod.GET)
 public ModelAndView top() {
   ModelAndView mav = new ModelAndView();
      
   ArrayList<ItemVO> list = this.itemProc.list_all();
   mav.addObject("list", list);
   
   ArrayList<ItemVO> list_y = this.itemProc.list_all_y();
   mav.addObject("list_y", list_y);
   
   mav.setViewName("/menu/top"); // /WEB-INF/views/menu/top.jsp
   
   return mav;
 }
 
  
}
