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
   * @param recipeno
   * @return
   */
  public int cnt(int recipeno);

    /**
   * 좋아요 확인
   * @param recomVO
   * @return
   */
  public int check(RecomVO recomVO);

  /**
   * 좋아요 삭제
   * @param memberno
   * @return
   */
  public int delete(int memberno);
}
