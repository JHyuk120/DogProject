<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="noticeno" value="${noticeVO.noticeno }" />
<c:set var="title" value="${noticeVO.title }" />        
<c:set var="file1" value="${noticeVO.file1 }" />
<c:set var="file1saved" value="${noticeVO.file1saved }" />
<c:set var="thumb1" value="${noticeVO.thumb1 }" />
<c:set var="content" value="${noticeVO.content }" />
<c:set var="word" value="${noticeVO.word }" />
<c:set var="size1_label" value="${noticeVO.size1_label }" />
<c:set var="rdate" value="${noticeVO.rdate.substring(0,16) }" />

 
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
 
<DIV class='title_line'>📢공지사항</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.admin_id != null }">

      <A href="./create.do">등록</A>
      <span class='menu_divide' >│</span>
	    <A href="./update_text.do?noticeno=${noticeno}&now_page=${param.now_page}&word=${param.word}">글 수정</A>
	    <span class='menu_divide' >│</span>
	    <A href="./update_file.do?noticeno=${noticeno}&now_page=${param.now_page}">파일 수정</A>  
	    <span class='menu_divide' >│</span>
	    <A href="./delete.do?noticeno=${noticeno}&now_page=${param.now_page}&cateno=${param.cateno}">삭제</A>  
    <span class='menu_divide' >│</span>
    </c:if>

    <A href="javascript:location.reload();">새로고침</A>
   
  </ASIDE> 
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width:100%;">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/notice/storage/ --%>
                <img src="/dogproject/storage/${file1saved }" style='width: 50%; float:left; margin-top:0.5%; margin-right:1%'> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <img src="/dogproject/images/none1.png" style='width: 50%; float:left; margin-top:0.5%; margin-right:1%'> 
              </c:otherwise>
            </c:choose>
          
         <span style="font-size: 1.5em; font-weight: bold;">${title }</span><br>
         <div style="font-size: 0.7em;">${mname}${rdate }</div><br>
        ${content }
        </DIV>
      </li>
  
     <li class="li_none" style="clear: both;">
        <DIV style='text-decoration: none;'>
        <br>
          검색어(키워드): ${word }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/dogproject/storage&filename=${file1saved}&downname=${file1}'>${file1}</A> (${size1_label})  
          </c:if>
         
        </DIV>
      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>