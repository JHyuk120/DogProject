<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="dev.mvc.item.ItemVO" %>

<%
ArrayList<ItemVO> list = (ArrayList<ItemVO>)request.getAttribute("list");
ItemVO itemVO;
int seqno = 0;
if (list.size() > 0){
  itemVO = list.get(list.size()-1);
  seqno = itemVO.getSeqno();
}
%>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>댕키트</title>
 <link rel="shortcut icon" href="/images/ee.png" /> <%-- /static 기준 --%>

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head> 
 
<body>
<c:import url="/menu/top.do" />
<%-- <jsp:include page="../menu/top.jsp" flush='false' />   -- 구형 --%> 
 
<DIV class='title_line'>전체 품목</DIV>

<DIV class='content_body'>
  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <label>품목명</label>
      <input type='text' name='item' value='' required="required" style='width: 35%;' margin-right= 10px; autofocus="autofocus">
      
      <label>순서 지정</label>
      <input type='number' name='seqno' min="1" value=<%=seqno + 1%> required="required" style='width: 5%;'>
  
      <button type="submit" id='submit' class='btn btn-success btn-sm'>등록</button>
      <button type="button" onclick="cancel();" class='btn btn-info btn-sm'>취소</button>
    </FORM>
  </DIV>

  <TABLE class='table table-hover'>
    <colgroup>
      <col style='width: 10%;'/>
      <col style='width: 60%;'/>
      <col style='width: 10%;'/>    
      <col style='width: 20%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">순서</TH>
      <TH class="th_bs">품목명</TH>
      <TH class="th_bs">자료수</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <%
        for (int i=0; i < list.size(); i++) {
          itemVO = list.get(i);
    %>
        <TR>
        <TD class='td_bs'><%= itemVO.getSeqno() %></TD>
        <%
        if (itemVO.getItemno() == 2){
          %>
          <TD><A href="/goods/list_by_itemno_grid.do?itemno=<%=itemVO.getItemno() %>&now_page=1" ><%=itemVO.getItem() %></A></TD>  
          <%
        } else {
          %>
          <TD><A href="/recipe/list_by_itemno.do?itemno=<%=itemVO.getItemno() %>&now_page=1" ><%=itemVO.getItem() %></A></TD>
          <%
        }
        %>
        <TD class='td_bs'><%=itemVO.getCnt() %></TD>
         <TD class='td_bs'>
         <a href="./read_update.do?itemno=<%=itemVO.getItemno() %>" title="수정"><IMG src="/item/images/update.png" class=icon></a>
         <a href="./update_seqno_decrease.do?itemno=<%=itemVO.getItemno() %>" title="우선순위 높이기"><IMG src="/item/images/increase.png" class=icon></a>
         <a href="./update_seqno_increase.do?itemno=<%=itemVO.getItemno() %>" title="우선순위 낮추기"><IMG src="/item/images/decrease.png" class=icon></a>
         <a href="./read_delete.do?itemno=<%=itemVO.getItemno() %>" title="삭제"><IMG src="/item/images/delete.png" class=icon></a>
        
        <%
        if(itemVO.getVisible().equals("Y")) {
          %>
        <a href="./update_visible_n.do?itemno=<%=itemVO.getItemno()%>"><IMG src="/item/images/show.png" class=icon></a>  
          <%
        } else {// N
          %>
          <a href="./update_visible_y.do?itemno=<%=itemVO.getItemno()%>"><IMG src="/item/images/hide.png" class=icon></a>
          <%
        }
        
      }
    %>
    </TD>
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

