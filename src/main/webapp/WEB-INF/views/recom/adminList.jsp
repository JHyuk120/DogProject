<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Daeng Kit</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

    
</head> 
 
<body style="background-color: #EFF8FB;">
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>
  📢 전체 공지사항
</DIV>

<DIV class='content_body'>
    
  <table class="table table-striped">
    <colgroup>
    <c:choose>
        <c:when test="${sessionScope.admin_id != null }">
      <col style="width: 50%; "></col>
      <col style="width: 50%;"></col>
        </c:when>
    </c:choose>
    
    </colgroup>

<thead>
  <tr>
    <th style="text-align: center;">번호</th>
    <th style="text-align: center;">카운트</th>
  </tr>
</thead>

 
 <tbody>
<c:forEach var="recomVO" items="${list_a}" varStatus="loop">
        <c:set var="recipeno" value="${recomVO.recipeno }" />
         
  <tr style="height: 50px;">
      <td style='vertical-align: middle; text-align: center;'>
        <a href="./read.do?noticeno=${noticeno}&now_page=${param.now_page == null?1:now_page }" style="display: block;">
          <div style='font-weight:bold;'>${recipeno}</div>
        </a>
      </td>
      <td style='vertical-align: middle; text-align: center;'>
        <div>${cnt}</div>
      </td>
    </tr>
  </c:forEach>
</tbody>
  </table>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>