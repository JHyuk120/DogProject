package dev.mvc.answer;


import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.cart.CartVO;
import dev.mvc.qna.QnaVO;

@Component("dev.mvc.answer.AnswerProc")
public class AnswerProc implements AnswerProcInter{
  @Autowired
  private AnswerDAOInter answerDAO;

  @Override
  public int create(AnswerVO answerVO) {
    int cnt = this.answerDAO.create(answerVO);
    return cnt;
  }

  @Override
  public AnswerVO read(int answer_no) {
    AnswerVO answerVO = this.answerDAO.read(answer_no);
    return answerVO;
  }




}
