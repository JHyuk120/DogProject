package dev.mvc.cart;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;

@Controller
public class CartCont {
  @Autowired
  @Qualifier("dev.mvc.cart.cartProc")
  private CartProcInter cartProc;
  
  public CartCont() {
    System.out.println("-> CartCont created");
  }

}
