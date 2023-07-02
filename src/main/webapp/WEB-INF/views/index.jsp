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
                <img src="/dogproject/images/ccc.png" class="d-block w-100" alt="..."  >
                 <div class="carousel-caption d-none d-md-block"></div>
              </div>
              <div class="carousel-item">              
                    <IMG src="/dogproject/images/My project5.png"  class="d-block w-100" >
                     <div class="carousel-caption d-none d-md-block"></div>
              </div>
              <div class="carousel-item">              
                    <IMG src="/dogproject/images/d8.png"   class="d-block w-100">     
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

    
<c:import url="/main/main.do" />
<jsp:include page="./menu/bottom.jsp" flush='false' />
 
</body>
</html>