<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="noticeno" value="${noticeVO.noticeno }" />
<c:set var="title" value="${noticeVO.title }" />
<c:set var="content" value="${noticeVO.content }" />
<c:set var="word" value="${noticeVO.word }" />

 
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
    
    background-color:#FEFCF0;
  }


    .btn-custom {
      background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
      color: white; /* 버튼 텍스트 색상 설정 (선택적) */
    }  
    </style>
    
</head> 
<body>
<c:import url="/menu/top.do" />
 
  <DIV class='content_body'>
  <DIV>
<img src="/menu/images/qna1.png" class="icon1" style='margin-left:42%; margin-right:10px; margin-bottom: 7px;'> <span style='font-size: 30px;'>관리자 답변</span>
</DIV> <br>

  <%--수정 폼 --%>
  <FORM name='frm' method='POST' action='./update_text.do'>
    <input type="hidden" name="noticeno" value="${noticeno }">
    <input type="hidden" name="now_page" value="${param.now_page }">


    
        
    <div>
       <label>제목</label>
       <input type='text' name='title' value='${title }' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;' maxlength='50'>
    </div>
    
    <div>
       <label>내용</label>
       <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'>${content }</textarea>
    </div>

    
    <div>
       <label>검색어</label>
       <input type='text' name='word' value='${word }' required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
    
    <c:choose>
        <c:when test ='${sessionScope.admin_id == null }'>
        <div>
       <label>패스워드</label>
       <input type='passwd' name='passwd' value='' required="required" 
                 class="form-control" style='width: 50%;'>
        </div> 
        </c:when>
      <c:otherwise>
      </c:otherwise>
    </c:choose>
    

    
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-dark">저장</button>
      <button type="button" onclick="location.href='./read.do?'" class="btn btn-outline-dark">취소</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>