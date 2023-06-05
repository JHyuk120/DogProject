package dev.mvc.reply;

import java.util.ArrayList;

import dev.mvc.review.ReviewVO;

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
     * recipeno별 댓글 수
     * @param revipeno
     * @return
     */
    public int reply_count(int recipeno);
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
    /**
     * 리뷰 수정 조회
     * @param replyno
     * @return
     */
    public ReplyVO reply_read(int replyno);
    /**
     * 리뷰 수정
     * @param recipeno
     * @return
     */
    public int reply_update(ReplyVO replyVO);
    /**
     * 리뷰 삭제
     * @param replyno
     * @return
     */
    public int reply_delete(int replyno);


}
