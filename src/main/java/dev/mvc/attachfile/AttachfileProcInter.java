package dev.mvc.attachfile;

import java.util.ArrayList;

import dev.mvc.qna.QnaVO;

public interface AttachfileProcInter {
  
  /**
   * 파일 저장
   * @param cartVO
   * @return
   */
  public int create(AttachfileVO attachfileVO);
  
  /**
   * 조회
   * @param qnano
   * @return
   */
  public ArrayList<AttachfileVO> read(int qnano);
  
  /**
   * 수정
   * @param qnano
   * @return
   */
  public int update_file(AttachfileVO attachfileVO);
  
  /**
   * 삭제
   * @param qnano
   * @return
   */
  public int delete(int qnano);

}