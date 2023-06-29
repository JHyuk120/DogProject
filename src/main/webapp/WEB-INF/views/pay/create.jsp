<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=5.0, width=device-width" /> 
<title>댕키트</title>
 <link rel="shortcut icon" href="/images/ee.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->

<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function() { // 자동 실행
    $('#btn_DaumPostcode').on('click', DaumPostcode); // 다음 우편 번호
    $('#btn_my_address').on('click', my_address);          // 나의 주소 가져오기
    $('#btn_pay').on('click', send);                      // 결제
    
  });

  // 나의 주소 가져오기, jQuery ajax 요청
  function my_address() {
    // $('#btn_close').attr("data-focus", "이동할 태그 지정");
   
    // var frm = $('#frm'); // id가 frm인 태그 검색
    // var id = $('#id', frm).val(); // frm 폼에서 id가 'id'인 태그 검색
    var params = '';
    var msg = '';

    $.ajax({
      url: '/member/read_ajax.do', // spring execute
      type: 'get',  // post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";

        $('#tname').val(rdata.tname);
        $('#ttel').val(rdata.ttel);
        $('#tzipcode').val(rdata.tzipcode);
        $('#taddress1').val(rdata.taddress1);
        $('#taddress2').val(rdata.taddress2);
        
       
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우
      error: function(request, status, error) { // callback 함수
        console.log(error);
      }
    });

  }

  // 값이 없는지 검사
  function check_null(str) {
    var sw = false;
    if (str == "" || str.trim().length == 0 || str == null || str == undefined || typeof str == "object") {
      sw = true;  // 값이 없는 경우  
    }
    return sw;    // 값이 있는 경우  
  }

  // 주문하기
  function send() {
    if (check_null($('#tname').val()))  {
      alert('수취인 성명을 입력해주세요.');
      $('#tname').focus();
      return; // 실행 중지
    }

    if (check_null($('#ttel').val()))  {
      alert('수취인 전화번호를 입력해주세요.');
      $('#ttel').focus();
      return;
    }

    if (check_null($('#tzipcode').val()))  {
      alert('우편번호를 입력해주세요.');
      $('#tzipcode').focus();
      return;
    }    

    if (check_null($('#taddress1').val()))  {
      alert('주소를 입력해주세요.');
      $('#taddress1').focus();
      return;
    }    
     
    if (check_null($('#taddress2').val()))  {
      alert('상세 주소를 입력해주세요. 내용이 없으면 수취인 성명을 입력주세요.');
      $('#taddress2').focus();
      return;
    }    
    if (check_null($('#ptype').val())) {
          alert('결제 방식을 선택해주세요.');
          return;
        }

    frm.submit();
  }

  // 라디오 함수
      function RadioClick() {
          const radios = document.getElementsByName('ptype');
          var checkedValue = '4';
          
          for (let i = 0; i < radios.length; i++) {
            if (radios[i].checked) {
              checkedValue = radios[i].value;
              break;
            }
          }

      const p_code = `<div class="cart_label">나의 포인트</div>
          <div class="cart_price"><fmt:formatNumber value="${memberVO.mpoint }" pattern="#,###" /> 원 </div>
          <c:choose>
            <c:when test="${total_order <= memberVO.mpoint }">
              <div class="cart_label" style="font-size: 1.8em;">최종 주문 금액</div>
              <div class="cart_price"  style="font-size: 1.8em; color: #FF0000;"><fmt:formatNumber value="0" pattern="#,###" /> 원</div>
            </c:when>
            <c:otherwise>
              <div class="cart_label" style="font-size: 1.8em;">최종 주문 금액</div>
              <div class="cart_price"  style="font-size: 1.8em; color: #FF0000;"><fmt:formatNumber value="${total_order - memberVO.mpoint}" pattern="#,###" /> 원</div>
            </c:otherwise>
          </c:choose>`;

      const code = `<br><br>
        <div class="cart_label" style="font-size: 1.8em;">최종 주문 금액</div>
          <div class="cart_price"  style="font-size: 1.8em; color: #FF0000;"><fmt:formatNumber value="${total_order}" pattern="#,###" /> 원</div>
        `;
              
      // 초기 화면 로드시 실행
      if (checkedValue === '3') {
          document.getElementById('result').innerHTML = p_code;
        } else {
            document.getElementById('result').innerHTML = code;
        }
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
      background-color:#FEFCF0;
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

<DIV class='content_body'>
<DIV class='title_line'>주문, 결제</DIV>

  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 40%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col> <%-- 수량 --%>
      <col style="width: 10%;"></col> <%-- 합계 --%>
      <col style="width: 10%;"></col>
    </colgroup>
   
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="cartVO" items="${list }">
        <c:set var="cartno" value="${cartVO.cartno }" />
        <c:set var="goodsno" value="${cartVO.goodsno }" />
        <c:set var="gname" value="${cartVO.gname }" />
        <c:set var="thumb1" value="${cartVO.thumb1 }" />
        <c:set var="price" value="${cartVO.price }" />
        <c:set var="dc" value="${cartVO.dc }" />
        <c:set var="saleprice" value="${cartVO.saleprice }" />
        <c:set var="point" value="${cartVO.point }" />
        <c:set var="memberno" value="${cartVO.memberno }" />
        <c:set var="cnt" value="${cartVO.cnt }" />
        <c:set var="tot" value="${cartVO.tot }" />
        <c:set var="rdate" value="${cartVO.rdate }" />
       
        <tr>
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/goods/storage/ --%>
                <a href="/goods/read.do?goodsno=${goodsno}"><IMG src="/goods/storage/${thumb1 }" style="width: 120px; height: 80px;"></a>
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
               <IMG src="/recipe/images/ee.png" style="width: 90%; height: 90px; margin-bottom:4px; margin-top:4px; "><br>
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="/goods/read.do?goodsno=${goodsno}"><strong>${gname}</strong></a>
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <del><fmt:formatNumber value="${price}" pattern="#,###" /></del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${dc} %</span>
            <strong><fmt:formatNumber value="${saleprice}" pattern="#,###" /></strong><br>
            <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${point}" pattern="#,###" /></span>
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            수량: ${cnt }
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <fmt:formatNumber value="${tot}" pattern="#,###" />
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <A href="../cart/list_by_memberno.do"><IMG src="/cart/images/delete.png" title="쇼핑카트로 이동합니다."></A>
          </td>
        </tr>
      </c:forEach>
     
    </tbody>
  </table>
 
  <form name='frm' id='frm' style='margin-top: 50px;' action="/pay/create.do" method='post'>
    <input type="hidden" name="amount" value=" ${total_order }">   <%-- 전체 주문 금액 --%>
   
   
    <ASIDE class="aside_left">
      배송 정보<span style="font-size: 0.7em;">(*: 필수 입력)</span>
      <button type="button" id="btn_my_address" class="btn btn-light" style="margin-bottom: 2px;">나의 주소 가져오기</button>
      <button type="reset" id="btn_reset" class="btn btn-light" style="margin-bottom: 2px;">주소 지우기</button>
    </ASIDE>

    <div class='menu_line'></div>

    <div class="form_input">
      <input type='text' class="form-control" name='tname' id='tname'
                value='' required="required" style='width: 30%;' placeholder="수취인 성명*">
    </div>  

    <div class="form_input">
      <input type='text' class="form-control" name='ttel' id='ttel' value='' required="required" style='width: 30%;' placeholder="수취인 전화번호*"> 예) 010-0000-0000
    </div>  

    <div class="form_input">
      <input type='text' class="form-control" name='tzipcode' id='tzipcode' value='' style='width: 30%;' placeholder="우편번호*">
      <input type="button" id="btn_DaumPostcode" value="우편번호 찾기" class="btn btn-dark btn-sm">
    </div>  

    <div class="form_input">
      <input type='text' class="form-control" name='taddress1' id='taddress1' value='' style='width: 80%;' placeholder="주소*">
    </div>  

    <div class="form_input">
      <input type='text' class="form-control" name='taddress2' id='taddress2' value='' style='width: 80%;'
                placeholder="상세 주소(없을시 수취인 성명 입력)*">
    </div>  

    <div>

