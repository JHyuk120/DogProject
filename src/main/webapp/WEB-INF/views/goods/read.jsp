<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="goodsno" value="${goodsVO.goodsno }" />
<c:set var="itemno" value="${goodsVO.itemno }" />
<c:set var="gname" value="${goodsVO.gname }" />    
<c:set var="price" value="${goodsVO.price }" />  
<c:set var="dc" value="${goodsVO.dc }" />
<c:set var="cnt" value="${goodsVO.cnt }"/>
<c:set var="origin" value="${goodsVO.origin }"/>
<c:set var="exdate" value="${goodsVO.exdate }"/>
<c:set var="storage" value="${goodsVO.storage }"/>
<c:set var="grams" value="${goodsVO.grams }"/>
<c:set var="saleprice" value="${goodsVO.saleprice}" /> 
<c:set var="point" value="${goodsVO.point }"/> 
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
<title>댕키트</title>
 <link rel="shortcut icon" href="/images/ee.png" /> <%-- /static 기준 --%>
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

  <%-- 로그인 기본값 --%>
  function loadDefault() {
        $('#id').val('user');
        $('#passwd').val('1234');
  } 

  <%-- 로그인 --%>
  function login_ajax() {
    var params = "";
    params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    // params += '&${ _csrf.parameterName }=${ _csrf.token }';
    // alert(params);
    // return;
    
    $.ajax(
          {
            url: '/member/login.do',
            type: 'post',  // get, post
            cache: false, // 응답 결과 임시 저장 취소
            async: true,  // true: 비동기 통신
            dataType: 'json', // 응답 형식: json, html, xml...
            data: params,      // 데이터
            success: function(rdata) { // 응답이 온경우
              var str = '';
              //alert('-> login cnt: ' + rdata.cnt);  // 1: 로그인 성공
              
              if (rdata.cnt == 1) {
                // 쇼핑카트에 insert 처리 Ajax 호출
                $('#div_login').hide(); // 로그인폼 감추기
               // alert('로그인 성공');
                $('#login_yn').val('Y');
                location.reload(); // 페이지 새로고침
                

                cart_ajax_post(); // 쇼핑카트에 상품 담기
                
              } else {
                alert('로그인에 실패했습니다.\n잠시후 다시 시도해주세요.');
                
              }
            },
            // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
            error: function(request, status, error) { // callback 함수
              console.log(error);
            }
          }
        );  //  $.ajax END

      }

    <%-- 쇼핑 카트에 상품 추가 --%>
    function cart_ajax(goodsno) {
/*       var f = $('#frm_login');
      $('#goodsno', f).val(goodsno);  // 쇼핑카트 등록시 사용할 상품 번호를 저장. */
      
      // console.log('-> goodsno: ' + $('#goodsno', f).val()); 
      
      if("${sessionScope.id}" == "" && $('#login_yn').val() != 'Y') {  // 로그인이 안되어 있다면
        $('#div_login').show();   // 로그인 폼 
      } else {  // 로그인 한 경우
       // alert('쇼핑카트에 insert 처리 Ajax 호출');
         cart_ajax_post(goodsno); // 쇼핑카트에 상품 담기
      }
  
    }

    <%-- 쇼핑카트 상품 등록 --%>
    function cart_ajax_post(goodsno) {
      //var f = $('#frm_order');
      //var cntc = $('#cntc', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
      let cntc = $('#cntc').val(); //form 태그를 무시하고 값을 추출, 페이지 안에서 같은 id가 사용되고 있지않은 경우 사용가능
      
      var params = "";
      // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
      params += 'goodsno=' + goodsno + '&cntc=' + cntc;
      // alert('-> cart_ajax_post: ' + params);
      // return;
      // 쇼핑카트 등록시 사용할 상품 번호.
      

      
      $.ajax(
        {
          url: '/cart/create.do',
          type: 'post',  // get, post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,     // 데이터
          success: function(rdata) { // 응답이 온경우
            var str = '';
            // console.log('-> cart_ajax_post cnt: ' + rdata.cnt);  // 1: 쇼핑카트 등록 성공
            
            if (rdata.cnt == 1) {
              var sw = confirm('선택한 상품이 장바구니에 담겼습니다.\n장바구니로 이동하시겠습니까?');
              if (sw == true) {
                // 쇼핑카트로 이동
                location.href='/cart/list_by_memberno.do';
              }           
            } else {
              alert('선택한 상품을 장바구니에 담지못했습니다.<br>잠시후 다시 시도해주세요.');
            }
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
          error: function(request, status, error) { // callback 함수
            console.log(error);
          }
        }
      );  //  $.ajax END

    }    
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
</script>  
 
<style>


  .content_body {
    width: 100%;
    max-width: 1200px;
    text-align: center;
  }

  .fieldset_basic {
    width: 100%;
    height: 100%;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
  

</style>
</head>  
 
 
<body style="background-color: #FEFCE6;">
<c:import url="/menu/top.do" />
 
<A href="./list_by_itemno.do?itemno=${itemno }" class='title_link'  style='background-color:#FEFCF0; margin-left: 15%; font-size: 25px;'>🥗${itemVO.item }🥗</A></DIV>

<DIV class='content_body' style='background-color:#FEFCF0;'>
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
      <A href="./delete.do?goodsno=${goodsno}&now_page=${param.now_page}&itemno=${itemno}">삭제</A> 
      <span class='menu_divide' >│</span> 
    </c:if>

    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_search_paging_cart.do?itemno=${itemno }&now_page=${param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${itemno }&now_page=${param.now_page}&word=${param.word }">갤러리형</A>
    
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_itemno.do'>
      <input type='hidden' name='itemno' value='${itemVO.itemno }'>  <%-- 게시판의 구분 --%>
      
   
    </form>
           <style>
          .btn-custom {
            background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
            color: white; /* 버튼 텍스트 색상 설정 (선택적) */
          }
          </style>
  </DIV>
  
    <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
  
  <DIV id='div_login' style='display: none;'>
    <div style='width: 30%; margin: 0px auto;'>
      <FORM name='frm_login' id='frm_login' method='POST'>
        <input type='hidden' name='goodsno' id='goodsno' value=''>
        <input type='hidden' name='login_yn' id='login_yn' value=''>
        
        <div class="form_input">
          <input type='text' class="form-control" name='id' id='id' 
                    value="${ck_id }" required="required" 
                    style='width: 100%;' placeholder="아이디" autofocus="autofocus">
          <Label>   
            <input type='checkbox' name='id_save' value='Y' ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>    
        </div>   
     
        <div class="form_input">
          <input type='password' class="form-control" name='passwd' id='passwd' 
                    value='${ck_passwd }' required="required" style='width: 100%;' placeholder="패스워드">
          <Label>
            <input type='checkbox' name='passwd_save' value='Y' ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>                    
        </div>   
      
      </FORM>
    </div>
   
    <div style='text-align: center; margin: 10px auto;'>
      <button type="button" id='btn_login' class="btn btn-info" onclick="login_ajax()">로그인</button>
      <button type='button' onclick="location.href='./create.do'" class="btn btn-info">회원가입</button>
      <button type='button' id='btn_loadDefault' class="btn btn-info" onclick="loadDefault()">테스트 계정</button>
      <button type='button' id='btn_cancel' class="btn btn-info" onclick="$('#div_login').hide();">취소</button>
    </div>
  
  </DIV>
  
    <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
  
  
  
  <DIV class='menu_line'></DIV>

    <fieldset class="fieldset_basic">
 
      <ul>
        <li class="li_none">
          <DIV style="width: 100%;">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <IMG src="/dogproject/storage/${file1saved }" style="width: 40%; height:380px; float:left; margin-top: 5%; margin-right: 20px; margin-bottom: 5px;'"> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <IMG src="/goods/images/ee.png" style="width: 40%; height:380px; float: left; margin-top: 5%; margin-right:5%;"> 
              </c:otherwise>
            </c:choose>
            <div style="text-align: left; margin-left: 50%; margin-bottom: 1%;">
            <span style="font-size: 1.5em; font-weight: bold;">🥗${gname }🥗</span><br> 
            <span style="color: #59D9B2; font-size: 1.2em; margin-right: 0.3em;">${dc}% 🠗 </span>
            <strong style="font-size: 1.2em; margin-right: 0.2em;"><fmt:formatNumber value="${saleprice}" pattern="#,###" />원</strong>   
             <del style= "color: #949494; font-size: 1em;" ><fmt:formatNumber value="${price}" pattern="#,###" />원</del>
            </div>
            
            
           
               
            
						<style>
						  .table {
						    width: 45%; /* 테이블 너비 */
						    margin: 0 auto; /* 가운데 정렬 */
						  }
						  
						  .table caption {
						    font-weight: bold; /* 표 제목 굵게 */
						    margin-bottom: 2px; /* 표 제목과 표 사이 여백 */
						  }
						  
						  .table td,
						  .table th {
						    color: #989993; /* 폰트 색상 변경 */
						    text-align: left; /* 텍스트 왼쪽 정렬 */
						    font-size: 0.9em; /* 폰트 크기 작게 설정 */
						  }
						  
						  .table td.bold,
						  .table th.bold {
						    font-weight: bold; /* 해당 셀에 폰트 굵게 적용 */
						    color: #7C7D78; 
						  }
						</style>
						
						<table class="table table-sm ">
						  <thead>
						    <tr>
						      <th>상세옵션</th>
						      <th>/ 상품 기본정보 입니다.</th>
						    </tr>
						  </thead>
						  <tbody>
						    <tr>
						      <td>원산지</td>
						      <td>${origin }</td>
						    </tr>
						    <tr>
						      <td>유통기한</td>
						      <td>${exdate }</td>
						    </tr>
						    <tr>
						      <td>보관방법</td>
						      <td>${storage } 보관</td>
						    </tr>
						    <tr>
						      <td>그램 수</td>
						      <td>${grams } g</td>
						    </tr>
                  <td>적립금</td>
                  <td>${point }원 (2%)</td>
                </tr>
						    <tr>
						      <td>배송비</td>
						      <td class="bold">3000원 (30,000원 이상 구매 시 무료)</td>
						    </tr>
						    <tr>
						      <td>남은 수량</td>
						      <td class="bold">${cnt }</td>
						    </tr>
						    <tr>
						      <td>수량 선택</td>
							    <td class="bold">
                    <input type="number" class="form-control" id="cntc" name="cntc" value="1" max="${cnt }" min="1" style='width:15%; height: 25px;'>

							    </td>
						    </tr>  
						                                      
						  </tbody>
						 
						  
						</table>
						<div style="text-align: left; margin-left: 50%; margin-top: 0.8%; ">
						  <span style="font-size: 0.8em;">ღ 주문 수량안내 : 최소 주문수량 1개 이상<br>
						  ღ 위 수량선택 박스를 선택하시면 아래에 상품이 추가됩니다.</span>
						</div>

          </DIV>
        </li>
        

      
     
<li class="li_none">
  <div style='margin-left: 570px; margin-top: 50px; display: flex;'>
    <form name="frm_order" id="frm_order" action="/wish/create.do" method="POST">
      <input type="hidden" name="goodsno" value="${goodsno}" />
      <input type="hidden" name="check" value="${check}" />
      
	    <button type='button' id='btn_cart' class="btn btn-outline-dark btn-lg" style='margin-right: 10px;' onclick="cart_ajax(${goodsno })">
	      <img src="/goods/images/cart.png" class="icon" style="width:22px; margin-bottom:3px;">
	    </button>

  
    <c:choose>
      <c:when test="${sessionScope.adminno != null}">
        <button type='button'onclick="favorite_ajax(${goodsno}) id='wish' class="btn btn-outline-dark btn-lg" style='margin-right: 10px;' >
      <img src="/goods/images/wish.png" class="icon" style="width:22px; margin-bottom:3px;"></button>
      </c:when>
      <c:when test="${sessionScope.memberno == null}">
        <button type='submit' id='wish' class="btn btn-outline-dark btn-lg" style='margin-right: 10px;' >
      <img src="/goods/images/wish.png" class="icon" style="width:22px; margin-bottom:3px;"></button>
      </c:when>
      <c:when test="${check == 1}">
        <button type='submit' id='wish' class="btn btn-outline-dark btn-lg" style='margin-right: 10px;' >
      <img src="/goods/images/pullhrt.png" class="icon" style="width:25px; margin-bottom:3px;"></button>
      </c:when>
      <c:otherwise>
        <button type='submit' id='wish' class="btn btn-outline-dark btn-lg" style='margin-right: 10px;' >
      <img src="/goods/images/wish.png" class="icon" style="width:22px; margin-bottom:3px;"></button>
      </c:otherwise>
    </c:choose>

     </form> 
    <button type='button' id='btn_ordering' class=" btn btn-dark btn-lg" style='width: 370px;' onclick="cart_ajax(${goodsno })">&emsp;BUY&emsp;</button>
    
  
  </div>
</li>


      </ul>
    </fieldset>
  </DIV>
  <%-- 댓글 조회 --%>
 <%--
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

    <textarea name='reviewcont' required="required" rows="6" cols="145"  style='background-color:#FEFCF0; table-layout: fixed;'></textarea>
    
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
                      <img src="/dogproject/images/${file2saved }" style= "width: 50%; margin: 1px;"> 
                    </c:when>
              
                    <c:otherwise> <!-- 기본 이미지 출력 -->
                      <img src="/goods/images/ee.png" style= "width: 50%; margin: 1px;">
                    </c:otherwise>
                  </c:choose>
                </div>
              </td> 
          
              <td  style='vertical-align: middle; text-align: center;'>
                <div >${reviewcont}</div>
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
      <DIV class='bottom_menu'>${paging }</DIV> 
      <!-- 페이지 목록 출력 부분 종료 -->
      <!-- 리뷰 조회 -->
       --%>
      <jsp:include page="../review/review_read.jsp"  flush='true'/>
      
      <jsp:include page="../menu/bottom.jsp" flush='false' />
    </body>
 
  </html>