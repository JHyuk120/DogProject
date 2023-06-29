package dev.mvc.recipe;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.tool.Tool;

@Component("dev.mvc.recipe.RecipeProc")
  public class RecipeProc implements RecipeProcInter {
    @Autowired
    private RecipeDAOInter recipeDAO;

    @Override
    public int create(RecipeVO recipeVO) {
      int cnt=this.recipeDAO.create(recipeVO);
      return cnt;
    }

    @Override
    public ArrayList<RecipeVO> list_all() {
      ArrayList<RecipeVO> list = this.recipeDAO.list_all();
      
      for (RecipeVO recipeVO : list) {
        String title = recipeVO.getTitle();
        String article = recipeVO.getArticle();
        
        title = Tool.convertChar(title);  // 특수 문자 처리
        article = Tool.convertChar(article); 
        
        recipeVO.setTitle(title);
        recipeVO.setArticle(article);  
        
      }
      
      return list;
    }

    @Override
    public ArrayList<RecipeVO> list_by_itemno(int itemno) {
      ArrayList<RecipeVO> list = this.recipeDAO.list_by_itemno(itemno);
      for (RecipeVO recipeVO : list) {
        String title = recipeVO.getTitle();
        String article = recipeVO.getArticle();
        
        title = Tool.convertChar(title);  // 특수 문자 처리
        article = Tool.convertChar(article); 
        
        recipeVO.setTitle(title);
        recipeVO.setArticle(article);  
      }
      return list;
    }

    /**
     * 조회
     */
    @Override
    public RecipeVO read(int recipeno) {
      RecipeVO recipeVO = this.recipeDAO.read(recipeno);
      return recipeVO;
    }

    @Override
    public int youtube(RecipeVO recipeVO) {
      int cnt=this.recipeDAO.youtube(recipeVO);
      return cnt;
    }

    @Override
    public ArrayList<RecipeVO> list_by_itemno_search(RecipeVO recipeVO) {
      ArrayList<RecipeVO> list = this.recipeDAO.list_by_itemno_search(recipeVO);
      return list;
    }
    
    @Override
    public int search_count(RecipeVO recipeVO) {
      int cnt=this.recipeDAO.search_count(recipeVO);
      return cnt;
    }

    @Override
    public ArrayList<RecipeVO> list_by_itemno_search_paging(RecipeVO recipeVO) {
      
      /*
      예) 페이지당 10개의 레코드 출력
      1 page: WHERE r >= 1 AND r <= 10
      2 page: WHERE r >= 11 AND r <= 20
      3 page: WHERE r >= 21 AND r <= 30
        
      페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
      1 페이지 시작 rownum: now_page = 1, (1 - 1) * 10 --> 0 
      2 페이지 시작 rownum: now_page = 2, (2 - 1) * 10 --> 10
      3 페이지 시작 rownum: now_page = 3, (3 - 1) * 10 --> 20
      */
      int begin_of_page = (recipeVO.getNow_page() - 1) * Recipe.RECORD_PER_PAGE;
     
      // 시작 rownum 결정
      // 1 페이지 = 0 + 1: 1
      // 2 페이지 = 10 + 1: 11
      // 3 페이지 = 20 + 1: 21 
      int start_num = begin_of_page + 1;
      
      //  종료 rownum
      // 1 페이지 = 0 + 10: 10
      // 2 페이지 = 0 + 20: 20
      // 3 페이지 = 0 + 30: 30
      int end_num = begin_of_page + Recipe.RECORD_PER_PAGE;   
      /*
      1 페이지: WHERE r >= 1 AND r <= 10
      2 페이지: WHERE r >= 11 AND r <= 20
      3 페이지: WHERE r >= 21 AND r <= 30
      */
      recipeVO.setStart_num(start_num);
      recipeVO.setEnd_num(end_num);
     
      ArrayList<RecipeVO> list = this.recipeDAO.list_by_itemno_search_paging(recipeVO);
      
      for(RecipeVO vo : list) {  //특수 문자 처리
        String title =  vo.getTitle();
        String article =  vo.getArticle();
        
        title = Tool.convertChar(title);
        article = Tool.convertChar(article);
        
        vo.setTitle(title);
        vo.setArticle(article);
      }
      
      return list;
    }

      /** 
       * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
       * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
       *
       * @param itemno 카테고리번호 
       * @param now_page     현재 페이지
       * @param word 검색어
       * @param list_file 목록 파일명
       * @return 페이징 생성 문자열
       */ 
    @Override
    public String pagingBox(int itemno, int now_page, String word, String list_file){
      RecipeVO recipeVO = new RecipeVO();
      recipeVO.setItemno(itemno);
      recipeVO.setWord(word);
            
      int search_count = this.recipeDAO.search_count(recipeVO);  // 검색된 레코드 갯수 ->  전체 페이지 규모 파악
      int total_page = (int)(Math.ceil((double)search_count / Recipe.RECORD_PER_PAGE)); // 전체 페이지 수 
      int total_grp = (int)(Math.ceil((double)total_page / Recipe.PAGE_PER_BLOCK)); // 전체 그룹  수
      int now_grp = (int)(Math.ceil((double)now_page / Recipe.PAGE_PER_BLOCK));  // 현재 그룹 번호
      
      // 1 group: 1, 2, 3 ... 9, 10
      // 2 group: 11, 12 ... 19, 20
      // 3 group: 21, 22 ... 29, 30
      int start_page = ((now_grp - 1) * Recipe.PAGE_PER_BLOCK) + 1; // 특정 그룹의 시작  페이지  
      int end_page = (now_grp * Recipe.PAGE_PER_BLOCK);               // 특정 그룹의 마지막 페이지   
       
      StringBuffer str = new StringBuffer(); // String class 보다 문자열 추가등의 편집시 속도가 빠름 
       
      str.append("<style type='text/css'>"); 
      str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
      str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
      str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
      str.append("  #paging A:visited {text-decoration:none; color:#3DC79C; font-size: 1em;}"); 
      str.append("  .span_box_1{"); 
      str.append("    text-align: center;");    
      str.append("    font-size: 1em;"); 
      str.append("    border: 1px;"); 
      str.append("    border-style: solid;"); 
      str.append("    border-color: #cccccc;"); 
      str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("  }"); 
      str.append("  .span_box_2{"); 
      str.append("    text-align: center;");    
      str.append("    background-color: #3DC79C;"); 
      str.append("    color: white;"); 
      str.append("    font-size: 1em;"); 
      str.append("    border: 1px;"); 
      str.append("    border-style: solid;"); 
      str.append("    border-color: #cccccc;"); 
      str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
      str.append("  }"); 
      str.append("</style>"); 
      str.append("<DIV id='paging'>"); 
//      str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
   
      // 이전 10개 페이지로 이동
      // now_grp: 1 (1 ~ 10 page)
      // now_grp: 2 (11 ~ 20 page)
      // now_grp: 3 (21 ~ 30 page) 
      // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 마지막 페이지 10
      // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 마지막 페이지 20
      int _now_page = (now_grp - 1) * Recipe.PAGE_PER_BLOCK;  
      if (now_grp >= 2){ // 현재 그룹번호가 2이상이면 페이지수가 11페이 이상임으로 이전 그룹으로 갈수 있는 링크 생성 
        str.append("<span class='span_box_1'><A href='"+list_file+"?&word="+word+"&now_page="+_now_page+"&itemno="+itemno+"'>이전</A></span>"); 
      } 
   
      // 중앙의 페이지 목록
      for(int i=start_page; i<=end_page; i++){ 
        if (i > total_page){ // 마지막 페이지를 넘어갔다면 페이 출력 종료
          break; 
        } 
    
        if (now_page == i){ // 목록에 출력하는 페이지가 현재페이지와 같다면 CSS 강조(차별을 둠)
          str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
        }else{
          // 현재 페이지가 아닌 페이지는 이동이 가능하도록 링크를 설정
          str.append("<span class='span_box_1'><A href='"+list_file+"?word="+word+"&now_page="+i+"&itemno="+itemno+"'>"+i+"</A></span>");   
        } 
      } 
   
      // 10개 다음 페이지로 이동
      // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
      // 현재 페이지 5일경우 -> 현재 1그룹: (1 * 10) + 1 = 2그룹의 시작페이지 11
      // 현재 페이지 15일경우 -> 현재 2그룹: (2 * 10) + 1 = 3그룹의 시작페이지 21
      // 현재 페이지 25일경우 -> 현재 3그룹: (3 * 10) + 1 = 4그룹의 시작페이지 31
      _now_page = (now_grp * Recipe.PAGE_PER_BLOCK)+1; //  최대 페이지수 + 1 
      if (now_grp < total_grp){ 
        str.append("<span class='span_box_1'><A href='"+list_file+"?&word="+word+"&now_page="+_now_page+"&itemno="+itemno+"'>다음</A></span>"); 
      } 
      str.append("</DIV>"); 
       
      return str.toString(); 
    }

      @Override
      public int update_text(RecipeVO recipeVO) {
        int cnt = this.recipeDAO.update_text(recipeVO);
        return cnt;
      }

      @Override
      public int password_check(RecipeVO recipeVO) {
        int cnt = this.recipeDAO.password_check(recipeVO);
        return cnt;
      }

      @Override
      public int update_file(RecipeVO recipeVO) {
        int cnt = this.recipeDAO.update_file(recipeVO);
        return cnt;
    }

      @Override
      public int delete(int recipeno) {
        int cnt = this.recipeDAO.delete(recipeno);
        return cnt;
      
      }

      @Override
      public int count_by_itemno(int itemno) {
        int cnt = this.recipeDAO.count_by_itemno(itemno);
        return cnt;
      }

      @Override
      public int delete_by_itemno(int itemno) {
        int cnt = this.recipeDAO.delete_by_itemno(itemno);
        return cnt;
      }

      @Override
      public int cnt_add(int recipeno) {
        int cnt = this.recipeDAO.cnt_add(recipeno);
        return cnt;
      }

      @Override
      public int recom_add(int recipeno) {
        int cnt = this.recipeDAO.recom_add(recipeno);
        return cnt;
      }

      @Override
      public int recom_sub(int recipeno) {
        int cnt = this.recipeDAO.recom_sub(recipeno);
        return cnt;
      }

      @Override
      public ArrayList<RecipeVO> adminList() {
        ArrayList<RecipeVO> list_a = this.recipeDAO.adminList();
        return list_a;
      }

      @Override
      public ArrayList<RecipeVO> memberList(int memberno) {
        ArrayList<RecipeVO> list_m = this.recipeDAO.memberList(memberno);
        return list_m;
      }

    @Override
    public ArrayList<RecipeVO> recom_list() {
        ArrayList<RecipeVO> recom_list = this.recipeDAO.recom_list();
        return recom_list;
    }

    @Override
    public ArrayList<RecipeVO> new_list() {
        ArrayList<RecipeVO> new_list = this.recipeDAO.new_list();
        return new_list;
    }
 

}
 
 