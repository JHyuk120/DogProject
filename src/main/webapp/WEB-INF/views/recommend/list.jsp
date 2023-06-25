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


</body>
</html>
