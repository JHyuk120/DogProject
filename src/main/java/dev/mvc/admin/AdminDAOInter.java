package dev.mvc.admin;

import java.util.ArrayList;

public interface AdminDAOInter {
  
  /**
   * 로그인
   * @param adminVO
   * @return
   */
  public int login(AdminVO adminVO);
  
  /**
   * 회원정보
   * @param id
   * @return
   */
  public AdminVO read_by_id(String id);
  
  public AdminVO read(int adminno);

}
