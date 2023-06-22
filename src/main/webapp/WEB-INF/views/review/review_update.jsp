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

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>   
    
<<<<<<< HEAD
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
    
=======
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
      var f = $('#frm_login');
      $('#goodsno', f).val(goodsno);  // 쇼핑카트 등록시 사용할 상품 번호를 저장.
      
      // console.log('-> goodsno: ' + $('#goodsno', f).val()); 
      
      if("${sessionScope.id}" == "" && $('#login_yn').val() != 'Y') {  // 로그인이 안되어 있다면
        $('#div_login').show();   // 로그인 폼 
      } else {  // 로그인 한 경우
       // alert('쇼핑카트에 insert 처리 Ajax 호출');
         cart_ajax_post(); // 쇼핑카트에 상품 담기
      }
  
    }

    <%-- 쇼핑카트 상품 등록 --%>
    function cart_ajax_post() {
      var f = $('#frm_login');
      var goodsno = $('#goodsno', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
      
      var params = "";
      // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
      params += 'goodsno=' + goodsno;
      // alert('-> cart_ajax_post: ' + params);
      // return;
      
      $.ajax(
        {
          url: '/cart/create.do',
          type: 'post',  // get, post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
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


    <!--댓글 등록시 로그인 여부 확인 -->
    function checkLoginStatus() {
        var isLoggedIn = ${sessionScope.id != null}; // 로그인 상태 확인
        if (!isLoggedIn) {
            // 로그인하지 않은 상태이므로 폼 제출을 방지하고 로그인 알림을 표시
            alert('로그인이 필요합니다.');
            return false; // 폼 제출 중단
        }
        return true; // 폼 제출 진행
    }

    function confirmDelete(goodsno, reviewno) {
        if (confirm("리뷰를 삭제하시겠습니까?")) {
            location.href = './delete.do?reviewno=${goodsno}&reviewno=${reviewno}';
        } else {

        }
    }
    
</script>  
 
>>>>>>> c1d97ab04267b89dade664f98450226fc7eb4e0f
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
        <br>
        <button type='button' id='btn_cart' class="btn btn-info btn-sm" style='margin-bottom: 2px;' onclick="cart_ajax(${goodsno })">장바 구니</button>
        <button type='button' id='btn_ordering' class="btn btn-info btn-sm" onclick="cart_ajax(${goodsno })">바로 구매</button>  
      </li>   
    </ul>
  </fieldset>

</DIV>
 <%-- 댓글 조회 --%>

 <FORM name='frm' method='POST' action='../review/update.do' enctype="multipart/form-data"  onsubmit="return checkLoginStatus();">
    <input type="hidden" name="goodsno" value="${goodsno}"/><!-- 현재 recipe의 recipeno -->
    <input type="hidden" name="reviewno" value="${reviewVO.reviewno}"/>  
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
           
    <textarea name='reviewcont' required="required" rows="7" cols="63">${reviewVO.reviewcont }</textarea>
    </td>
  </tr>
   <button type='submit' class='btn btn-info btn-sm'  onclick="checkRatingValue(event)">리뷰 글 수정</button>
    <div>
       <label>리뷰 사진 업로드</label>
       <input type='file' class="form-control" name='file2MF' id='file2MF' 
                 value='' placeholder="파일 선택"><br>
    </div>

 </FORM>    
 
 <!-- 댓글 목록 -->
   <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <c:choose>
          <c:when test="${sessionScope.admin_id != null}">
              <col style="width: 20px;"></col>
              <col style="width: 10%;"></col>
              <col style="width: 60%;"></col>
              <col style="width: 10%;"></col>
              <col style="width: 20px;"></col>
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
        <c:set var="file2" value="${reviewVO.file2 }" />
        <c:set var="file2saved" value="${reviewVO.file2saved }" />
        <c:set var="thumb2" value="${reviewVO.thumb2 }" />
        
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
                    <img src="/review/images/star_5.png" style="width: 100px; text-align: center;" >
                  </c:when>
                  <c:when test="${ratingValue.toString() == ' 4' }">
                     <img src="/review/images/star_4.jpg" style="width: 100px; text-align: center;">
                  </c:when>
                  <c:when test="${ratingValue.toString() == ' 3'}">
                    <img src="/review/images/star_3.jpg" style="width: 100px; text-align: center;">
                  </c:when>
                  <c:when test="${ratingValue.toString() == ' 2'}">
                    <img src="/review/images/star_2.png" style="width: 100px; text-align: center;">
                  </c:when>
                  <c:when test="${ratingValue.toString() == ' 1'}">
                    <img src="/review/images/star_1.png" style="width: 100px; text-align: center;">
                  </c:when>
                   <c:otherwise> <!-- 기본 이미지 출력 -->
                <img src="/review/images/star_0.png"> 
              </c:otherwise>
                </c:choose>
                
            </div>
          </td>
          
          <td style='vertical-align: middle; text-align: center;'>
            <div>
             <c:choose>
              <c:when test="${thumb2.endsWith('jpg') || thumb2.endsWith('png') || thumb2.endsWith('gif')}">
                <%-- /static/contents/storage/ --%>
                <img src="/dogproject/images/${file2saved }" style= "width: 20%; float: left; margin-right: 1px; margin-top: 0.5px;"> 
              </c:when>
              
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <img src="/goods/images/ee.png" style= "width: 20%; float: left; margin-right: 1px; margin-top: 0.5px;"> 
              </c:otherwise>
             </c:choose>
            
            </div>
          </td> 
          
          <td style='vertical-align: middle; text-align: center;'>
            <div>${reviewcont}</div>
          </td> 
          
          <td style='vertical-align: middle; text-align: center;'>
            <div>${rdate}</div>
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <div><a href="/review/update.do?goodsno=${goodsno}&reviewno=${reviewVO.reviewno}">수정</a>/<a href="/review/delete.do?goodsno=${goodsno }&reviewno=${reviewVO.reviewno}" onclick="return confirm('리뷰를 삭제하시겠습니까?')">삭제</a></div>
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