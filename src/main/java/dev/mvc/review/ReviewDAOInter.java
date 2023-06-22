package dev.mvc.review;

import java.util.ArrayList;

public interface ReviewDAOInter {
    /**
     * 리뷰 조회
     * @param goodsno
     * @return
     */
    public ArrayList<ReviewVO> review_list(int goodsno);
    /**
     * 
     * @param reviewVO
     * @return
     */
    public int review_create(ReviewVO reviewVO);
    /**
     * 리뷰 평균 계산
     * @param goodsno
     * @return
     */
    //public int ratingAVG_cal(int goodsno);
    /**w
     * 리뷰 평균 조회
     * @param goodsno
     * @return
     */
    public Float ratingAVG(int goodsno);
    /**
     * 리뷰 리스트 + 페이징
     * @param goodsno
     * @return
     */
    public ArrayList<ReviewVO>list_by_review_paging(ReviewVO reviewVO);
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
     * 리뷰 이미지 파일 수정
     * @param reviewVO
     * @return
     */
    public ReviewVO review_update_file(ReviewVO reviewVO);
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
