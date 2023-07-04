  <%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>댕키트</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
 
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
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

  function delete_func(goodsno,memberno) {  // GET -> POST 전송, 상품 삭제
	    var frm = $('#frm_post');
	    frm.attr('action', 'wish/delete.do');
	    $('#goodsno',  frm).val(goodsno);
	    $('#memberno',  frm).val(memberno);
	    
	    frm.submit();
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
</script>  
 
    
    
    
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
 
<body>
<c:import url="/menu/top.do" />
 

<DIV class='content_body' style='background-color:#FEFCF0;'>

  <DIV>
    <div style='display: flex; align-items: flex-start;'>
        <img src="/goods/images/wish.png" class="icon0"  style='margin-left:5px; width: 2%; margin-bottom: 7px; margin-right: 1%;'>찜한 재료 목록
    </div>

</DIV>

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
    </c:if>
    
    <A href="javascript:location.reload();">새로고침</A>
    
    
  </ASIDE> 
  

  
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
  
  
  
  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <c:choose>
        <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
        <c:when test="${sessionScope.admin_id != null }">
          <col style="width: 10%;"></col>
          <col style="width: 55%;"></col>
          <col style="width: 20%;"></col>
          <col style="width: 15%;"></col>
        </c:when>
        <c:otherwise>
          <col style="width: 10%;"></col>
          <col style="width: 70%;"></col>
          <col style="width: 20%;"></col>
        </c:otherwise>
      </c:choose>
      
    </colgroup>

<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>제목</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <tbody>
      <c:forEach var="goodsVO" items="${list_m}">
        <c:set var="gname" value="${goodsVO.gname }" />
        <c:set var="content" value="${goodsVO.content }" />
        <c:set var="price" value="${goodsVO.price }" />   
        <c:set var="dc" value="${goodsVO.dc }" /> 
        <c:set var="point" value="${goodsVO.point }" />
        <c:set var="saleprice" value="${goodsVO.saleprice }" />
        <c:set var="itemno" value="${goodsVO.itemno }" />
        <c:set var="goodsno" value="${goodsVO.goodsno }" />
        <c:set var="thumb1" value="${goodsVO.thumb1 }" />
        <c:set var="now_page" value="${goodsVO.now_page }" />
        <c:set var="word" value="${goodsVO.word }" />
        <c:set var="rdate" value="${goodsVO.rdate.substring(0, 16) }" />

      <tr style="height: 102px;" >
          <td style='vertical-align: middle; text-align: center;'>
              <c:choose>
                <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                  <%-- registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
                   <a href="/goods/read.do?goodsno=${goodsno}"><img src="/dogproject/storage/${thumb1 }" style="width: 150px; height: 150px;"></a>
                </c:when>
                <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
                  <IMG src="/goods/images/ee.png" style="width: 100%; height: 120px; ">
                </c:otherwise>
              </c:choose>
            </a>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="../goods/read.do?goodsno=${goodsno }&now_page=${param.now_page == null? 1: param.now_page}&word=${param.word}">
              <div style='font-weight: bold; margin-bottom:10px;'>${gname }</div>

           
              <del><fmt:formatNumber value="${price}" pattern="#,###" />원</del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${dc} %</span>
            <strong><fmt:formatNumber value="${saleprice}" pattern="#,###" />원</strong><br>
            
            </a>
          </td> 
          
           <td style='vertical-align: middle; text-align: center;'>
            
            <button type='button' id='btn_cart' class="btn btn-dark" style='margin-bottom: 8px; margin-right:3px;  width:130px; height:43px' onclick="cart_ajax(${goodsno })">장바구니</button><br>
            
            <%-- <button type='button' id='btn_ordering' class="btn btn-outline-dark" style="width:130px; height:40px" onclick="delete_func(${goodsno}, ${memberno})">삭제</button>  --%>
            <form name="frm_order" id="frm_order" action="/wish/delete.do" method="POST">
					      <input type="hidden" name="goodsno" value="${goodsno}" />
					      
					      <button type='submit' id='wish' class="btn btn-outline-dark btn-lg" style=' width: 130px; height: 40px; '>
                 <span style="font-size: 18px; display: flex; align-items: center; justify-content: center;">삭제</span>
                </button>
					      
					      
			
           </form> 
  
          </td>
          
         <%--  <td style='vertical-align: middle; text-align: center;'>
            <A href="/contents/map.do?cateno=${cateno }&contentsno=${contentsno}&word=${param.word }" title="지도"><IMG src="/contents/images/map.png" class="icon"></A>
            <A href="/contents/youtube.do?cateno=${cateno }&contentsno=${contentsno}&word=${param.word }" title="Youtube"><IMG src="/contents/images/youtube.png" class="icon"></A>
            <A href="/contents/update_text.do?cateno=${cateno }&contentsno=${contentsno}&word=${param.word }" title="글 수정"><IMG src="/contents/images/update.png" class="icon"></A>
            <A href="/contents/update_file.do?cateno=${cateno }&contentsno=${contentsno}&word=${param.word }" title="파일 수정"><IMG src="/contents/images/update_file.png" class="icon"></A>
            <A href="/contents/delete.do?cateno=${cateno }&contentsno=${contentsno}&word=${param.word }" title="삭제"><IMG src="/contents/images/delete.png" class="icon"></A>
          </td>
          --%>
          
          <c:choose>
            <c:when test="${sessionScope.admin_id != null }">
              <td style='vertical-align: middle; text-align: center;'>
                <A href="/goods/delete.do?itemno=${itemno }&goodsno=${goodsno}&now_page=${param.now_page == null? 1: param.now_page}" title="삭제"><IMG src="/goods/images/delete.png" class="icon"></A>
                <A href="/goods/update_text.do?itemno=${itemno }&goodsno=${goodsno}&now_page=${param.now_page == null? 1: param.now_page}" title="글 수정"><IMG src="/goods/images/update.png" class="icon"></A>
                <A href="/goods/update_file.do?itemno=${itemno }&goodsno=${goodsno}&now_page=${param.now_page == null? 1: param.now_page}" title="파일 수정"><IMG src="/goods/images/update_file.png" class="icon"></A>
              </td>
            </c:when>
          </c:choose>
        </tr>
        
      </c:forEach>
    
    </tbody>
  </table>
  
    <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</DIV>
   <!-- 플로팅 메뉴 -->
<style>
    .float {
        position: fixed;
        bottom: 30px;
        right: 20px;
        z-index: 999;
    }
</style>

<div class="float">
    <div class="btn-group-vertical">
      <c:choose>
        <c:when test="${sessionScope.id != null }">
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';" onclick="location.href='/cart/list_by_memberno.do'">장바구니</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';" onclick="location.href='../recom/memberList.do?memberno=${memberno}'">저장한 레시피</button>
          <button type="button"class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"  onclick="location.href='/pay/pay_list.do'">주문내역</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='qna/list_by_search.do'">고객상담</button>
        </c:when>
        <c:otherwise>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='member/create.do'">회원가입</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='qna/list_by_search.do'">고객상담</button>
        </c:otherwise>
      </c:choose>
    </div>
</div>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>