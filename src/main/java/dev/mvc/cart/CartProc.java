package dev.mvc.cart;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.cart.cartProc")
public class CartProc implements CartProcInter{
  @Autowired
  private CartDAOInter cartDAO;

  @Override
  public int insert(CartVO cartVO) {
    int cnt = this.insert(cartVO);
    return cnt;
  }
  
  @Override
  public ArrayList<CartVO> list_by_memberno(int memberno) {
    ArrayList<CartVO> list = this.cartDAO.list_by_memberno(memberno);
    return list;
  }

  @Override
  public int delete(int cartno) {
    int cnt = this.cartDAO.delete(cartno);
    return cnt;
  }

}
