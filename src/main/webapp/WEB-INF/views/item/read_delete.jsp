<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="dev.mvc.item.ItemVO" %>

<%
ItemVO read_itemVO = (ItemVO) request.getAttribute("itemVO");
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
    
    <style>
  body {
    background-color: #FEFCE6;
    display: flex;
    flex-direction: column;
    align-items: center;
  }

  .content_body {
    width: 100%;
    max-width: 1200px;
    text-align: center;
    background-color:#FEFCF0;
  }

  .gallery_item {
    width: 22%;
    height: 300px;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
    </style>
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
<%-- <jsp:include page="../menu/top.jsp" /> --%>
 
<DIV class='content_body'>

<div><IMG src="/item/images/dele.png" class=icon0>&nbsp;전체 품목 > 삭제</div>

  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
      <input type="hidden" name="itemno" value="<%=read_itemVO.getItemno() %>">
    
      <div class="msg_warning">카테고리를 삭제하면 복구 할 수 없습니다.</div>
      <label>품목</label> : <%=read_itemVO.getItem() %>
  
      <button type="submit" id='submit' class="btn btn-danger btn-sm">삭제</button>
      <button type="button" onclick="location.href='/item/list_all.do'" class="btn btn-secondary btn-sm">취소</button>
    </FORM>
  </DIV>

  <TABLE class='table table-hover'>
    <colgroup>
      <col style='width: 15%;'/>
      <col style='width: 55%;'/>
      <col style='width: 15%;'/>    
      <col style='width: 25%;'/>
    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">순서</TH>
      <TH class="th_bs">품목</TH>
      <TH class="th_bs">자료수</TH>
      <TH class="th_bs">기타</TH>
    </TR>
    </thead>
    
    <tbody>
    <%
    ArrayList<ItemVO> list = (ArrayList<ItemVO>)request.getAttribute("list");

    for(int i = 0; i < list.size(); i ++){
      ItemVO itemVO = list.get(i);
      %>
      <TR>
      <TD class = 'td_bs'><%=itemVO.getSeqno() %></TD>
      <TD><%=itemVO.getItem() %></TD>
      <TD class = 'td_bs'><%=itemVO.getCnt() %></TD>
      <TD class = 'td_bs'>
      <a href="./read_update.do?itemno=<%=itemVO.getItemno()%>" title="수정"><IMG src="/item/images/update.png" class=icon></a> /
      <a href="./read_delete.do?itemno=<%=itemVO.getItemno()%>" title="삭제"><IMG src="/item/images/dele.png" class=icon></a>
      </TD>
      </TR>
    
    <%
    }
    %>
    </tbody>
   
  </TABLE>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>