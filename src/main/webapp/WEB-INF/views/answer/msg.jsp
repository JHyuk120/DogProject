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


</head> 
<body>
<c:import url="/menu/top.do" />

<DIV class='title_line'>🔔알림</DIV>

<c:set var="code" value="${param.code }" />
<c:set var="cnt" value="${param.cnt }" /> 

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${code == 'passwd_fail'}">
          <LI class='li_none'>
            <span class="span_fail">🔔패스워드가 일치하지 않습니다.</span>
          </LI> 
        </c:when>
        
        <c:when test="${code == 'create_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">🔔답변을 등록했습니다.</span>
          </LI> 
        </c:when>
        
        <c:when test="${code == 'create_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">🔔답변 등록을 실패했습니다.</span>
          </LI>                                                                      
        </c:when>
        
        <c:when test="${code == 'update_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">🔔답변 수정에 실패했습니다</span>
          </LI>                                                                      
        </c:when>
        
        <c:when test="${code == 'delete_success'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_success">🔔답변 삭제를 성공했습니다.</span>
          </LI>                                                                      
        </c:when>        
        
        <c:when test="${code == 'delete_fail'}"> <%-- Java if --%>
          <LI class='li_none'>
            <span class="span_fail">🔔답변 삭제에 실패했습니다.</span>
          </LI>                                                                      
        </c:when> 
        
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">🔔알 수 없는 에러로 답변 등록에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">🔔다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:choose>
            <c:when test="${cnt == 0 }">
                <button type='button' onclick="history.back()" class="btn btn-primary">다시 시도</button>    
            </c:when>
        </c:choose>
        
        <button type='button' onclick="location.href='/qna/list_by_search.do'" class="btn btn-dark">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>