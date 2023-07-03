package dev.mvc.answer;


import java.util.ArrayList;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.cart.CartVO;
import dev.mvc.qna.QnaVO;
import dev.mvc.tool.Tool;

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

  @Override
  public ArrayList<AnswerVO> list_all() {
    ArrayList<AnswerVO> list = this.answerDAO.list_all();
    
    for (AnswerVO answerVO : list) {
      String title = answerVO.getTitle();
      String text = answerVO.getText();
      
      title = Tool.convertChar(title);  // 특수 문자 처리
      text = Tool.convertChar(text); 
      
      answerVO.setTitle(title);
      answerVO.setText(text);  

    }
    return list;
  }


}
