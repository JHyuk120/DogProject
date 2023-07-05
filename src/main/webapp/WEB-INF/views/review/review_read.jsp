<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="goodsno" value="${goodsVO.goodsno }" />
<c:set var="itemno" value="${goodsVO.itemno }" /> 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<link href="/css/style.css" rel="Stylesheet" type="text/css">

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>   
    

 <%-- 별점 로그인 스크립트 --%>
<script type="text/javascript">

  $(function() {
    // var contentsno = 0;
    // $('#btn_cart').on('click', function() { cart_ajax(contentsno)});
    // $('#btn_login').on('click', login_ajax);
    // $('#btn_loadDefault').on('click', loadDefault);
  });
 
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
<!--리뷰 등록시 별점 체크-->
function checkRatingValue() {
    var ratingValue = document.getElementById('star-rating').value;
    if (ratingValue == null || ratingValue == 0) {
        alert("별점을 선택하세요.");
        event.preventDefault();  // 폼 제출을 막음
        return false;  // 폼 제출을 막음
    } else {
        return true;  // 폼 제출을 허용
    }
}

<!-- 리뷰 갯수 -->
function reviewcnt(){
    
      var cnt = document.getElementById('reviewcnt').value;
   
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
<!--리뷰 더보기-->
$(document).ready(function(){

    $('.box').each(function(){
        var content = $(this).children('.content');
        var content_txt = content.text();
        var content_txt_short = content_txt.substring(0,80)+"...";
        var btn_more = $('<a href="javascript:void(0)" class="more" style="margin-left:70%">더보기</a>');

        
        $(this).append(btn_more);
        
        if(content_txt.length >= 100){
            content.html(content_txt_short)
            
        }else{
            btn_more.hide()
        }
        
        btn_more.click(toggle_content);

        function toggle_content(){
            if($(this).hasClass('short')){
                // 접기 상태
                $(this).html('더보기');
                content.html(content_txt_short)
                $(this).removeClass('short');
            }else{
                // 더보기 상태
                $(this).html('접기');
                content.html(content_txt);
                $(this).addClass('short');

            }
        }
    });
});
</script>  

</head>  
 
 
<body style="background-color: #FEFCE6;">
  <fieldset class="fieldset_basic">
    <FORM name='frm' method='POST' action='../review/create.do' enctype="multipart/form-data"  enctype='multipart/form-data' onsubmit="return checkLoginStatus();" >
      <input type="hidden" name="goodsno" value="${goodsno}"/><!-- 현재 recipe의 recipeno -->   
      <input type="hidden" name="memberno" value="${sessionScope.memberno}"/>
      <input type="hidden" name="id" value="${sessionScope.id}"/>
      <input type="hidden" id="star-rating" name="ratingValue" value=""/>
    
      <!-- <input type="hidden" name="ratingValue" value="${reiviewVO.ratingValue}"/> -->
      <!-- 댓글 평점 별  -->

        <div style='width: 70%; max-width: 70%; margin:0 auto; display: flex; align-items: center; font-size:20px; margin-bottom: 0.2%;'>
        <img src="/review/images/reviewst.png" class="icon3" >리뷰 작성 


        <div style='margin-left: 1%; color: #8E9187;'>리뷰수 ${reviewcnt}</div>
        <div style='margin-left: 1%; color: #8E9187;'>평점 ${ratingAVG}</div>
        <div style='width: 70%; max-width: 70%; margin:0 auto; '>
        <div style="display: flex; align-items: center; font-size:20px;"> 

     </div>  </div></div>
     
      <div class="stars" style="margin-right: 53%; margin-bottom: 0.5%;">
        <img src="/menu/images/pcircle.svg">
        <td width="100" rowspan="2">${sessionScope.id} : </td>
        <span class="star" id="star_1" onclick="setStarRating(1)" style="opacity: 0.2;">⭐</span>
        <span class="star" id="star_2" onclick="setStarRating(2)" style="opacity: 0.2;">⭐</span>
        <span class="star" id="star_3" onclick="setStarRating(3)" style="opacity: 0.2;">⭐</span>
        <span class="star" id="star_4" onclick="setStarRating(4)" style="opacity: 0.2;">⭐</span>
        <span class="star" id="star_5" onclick="setStarRating(5)" style="opacity: 0.2;">⭐</span>
        <div id="rating-display" style="display: inline; color: #838580;">(0) </div>
        <input type="hidden" id="star-rating" value="0" />
      </div>
      
      <script>
        function setStarRating(rating) {
            var stars = document.getElementsByClassName('star');
            var ratingDisplay = document.getElementById('rating-display');
            var starRatingInput = document.getElementById('star-rating');
            for (var i = 0; i < stars.length; i++) {
              if (i < rating) {
                stars[i].style.opacity = '1';
              } else {
                stars[i].style.opacity = '0.2';
              }
            }
            ratingDisplay.textContent = '(' + rating + ')';
            starRatingInput.value = rating;
          }

          // 초기 값 설정
          window.addEventListener('DOMContentLoaded', function() {
            setStarRating(5); // 초기 값으로 5 설정
          });
      </script>

    <textarea name='reviewcont' required="required" rows="6" cols="145"  style='background-color:#FEFCF0; width: 70%;'></textarea>
    
    <div style="display: flex; align-items: center; table-layout: fixed; margin-left: 60%;">
  <input type="file" name="file2MF" id="file2MF" value="" placeholder="첨부파일" >
  <button id="submitBtn" type="submit" class="btn btn-outline-dark btn-sm" style="table-layout: fixed;">리뷰 등록</button>
</div>

</td>
      </tr>
  
      <script>
        document.getElementById('submitBtn').addEventListener('click', checkRatingValue);
      </script>
    </FORM>
  </fieldset>
   
 
  <!-- 댓글 목록 -->
    <table class="table table-striped " style='width: 70%; table-layout: fixed; margin-left: 16.5%; background-color: #FEFCF0; '>
      <colgroup>
        <c:choose>
          <c:when test="${sessionScope.admin_id != null}">
            <col style="width: 10%;">
            <col style="width: 10%;">
            <col style="width: 30%;">
            <col style="width: 30%;">
            <col style="width: 10%;">
            <col style="width: 10%;">
          </c:when>
        </c:choose>
      </colgroup>
      <thead>
        <tr>
          <th style='text-align: center; width: 10%;'>id</th>
          <th style='text-align: center; width: 10%;'>평점</th>
          <th style='text-align: center; width: 20%;'>이미지</th>
          <th style='text-align: center; width: 40%;'>리뷰</th>
          <th style='text-align: center; width: 10%;'>작성일</th>
          <th style='text-align: center; width: 10%;'>수정/삭제</th>
        </tr>
        <tbody>
          <c:forEach var="reviewVO" items="${list}">
            <c:set var="ratingValue" value=" ${reviewVO.ratingValue}" />
            <c:set var="reviewcont" value="${reviewVO.reviewcont}" />
            <c:set var="rdate" value="${reviewVO.rdate}" />
            <c:set var="ratingAvg" value="${reviewVO.ratingAvg}" />
            <c:set var="mid" value="${memberVO.id}" />
            <c:set var="file2" value="${reviewVO.file2 }" />
            <c:set var="file2saved" value="${reviewVO.file2saved }" />
            <c:set var="thumb2" value="${reviewVO.thumb2 }" />
         
            <tr style="height: 112px;"  class='hover'>
          
              <td style='vertical-align: middle; text-align: center;'>
                <div> ${reviewVO.mid }</div>
              </td>  
          
              <td style='vertical-align: middle; '>
                <!-- <div>${ratingValue }</div>  -->
                <!-- 별점 이미지  -->
                <div> 
                  <c:choose>
                    <c:when test="${ratingValue.toString() == ' 5'}"><center>
                      <img src="/review/images/star_5.png" style="width: 100px; text-align: center;"></center>
                    </c:when>
                    <c:when test="${ratingValue.toString() == ' 4' }"><center>
                      <img src="/review/images/star_4.png" style="width: 100px; text-align: center;"></center>
                    </c:when>
                    <c:when test="${ratingValue.toString() == ' 3'}"><center>
                      <img src="/review/images/star_3.png" style="width: 100px; text-align: center;"></center>
                    </c:when>
                    <c:when test="${ratingValue.toString() == ' 2'}"><center>
                      <img src="/review/images/star_2.png" style="width: 100px; text-align: center;"></center>
                    </c:when>
                    <c:when test="${ratingValue.toString() == ' 1'}"><center>
                      <img src="/review/images/star_1.png" style="width: 100px; text-align: center;"></center>
                    </c:when>
                    <c:otherwise> <!-- 기본 이미지 출력 -->
                      <img src="/review/images/star_0.png" style="width: 100px; text-align: center;"> 
                    </c:otherwise>
                  </c:choose>
                </div>
              </td>
          
              <td style='vertical-align: middle; text-align: center; '>
                <div>
                  <c:choose>
                    <c:when test="${thumb2.endsWith('jpg') || thumb2.endsWith('png') || thumb2.endsWith('gif')}">
                      <%-- /static/contents/storage/ --%>
                      <img src="/dogproject/review/storage/${thumb1 }" style= "width: 50%; margin: 1px;"> 
                    </c:when>
              
                    <c:otherwise> <!-- 기본 이미지 출력 -->
                      <img src="/goods/images/ee.png" style= "width: 50%; margin: 1px;">
                    </c:otherwise>
                  </c:choose>
                </div>
              </td> 
          
              <td style='vertical-align: middle; ' class="box">
                <div class="content">
                  ${reviewcont}</div>
              </td> 
          
              <td style='vertical-align: middle; text-align: center;'>
                <div>${rdate}</div>
              </td>
          
              <td style='vertical-align: middle; text-align: center; '>
                <div>

                        <a href="/review/update.do?goodsno=${goodsno}&reviewno=${reviewVO.reviewno}">수정</a>/
                        <a href="/review/delete.do?goodsno=${goodsno}&reviewno=${reviewVO.reviewno}" onclick="return confirm('리뷰를 삭제하시겠습니까?')">삭제</a>

                </div>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
   <!-- 작성된 리뷰 없을 시  -->
   <c:choose>
     <c:when test="${reviewcnt == 0 }">
        <tr style="height: 112px;" class='hover'>
           <td style='vertical-align: middle; text-align: center;' colspan='6'>
               <div class="empty-review-message">
                   <p>작성된 리뷰가 없습니다.</p>
               </div>
           </td>
        </tr>
        <style>
           .empty-review-message {        
               padding: 20px;
               text-align: center;
           }
           
           .empty-review-message p {
               color: #888;
               font-size: 18px;
               font-weight: bold;
               margin: 0;
           }
        </style>
   </c:when>
   </c:choose>
      <!-- 페이지 목록 출력 부분 시작 -->
      <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
      <!-- 페이지 목록 출력 부분 종료 -->

    </body>
 
  </html>