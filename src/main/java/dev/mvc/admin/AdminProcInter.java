package dev.mvc.admin;

import javax.servlet.http.HttpSession;

public interface AdminProcInter {
  
  public int login(AdminVO adminVO);
  
  public AdminVO read_by_id(String id);
  
  
  /**
   * 관리자인지 체크
   * @param session
   * @return
   */
  public boolean isAdmin(HttpSession session);

  public AdminVO read(int adminno);

}
