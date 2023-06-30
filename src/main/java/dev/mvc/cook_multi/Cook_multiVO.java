package dev.mvc.cook_multi;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class Cook_multiVO {

  /** 파일 번호 */
  private int cookfileno;
  /** 글 번호(FK) */
  private int recipeno;
  /** 원본 파일명 */
  private String cookfile;
  /** 업로드된 파일명 */
  private String cookfilesaved;
  /** Thumb 이미지 */
  private String thumb;
  /** 레시피 설명 */
  private String exp;
  
  /** Form의 파일을 MultipartFile로 변환하여 List에 저장  */
  private MultipartFile cookfileMF;
  
  /** 버튼 숫자 */
  private int count;
  
  
}