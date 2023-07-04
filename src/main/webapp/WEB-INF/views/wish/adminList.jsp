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
 ♥ 좋아요 많은 글 ♥
</DIV>

<DIV class='content_body'>
    
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
    <th style="text-align: center;">좋아요 수</th>
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
   <!-- 플로팅 메뉴 -->
<style>
    .float {
        position: fixed;
        bottom: 30px;
        right: 20px;
        z-index: 999;
    }
</style>

<div class="float">
    <div class="btn-group-vertical">
      <c:choose>
        <c:when test="${sessionScope.id != null }">
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';" onclick="location.href='/cart/list_by_memberno.do'">장바구니</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';" onclick="location.href='../recom/memberList.do?memberno=${memberno}'">저장한 레시피</button>
          <button type="button"class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"  onclick="location.href='/pay/pay_list.do'">주문내역</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='qna/list_by_search.do'">고객상담</button>
        </c:when>
        <c:otherwise>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='member/create.do'">회원가입</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='qna/list_by_search.do'">고객상담</button>
        </c:otherwise>
      </c:choose>
    </div>
</div>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>