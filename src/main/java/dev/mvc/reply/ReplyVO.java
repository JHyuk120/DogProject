package dev.mvc.reply;

public class ReplyVO {
    private int replyno;
    private int memberno;
    private int recipeno;
    private String replycont;
    private String rdate ="";
    private String file1 ="";
    private String file1saved ="";
    private String thumb1 ="";
    private String id="";
    private long size1;
    private int now_page = 1;
    private int start_num;
    private int end_num;
    private int recom = 0;
    private int replycnt = 0;
    private int ratingValue =0;
    private float ratingAvg = 0;
    
    public int getReplyno() {
        return replyno;
    }
    public void setReplyno(int replyno) {
        this.replyno = replyno;
    }
    public int getMemberno() {
        return memberno;
    }
    public void setMemberno(int memberno) {
        this.memberno = memberno;
    }
    public int getRecipeno() {
        return recipeno;
    }
    public void setRecipeno(int recipeno) {
        this.recipeno = recipeno;
    }
    public String getReplycont() {
        return replycont;
    }
    public void setReplycont(String replycont) {
        this.replycont = replycont;
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
    public int getReplycnt() {
        return replycnt;
    }
    public void setReplycnt(int replycnt) {
        this.replycnt = replycnt;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
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
