//package dev.mvc.qna;
//
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//
//import dev.mvc.notice.NoticeVO;
//import dev.mvc.tool.Tool;
//
//@Component("dev.mvc.qna.QnaProc")
//  public class QnaProc implements QnaProcInter {
//    @Autowired
//    private QnaDAOInter qnaDAO;
//
//    @Override
//    public int create(QnaVO qnaVO) {
//      int cnt = this.qnaDAO.create(qnaVO);
//      return cnt;
//    }
//
//    @Override
//    public ArrayList<QnaVO> list_all() {
//       ArrayList<QnaVO> list = this.qnaDAO.list_all();
//      
//      for (QnaVO qnaVO : list) {
//        String title = qnaVO.getTitle();
//        String content = qnaVO.getContent();
//        
//        title = Tool.convertChar(title);  // 특수 문자 처리
//        content = Tool.convertChar(content); 
//        
//        qnaVO.setTitle(title);
//        qnaVO.setContent(content);  
// 
//      }
//      return list;
//    }
//
//    @Override
//    public QnaVO read(int qnano) {
//      QnaVO qnaVO = this.qnaDAO.read(qnano);
//      return qnaVO;
//    }
//
//    @Override
//    public int password_check(QnaVO qnaVO) {
//      int cnt = this.qnaDAO.password_check(qnaVO);
//      return cnt;
//    }
//
//    @Override
//    public int update_text(QnaVO qnaVO) {
//      int cnt = this.qnaDAO.update_text(qnaVO);
//      return cnt;
//    }
//
//    @Override
//    public int delete(int qnano) {
//      int cnt = this.qnaDAO.delete(qnano);
//      return cnt;
//    }
//
//    
//}
//
