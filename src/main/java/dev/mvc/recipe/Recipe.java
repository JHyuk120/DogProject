package dev.mvc.recipe;

import java.io.File;

//파일 업로드 경로는 war 외부의 절대경로를 지정해야 파일이 손실되지 않습니다. 
//만약 이렇게 안하면 war 생성시마다 업로드 경로가 초기화 되어 등록된 모든 파일이 삭제됩니다. ★
public class Recipe {
 /** 페이지당 출력할 레코드 갯수 */
 public static int RECORD_PER_PAGE = 8;

 /** 블럭당 페이지 수, 하나의 블럭은 10개의 페이지로 구성됨 */
 public static int PAGE_PER_BLOCK = 8;

 // Windows, VMWare, AWS cloud 절대 경로 설정
 public static synchronized String getUploadDir() {
     String path = "";
     if (File.separator.equals("\\")) { // windows, 개발 환경의 파일 업로드 폴더
         // path = "C:/kd/deploy/dog_v1sbm3c/recipe/storage/";
       path="C:\\kd\\deploy\\dogproject\\storage\\";
         // System.out.println("Windows 10: " + path);
         
     } else { // Linux, AWS, 서비스용 배치 폴더 
         // System.out.println("Linux");
       path = "/home/ubuntu/deploy/dogproject/recipe/storage/";
     }
     
     return path;
 }
 
}
