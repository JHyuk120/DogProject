package dev.mvc.detail;

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

}
