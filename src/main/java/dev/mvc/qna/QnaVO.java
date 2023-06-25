package dev.mvc.qna;

import java.util.List;

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
    private String title;
    /** 내용 */
    private String content = "";
    /** 패스워드 */
    private String passwd = "";
    /** 검색어 */
    private String word = "";
    /** 작성자 */
    private String mname="";
    /** 등록 날짜 */
    private String rdate = "";
   
    /** 시작 rownum */
    private int start_num;
    
    /** 종료 rownum */
    private int end_num;    
    
    /** 현재 페이지 */
    private int now_page=1;

    /** 파일 번호 */
    private int attachfileno;
    /** 원본 파일명 */
    private String fname;
    /** 업로드된 파일명 */
    private String fupname;
    /** Thumb 이미지 */
    private String thumb;
    /** 파일 크기 */
    private long fsize;

    /** Form의 파일을 MultipartFile로 변환하여 List에 저장  */
    private List<MultipartFile> fnamesMF;
    
    // private MultipartFile fnamesMF;  // 하나의 파일 처리
    /** 파일 단위 출력 */
    private String flabel;   
    
    


}