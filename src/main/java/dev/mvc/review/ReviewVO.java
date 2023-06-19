package dev.mvc.review;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {
    private int reviewno;
    private int memberno;
    private int goodsno;
    private String reviewcont;
    private String rdate ="";
    private MultipartFile file2MF;
    private String file2 ="";
    private String file2saved ="";
    private String thumb2 ="";
    private String mid="";
    private long size2;
    private int now_page = 1;
    private int start_num;
    private int end_num;
    private int recom = 0;
    private int reviewcnt = 0;
    private int ratingValue =5;
    private float ratingAvg = 0;
    
    
    public int getReviewno() {
        return reviewno;
    }
    public void setReviewno(int reviewno) {
        this.reviewno = reviewno;
    }
    public int getMemberno() {
        return memberno;
    }
    public void setMemberno(int memberno) {
        this.memberno = memberno;
    }
    public int getGoodsno() {
        return goodsno;
    }
    public void setGoodsno(int goodsno) {
        this.goodsno = goodsno;
    }
    public String getReviewcont() {
        return reviewcont;
    }
    public void setReviewcont(String reviewcont) {
        this.reviewcont = reviewcont;
    }
    public String getRdate() {
        return rdate;
    }
    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
    
    public String getMid() {
        return mid;
    }
    public void setMid(String mid) {
        this.mid = mid;
    }
    public int getNow_page() {
        return now_page;
    }
    public void setNow_page(int now_page) {
        this.now_page = now_page;
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
    public int getRecom() {
        return recom;
    }
    public void setRecom(int recom) {
        this.recom = recom;
    }
    public int getReviewcnt() {
        return reviewcnt;
    }
    public void setReviewcnt(int reviewcnt) {
        this.reviewcnt = reviewcnt;
    }
    public int getRatingValue() {
        return ratingValue;
    }
    public void setRatingValue(int ratingValue) {
        this.ratingValue = ratingValue;
    }
    public float getRatingAvg() {
        return ratingAvg;
    }
    public void setRatingAvg(float ratingAvg) {
        this.ratingAvg = ratingAvg;
    }
    
    public String getFile2() {
        return file2;
    }
    public void setFile2(String file2) {
        this.file2 = file2;
    }
    public String getFile2saved() {
        return file2saved;
    }
    public void setFile2saved(String file2saved) {
        this.file2saved = file2saved;
    }
    public String getThumb2() {
        return thumb2;
    }
    public void setThumb2(String thumb2) {
        this.thumb2 = thumb2;
    }
    public long getSize2() {
        return size2;
    }
    public void setSize2(long size2) {
        this.size2 = size2;
    }
    public MultipartFile getFile2MF() {
        return file2MF;
    }
    public void setFile2MF(MultipartFile file2mf) {
        file2MF = file2mf;
    }
    
    
    
    
}
