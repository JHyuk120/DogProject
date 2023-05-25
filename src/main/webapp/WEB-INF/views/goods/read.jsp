<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="goodsno" value="${goodsVO.goodsno }" />
<c:set var="itemno" value="${goodsVO.itemno }" />
<c:set var="gname" value="${goodsVO.gname }" />        
<c:set var="file1" value="${goodsVO.file1 }" />
<c:set var="file1saved" value="${goodsVO.file1saved }" />
<c:set var="thumb1" value="${goodsVO.thumb1 }" />
<c:set var="content" value="${goodsVO.content }" />
<c:set var="word" value="${goodsVO.word }" />
<c:set var="size1_label" value="${goodsVO.size1_label }" />
<c:set var="rdate" value="${goodsVO.rdate.substring(0, 16) }" />



 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Dog#</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'><A href="./list_by_itemno.do?itemno=${itemno }" class='title_link'>${itemVO.item }</A></DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
     <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.admin_id != null }">
      <%--
      http://localhost:9091/contents/create.do?itemno=1
      http://localhost:9091/contents/create.do?itemno=2
      http://localhost:9091/contents/create.do?itemno=3
      --%>
      <A href="./create.do?itemno=${itemVO.itemno }">등록</A>
      <span class='menu_divide' >│</span>
      <A href="./update_text.do?goodsno=${goodsno}&now_page=${param.now_page}&word=${param.word}">글 수정</A>
      <span class='menu_divide' >│</span>
      <A href="./update_file.do?goodsno=${goodsno}&now_page=${param.now_page}">파일 수정</A>  
      <span class='menu_divide' >│</span>
      <A href="./map.do?itemno=${itemno }&goodsno=${goodsno}">지도</A>   <!-- 카테고리 그룹: itemno -->
      <span class='menu_divide' >│</span>
      <A href="./youtube.do?itemno=${itemno }&goodsno=${goodsno}">YouTube</A>   <!-- 카테고리 그룹: itemno -->
      <span class='menu_divide' >│</span>
      <A href="./delete.do?goodsno=${goodsno}&now_page=${param.now_page}&itemno=${itemno}">삭제</A> 
      <span class='menu_divide' >│</span> 
    </c:if>

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno.do?itemno=${itemno }&now_page=${param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${itemno }&now_page=${param.now_page}&word=${param.word }">갤러리형</A>
    
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_itemno.do'>
      <input type='hidden' name='itemno' value='${itemVO.itemno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word}' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class='btn btn-info btn-sm' >검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class='btn btn-info btn-sm'
                     onclick="location.href='./list_by_itemno.do?itemno=${itemVO.itemno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 100%;">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/contents/storage/ --%>
                <IMG src="/contents/storage/${file1saved }" style="width: 50%; float: left; margin-top: 0.5%; margin_right: 1%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/contents/images/none1.png" style="width: 50%; float: left; margin-top: 0.5%; margin_right: 1%;"> 
              </c:otherwise>
            </c:choose>
       
          <span style="font-size: 1.5em; font-weight: bold;">${gname }</span><br>      
          <div style="font-size: 1em;">${mname } ${rdate }</div><br>     
          ${content }
        </DIV>
      </li>
      
      <c:if test="${map.trim().length() > 0 }">
          <li class="li_none" style="clear: both; padding-top: 15px; padding-bottom: 15px;">
                  <DIV style='text-align: center; width:640px; height: 380px; margin: 0px auto;'>
                    ${map }
                  </DIV>
          </li>
      </c:if>
     
      <li class="li_none">
        <DIV style='text-decoration: none;'>
        <br>
          검색어(키워드): ${word }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">  <%-- ServletRegister.java: registrationBean.addUrlMappings("/download");  --%>
            첨부 파일: <A href='/download?dir=/contents/storage&filename=${file1saved}&downname=${file1}'>${file1}</A> (${size1_label})  
          </c:if>
        </DIV>
      </li>   
    </ul>
  </fieldset>

</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>