<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>댕키트</title>
 <link rel="shortcut icon" href="/images/ee.png" /> <%-- /static 기준 --%>
<%-- /static/css/style.css --%> 
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
    
    background-color:#FEFCF0;
  }

</style>
    
</head> 
<body>
<c:import url="/menu/top.do" />
 

<br>
<div style='background-color:#FEFCF0; margin-left: 1%; font-size: 25px;'> 🔔알림</A></dIV>

  <DIV class='content_body'>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.code == 'payment_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">${param.mname }님 구매에 감사합니다.</span>
          </LI>  
          <LI class='li_none'>
            <button type='button' 
                         onclick="location.href='./login.do?id=${param.id}'"
                         class="btn btn-primary">로그인</button>
          </LI> 
        </c:when>
        
        <c:when test="${param.code == 'payment_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">구매에 실패했습니다. 다시 시도해주세요.</span>
          </LI>                                                                      
        </c:when>

        
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">알 수 없는 에러로 작업에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
        
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:choose>
            <c:when test="${param.cnt == 0 }">
                <button type='button' onclick="history.back()" class="btn btn-outline-dark">다시 시도</button>    
            </c:when>
        </c:choose>
        
        <%-- <a href="./list_by_cateno.do?cateno=${param.cateno}" class="btn btn-primary">목록</a> --%>
        <%-- <button type='button' onclick="location.href='./list_by_cateno_search.do?cateno=${param.cateno}'" class="btn btn-primary">목록</button> --%>
        <%-- <button type='button' onclick="location.href='./list_by_cateno_search_paging.do?cateno=${param.cateno}'" class="btn btn-primary">목록</button> --%>

      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>