package dev.mvc.recipe;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


public class RecipeVO {
    /** 컨텐츠 번호 */
    private int recipeno;
    /** 관리자 번호 */
    private int adminno;
    /** 품목 번호 */
    private int itemno;
    /** 제목 */
    private String title = "";
    /** 글 내용 */
    private String article = "";
    /** 추천수 */
    private int recom;
    /** 조회수 */
    private int cnt = 0;
    /** 댓글수 */
    private int replycnt = 0;
    /** 패스워드 */
    private String passwd = "";
    /** 검색어 */
    private String word = "";
    /** 등록 날짜 */
    private String rdate = "";

    /** 메인 이미지 */
    private String file1 = "";
    /** 실제 저장된 메인 이미지 */
    private String file1saved = "";
    
    /** 메인 이미지 preview */
    private String thumb1 = "";
    /** 메인 이미지 크기 */
    private long size1;

    /**유튜브*/
    private String youtube;
    
    /** 재료 */
    private String ingredient = "";
    
    /** 리뷰 */
    private String review = "";
    
    /** 별점 */
    private int star;
    
    /**
     이미지 파일
     <input type='file' class="form-control" name='file1MF' id='file1MF' 
                value='' placeholder="파일 선택">
     */
    private MultipartFile file1MF;
    
    /** 메인 이미지 크기 단위, 파일 크기 */
    private String size1_label = "";
    
    /** 시작 rownum */
    private int start_num;
    
    /** 종료 rownum */
    private int end_num;    
    
    /** 현재 페이지 */
    private int now_page=1;

    public int getRecipeno() {
      return recipeno;
    }

    public void setRecipeno(int recipeno) {
      this.recipeno = recipeno;
    }

    public int getAdminno() {
      return adminno;
    }

    public void setAdminno(int adminno) {
      this.adminno = adminno;
    }

    public int getItemno() {
      return itemno;
    }

    public void setItemno(int itemno) {
      this.itemno = itemno;
    }

    public String getTitle() {
      return title;
    }

    public void setTitle(String title) {
      this.title = title;
    }

    public String getArticle() {
      return article;
    }

    public void setArticle(String article) {
      this.article = article;
    }

    public int getRecom() {
      return recom;
    }

    public void setRecom(int recom) {
      this.recom = recom;
    }

    public int getCnt() {
      return cnt;
    }

    public void setCnt(int cnt) {
      this.cnt = cnt;
    }

    public int getReplycnt() {
      return replycnt;
    }

    public void setReplycnt(int replycnt) {
      this.replycnt = replycnt;
    }

    public String getPasswd() {
      return passwd;
    }

    public void setPasswd(String passwd) {
      this.passwd = passwd;
    }

    public String getWord() {
      return word;
    }

    public void setWord(String word) {
      this.word = word;
    }

    public String getRdate() {
      return rdate;
    }

    public void setRdate(String rdate) {
      this.rdate = rdate;
    }

    public String getFile1() {
      return file1;
    }

    public void setFile1(String file1) {
      this.file1 = file1;
    }

    public String getFile1saved() {
      return file1saved;
    }

    public void setFile1saved(String file1saved) {
      this.file1saved = file1saved;
    }

    public String getThumb1() {
      return thumb1;
    }

    public void setThumb1(String thumb1) {
      this.thumb1 = thumb1;
    }

    public long getSize1() {
      return size1;
    }

    public void setSize1(long size1) {
      this.size1 = size1;
    }

    public String getYoutube() {
      return youtube;
    }

    public void setYoutube(String youtube) {
      this.youtube = youtube;
    }

    public String getIngredient() {
      return ingredient;
    }

    public void setIngredient(String ingredient) {
      this.ingredient = ingredient;
    }

    public String getReview() {
      return review;
    }

    public void setReview(String review) {
      this.review = review;
    }

    public int getStar() {
      return star;
    }

    public void setStar(int star) {
      this.star = star;
    }

    public MultipartFile getFile1MF() {
      return file1MF;
    }

    public void setFile1MF(MultipartFile file1mf) {
      file1MF = file1mf;
    }

    public String getSize1_label() {
      return size1_label;
    }

    public void setSize1_label(String size1_label) {
      this.size1_label = size1_label;
    }

    public int getStart_num() {
      return start_num;
    }

    public void setStart_num(int start_num) {
      this.start_num = start_num;
    }

    public int getEnd_num() {
      return end_num;
    }

    public void setEnd_num(int end_num) {
      this.end_num = end_num;
    }

    public int getNow_page() {
      return now_page;
    }

    public void setNow_page(int now_page) {
      this.now_page = now_page;
    }



}