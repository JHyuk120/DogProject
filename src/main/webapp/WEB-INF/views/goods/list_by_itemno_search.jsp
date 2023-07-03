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
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>
  ${itemVO.name }
  <c:if test= "${param.word.length() > 0 }">
    > 「${param.word }」 검색 ${list.size() }건
    </c:if>
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
      <col style="width: 10%;"></col>
      <col style="width: 80%;"></col>
      <col style="width: 10%;"></col>
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
        
        <tr style="height: 112px;" onclick="location.href='./read.do?goodsno=${goodsno }&word=${param.word }' " class='hover'>
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
            <a href="./read.do?goodsno=${goodsno }&word=${param.word}">
              <div style='font-weight: bold;'>${title }</div>
              <c:choose> 
                <c:when test="${content.length() > 160 }"> <%-- 160자 이상이면 160자만 출력 --%>
                    ${content.substring(0, 160)}.....
                </c:when>
                <c:when test="${content.length() <= 160 }">
                    ${content}
                </c:when>
              </c:choose>
            </a>
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
            <A href="/contents/map.do?itemno=${itemno }&goodsno=${goodsno}" title="지도"><IMG src="/contents/images/map.png" class="icon"></A>
            <A href="/contents/youtube.do?itemno=${itemno }&goodsno=${goodsno}" title="Youtube"><IMG src="/contents/images/youtube.png" class="icon"></A>
          </td>
        </tr>
        
      </c:forEach>

    </tbody>
  </table>
</DIV>

 </body>
<jsp:include page="../menu/bottom.jsp" />

 
</html>