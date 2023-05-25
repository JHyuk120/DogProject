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
     * 리뷰 생성
     * @param replyVO
     * @return
     */
    public int reply_create(ReplyVO replyVO);
}
