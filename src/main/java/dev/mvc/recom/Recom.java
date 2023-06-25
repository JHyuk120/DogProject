package dev.mvc.recom;

import java.io.File;

// 파일 업로드 경로는 war 외부의 절대경로를 저정해야 파일이 손실되지 않는다.
// 만약 이렇게 안하면 war 생성시마다 업로드 경로가 초기화되어 등록된 모든 파일이 삭제된다. <<<<


public class Recom {
  /** 페이지당 출력할 레코드 갯수 */
  public static int RECORD_PER_PAGE = 8;

}