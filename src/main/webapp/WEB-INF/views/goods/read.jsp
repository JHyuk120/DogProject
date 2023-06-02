<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="goodsno" value="${goodsVO.goodsno }" />
<c:set var="itemno" value="${goodsVO.itemno }" />
<c:set var="gname" value="${goodsVO.gname }" />    
<c:set var="price" value="${goodsVO.price }" />    
<c:set var="file1" value="${goodsVO.file1 }" />
<c:set var="file1saved" value="${goodsVO.file1saved }" />
<c:set var="thumb1" value="${goodsVO.thumb1 }" />
<c:set var="content" value="${goodsVO.content }" />
<c:set var="word" value="${goodsVO.word }" />
<c:set var="size1_label" value="${goodsVO.size1_label }" />
<c:set var="rdate" value="${goodsVO.rdate.substring(0, 16) }" />



 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Dog#</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
 <%-- 별점 스크립트 --%>
<script type="text/javascript">
function setStarRating(ratingValue) {

    const starIds = ["star_1", "star_2", "star_3", "star_4", "star_5"];
    for (let i = 0; i < starIds.length; i++) {
        let starElement = document.getElementById(starIds[i]);

        // 정수 부분만 처리하고 소수 부분은 제외
        let intPart = Math.floor(ratingValue);

        // 별의 색을 설정: 전체 별, 빈 별
        if (i < intPart) {
            starElement.style.color = "orange";
        } else {
            starElement.style.color = "lightgray";
        }
    }

    document.getElementById('star-rating').value = ratingValue;

    // rating-display의 내용을 ratingValue로 업데이트
    document.getElementById('rating-display').textContent = "("+ratingValue+")";
}
<!--댓글 등록시 로그인 여부 확인 -->
    function checkLoginStatus() {
        var isLoggedIn = ${sessionScope.id != null}; // 로그인 상태 확인
        if (!isLoggedIn) {
            // 로그인하지 않은 상태이므로 폼 제출을 방지하고 로그인 알림을 표시
            alert('로그인이 필요합니다.');
            window.location.href = "../member/login.do";
            return false; // 폼 제출 중단
        }
        return true; // 폼 제출 진행
    }

