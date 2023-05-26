package dev.mvc.goods;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class GoodsVO {

  /** 상품 번호 */
  private int goodsno;
  /** 관리자 번호 */
  private int adminno;
  /** 품목 번호 */
  private int itemno;
  /** 품목명*/
  private String gname;
  /** 품목 내용*/
  private String content;
  /** 품목 갯수 */
  private int cnt;
  /** 검색어*/
  private String word="";
  /** 등록일*/
  private String rdate;
  
  /** 메인 이미지 */
  private String file1 = "";
  /** 실제 저장된 메인 이미지 */
  private String file1saved = "";
  /** 메인 이미지 preview */
  private String thumb1 = "";
  /** 메인 이미지 크기 */
  private long size1;
  
  /** 정가*/
  private int price;
  /** 할인율*/
  private int dc;
  /** 할인된 가격*/
  private int saleprice;
  /** 판매 수*/
  private int salecnt;
  /** 포인트*/
  private int point;
  
  /** 여러 파일 */
 private MultipartFile file1MF;
 
 /** 메인 이미지 크기 단위, 파일 크기 */
 private String size1_label = "";
 
  /** 시작 rownum */
  private int start_num;
  
  /** 끝 rownum */
  private int end_num;
  
  /** 현재 페이지 */
  private int now_page = 1;
  
}
