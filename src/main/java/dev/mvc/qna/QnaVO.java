package dev.mvc.qna;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter @Getter @ToString
public class QnaVO {
    /** QnA 번호 */
    private int Qnano;
    /** 회원 번호 */
    private int memberno;
    /** 제목 */
    private String title = "";
    /** 내용 */
    private String content = "";
    /** 패스워드 */
    private String passwd = "";
    /** 검색어 */
    private String word = "";
    /** 등록 날짜 */
    private String rdate = "";
   
    /** 시작 rownum */
    private int start_num;
    
    /** 종료 rownum */
    private int end_num;    
    
    /** 현재 페이지 */
    private int now_page=1;



}