  <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
 
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
 
<DIV class='title_line'>
  ${itemVO.item  }
</DIV>

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
    </c:if>
    
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno.do?itemno=${param.itemno }&now_page=${param.now_page == null? 1: param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${param.itemno }&now_page=${param.now_page == null? 1: param.now_page}&word=${param.word }">갤러리형</A>
    
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
      <button type='submit' class='btn btn-info btn-sm' >검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class='btn btn-info btn-sm'
                     onclick="location.href='./list_by_itemno.do?itemno=${itemVO.itemno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>

  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <c:choose>
        <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
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
      <c:forEach var="goodsVO" items="${list}">
        <c:set var="gname" value="${goodsVO.gname }" />
        <c:set var="content" value="${goodsVO.content }" />
        <c:set var="itemno" value="${goodsVO.itemno }" />
        <c:set var="goodsno" value="${goodsVO.goodsno }" />
        <c:set var="thumb1" value="${goodsVO.thumb1 }" />
        <c:set var="rdate" value="${goodsVO.rdate.substring(0, 16) }" />
        
        
        <tr style="height: 112px;" onclick="location.href='./read.do?goodsno=${goodsno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }'" class='hover'>
          <td style='vertical-align: middle; text-align: center;'>
              <c:choose>
                <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                  <%-- registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
                  <img src="/contents/storage/${thumb1 }" style="width: 130px; height: 90px;">
                </c:when>
                <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
                  <IMG src="/contents/images/none1.png" style="width: 130px; height: 90px;">
                </c:otherwise>
              </c:choose>
            </a>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?goodsno=${goodsno }&now_page=${param.now_page }&word=${param.word}">
              <div style='font-weight: bold;'>${gname }</div>
              <c:choose> 
                <c:when test="${content.length() > 160 }"> <%-- 160자 이상이면 160자만 출력 --%>
                    ${content.substring(0, 160)}.....
                </c:when>
                <c:when test="${content.length() <= 160 }">
                    ${content}
                </c:when>
              </c:choose>
              <br>
              <div style = 'font-size: 0.95em;' >${rdate }</div>
            </a>
          </td> 
          <c:choose>
            <c:when test="${sessionScope.admin_id != null }">
              <td style='vertical-align: middle; text-align: center;'>
                <A href="/contents/delete.do?itemno=${itemno }&goodsno=${goodsno}&now_page=${param.now_page == null? 1: param.now_page}" title="삭제"><IMG src="/contents/images/delete.png" class="icon"></A>
              </td>
            </c:when>
          </c:choose>
        </tr>
        
      </c:forEach>
    
    </tbody>
  </table>
    <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>