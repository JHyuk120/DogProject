package dev.mvc.detail;

import java.util.ArrayList;
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
  
  /**
   * 관리자가 보는 주문 사항
   * @return
   */
  public ArrayList<DetailVO> order_list();

}
