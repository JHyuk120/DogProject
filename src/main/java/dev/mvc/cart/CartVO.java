package dev.mvc.cart;

import org.springframework.web.multipart.MultipartFile;

/*
 * SELECT c.cartno, g.goodsno, g.gname, g.thumb1, g.price, g.dc, g.saleprice, g.point, c.memberno, c.cnt, c.rdate 
FROM goods g, cart c
WHERE (g.goodsno = c.cartno) AND c.memberno=1
ORDER BY cartno;
 */

import dev.mvc.goods.GoodsVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class CartVO {
  
  /** 장바구니 번호*/
  private int cartno;
  /** 상품 번호 */
  private int goodsno;
  /** 상품 이름*/
  private String gname ="";
  /** 상품 이미지*/
  private String thumb1="";
  /** 정가 */
  private int price;
  /** 할인율 */
  private int dc;

  /** 판매가 */
  private int saleprice;
  

  

  /** 포인트 */
  private int point;
  /** 회원 번호*/
  private int memberno;
  /** 수량*/
  private int cnt;
  /** 금액 = 판매가 x 수량 */
  private int tot;
  /** 등록일*/
  private String rdate;
}
