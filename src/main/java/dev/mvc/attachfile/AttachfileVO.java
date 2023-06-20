package dev.mvc.attachfile;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class AttachfileVO {
  /*
    attachfileno                  NUMBER(10)     NOT NULL    PRIMARY KEY,
    contentsno                   NUMBER(10)    NULL ,
    fname                           VARCHAR2(100)    NOT NULL,
    fupname                      VARCHAR2(100)     NOT NULL,
    thumb                         VARCHAR2(100)    NULL ,
    fsize                             NUMBER(10)     DEFAULT 0     NOT NULL,
   */
  /** 파일 번호 */
  private int attachfileno;
  /** 글 번호(FK) */
  private int qnano;
  /** 원본 파일명 */
  private String fname;
  /** 업로드된 파일명 */
  private String fupname;
  /** Thumb 이미지 */
  private String thumb;
  /** 파일 크기 */
  private long fsize;
  /** 등록일 */
  private String rdate;
  
  /** Form의 파일을 MultipartFile로 변환하여 List에 저장  */
  private List<MultipartFile> fnamesMF;
  
  // private MultipartFile fnamesMF;  // 하나의 파일 처리
  /** 파일 단위 출력 */
  private String flabel;   
  
}