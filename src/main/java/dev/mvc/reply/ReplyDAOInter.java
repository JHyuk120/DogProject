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

    /**
     * recipeno별 댓글 수
     * @param revipeno
     * @return
     */
    public int reply_count(int recipeno);
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
    /**
     * 댓글 갯수     
     * @param recipeno
     * @return
     */
    public ReplyVO replycnt(int recipeno);
    /**
     * 댓글 추천
     * @param memberno
     * @param replyno
     * @return
     */
    public int reply_recom_create (int memberno, int replyno);
    /**
     * 추천 취소
     * @param replyno
     * @return
     */
    public int reply_recom_undo (int replyno);
    /**
     * 추천 조회
     * @param replyno
     * @return
     */
    public int reply_recom(int replyno);

}
