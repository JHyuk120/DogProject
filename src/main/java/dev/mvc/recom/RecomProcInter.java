package dev.mvc.recom;

public interface RecomProcInter {

  /**
   * 좋아요 생성
   * @param recomVO
   * @return
   */
  public int create(RecomVO recomVO);

  /**
   * 좋아요 갯수
   * @param memberno
   * @return
   */
  public int cnt(int memberno);

}