<!-- ------------------------------ DAUM 우편번호 API 시작 ------------------------------ -->
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                $('#tzipcode').val(data.zonecode); //5자리 새우편번호 사용 ★
                $('#taddress1').val(fullAddr);  // 주소 ★

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
               
                $('#taddress2').focus(); //  ★
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ------------------------------ DAUM 우편번호 API 종료 ------------------------------ -->

    </div>
 
  <div style='margin-top: 20px; width: 100%; clear: both;'> </div>  
  <ASIDE class="aside_left" style='margin-top: 50px;'>
    결제 정보&nbsp;<a style='font-size: 0.7em; color: #FF0000;'>※결제 방식을 선택해주세요</a> <br>
  </ASIDE>

  <div class='menu_line'></div>
  <div style=" text-align: left;">
    <label><input type="radio" name="ptype" id="ptype" value="1" onclick="RadioClick()"> 신용 카드</label>
    <label><input type="radio" name="ptype" id="ptype" value="2" onclick="RadioClick()"> 모바일</label>
    <label><input type="radio" name="ptype" id="ptype" value="3" onclick="RadioClick()"> 포인트</label><br>
    
       
  </div>
 
  <table class="table table-striped" style='margin-top: 20px; margin-bottom: 50px; width: 100%; clear: both;'>
    <tbody>
      <tr>
        <td style='width: 45%;'>
          <div class='cart_label'>상품 금액</div>
          <div class='cart_price'><fmt:formatNumber value="${tot_sum }" pattern="#,###" /> 원</div>
         
          <div class='cart_label'>적립 포인트</div>
          <div class='cart_price'><fmt:formatNumber value="${point_tot }" pattern="#,###" /> 원 </div>
         
         
          <div class='cart_label'>배송비</div>
          <div class='cart_price'><fmt:formatNumber value="${baesong_tot }" pattern="#,###" /> 원</div>
        </td>
        <td style='width: 45%;'>
          <div class='cart_label' style='font-size: 1.5em;'>주문 금액</div>
          <div class='cart_price'  style='font-size: 1.5em;'><fmt:formatNumber value="${total_order }" pattern="#,###" /> 원</div>
          
         <div id="result"></div>    <!-- radio버튼 선택시 -->

        </td>
        <td style='width: 10%;'>
          <button type='button' id='btn_pay' class='btn btn-outline-dark btn-sm' style='font-size: 1.2em;'>결 제 하 기</button><br>
          <button type='button' id='btn_cart' class='btn btn-dark btn-sm onclick="location.href='/cart/list_by_memberno.do'" style='font-size: 1.2em;'>돌 아 가 기</button>
        </td>
      </tr>
    </tbody>
  </table>  
     
  </FORM>
  </DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>
