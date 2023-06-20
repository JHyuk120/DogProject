<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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


<script type="text/javascript">
  $(function() { // click 이벤트 핸들러 등록
    $('#btn_create').on('click', create); // 회원 가입
    $('#btn_loadDefault').on('click', loadDefault); // 기본 로그인 정보 설정
  });

  // 회원 가입  
  function create() {
    location.href="./create.do";
  }

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
                 // $('#div_login').hide(); // 로그인폼 감추기
                  //alert('로그인 성공');
                  $('#login_yn').val('Y');
                  window.location.href = "/";
                  
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

  function id_code() { // 인증번호 받기
	  let mname = $('#mname').val(); // 태그의 아이디가 'mname'인 태그의 값
      if ($.trim(mname).length == 0) { // id를 입력받지 않은 경우
        msg = '· 이름을 입력하세요.<br>· 이름 입력은 필수입니다.';
        
        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('이름 입력 누락'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "mname");  // 닫기 버튼 클릭시 mname 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        return false;
        } 

    let tel = $('#tel').val().trim(); // 태그의 아이디가 'tel'인 태그의 값
      if (tel.length == 0) { // id를 입력받지 않은 경우
        msg = '· 전화번호를 입력하세요.<br>· 전화번호 입력은 필수입니다.';
        
        $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
        $('#modal_title').html('전화번호 입력 누락'); // 제목 
        $('#modal_content').html(msg);        // 내용
        $('#btn_close').attr("data-focus", "tel");  // 닫기 버튼 클릭시 tel 입력으로 focus 이동
        $('#modal_panel').modal();               // 다이얼로그 출력
        return false;
        } 
	       }

	      $('#frm').submit(); // required="required" 작동 안됨.
  
  }  
	  
    
</script> 

</head>  
  <body>
<c:import url="/menu/top.do" />

    

  <ASIDE class="aside_right" style="margin-right:20px;">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
  <br>
 
  <DIV style='text-align: center; margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; font-size:30px; font-weight: bold;'>아이디</DIV>

  <DIV class='content_body'> 
    <DIV style='width: 40%;  margin: 0px auto; '>


      <FORM name='frm_login' id='frm_login' method='POST'>
        <input type='hidden' name='goodsno' id='goodsno' value=''>
        <input type='hidden' name='login_yn' id='login_yn' value=''>

      <FORM name='frm' method='POST' action='./login.do'>
        <%-- 로그인 후 자동으로 이동할 페이지 전달 ★ --%>
        <input type="hidden" name="return_url" value="${return_url}">
      
        <div class="form_input"  >
          <input type='text' class="form-control" name='mname' id='mname'  
                    value="${memberVO.mname }" required="required" style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 50%; height:50px;  margin-top:40px;  margin-bottom:30px;"
                     placeholder="이름" autofocus="autofocus"> 
        </div>   

        <div class="form_input" >
          <input type='text' class="form-control" name='tel' id='tel'
                    value='${memberVO.tel }' required="required"  style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 50%; height:50px;  margin-bottom:50px;" placeholder="휴대폰 번호">            
        </div> 
        
      
      </FORM>
    </div>
   
    <div class="form_input" style='text-align: center; style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; '>
      <button type="button"  id='id_code' onclick="id_code()" style="width:340px; height:55px; margin-bottom:50px;"class="btn btn-dark">인증번호 받기</button>

      
    </div>
    
 
  
  </DIV>
  
    <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
  
  </DIV> <%-- <DIV class='content_body'> END --%>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>