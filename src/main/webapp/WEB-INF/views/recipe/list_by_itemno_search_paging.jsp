<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
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
 
<body style="background-color: #FEFCE6;">
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>
<img src="/recipe/images/bone3.png" class="icon"  style='margin-left:5px; width: 2%; margin-bottom: 7px;'> ${itemVO.item }<img src="/recipe/images/arrow.png" class="icon" style='margin-left:5px; width: 2%; margin-bottom: 5px;'>총 ${search_count }건

</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">

    <c:choose>
      <c:when test="${sessionScope.isMember == null }">
      </c:when>
      <c:otherwise>
        <A href="./create.do?itemno=${itemVO.itemno }">📝레시피 등록</A>
        <span class='menu_divide' >│</span>
      </c:otherwise>
    </c:choose>

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno.do?itemno=${param.itemno }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">기본 목록형</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${param.itemno }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">갤러리형</A>
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
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
    <c:choose>
        <c:when test="${sessionScope.admin_id != null }">
      <col style="width: 10%;"></col>
      <col style="width: 80%;"></col>
      <col style="width: 10%;"></col>
        </c:when>
        <c:otherwise>
      <col style="width: 10%;"></col>
      <col style="width: 90%;"></col>
        </c:otherwise>
    </c:choose>
    
    </colgroup>

<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>제목</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <tbody>
      <c:forEach var="recipeVO" items="${list}">
        <c:set var="title" value="${recipeVO.title }" />
        <c:set var="article" value="${recipeVO.article }" />
        <c:set var="itemno" value="${recipeVO.itemno }" />
        <c:set var="recipeno" value="${recipeVO.recipeno }" />
        <c:set var="thumb1" value="${recipeVO.thumb1 }" />
        <c:set var="rdate" value="${recipeVO.rdate.substring(0,16) }" />
        <c:set var="cnt" value="${recipeVO.cnt }" />
         <c:set var="recom" value="${recipeVO.recom }" />
        <c:set var="mname" value="${recipeVO.mname }" />
        
         <tr style="height: 102px; onclick="location.href='./read.do?recipeno=${recipeno }' "class='hover'>
        <td style='vertical-align: middle;   background-color: ${recipeno % 2 == 0 ? '#FEFCD6' : '#F5FEDE'}; text-align: center;'>
        <a href="./read.do?recipeno=${recipeno }">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
              <%--registry.addResourceHandler("/recipe/storage/**").addResourceLocations("file:///" +  Recipe.getUploadDir()); --%>
              <img src="/dogproject/storage/${thumb1 }" style="width: 120px; height: 90px;">
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
              <IMG src="/recipe/images/ee.png" style="width: 100%; height: 120px; margin-bottom:4px; margin-top:4px; "><br>
              </c:otherwise>
            </c:choose>
            </a>
          </td>  
          <td style='vertical-align: middle;'>
        
            <a href="./read.do?recipeno=${recipeno }" style="display: block; width: 100%; height: 100%;">
              <div style='font-weight:bold;'>${title } </div>

          <div style='font-size:0.8em;  word-break: break-all;'>
          작성자 : <img src="/menu/images/pcircle.svg" class="icon" style="margin-bottom:15px; margin-top:8px;"> ${mname } <br>
             조회수 : ${cnt } | 좋아요 : ${recom } 

          </div>

            </a> 
          </td> 
          
          
          
    <c:choose>
        <c:when test="${sessionScope.admin_id != null }">
          
          <td style='vertical-align: middle; text-align: center;'>
            <A href="/recipe/map.do?itemno=${itemno }&recipeno=${recipeno}&now_page=&{param.now_page==null? 1:param.now_page}" title="지도"><IMG src="/recipe/images/map.png" class="icon"></A>
            <A href="/recipe/youtube.do?itemno=${itemno }&recipeno=${recipeno}&now_page=&{param.now_page==null? 1:param.now_page}" title="Youtube"><IMG src="/recipe/images/youtube.png" class="icon"></A>
            <A href="/recipe/delete.do?recipeno=${recipeno}&now_page=${param.now_page}" title="삭제"><IMG src="/recipe/images/delete.png" class="icon"></A>
          </td>
        </c:when>

        <c:otherwise>
        
        </c:otherwise>
        </c:choose>
        
        </tr>
        
      </c:forEach>

    </tbody>
  </table>
  
  <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
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
 