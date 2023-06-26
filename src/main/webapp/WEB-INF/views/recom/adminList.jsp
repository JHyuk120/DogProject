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

<DIV class='content_body'>
  <DIV>
    <img src="/menu/images/save.png" class="icon0" style='margin-left:10px; margin-right:10px; margin-bottom: 7px;'> <span style='font-size: 30px;'>회원들이 많이 저장한 글 목록</span>
</DIV> <br>
    
  <table class="table table-striped">
    <colgroup>
    <c:choose>
        <c:when test="${sessionScope.admin_id != null }">
      <col style="width: 60%; "></col>
      <col style="width: 15%;"></col>
      <col style="width: 25%;"></col>
        </c:when>
    </c:choose>
    
    </colgroup>

<thead>
  <tr>
    <th style="text-align: center;">제목</th>
    <th style="text-align: center;">글 저장수</th>
    <th style="text-align: center;">날짜</th>
  </tr>
</thead>

 
 <tbody>
<c:forEach var="recipeVO" items="${list_a}" varStatus="loop">
        <c:set var="recipeno" value="${recipeVO.recipeno }" />
        <c:set var="title" value="${recipeVO.title }" />
        <c:set var="recom" value="${recipeVO.recom }" />
        <c:set var="rdate" value="${recipeVO.rdate }" />
         
  <tr style="height: 50px;">
      <td style='vertical-align: middle; text-align: center;'>
        <a href="../recipe/read.do?recipeno=${recipeno}&now_page=${param.now_page == null?1:now_page }" style="display: block;">
          <div style='font-weight:bold;'>${title}</div>
        </a>
      </td>
      <td style='vertical-align: middle; text-align: center;'>
        <div>${recom}</div>
      </td>
      <td style='vertical-align: middle; text-align: center;'>
        <div>${rdate}</div>
      </td>
    </tr>
  </c:forEach>
</tbody>
  </table>
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>