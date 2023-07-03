<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" />  

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

<body style="background-color: #FEFCE6;">
<div style='' class="content_body">
<c:choose>
<c:when test="${sessionScope.id != null }">  

<div style="font-size: 24px; font-weight: bold; text-align: center; margin:20px; color: #9A9C92;">${mname}(${sessionScope.id})님 맞춤 추천 레시피</div>

  <!-- 추천시스템 캐러셀 효과 -->      
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <div class="container">
                <div class="row">
<c:forEach var="recommendVO" items="${list}" begin="0" end="4" varStatus="status">
                        <a href="http://localhost:9093/recipe/read.do?recipeno=${recipeVO.recipeno }&word=&now_page=1">
                            <div class="col" style="text-align: center; display: flex; flex-direction: column; align-items: center;">
                                <div class="image-container_rc">
                                    <c:choose>
                                        <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                                            <img src="/recipe/storage/${thumb1 }" class="carousel-image">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="/images/ee.png" class="carousel-image">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div style="margin: 20px;">
                                    <strong style="display: block; width: 150px; height: 60px; overflow: hidden; text-overflow: ellipsis;">
                                        <c:choose>
                                            <c:when test="${recommendVO.title.length() > 20}">
                                                ${recommendVO.title.substring(0, 20)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${recommendVO.title}
                                            </c:otherwise>
                                        </c:choose>
                                    </strong>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="carousel-item">
            <div class="container">
                <div class="row">
                    <c:forEach var="recommendVO" items="${rlist}" begin="5" end="9" varStatus="status">
                        <div class="col" style="text-align: center; display: flex; flex-direction: column; align-items: center;">
                            <div class="image-container_rc">
                                <c:choose>
                                    <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                                        <img src="/recipe/storage/${thumb1 }" class="carousel-image">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="/images/ee.png" class="carousel-image">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div style="margin: 20px;">
                                <strong style="display: block; width: 150px; height: 60px; overflow: hidden; text-overflow: ellipsis;">
                                    <c:choose>
                                        <c:when test="${recommendVO.title.length() > 20}">
                                            ${recommendVO.title.substring(0, 20)}...
                                        </c:when>
                                        <c:otherwise>
                                            ${recommendVO.title}
                                        </c:otherwise>
                                    </c:choose>
                                </strong>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    
    <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
        <span aria-hidden="true" style="margin-bottom: 10%; margin-right: 80%"><img alt="" src="/main/pre.png" style="width:100%"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next" >
        <span  aria-hidden="true" style="margin-bottom: 10%; margin-left: 80% " ><img alt="" src="/main/next.png" style="width:100%"></span>
        <span class="sr-only">Next</span>
    </a>
 
</div>
    </c:when>

    
    <c:otherwise>
 
    </c:otherwise>
  </c:choose>

<!-- 인기순 레시피 그리드 형식 -->
<p  style="font-size: 24px; font-weight: bold; text-align: center; margin:20px; color: #9A9C92;">좋아요 많이받은 레시피 TOP5</p>
  <div style="width: 90%; margin-left:5%">

        <div style='width: 100%; text-align: center; display: flex; flex-wrap: wrap; justify-content: space-between;'>
             <c:forEach var="recipeVO" items="${recom_list}"  varStatus="status">
              <c:set var="title" value="${recipeVO.title }" />
              <c:set var="thumb1" value="${recipeVO.thumb1 }" />                
              <div  onclick="location.href='/recipe/read.do?recipeno=${recipeVO.recipeno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }'" class='hover' 
               style='width: 15%; height: 216px; float: left; margin: 0.3%; padding: 0.5%;  text-align: center; '>
                
                <c:choose> 
                  <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> 
                    <img src="/storage/${thumb1 }" style="width: 100%; height: 140px;">
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


 <!-- 판매순 레시피 그리드 형식 -->
<p  style="font-size: 24px; font-weight: bold; text-align: center; margin:20px; color: #9A9C92;"> 최신 레시피</p>
  <div style="width: 90%; margin-left: 5%;">
        <div style='width: 100%; text-align: center; display: flex; flex-wrap: wrap; justify-content: space-between;'>
             <c:forEach var="recipeVO" items="${new_list}" begin="0" end="4" varStatus="status">
              <c:set var="title" value="${recipeVO.title }" />
              <c:set var="thumb1" value="${recipeVO.thumb1 }" />                
              <div  onclick="location.href='/recipe/read.do?recipeno=${recipeVO.recipeno }&word=${param.word }&now_page=${param.now_page == null ? 1 : param.now_page }'" class='hover' 
               style='width: 15%; height: 216px; float: left; margin: 0.3%; padding: 0.5%;  text-align: center; '>
                <c:choose> 
                  <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> 
                    <img src="/storage/${thumb1 }" style="width: 100%; height: 140px;">
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
</div>
</body>
</html>