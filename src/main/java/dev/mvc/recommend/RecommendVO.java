package dev.mvc.recommend;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class RecommendVO {
    
    public int recommendno;
    public int memberno;
    public int itemno;
    public int seq;
    public String rdate ="";
    private String thumb1 = "";
    private String title = "";
}
