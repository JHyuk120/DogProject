package dev.mvc.detail;

import java.util.HashMap;
import java.util.List;

public interface DetailDAOInter {
  
  /**
   * 등록
   * @param detailVO
   * @return
   */
  public int create(DetailVO detailVO);

  /**
   * 회원별 주문 결재 목록
   * @param payno
   * @return
   */
  public List<DetailVO> detail_list(HashMap<String, Object> map);

}
