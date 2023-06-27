package dev.mvc.wish;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.wish.WishProc")
public class WishProc implements WishProcInter{
  
  @Autowired
  private WishDAOInter wishDAO;

  @Override
  public int create(WishVO wishVO) {
    int cnt = this.wishDAO.create(wishVO);
    
    return cnt;
  }

  @Override
  public int check(WishVO wishVO) {
    int cnt = this.wishDAO.check(wishVO);
    return cnt;
  }

  @Override
  public int delete(WishVO wishVO) {
    int cnt = this.wishDAO.delete(wishVO);
    return cnt;
  }

  @Override
  public int mycnt(int memberno) {
    int cnt = this.wishDAO.mycnt(memberno);
    return cnt;
 }

}
