package dev.mvc.attachfile;


import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.cart.CartVO;
import dev.mvc.qna.QnaVO;

@Component("dev.mvc.attachfile.AttachfileProc")
public class AttachfileProc implements AttachfileProcInter{
  @Autowired
  private AttachfileDAOInter attachfileDAO;

  @Override
  public int create(AttachfileVO attachfileVO) {
    int cnt = this.attachfileDAO.create(attachfileVO);
    return cnt;
  }

  @Override
  public ArrayList<AttachfileVO> read(int qnano) {
    ArrayList<AttachfileVO> list = this.attachfileDAO.read(qnano);
    return list;
  }
  
  @Override
  public int update_file(int qnano) {
    int cnt = this.attachfileDAO.update_file(qnano);
    return cnt;
  }

  @Override
  public int delete(int qnano) {
    int cnt = this.attachfileDAO.delete(qnano);
    return cnt;
  }




}
