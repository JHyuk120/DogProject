<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="itemno" value="${itemVO.itemno }" />

<c:set var="goodsno" value="${goodsVO.goodsno }" />
<c:set var="gname" value="${goodsVO.gname }" />
<c:set var="content" value="${goodsVO.content }" />
<c:set var="word" value="${goodsVO.word }" />
<c:set var="price" value="${goodsVO.price }" />
<c:set var="dc" value="${goodsVO.dc }" />
<c:set var="cnt" value="${goodsVO.cnt }" />

 
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
    .btn-custom {
      background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
      color: white; /* 버튼 텍스트 색상 설정 (선택적) */
    }
</style>
</head>
 
<body>




<c:import url="/menu/top.do" />
 
<DIV class='title_line'> ${itemVO.item } > ${gname } > 수정</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?itemno=${itemno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_search_paging_cart.do?itemno=${itemno }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${itemno }">갤러리형</A>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_itemno.do'>
      <input type='hidden' name='itemno' value='${itemno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class='btn btn-custom btn-sm'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class='btn btn-custom btn-sm' 
                    onclick="location.href='./list_by_itemno.do?itemno=${itemVO.itemno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <FORM name='frm' method='POST' action='./update_text.do'>
    <input type="hidden" name="itemno" value="${itemno }">
    <input type="hidden" name="goodsno" value="${goodsno }">
    <input type="hidden" name="now_page" value="${param.now_page }">
    
     <div>
       <label>제목</label>
       <input type='text' name='gname' value='${gname }' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 30%;'><br>
    </div>
     
    <div class="row" style='width:35%'>
      <div class="col-sm-4">
        <label for="price">가격</label>
        <input type="number" class="form-control" id="price" name="price" value="${price }" >
      </div>
      <div class="col-sm-4">
        <label for="dc">DC</label>
          <div class="input-group">
            <input type="number" class="form-control" id="dc" name="dc" min="0" max="100" value="${dc }">
            <div class="input-group-append">
              <span class="input-group-text">%</span>
            </div>
          </div>
        </div>
        <div class="col-sm-4">
          <label for="cnt">수량</label>
          <input type="number" class="form-control" id="cnt" name="cnt" value="${cnt }" min="0" style='width:80%'>
        </div>
    </div>
    <br>
    
    <div>
       <label>내용</label>
       <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'>${content }</textarea><br>
    </div>
    
    <div>
       <label>검색어</label>
       <input type='text' name='word' value='${word }' required="required" 
                 class="form-control" style='width: 100%;'><br>
    </div>  
       
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-dark">저장</button>
      <button type="button" onclick="location.href='./read.do?itemno=${param.itemno}&goodsno=${goodsno }'" class="btn btn-outline-dark">취소</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>