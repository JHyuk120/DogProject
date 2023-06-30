package dev.mvc.recommend;

import java.util.ArrayList;

public interface RecommendDAOInter {
    /**
     * itemno 읽어오기
     * @param memberno
     * @return
     */
    public int recommend_read(int memberno);
    /**
     * 추천하는 카테고리 출력
     * @param itemno
     * @return
     */
    public ArrayList<RecommendVO> recommend(int itemno);
    /**
     * 추천시스템 실행 여부
     * @param memberno
     * @return
     */
    public int recommend_cnt(int memberno);
    
   
        
}
