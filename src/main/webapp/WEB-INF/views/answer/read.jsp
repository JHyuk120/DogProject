<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="answer_no" value="${answerVO.answer_no }" />
<c:set var="qnano" value="${answerVO.qnano }" />
<c:set var="title" value="${answerVO.title }" />
<c:set var="aname" value="${answerVO.aname }" />
<c:set var="text" value="${answerVO.text }" />        
<c:set var="rdate" value="${answerVO.rdate.substring(0,10) }" />


 
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
    background-color: #FEFCF0;
  }

  .fieldset_basic {
    width: 100%;
    height: 100%;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
</style>

</head>
 
<body>
<c:import url="/menu/top.do" />
 
<DIV style='background-color:#FEFCF0; margin-right: 60%; font-size: 30px;'><img src="/menu/images/qna1.png" class="icon1"> Q&A 답변</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
      <c:if test="${sessionScope.adminno == adminno }">
          <span class='menu_divide' >│</span>
          <A href="./update_text.do?qnano=${qnano}&now_page=${param.now_page}&word=${param.word}">글 수정</A>
          <span class='menu_divide' >│</span>
          <A href="./delete.do?qnano=${qnano}&now_page=${param.now_page}">삭제</A>  
      </c:if>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
   
  </ASIDE> 
  
  <DIV class='menu_line'></DIV><br>
      <span style="font-size: 1.7em; font-weight: bold;">${title }</span>
          <div style="font-size: 0.8em; margin-left: 78%;">${aname } / ${rdate }</div> <br>
          
          <div style="float: left;">${text }</div>
      </li>
      
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>