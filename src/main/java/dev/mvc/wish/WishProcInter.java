package dev.mvc.wish;

public interface WishProcInter {
  
  /**
   * 찜하기 생성
   * @param wishVO
   * @return
   */
  public int create(WishVO wishVO);
  
  /**
   * 찜하기 확인
   * @param wishVO
   * @return
   */
  public int check(WishVO wishVO);
  
  
  /**
   * 찜하기 삭제
   * @param wishVO
   * @return
   */
  public int delete(int memberno);

}
