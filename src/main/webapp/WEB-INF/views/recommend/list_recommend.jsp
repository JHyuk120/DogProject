<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dev.mvc.recommend.RecommendVO" %>

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
<body style="background-color: #FEFCE6;">
<c:import url="/menu/top.do" />

<p>추천 레시피</p>
<%--
         <tbody>
        <%
          ArrayList<RecommendVO> list = (ArrayList<RecommendVO>) request.getAttribute("list");
          if (list != null) {
            for (int i=0; i < list.size(); i++) {
                RecommendVO recommendVO = list.get(i);
              String thumb1 = recommendVO.getThumb1();
        %>
        
        <tr style="height: 112px;" class="hover">
          <td style="vertical-align: middle; text-align: center;">
            <% if (thumb1.endsWith("jpg") || thumb1.endsWith("png") || thumb1.endsWith("gif")) { %>
              <img src="/dogproject/images/storage/<%= thumb1 %>" style="width: 130px; height: 90px;">
            <% } else { %>
              <img src="/images/ee.png" style="width: 130px; height: 90px;">
            <% } %>
          </td>
        </tr>
        
        <%
            }
          }else{
              %><p>NULL NULL NULL NULL NULL NULL NULL NULL NULL NULL NULL NULL NULL NULL </p><%
          }
        %>
        </tbody>
 --%>
         <!-- 캐러셀 효과 배너 넣기 -->
      <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel"  style="width: 300px; height: 200px;">
            <ol class="carousel-indicators">
              <li data-target="#carouselExampleCaptions" data-slide-to="0" class="active"></li>
              <c:forEach var="recommendVO" items="${list}" varStatus="status">
              <li data-target="#carouselExampleCaptions" data-slide-to="${status.index + 1}"></li>
             </c:forEach>
            </ol>
            <div class="carousel-inner">
              <div class="carousel-item active">
                <img src="/dogproject/images/b1.jfif" class="d-block w-100" alt="..."  style="width: 260px; height: 180px;">
              </div>
              <c:forEach var="recommendVO" items="${list}" varStatus="status">
              <c:set var="thumb1" value="${recommendVO.thumb1}" /> 
              <div class="carousel-item">
                    <c:choose>
                      <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> 
                        <center><IMG src="/recipe/storage/${thumb1}"  style="width: 260px; height: 180px;"></center>
                      </c:when>
                      <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: static/contents/images/none1.png  -->
                        <center><IMG src="/images/dog1.png" style="width: 260px; height: 180px;"></center>
                      </c:otherwise>
                    </c:choose>
                <div class="carousel-caption d-none d-md-block">
                <p> ${recommendVO.title } </p>
                </div>
              </div>
              </c:forEach>
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
   

 
  <DIV style='width: 94.8%; margin: 0px auto;'>
  </DIV>  
<jsp:include page="../menu/bottom.jsp" flush='false' />
 
</body>
</html>

