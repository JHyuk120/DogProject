<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />  
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
</head>

<body style="background-color: #FEFCE6;">

<!-- 인기순 레시피 그리드 형식 -->
<div style="width: 90%; text-align: center;">
     <p  style="font-size: 24px; font-weight: bold; text-align: left; margin:20px;">좋아요 많이받은 레시피 TOP5</p>
        <div style='width: 100%; text-align: center; display: flex; flex-wrap: wrap; justify-content: space-between;'>
             <c:forEach var="recipeVO" items="${recom_list}"  varStatus="status">
              <c:set var="title" value="${recipeVO.title }" />
              <c:set var="thumb1" value="${recipeVO.thumb1 }" />                
              <div  onclick="location.href='/recipe/read.do?recipeno=${recipeVO.recipeno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }'" class='hover'
               style='width: 19%; height: 216px; float: left; margin: 0.5%; padding: 0.1%;  text-align: center; '>
                
                <c:choose> 
                  <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> 
                    <img src="/recipe/storage/${thumb1 }" style="width: 100%; height: 140px;">
                  </c:when>
                  <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
                    <IMG src="/images/ee.png" style="width: 100%; height: 140px;">
                  </c:otherwise>
                </c:choose>
                <strong >
                    <c:choose>
                      <c:when test="${title.length() > 20 }">
                          ${title.substring(0, 20)}.....
                      </c:when>
                      <c:when test="${title.length() <= 20 }">
                          ${title}
                      </c:when>
                    </c:choose>
                </strong>
              </div>           
            </c:forEach>
        </div>
</div>     
<br>  
 <!-- 판매순 레시피 그리드 형식 -->
<div style="width: 90%; text-align: center;">
     <p  style="font-size: 24px; font-weight: bold; text-align: left; margin:20px;"> 최신 레시피</p>
        <div style='width: 100%; text-align: center; display: flex; flex-wrap: wrap; justify-content: space-between;'>
             <c:forEach var="recipeVO" items="${new_list}" begin="0" end="4" varStatus="status">
              <c:set var="title" value="${recipeVO.title }" />
              <c:set var="thumb1" value="${recipeVO.thumb1 }" />                
              <div  onclick="location.href='/recipe/read.do?recipeno=${recipeVO.recipeno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }'" class='hover'
               style='width: 19%; height: 216px; float: left; margin: 0.5%; padding: 0.1%; text-align: center;'>
                <c:choose> 
                  <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> 
                    <img src="/recipe/storage/${thumb1 }" style="width: 100%; height: 140px;">
                  </c:when>
                  <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
                    <IMG src="/images/ee.png" style="width: 100%; height: 140px;">
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
              </div>           
            </c:forEach>
        </div>
</div>
</body>
</html>