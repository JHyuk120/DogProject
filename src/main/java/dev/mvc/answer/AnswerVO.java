package dev.mvc.answer;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class AnswerVO {
  /*
        answer_no                          NUMBER(10)         NOT NULL         PRIMARY KEY,
        qnano                                   NUMBER(10)         NOT NULL , -- FK
        text                                       CLOB                      NOT NULL, 
        rdate                                     DATE                      NOT NULL, 
        passwd                                VARCHAR(30)                NULL,  
   */
  
  /** 답변 번호 */
  private int answer_no;
  /** 글 번호(FK) */
  private int qnano;
  /** 제목 */
  private String title;
  /** 작성자 */
  private String aname;
  /** 답글 */
  private String text;
  /** QNA 비밀번호 */
  private String passwd;
  /** 등록일 */
  private String rdate;
  
}