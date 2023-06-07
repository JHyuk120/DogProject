package dev.mvc.detail;

public class DetailVO {
  private int detailno;
  private int payno;
  private int memberno;
  private int goodsno;
  private String gname = "";
  private int saleprice;
  private int cnt = 0;
  private int tot;
  private int stateno;
  private String rdate  = "";
  
  
  public int getDetailno() {
    return detailno;
  }
  public void setDetailno(int detailno) {
    this.detailno = detailno;
  }
  public int getPayno() {
    return payno;
  }
  public void setPayno(int payno) {
    this.payno = payno;
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
  public String getGname() {
    return gname;
  }
  public void setGname(String gname) {
    this.gname = gname;
  }
  public int getSaleprice() {
    return saleprice;
  }
  public void setSaleprice(int saleprice) {
    this.saleprice = saleprice;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  public int getTot() {
    return tot;
  }
  public void setTot(int tot) {
    this.tot = tot;
  }
  public int getStateno() {
    return stateno;
  }
  public void setStateno(int stateno) {
    this.stateno = stateno;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  
  

}
