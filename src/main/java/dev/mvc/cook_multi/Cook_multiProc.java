package dev.mvc.cook_multi;


import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.cook_multi.Cook_multiVO;
import dev.mvc.cart.CartVO;

@Component("dev.mvc.cook_multi.Cook_multiProc")
public class Cook_multiProc implements Cook_multiProcInter{
  @Autowired
  private Cook_multiDAOInter cook_multiDAO;
  
  @Override
  public int create(Cook_multiVO cook_multiVO) {
    int cnt = this.cook_multiDAO.create(cook_multiVO);
    return cnt;
  }

  @Override
  public ArrayList<Cook_multiVO> read(int recipeno) {
    ArrayList<Cook_multiVO> list = this.cook_multiDAO.read(recipeno);
    return list;
  }

  @Override
  public int update_file(Cook_multiVO cook_multiVO) {
    int cnt = this.cook_multiDAO.update_file(cook_multiVO);
    return cnt;
  }

  @Override
  public int delete(int recipeno) {
    int cnt = this.cook_multiDAO.delete(recipeno);
    return cnt;
  }

}
