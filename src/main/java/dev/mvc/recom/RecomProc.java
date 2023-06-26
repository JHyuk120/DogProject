package dev.mvc.recom;

import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.recom.RecomProc")
public class RecomProc implements RecomProcInter{
  
  @Autowired
  private RecomDAOInter recomDAO;

  @Override
  public int create(RecomVO recomVO) {
    int cnt = this.recomDAO.create(recomVO);
    
    return cnt;
  }

  @Override
  public int check(RecomVO recomVO) {
    int cnt = this.recomDAO.check(recomVO);
    
    return cnt;
  }

  @Override
  public int delete(RecomVO recomVO) {
    int cnt = this.recomDAO.delete(recomVO);
    
    return cnt;
  }


}
