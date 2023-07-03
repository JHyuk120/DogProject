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

<link href="/css/style.css" rel="Stylesheet" type="text/css">  <!-- /static -->

<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
    // jQuery ajax 요청

  function setFocus() {  // focus 이동
    // console.log('btn_close click!');
    
    let tag = $('#btn_close').attr('data-focus'); // data-focus 속성에 선언된 값을 읽음 
    // alert('tag: ' + tag);
    
    $('#' + tag).focus(); // data-focus 속성에 선언된 태그를 찾아서 포커스 이동
  }
  
  function send() { // 회원 가입 처리
    let id = $('#id').val(); // 태그의 아이디가 'id'인 태그의 값
    let tel = $('#tel').val().trim(); // 태그의 아이디가 'id'인 태그의 값
    
      if (tel.length == 0) { // id를 입력받지 않은 경우
        msg = '· 전화번호를 입력하세요.<br>· 전화번호 입력은 필수입니다.';
        
        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('전화번호 입력 누락'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "tel");  // 닫기 버튼 클릭시 tel 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        return false;
        } 
      
      let current_passwd = $('#current_passwd').val().trim(); // 태그의 아이디가 'current_passwd'인 태그의 값
      if (current_passwd.length == 0) { // id를 입력받지 않은 경우
        msg = '현재 비밀번호를 입력하세요.<br>· 현재 비밀번호 입력은 필수입니다.';
        
        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('현재 비밀번호 입력 누락 '); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "current_passwd");  // 닫기 버튼 클릭시 tel 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        return false;
        } 

      $.ajax({
          url: '/member/getMemberVO',  // MemberVO 데이터를 제공하는 경로로 수정해야 함
          type: 'GET',
          dataType: 'json',
          success: function(data) {
              var memberVO = data.memberVO;
              var passwd = memberVO.passwd;
              // 위에서 가져온 passwd 값과 비교하는 로직을 여기에 추가하면 됩니다.
          },
          error: function(request, status, error) { // callback 함수
                 console.log(error);
          }
      });
     
      if ($('#new_passwd').val() != $('#new_passwd2').val()) {  // 새로 입력되는 2개의 패스워드 비교
          $('#modal_title').html('패스워드 일치 여부  확인'); // 제목 

          $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
          msg = '· 입력된 패스워드가 일치하지 않습니다.<br>';
          msg += "· 패스워드를 다시 입력해주세요.<br>"; 
          $('#modal_content').html(msg);  // 내용
          $('#modal_panel').modal();         // 다이얼로그 출력
          
          $('#btn_close').attr("data-focus", "new_passwd"); // 모달창에서 닫기 버튼 클릭시 focus를 이동할 태그 설정
          
          return false; // submit 중지
        }

   // 패스워드 유효성 검사
     let new_passwd = $('#new_passwd').val();
     if (new_passwd.length > 0) {
      let passwordRegex = /^(?=.*?[A-Z].*?[a-z]|.*?[A-Z].*?\d|.*?[A-Z].*?[!@#$%^&*()\-_=+[\]{};:'"\\|,.<>/?]|.*?[a-z].*?\d|.*?[a-z].*?[!@#$%^&*()\-_=+[\]{};:'"\\|,.<>/?]|.*?\d.*?[!@#$%^&*()\-_=+[\]{};:'"\\|,.<>/?]).{10,16}$/;
      if (!passwordRegex.test(new_passwd)) { 
        msg = '영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 10자~16자<br>';
        msg += "패스워드를 다시 입력해주세요.<br>"; 
        
        $('#modal_content').attr('class', 'alert alert-danger'); // CSS 변경
        $('#modal_title').html('패스워드 조건 성립 확인'); // 제목 
        $('#modal_content').html(msg);  // 내용
        $('#btn_close').attr('data-focus', 'passwd');
        $('#modal_panel').modal();  
        return false; // submit 중지
      }
     }


    $('#frm').submit(); // required="required" 작동 안됨.
  }  

  function RecommendForm(memberno) {
      var url = "http://15.164.233.43:8000/ais/recommend_form/?memberno=${sessionScope.memberno }";
      window.location.href = url;
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
    text-align: left;
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

  <!-- ******************** Modal 알림창 시작 ******************** -->
  <div id="modal_panel" class="modal fade"  role="dialog">
    <div class="modal-dialog">
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id='modal_title'></h4><%-- 제목 --%>
          <button type="button" id='btn_close_modal' class="close" data-dismiss="modal">×</button>
        </div>
        <div class="modal-body">
          <p id='modal_content'></p>  <%-- 내용 --%>
        </div>
        <div class="modal-footer"> <%-- data-focus="": 캐럿을 보낼 태그의 id --%>
          <button type="button" id="btn_close" data-focus="" onclick="setFocus()" class="btn btn-default" 
                      data-dismiss="modal">닫기</button> <%-- data-focus: 캐럿이 이동할 태그 --%>
        </div>
      </div>
    </div>
  </div>
  <!-- ******************** Modal 알림창 종료 ******************** -->

  <DIV class='content_body'>
  <DIV>
    <img src="/menu/images/pg.svg" class="icon0" style='margin-left:40%; margin-right:10px; margin-bottom: 7px;'> <span style='font-size: 30px;'>회원 정보 수정</span>
</DIV> 

  <div class='menu_line'></div>
  
  <div style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; margin-top:20px; ">
  <FORM name='frm' id='frm' method='POST' action='./update.do' class="">
    <input type="hidden" name="memberno" value="${memberVO.memberno }">
    <div class="form_input"  style = "margin-bottom:20px; margin-top:40px;">
      <label style="  margin-right: 124px; font-size: 18px;" >아이디</label>
      <input maxlength="30" type='text' class="form-control " name='id' id='id' value="${memberVO.id }" required="required" disabled style='width: 400px; height:50px; display: inline-block;' placeholder="아이디" autofocus="autofocus">
    </div>  
    
     <div class="form_input" style = "margin-bottom:20px;">
        <label style="  margin-right: 63px; font-size: 18px;">현재 패스워드</label>    
        <input maxlength="60" type='password' class="form-control" name='current_passwd' 
                    id='current_passwd' value='' required="required" style="font-family:'맑은 고딕'; width: 400px; height:50px; display: inline-block;" ' placeholder="현재 패스워드">
      </div>   
                      
      <div class="form_input"  style = "margin-bottom:20px;">
        <label style="  margin-right: 82px; font-size: 18px;">새 비밀번호</label>    
        <input maxlength="60" type='password' class="form-control" name='new_passwd' 
                  id='new_passwd' value='' required="required"  style="font-family:'맑은 고딕'; width: 400px; height:50px;display: inline-block; " placeholder="새로운 패스워드">
      </div>   
   
      <div class="form_input"  style = "margin-bottom:20px;">
        <label style="  margin-right: 40px; font-size: 18px;">새 비밀번호 확인</label>    
        <input maxlength="60" type='password' class="form-control" name='new_passwd2' 
                  id='new_passwd2' value='' required="required"  style="font-family:'맑은 고딕'; width: 400px; height:50px; display: inline-block;" placeholder="패스워드">
      </div>   
       
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label style="  margin-right: 143px; font-size: 18px;">성명</label>
      <input maxlength="30" type='text' class="form-control " name='mname' id='mname' 
                value='${memberVO.mname }' required="required" style='width: 400px; height:50px; display: inline-block;' placeholder="성명">
    </div> 
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label style="  margin-right: 124px; font-size: 18px;" >휴대폰</label>
      <input maxlength="14" type='text' class="form-control " name='tel' id='tel' 
                value='${memberVO.tel }' required="required" style='width: 400px; height:50px; display: inline-block;' placeholder="010********"> 
    </div>  
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label style="margin-right: 107px; font-size: 18px;">우편번호</label>
      <input maxlength="5" type='text' class="form-control " name='zipcode' id='zipcode' 
                value='${memberVO.zipcode }' style='width: 400px; height:50px;; display: inline-block;' placeholder="우편번호">
      <button type="button" id="btn_DaumPostcode" onclick="DaumPostcode()" class="btn btn-outline-dark"  style='margin-left:5px;'>우편번호 찾기</button>
    </div>  
  
     <div class="form_input" style = "margin-bottom:20px;">
      <label  style="margin-right: 143px; font-size: 18px;">주소</label>
      <input maxlength="100" type='text' class="form-control" name='address1' id='address1' 
                 value='${memberVO.address1 }' required="required" style='width: 400px; height:50px; display: inline-block;' placeholder="주소">
    </div>  
    
    <div class="form_input" style = "margin-bottom:20px;">
      <label  style="margin-right: 107px; font-size: 18px;"> 상세주소</label>
      <input maxlength="100" type='text' class="form-control" name='address2' id='address2' 
                value='${memberVO.address2 }' required="required" style='width: 400px; height:50px; display: inline-block; margin-bottom:30px;' placeholder="상세 주소">
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
              $('#zipcode').val(data.zonecode); // 5자리 새우편번호 사용 ★
              $('#address1').val(fullAddr);  // 주소 ★

              // iframe을 넣은 element를 안보이게 한다.
              // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
              element_wrap.style.display = 'none';

              // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
              document.body.scrollTop = currentScroll;

              $('#address2').val(""); // 기존의 상세 주소 값 삭제
              $('#address2').focus(); // 상세주소 ★
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
    
    <div class="form_input" >
     <button type="button" id="btn_send" onclick="RecommendForm(${memberVO.memberno})" class="btn btn-dark" style="width: 115px; height: 60px;  margin-left:255px;">관심 분야 변경하기</button>
      <button type="button" id='btn_send' onclick="send()" class="btn btn-dark" style="width: 100px; height:60px; ">수정</button>
      <button type="button" onclick="history.back()" class="btn btn-outline-dark" style='width:70px; height:60px;'><img src="/member/images/back.png" class="icon" style="width:30px"></button>
    </div>   
  </FORM>
  </DIV>
  
  </DIV>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>