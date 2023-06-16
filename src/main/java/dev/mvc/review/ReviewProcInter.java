package dev.mvc.review;

import java.util.ArrayList;

public interface ReviewProcInter {
    /**
     * 리뷰 조회
     * @param goodsno
     * @return
     */
    public ArrayList<ReviewVO> review_list(int goodsno);
    /**
     * 리뷰 생성
     * @param reviewVO
     * @return
     */
    public int review_create(ReviewVO reviewVO);
    /**
     * 리뷰 평균 계산
     * @param goodsno
     * @return
     */
    public int ratingAVG_cal(int goodsno);
    /**
     * 리뷰 평균 조회
     * @param goodsno
     * @return
     */
    public float ratingAVG(int goodsno);
    /**
     * 리뷰 리스트 + 페이징
     * @param goodsno
     * @return
     */
    public ArrayList<ReviewVO>list_by_review_paging(ReviewVO reviewVO);
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
    String pagingBox(int goodsno, int now_page, String list_review);
    /**
     * 게시물 별 리뷰 갯수
     * @param goodsno
     * @return
     */
    public int review_count(int goodsno);
    /**
     * 리뷰 수정 조회
     * @param reviewno
     * @return
     */
    public ReviewVO review_read(int reviewno);
    /**
     * 리뷰 수정
     * @param reviewVO
     * @return
     */
    public int review_update(ReviewVO reviewVO);
    /**
     * 리뷰 삭제
     * @param reviewno
     * @return
     */
    public int review_delete(int reviewno);
    /**
     * 이미지 수정
     * @param reviewVO
     * @return
     */
    public int update_file(ReviewVO reviewVO);

}
