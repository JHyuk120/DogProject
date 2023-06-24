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
  }

  .gallery_item {
    width: 22%;
    height: 300px;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
</style>
</head> 

<body>
  <c:import url="/menu/top.do" />
  
<DIV class='content_body' style='background-color:#FEFCF0;'>

<DIV>
   <span style='font-size: 30px;'>🥗밀키트 재료🥗</span>
</DIV>   
    <div style='display: flex; align-items: flex-start;'>
        <img src="/recipe/images/arrow.png" class="icon0" style='margin-right: 10px;'>
        <span style='font-size: 20px;'><span style='font-size: larger; '>${search_count}</span> 개의 재료가 있습니다</span>
    </div>


    <ASIDE class="aside_right">
  
      <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
      <c:if test="${sessionScope.admin_id != null }">
          <%--
          http://localhost:9091/contents/create.do?itemno=1
          http://localhost:9091/contents/create.do?itemno=2
          http://localhost:9091/contents/create.do?itemno=3
          --%>
        <A href="./create.do?itemno=${itemVO.itemno }">📝재료 등록</A>
        <span class='menu_divide' >│</span>
      </c:if>
    
      <A href="javascript:location.reload();">🔃새로고침</A>
      <span class='menu_divide' >│</span>    
      <A href="./list_by_itemno_search_paging_cart.do?itemno=${param.itemno }&now_page=${param.now_page == null ? 1 : param.now_page}&word=${param.word }">기본 목록형</A>    
      <span class='menu_divide' >│</span>
      <A href="./list_by_itemno_grid.do?itemno=${param.itemno }&now_page=${param.now_page == null ? 1: param.now_page}&word=${param.word }">갤러리형</A>
    </ASIDE>
  
    <DIV style="text-align: right; clear: both;">  
      <form name='frm' id='frm' method='get' action='./list_by_itemno_search_paging_cart.do'>
        <input type='hidden' name='itemno' value='${itemVO.itemno }'>  <%-- 게시판의 구분 --%>
      
        <c:choose>
          <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
            <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
          </c:when>
          <c:otherwise> <%-- 검색하지 않는 경우 --%>
            <input type='text' name='word' id='word' value='' class='input_word'>
          </c:otherwise>
        </c:choose>
        <button type='submit' class='btn btn-custom btn-sm' >검색</button>
          <c:if test="${param.word.length() > 0 }">
            <button type='button' class='btn btn-custom btn-sm' 
                    onclick="location.href='./list_by_itemno_search_paging_cart?itemno=${itemVO.itemno}&word='">검색 취소</button>  
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
  
    <div style='width: 100%; display: flex; flex-wrap: wrap; '>  <%-- 갤러리 Layout 시작 --%>
        <c:forEach var="goodsVO" items="${list }" varStatus="status">        
          <c:set var="gname" value="${goodsVO.gname }" />
          <c:set var="price" value="${goodsVO.price }" />  
          <c:set var="dc" value="${goodsVO.dc }" />
          <c:set var="saleprice" value="${goodsVO.saleprice}" />  
          <c:set var="point" value="${goodsVO.point}" />  
          <c:set var="content" value="${goodsVO.content }" />
          <c:set var="itemno" value="${goodsVO.itemno }" />
          <c:set var="goodsno" value="${goodsVO.goodsno }" />
          <c:set var="thumb1" value="${goodsVO.thumb1 }" />
          <c:set var="size1" value="${goodsVO.size1 }" />
        

          <!-- 4기준 하나의 이미지, 24 * 4 = 96% -->
          <!-- 5기준 하나의 이미지, 19.2 * 5 = 96% -->
          
          <div onclick="location.href='./read.do?goodsno=${goodsno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page}'"
        class="gallery_item"
        style="background-color: ${goodsno % 2 == 0 ? '#FEFCD6' : '#F5FEDE'};">
  
          <c:choose> 
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
              <%-- registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
              <div style="padding-bottom: 10px;">
              <img src="/dogproject/storage/${thumb1 }" style="width: 85%; height: 140px; ">
              </div>
            </c:when>
            <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
            <div style="padding-bottom:10px;">
              <IMG src="/goods/images/ee.png" style="width: 85%; height: 140px; ">
              </div>
            </c:otherwise>
          </c:choose>
          <strong><br>
          <div style='height: 25px; word-break: break-all;'>
              <c:choose>
                <c:when test="${gname.length() > 20 }"> <%-- 20 이상이면 10만 출력 --%>
                  ${gname.substring(0, 20)}...
                </c:when>
                <c:when test="${gname.length() <= 20 }">
                   ${gname}
                </c:when>
              </c:choose>
            </div>
          </strong>
         
         <DIV class='goods_line'></DIV>
          <span style="color: #94E5CD; font-size: 0.8em;">${dc} %</span>
           <del style="font-size: 0.4em; color: #D1D1D1"><fmt:formatNumber value="${price}" pattern="#,###" />원</del>
          <strong style="font-size: 0.99em;"><fmt:formatNumber value="${saleprice}" pattern="#,###" />원</strong><br>
          <img src="/cart/images/point.png" class="icon">
          <span style="font-size: 0.8em; color: #808080"><fmt:formatNumber value="${point}" pattern="#,###" />원 (2%)</span>
          <br>
          
          
				<c:forEach var="reviewVO" varStatus="reviewStatus" items="${reviewList}">
				  <c:if test="${reviewStatus.index eq status.index}">
				    <span>
				      <c:choose>
				        <c:when test="${reviewVO.ratingAvg >= 5}">
				          ⭐⭐⭐⭐⭐
				        </c:when>
				        <c:when test="${reviewVO.ratingAvg >= 4 && reviewVO.ratingAvg < 5}">
				          ⭐⭐⭐⭐
				        </c:when>
				        <c:when test="${reviewVO.ratingAvg >= 3 && reviewVO.ratingAvg < 4}">
				          ⭐⭐⭐
				        </c:when>
				        <c:when test="${reviewVO.ratingAvg >= 2 && reviewVO.ratingAvg < 3}">
				          ⭐⭐
				        </c:when>
				        <c:when test="${reviewVO.ratingAvg >= 1 && reviewVO.ratingAvg < 2}">
				          ⭐
				        </c:when>
				        <c:otherwise>
				          <img src="/review/images/wstar.png" style="width: 16px; text-align: center;">
				        </c:otherwise>
				      </c:choose>
				      <span style="font-size: 12px; color: #F2DC49;">(${reviewVO.reviewcnt})</span>
				    </span>
				  </c:if>
				</c:forEach>
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