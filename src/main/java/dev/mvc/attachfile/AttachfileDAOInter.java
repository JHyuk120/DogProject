package dev.mvc.attachfile;

public interface AttachfileDAOInter {
  
  /**
   * 파일 저장
   * @param cartVO
   * @return
   */
  public int create(AttachfileVO attachfileVO);

}