package dev.mvc.pay;

public class PayVO {
  private int payno;
  private int memberno;
  private int goosno;
  private String tname;
  private String ttel;
  private String tzipcode1;
  private String taddress1;
  private String taddress2;
  private int price;
  private int ptype;
  private String rdate;
  
  
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
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
  public int getGoosno() {
    return goosno;
  }
  public void setGoosno(int goosno) {
    this.goosno = goosno;
  }
  public String getTname() {
    return tname;
  }
  public void setTname(String tname) {
    this.tname = tname;
  }
  public String getTtel() {
    return ttel;
  }
  public void setTtel(String ttel) {
    this.ttel = ttel;
  }
  public String getTzipcode1() {
    return tzipcode1;
  }
  public void setTzipcode1(String tzipcode1) {
    this.tzipcode1 = tzipcode1;
  }
  public String getTaddress1() {
    return taddress1;
  }
  public void setTaddress1(String taddress1) {
    this.taddress1 = taddress1;
  }
  public String getTaddress2() {
    return taddress2;
  }
  public void setTaddress2(String taddress2) {
    this.taddress2 = taddress2;
  }
  public int getPrice() {
    return price;
  }
  public void setPrice(int price) {
    this.price = price;
  }
  public int getPtype() {
    return ptype;
  }
  public void setPtype(int ptype) {
    this.ptype = ptype;
  }
  

}
