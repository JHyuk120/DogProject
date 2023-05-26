package dev.mvc.cart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.cart.cartProc")
public class CartProc implements CartProcInter{
  @Autowired
  private CartDAOInter cartDAO;

  @Override
  public int insert(CartVO cartVO) {
    int cnt = this.cartDAO.insert(cartVO);
    return cnt;
  }

  @Override
  public int delete(int cartno) {
    int cnt = this.cartDAO.delete(cartno);
    return cnt;
  }

}
