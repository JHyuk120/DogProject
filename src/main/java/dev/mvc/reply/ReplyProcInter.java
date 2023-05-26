package dev.mvc.reply;

import java.util.ArrayList;

public interface ReplyProcInter {
    /**
     * 리뷰 조회
     * @param recipeno 
     * @param replyVO
     * @return
     */
    public ArrayList<ReplyVO>reply_list(int recipeno);
    /**
     * 리뷰 조회
     * @param replyVO
     * @return
     */
    public ArrayList<ReplyVO>list_by_reply_paging(ReplyVO replyVO);
    /**
     * 리뷰 생성
     * @param replyVO
     * @return
     */
    public int reply_create(ReplyVO replyVO);
    /**
     * 후기 평균계산 
     * @param recipeno
     * @return
     */
    public float ratingAVG_cal(int recipeno);
    /**
     * 후기 평균 조회
     * @param recipeno
     * @return
     */
    public float ratingAVG(int recipeno);
    /** 
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param cateno 카테고리번호  replyno
     *list_file 목록파일명
     * @param now_page     현재 페이지
     * @param word 검색어
     * @return 페이징 생성 문자열
     */
    String pagingBox(int recipeno, int now_page, String list_reply);

}
