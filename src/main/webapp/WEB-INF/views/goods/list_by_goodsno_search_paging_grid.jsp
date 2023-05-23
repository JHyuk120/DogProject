<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head> 
 
<body>
  <c:import url="/menu/top.do" />
 
  <DIV class='title_line'>
    ${cateVO.name }  
    <c:if test="${param.word.length() > 0 }">
      > 「${param.word }」 검색 ${list.size() } 건
    </c:if> 
      
  </DIV>

  <DIV class='content_body'>
    <ASIDE class="aside_right">
  
      <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
      <c:if test="${sessionScope.admin_id != null }">
          <%--
          http://localhost:9091/contents/create.do?cateno=1
          http://localhost:9091/contents/create.do?cateno=2
          http://localhost:9091/contents/create.do?cateno=3
          --%>
        <A href="./create.do?cateno=${cateVO.cateno }">등록</A>
        <span class='menu_divide' >│</span>
      </c:if>
    
      <A href="javascript:location.reload();">새로고침</A>
      <span class='menu_divide' >│</span>    
      <A href="./list_by_cateno.do?cateno=${param.cateno }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">기본 목록형</A>    
      <span class='menu_divide' >│</span>
      <A href="./list_by_cateno_grid.do?cateno=${param.cateno }&now_page=${param.now_page == null ? 1: param.now_page}&word=${param.word }">갤러리형</A>
    </ASIDE>
  
    <DIV style="text-align: right; clear: both;">  
      <form name='frm' id='frm' method='get' action='./list_by_cateno.do'>
        <input type='hidden' name='cateno' value='${cateVO.cateno }'>  <%-- 게시판의 구분 --%>
      
        <c:choose>
          <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
            <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
          </c:when>
          <c:otherwise> <%-- 검색하지 않는 경우 --%>
            <input type='text' name='word' id='word' value='' class='input_word'>
          </c:otherwise>
        </c:choose>
        <button type='submit' class='btn btn-info btn-sm'>검색</button>
          <c:if test="${param.word.length() > 0 }">
            <button type='button' class='btn btn-info btn-sm' 
                    onclick="location.href='./list_by_cateno.do?cateno=${cateVO.cateno}&word='">검색 취소</button>  
          </c:if>    
        </form>
      </DIV>

      <DIV class='menu_line'></DIV>
  
      <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>
        <c:forEach var="contentsVO" items="${list }" varStatus="status">
          <c:set var="title" value="${contentsVO.title }" />
          <c:set var="content" value="${contentsVO.content }" />
          <c:set var="cateno" value="${contentsVO.cateno }" />
          <c:set var="contentsno" value="${contentsVO.contentsno }" />
          <c:set var="thumb1" value="${contentsVO.thumb1 }" />
          <c:set var="size1" value="${contentsVO.size1 }" />
        
          <%-- 하나의 행에 이미지를 5개씩 출력후 행 변경, index는 0부터 시작 --%>
          <c:if test="${status.index % 5 == 0 && status.index != 0 }"> 
            <HR class='menu_line'> <%-- 줄바꿈 --%>
          </c:if>
        
          <!-- 4기준 하나의 이미지, 24 * 4 = 96% -->
          <!-- 5기준 하나의 이미지, 19.2 * 5 = 96% -->
          <div onclick="location.href='./read.do?contentsno=${contentsno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page}'" class='hover'
                    style='width: 19%; height: 240px; float: left; margin: 0.5%; padding: 0.1%; background-color: #EEEFFF; text-align: left;'>
        
          <c:choose> 
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
              <%-- registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
              <img src="/contents/storage/${thumb1 }" style="width: 100%; height: 140px;">
            </c:when>
            <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
              <IMG src="/contents/images/none1.png" style="width: 100%; height: 140px;">
            </c:otherwise>
          </c:choose>
          <strong>
            <div style='height=20px; word-break: break-all;'>
              <c:choose>
                <c:when test="${title.length() > 20 }"> <%-- 20 이상이면 10만 출력 --%>
                  ${title.substring(0, 20)}...
                </c:when>
                <c:when test="${title.length() <= 20 }">
                   ${title}
                </c:when>
              </c:choose>
            </div>
          </strong>
       
          <div style='font-size:0.95em; word-break: break-all;'>
            <c:choose>
              <c:when test="${content.length() > 60 }"> <%-- 60 이상이면 30자만 출력 --%>
                 ${content.substring(0, 60)}...
              </c:when>
              <c:when test="${content.length() <= 60 }">
                 ${content}
              </c:when>
           </c:choose>
        </div>
      </div>
      
    </c:forEach>
  </div>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>