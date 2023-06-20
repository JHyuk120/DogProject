package dev.mvc.attachfile;


import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.cart.CartVO;

@Component("dev.mvc.attachfile.AttachfileProc")
public class AttachfileProc implements AttachfileProcInter{
  @Autowired
  private AttachfileDAOInter attachfileDAO;

  @Override
  public int create(AttachfileVO attachfileVO) {
    int cnt = this.attachfileDAO.create(attachfileVO);
    return cnt;
  }

  

}
