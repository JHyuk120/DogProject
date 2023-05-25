package dev.mvc.reply;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.reply.ReplyVO;

@Component("dev.mvc.reply.ReplyProc")
public class ReplyProc implements ReplyProcInter {

    @Autowired
    private ReplyDAOInter ReplyDAO;

    @Override
    public ArrayList<ReplyVO> reply_list(int recipeno) {
       ArrayList<ReplyVO> list = this.ReplyDAO.reply_list(recipeno);
        return list;
    }

    @Override
    public int reply_create(ReplyVO replyVO) {
        int cnt = this.ReplyDAO.reply_create(replyVO);
        return cnt;
    }

}
