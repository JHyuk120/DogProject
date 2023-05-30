package dev.mvc.reply;

import java.util.ArrayList;

import dev.mvc.reply.ReplyVO;

public interface ReplyDAOInter {
    /**
     * 리뷰 조회
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
     * recipeno별 댓글 수
     * @param revipeno
     * @return
     */
    public int reply_count(int recipeno);

}
