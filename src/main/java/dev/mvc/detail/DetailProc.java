package dev.mvc.detail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.detail.DetailProc")
public class DetailProc implements DetailProcInter {
  @Autowired
  private DetailDAOInter detailDAO;

  @Override
  public int create(DetailVO detailVO) {
    int cnt = this.detailDAO.create(detailVO);
    return cnt;
  }

  @Override
  public List<DetailVO> detail_list(HashMap<String, Object> map) {
    List<DetailVO> list = null;
    list = this.detailDAO.detail_list(map);
    
    return list;
  }

  @Override
  public ArrayList<DetailVO> order_list() {
    ArrayList<DetailVO> list_a = this.detailDAO.order_list();
    return list_a;
  }

  @Override
  public int update_stateno(int detailno) {
    int cnt = this.detailDAO.update_stateno(detailno);
    return cnt;
  }

  @Override
  public DetailVO read(int detailno) {
    DetailVO detailVO = this.detailDAO.read(detailno);
    return detailVO;
  }

  @Override
  public int cancel(int detailno) {
    int cnt = this.detailDAO.cancel(detailno);
    return cnt;
  }

  @Override
  public int d_delete(int detailno) {
    int cnt = this.detailDAO.d_delete(detailno);
    return cnt;
  }

}
