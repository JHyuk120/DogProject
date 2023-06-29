package dev.mvc.cook_multi;

import java.util.ArrayList;

public interface Cook_multiProcInter {
  /**
   * 파일 저장
   * @param cartVO
   * @return
   */
  public int create(Cook_multiVO cook_multiVO);
  
  /**
   * 조회
   * @param recipeno
   * @return
   */
  public ArrayList<Cook_multiVO> read(int recipeno);
  
  /**
   * 수정
   * @param recipeno
   * @return
   */
  public int update_file(Cook_multiVO cook_multiVO);
  
  /**
   * 삭제
   * @param recipeno
   * @return
   */
  public int delete(int recipeno);

}