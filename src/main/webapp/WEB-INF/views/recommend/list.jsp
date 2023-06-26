<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 

<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

</head>
<body>
<p>테스트</p>
  <TABLE class='table table-hover'>
    <colgroup>
      <col >

    </colgroup>
   
    <thead>  
    <TR>
      <TH class="th_bs">순서</TH>
    </TR>
    </thead>
    <c:forEach var="recommendVO" items="${list}">
        <c:set var="itemno" value="${recommendVO.itemno}" />
        <c:set var="memberno" value="${recommendVO.memberno}" />
        <c:set var="thumb1" value="${recommendVO.thumb1}" /> 
        <tr style="height: 112px;" class='hover'>
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> 
                <IMG src="/recipe/storage/${thumb1}" style="width: 130px; height: 90px;">
              </c:when>
              <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: static/contents/images/none1.png  -->
                <IMG src="/images/dog1.png" style="width: 130px; height: 90px;">
              </c:otherwise>
            </c:choose>
          </td>  
        </tr>
      </c:forEach>

  <div style='width: 100%;'> <%-- 갤러리 Layout 시작 --%>
    <c:forEach var="recommendVO" items="${list }" varStatus="status">
      <c:set var="title" value="${recommendVO.title }" />
      <c:set var="thumb1" value="${recommendVO.thumb1 }" />

        
      <%-- 하나의 행에 이미지를 5개씩 출력후 행 변경, index는 0부터 시작 --%>
      <c:if test="${status.index % 5 == 0 && status.index != 0 }"> 
        <HR class='menu_line'> <%-- 줄바꿈 --%>
      </c:if>
        
      <!-- 4기준 하나의 이미지, 24 * 4 = 96% -->
      <!-- 5기준 하나의 이미지, 19.2 * 5 = 96% -->
      <div  onclick="location.href='./read.do?contentsno=${contentsno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }'" class='hover'
       style='width: 19%; height: 216px; float: left; margin: 0.5%; padding: 0.1%; background-color: #EEEFFF; text-align: left;'>
        
        <c:choose> 
          <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
            <%-- registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
            <img src="/contents/storage/${thumb1 }" style="width: 100%; height: 140px;">
          </c:when>
          <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
            <IMG src="/contents/images/none2.png" style="width: 100%; height: 140px;">
          </c:otherwise>
        </c:choose>
        <strong>
            <c:choose>
              <c:when test="${title.length() > 20 }">
                  ${title.substring(0, 20)}.....
              </c:when>
              <c:when test="${title.length() <= 20 }">
                  ${title}
              </c:when>
            </c:choose>
        </strong>
            <br>
            <div style='font-size: 0.9em;word-break: break-all;' >
             <c:choose>
              <c:when test="${content.length() > 50 }">
                  ${content.substring(0,50)}.....
              </c:when>
              <c:when test="${content.length() <= 50 }">
                  ${content}
              </c:when>
            </c:choose>
            </div>
      </div>
      
    </c:forEach>
  </div>


</body>
</html>
