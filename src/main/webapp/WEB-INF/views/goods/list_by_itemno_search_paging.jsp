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
  function login() {
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
    	            alert('로그인 성공');
    	            $('#login_yn').val('Y');
    	            
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
	    
	    if ($('#login_yn').val() != 'Y') {  // 로그인이 안되어 있다면
	      $('#div_login').show();   // 로그인 폼 
	    } else {  // 로그인 한 경우
	      alert('쇼핑카트에 insert 처리 Ajax 호출');
	    }
	
	  }
    	      
</script>  
    
    
    
    
</head> 
 
<body style="background-color: #FEFCE6;">
<c:import url="/menu/top.do" />
 
<DIV class='title_line'>

🦴 ${itemVO.item } 💛 ${search_count }개 💛
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
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno.do?itemno=${param.itemno }&now_page=${param.now_page == null? 1: param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${param.itemno }&now_page=${param.now_page == null? 1: param.now_page}&word=${param.word }">갤러리형</A>
    
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_itemno.do'>
      <input type='hidden' name='itemno' value='${itemVO.itemno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class='btn btn-custom btn-sm' >검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class='btn btn-custom btn-sm'
                     onclick="location.href='./list_by_itemno.do?itemno=${itemVO.itemno}&word='">검색 취소</button>  
      </c:if>    
         <style>
          .btn-custom {
            background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
            color: white; /* 버튼 텍스트 색상 설정 (선택적) */
          }
          </style>
    </form>
  </DIV>

  <DIV class='menu_line'></DIV>
  
  <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
  
   <DIV id='div_login' style='display: none;'>
    <div style='width: 30%; margin: 0px auto;'>
      <FORM name='frm_login' id='frm_login' method='POST'>
        <input type='hidden' name='contentsno' id='contentsno' value=''>
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
      <c:forEach var="goodsVO" items="${list}">
        <c:set var="gname" value="${goodsVO.gname }" />
        <c:set var="content" value="${goodsVO.content }" />
        <c:set var="price" value="${goodsVO.price }" />
        <c:set var="dc" value="${goodsVO.dc }" />
        <c:set var="price" value="${goodsVO.saleprice }" />
        <c:set var="point" value="${goodsVO.point }" />
        <c:set var="itemno" value="${goodsVO.itemno }" />
        <c:set var="goodsno" value="${goodsVO.goodsno }" />
        <c:set var="thumb1" value="${goodsVO.thumb1 }" />
        <c:set var="rdate" value="${goodsVO.rdate.substring(0, 16) }" />
        
<<<<<<< HEAD
        

        <tr style="height: 112px;">

        <tr style="height: 102px;" >
=======

        <tr style="height: 102px;">
>>>>>>> 413ed024a69061d8fca6ea2b4f1adf92b2b65e15
          <td style='vertical-align: middle; text-align: center;'>
              <c:choose>
                <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}"> <%-- 이미지인지 검사 --%>
                  <%-- registry.addResourceHandler("/contents/storage/**").addResourceLocations("file:///" +  Contents.getUploadDir()); --%>
                  <img src="/dogproject/storage/${thumb1 }" style="width: 120px; height: 90;">
                </c:when>
                <c:otherwise> <!-- 이미지가 없는 경우 기본 이미지 출력: /static/contents/images/none1.png -->
                  <IMG src="/goods/images/none1.jpg" style="width: 120px; height: 90px;">
                </c:otherwise>
              </c:choose>
            </a>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?goodsno=${goodsno }&now_page=${param.now_page }&word=${param.word}">
              <div style='font-weight: bold;'>${gname }</div>
              <div>${price }\</div>
              <c:choose> 
                <c:when test="${content.length() > 160 }"> <%-- 160자 이상이면 160자만 출력 --%>
                    ${content.substring(0, 160)}.....
                </c:when>
                <c:when test="${content.length() <= 160 }">
                    ${content}
                </c:when>
              </c:choose>
              <br>
              <div style = 'font-size: 0.95em;' >${rdate }</div>
            </a>
          </td> 
          
           <td style='vertical-align: middle; text-align: center;'>
            <del><fmt:formatNumber value="${goodsVO.price}" pattern="#,###" /></del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${goodsVO.dc} %</span>
            <strong><fmt:formatNumber value="${goodsVO.saleprice}" pattern="#,###" /></strong><br>
            <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${goodsVO.point}" pattern="#,###" /></span>
            <br>
            <button type='button' id='btn_cart' class="btn btn-info btn-sm" style='margin-bottom: 2px;' onclick="cart_ajax(${goodsno })">장바 구니</button><br>
            <button type='button' id='btn_ordering' class="btn btn-info btn-sm" onclick="cart_ajax(${goodsno })">바로 구매</button>  
          </td>
          
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

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>