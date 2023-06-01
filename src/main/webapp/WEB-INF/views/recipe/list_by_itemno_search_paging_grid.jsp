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
 
<body style="background-color: #FEFCE6;">
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>
🦴 ${itemVO.item } 💛 ${search_count }개 💛
    
    
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
  

      <A href="./create.do?itemno=${itemVO.itemno }">레시피 등록</A>
      <span class='menu_divide' >│</span>

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>    
    <A href="./list_by_itemno.do?itemno=${param.itemno }&now_page=${param.now_page == null?1:param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${param.itemno }&now_page=${param.now_page == null?1:param.now_page}&word=${param.word }">갤러리형</A>
  </ASIDE>
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_itemno.do'>
      <input type='hidden' name='itemno' value='${itemVO.itemno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
            <button type="submit" class="btn btn-custom btn-sm">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type="button" class="btn btn-custom btn-sm" onclick="location.href='./list_by_itemno.do?itemno=${itemVO.itemno}&word='">검색 취소</button>
      </c:if>
          <style>
          .btn-custom {
            background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
            color: white; /* 버튼 텍스트 색상 설정 (선택적) */
          }
          </style>
    </form>
  </DIV>
   

  <DIV class='menu_line'></DIV>
  
  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>
    <c:forEach var="recipeVO" items="${list }" varStatus="status">
      <c:set var="title" value="${recipeVO.title }" />
      <c:set var="article" value="${recipeVO.article }" />
      <c:set var="itemno" value="${recipeVO.itemno }" />
      <c:set var="recipeno" value="${recipeVO.recipeno }" />
      <c:set var="thumb1" value="${recipeVO.thumb1 }" />
      <c:set var="size1" value="${recipeVO.size1 }" />
      <c:set var="cnt" value="${recipeVO.cnt }" />
        
      <%-- 하나의 행에 이미지를 5개씩 출력후 행 변경, index는 0부터 시작 --%>
      <c:if test="${status.index % 4 == 0 && status.index != 0 }"> 

      </c:if>
        
      <!-- 4기준 하나의 이미지, 24 * 4 = 96% -->
      <!-- 5기준 하나의 이미지, 19.2 * 5 = 96% -->
      
      <div onclick="location.href='./read.do?recipeno=${recipeno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }'" class="hover"
      style="width: 23.2%; height: 300px; float: left; margin: 0.9%; padding: 0.5%;
      background-color: ${recipeno % 2 == 0 ? '#FEFCD6' : '#F5FEDE'}; text-align: center;
      border: 1px solid #000000;">
  <!-- 나머지 연산자를 사용하여 홀수와 짝수를 판별하여 배경색 설정 -->
  
        <c:choose> 
          <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
            <%-- registry.addResourceHandler("/recipe/storage/**").addResourceLocations("file:///" +  Recipe.getUploadDir()); --%>
            <img src="/dogproject/storage/${thumb1 }" style="width: 100%; height: 200px;">
          </c:when>
          <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/recipe/images/none1.png -->
            <IMG src="/recipe/images/none1.png" style="width: 100%; height: 200px;">
          </c:otherwise>
        </c:choose>
          <strong>
	          <div style='height: 25px;  word-break: break-all;'>
	            <c:choose> 
                <c:when test="${title.length() > 30 }"> <%-- 160자 이상이면 160자만 출력 --%>
                  ${title.substring(0, 30)}.....
                </c:when>
	              <c:when test="${title.length() <= 30 }">
	                ${title}
	              </c:when>
	            </c:choose>
	          </div>
          </strong>
          
          <div style='font-size:0.8em;  word-break: break-all;'>
             조회수 : ${cnt } | 
          </div>
          
          <div style='font-size:0.8em;  word-break: break-all;'>
	           <c:choose> 
		           <c:when test="${article.length() > 30 }"> <%-- 70자 이상이면 70자만 출력 --%>
		             ${article.substring(0, 30)}.....
		           </c:when>
               <c:when test="${article.length() <= 30 }">
                 ${article}
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