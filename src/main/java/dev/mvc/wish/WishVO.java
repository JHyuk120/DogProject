package dev.mvc.wish;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class WishVO {
  private int wishno;
  private int memberno;
  private int goodsno;
  private String rdate = "";
  
  private String title = "";
      

}
