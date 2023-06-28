<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>댕키트</title>

<!-- /static 기준 -->
<link rel="shortcut icon" href="/images/ee.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
</head>
<style>
.gallery_container_rc {
    display: flex;
    flex-wrap: wrap;
}
.gallery_item_rc {
    flex: 1 0 auto;
}

.carousel-item .col {
    margin-bottom: 20px; /* 일정한 간격을 설정합니다. */
}
.carousel-image {
    max-width: 100%;
    max-height: 140px;
    display: block;
    margin: 10px auto;
    text-align: center;
}

.image-container_rc {
    width: 100%;
    height: 140px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 18px;
    
}

</style>

<body style="background-color: #FEFCE6;">

<c:import url="/menu/top.do" />
   
<!-- 광고 캐러셀 효과 -->
      <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel" >
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
              <li data-target="#carouselExampleCaptions" data-slide-to="1"></li>
              <li data-target="#carouselExampleCaptions" data-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img src="/dogproject/images/b6.jpg" class="d-block w-100" alt="..."  >
                 <div class="carousel-caption d-none d-md-block"></div>
              </div>
              <div class="carousel-item">              
                    <IMG src="/dogproject/images/b4.jpg"  class="d-block w-100" >
                     <div class="carousel-caption d-none d-md-block"></div>
              </div>
              <div class="carousel-item">              
                    <IMG src="/dogproject/images/b5.jpg"   class="d-block w-100">     
              </div>
                                                 
            </div>
            <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="sr-only">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="sr-only">Next</span>
            </a>
          </div>

  <c:choose>
    <c:when test="${sessionScope.id != null}">  
     <!-- 로그인 시 추천시스템 그리드 형식 -->
 <%--          

    <br>
     <p style="font-size: 24px; font-weight: bold; color: #333; text-align: center; margin-bottom: 20px;">추천 레시피</p>
        <div style='width: 100%;'> 
             <c:forEach var="recommendVO" items="${list}" begin="0" end="9" varStatus="status">
              <c:set var="title" value="${recommendVO.title }" />
              <c:set var="thumb1" value="${recommendVO.thumb1 }" />                
              <div  onclick="" class='hover'
               style='width: 19%; height: 216px; float: left; margin: 0.5%; padding: 0.1%; background-color: #EEEFFF; text-align: left;'>
                
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
--%>
<div style="font-size: 24px; font-weight: bold; text-align: left; margin:20px;">${sessionScope.id}님 맞춤 추천 레시피</div>

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
                    <c:forEach var="recommendVO" items="${list}" begin="5" end="9" varStatus="status">
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
        <span class="carousel-control-prev-icon" style="fill: red;"aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>
<style>
    .carousel-control-next-icon {
        color: red;
    }
</style>
    </c:when>
    <c:otherwise>
 
    </c:otherwise>
  </c:choose>

<jsp:include page="./menu/bottom.jsp" flush='false' />
 
</body>
</html>