</script>
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'><A href="./list_by_itemno.do?itemno=${itemno }" class='title_link'>${itemVO.item }</A></DIV>

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
      <A href="./update_text.do?goodsno=${goodsno}&now_page=${param.now_page}&word=${param.word}">글 수정</A>
      <span class='menu_divide' >│</span>
      <A href="./update_file.do?goodsno=${goodsno}&now_page=${param.now_page}">파일 수정</A>  
      <span class='menu_divide' >│</span>
      <A href="./map.do?itemno=${itemno }&goodsno=${goodsno}">지도</A>   <!-- 카테고리 그룹: itemno -->
      <span class='menu_divide' >│</span>
      <A href="./youtube.do?itemno=${itemno }&goodsno=${goodsno}">YouTube</A>   <!-- 카테고리 그룹: itemno -->
      <span class='menu_divide' >│</span>
      <A href="./delete.do?goodsno=${goodsno}&now_page=${param.now_page}&itemno=${itemno}">삭제</A> 
      <span class='menu_divide' >│</span> 
    </c:if>

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno.do?itemno=${itemno }&now_page=${param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${itemno }&now_page=${param.now_page}&word=${param.word }">갤러리형</A>
    
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_itemno.do'>
      <input type='hidden' name='itemno' value='${itemVO.itemno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word}' class='input_word'>
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

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width: 100%;">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <IMG src="/dogproject/storage/${file1saved }" style="width: 50%; float: left; margin-top: 0.5%; margin_right: 1%;"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/dogproject/images/none1.png" style="width: 50%; float: left; margin-top: 0.5%; margin_right: 1%;"> 
              </c:otherwise>
            </c:choose>
       
          <span style="font-size: 1.5em; font-weight: bold;">${gname }</span><br> 
          <div>가격: ${price }\</div><br>     
          <div style="font-size: 1em;">${mname } ${rdate }</div><br>     
          ${content }
        </DIV>
      </li>
      
     
      <li class="li_none">
        <DIV style='text-decoration: none;'>
        <br>
          검색어(키워드): ${word }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">  <%-- ServletRegister.java: registrationBean.addUrlMappings("/download");  --%>
            첨부 파일: <A href='/download?dir=/dogproject/goods/storage&filename=${file1saved}&downname=${file1}'>${file1}</A> (${size1_label})  
          </c:if>
        </DIV>
        <a href = '/' class="btn btn-primary btn-sm">장바구니 넣기</a>
        <a href = '/' class="btn btn-primary btn-sm">바로구매</a>
      </li>   
    </ul>
  </fieldset>

</DIV>
 <%-- 댓글 조회 --%>

 <FORM name='frm' method='POST' action='../review/create.do' enctype="multipart/form-data"  onsubmit="return checkLoginStatus();">
    <input type="hidden" name="goodsno" value="${goodsno}"/><!-- 현재 recipe의 recipeno -->
    
    <input type="hidden" name="memberno" value="${sessionScope.memberno}"/>
    <input type="hidden" name="id" value="${sessionScope.id}"/>
    <input type="hidden" id="star-rating" name="ratingValue" value=""/>
    

    <!-- <input type="hidden" name="ratingValue" value="${reiviewVO.ratingValue}"/> -->
 <!-- 댓글 평점 별  -->
    <tr>
        <div class="stars">
         <td width="100" rowspan="2">${sessionScope.id } </td>
      <span class="star" id="star_1" onclick="setStarRating(1)">&#9733;</span>
       <span class="star" id="star_2" onclick="setStarRating(2)">&#9733;</span>
      <span class="star" id="star_3" onclick="setStarRating(3)">&#9733;</span>
      <span class="star" id="star_4" onclick="setStarRating(4)">&#9733;</span>
      <span class="star" id="star_5" onclick="setStarRating(5)">&#9733;</span>
      <input type="hidden" id="star-rating" value="0"/>
       <td width="100" rowspan="2" id="star-output"> </td>
    </div>
    <td>
           <div id="rating-display" >(0)</div>
           <div>평점: ${ratingAVG } </div>
           
    <textarea name='reviewcont' required="required" rows="7" cols="63"></textarea>
    </td>
  </tr>
   <button type='submit' class='btn btn-info btn-sm'>리뷰 등록</button>
 </FORM>    
 
 <!-- 댓글 목록 -->
   <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <c:choose>
          <c:when test="${sessionScope.admin_id != null}">
              <col style="width: 10%;"></col>
              <col style="width: 10%;"></col>
              <col style="width: 60%;"></col>
              <col style="width: 10%;"></col>
              <col style="width: 10%;"></col>
          </c:when>

      </c:choose>

    </colgroup>

    <thead>
      <tr>
        <th style='text-align: center;'>id</th>
        <th style='text-align: center;'>평점</th>
        <th style='text-align: center;'>리뷰</th>
        <th style='text-align: center;'>작성일</th>
        <th style='text-align: center;'>수정/삭제</th>
      </tr>
     <tbody>
      <c:forEach var="reviewVO" items="${list}">
        <c:set var="ratingValue" value=" ${reviewVO.ratingValue}" />
        <c:set var="reviewcont" value="${reviewVO.reviewcont}" />
        <c:set var="rdate" value="${reviewVO.rdate}" />
        <c:set var="ratingAvg" value="${reviewVO.ratingAvg}" />
         <c:set var="mid" value="${memberVO.id}" />
         
        <tr style="height: 112px;"  class='hover'>
          
          <td style='vertical-align: middle; text-align: center;'>
           <div> ${reviewVO.mid }</div>
          </td>  
          
          <td style='vertical-align: middle;'>
            <!-- <div>${ratingValue }</div>  -->
            <!-- 별점 이미지  -->
            <div> 
                <c:choose>
                  <c:when test="${ratingValue.toString() == ' 5'}">
                    <img src="/review/images/star_5.png" style="width: 100px">
                  </c:when>
                  <c:when test="${ratingValue.toString() == ' 4' }">
                     <img src="/review/images/star_4.jpg" style="width: 100px">
                  </c:when>
                  <c:when test="${ratingValue.toString() == ' 3'}">
                    <img src="/review/images/star_3.jpg" style="width: 100px">
                  </c:when>
                  <c:when test="${ratingValue.toString() == ' 2'}">
                    <img src="/review/images/star_2.png" style="width: 100px">
                  </c:when>
                  <c:when test="${ratingValue.toString() == ' 1'}">
                    <img src="/review/images/star_1.png" style="width: 100px">
                  </c:when>
                   <c:otherwise> <!-- 기본 이미지 출력 -->
                <img src="/review/images/star_0.png"> 
              </c:otherwise>
                </c:choose>
                
            </div>
          </td>
          
          <td style='vertical-align: middle;'>
            <div>${reviewcont}</div>
          </td> 
          
          <td style='vertical-align: middle;'>
            <div>${rdate}</div>
          </td>
          <td style='vertical-align: middle;'>
            <div><a href="/review/update.do?goodsno=${goodsno}&reviewno=${reviewVO.reviewno}">수정</a>/<a href="/reply/delete.do?goodsno=${goodsno }&reviewno=${reviewVO.reviewno}" onclick="return confirm('리뷰를 삭제하시겠습니까?')">삭제</a></div>
          </td>
          

        </tr>
      </c:forEach>

    </tbody>
  </table>
    <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>