package dev.mvc.cart;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class CartVO {
  
  /** 장바구니 번호*/
  private int cartno;
  /** 수량 번호*/
  private int amount;
  /** 회원 번호*/
  private int memberno;
  /** 상품 번호*/
  private int goosno;
}
