package dev.mvc.review;

public class ReviewVO {
    private int reviewno;
    private int memberno;
    private int goodsno;
    private String reviewcont;
    private String rdate ="";
    private String file1 ="";
    private String file1saved ="";
    private String thumb1 ="";
    private String mid="";
    private long size1;
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
    public String getMid() {
        return mid;
    }
    public void setMid(String mid) {
        this.mid = mid;
    }
    public long getSize1() {
        return size1;
    }
    public void setSize1(long size1) {
        this.size1 = size1;
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
    
    
}
