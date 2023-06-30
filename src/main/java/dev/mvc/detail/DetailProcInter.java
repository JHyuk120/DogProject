package dev.mvc.detail;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public interface DetailProcInter {

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
  
  /**
   * 배송 상태 변경
   * @param detailno
   * @return
   */
  public int update_stateno(int detailno);

  /**
   * 조회
   * @param detailno
   * @return
   */
  public DetailVO read(int detailno);

  /**
   * 회원 주문 취소
   * @param detailno
   * @return
   */
  public int cancel(int detailno);

  /**
   * 상세 주문 삭제
   * @param detailno
   * @return
   */
  public int d_delete(int detailno);
  
}
