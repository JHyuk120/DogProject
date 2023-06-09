package dev.mvc.qna;

import java.io.File;

public class Qna {
    /** 페이지당 출력할 레코드 갯수 */
    public static int RECORD_PER_PAGE = 15;

    /** 블럭당 페이지 수, 하나의 블럭은 10개의 페이지로 구성됨 */
    public static int PAGE_PER_BLOCK = 10;
//
//    /** 목록 파일명 */
//    public static String LIST_FILE = "list_by_cateno.do";

    // Windows, VMWare, AWS cloud 절대 경로 설정
    public static synchronized String getUploadDir() {
        String path = "";
        if (File.separator.equals("\\")) {
       // path = "C:/kd/deploy/dog_v1sbm3c/recipe/storage/";
            path="C:\\kd\\deploy\\dogproject\\\\storage\\";
            // System.out.println("Windows 10: " + path);
            
        } else {
            // System.out.println("Linux");
          path = "/home/ubuntu/deploy/dogproject/recipe/storage/";
        }
        
        return path;
    }
    
}