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
                  //window.location.href = "/member/passwd_update.do";
                  //window.history.back();
                  window.location.href = document.referrer;
                 
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
    <DIV style='width: 40%; margin: 0px auto;'>

      <FORM name='frm_login' id='frm_login' method='POST'>
        <input type='hidden' name='goodsno' id='goodsno' value=''>
        <input type='hidden' name='login_yn' id='login_yn' value=''>

      <FORM name='frm' method='POST' action='./login.do'>
       <DIV style=' margin-bottom:13%;'><span style='font-size: 28px;'>회원 로그인이 필요한 페이지입니다.</span></DIV> 
        <%-- 로그인 후 자동으로 이동할 페이지 전달 ★ --%>
        <input type="hidden" name="return_url" value="${return_url}">
      
        <div class="form_input">
          <input maxlength="30" type='text' class="form-control" name='id' id='id' 
                    value="${ck_id }" required="required" 
                    style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 60%; height:50px;  margin-top:40px;"
                     placeholder="아이디" autofocus="autofocus">
          <Label style="font-family:'맑은 고딕'; margin-left:-48%; margin-bottom:13px;">   
            <input type='checkbox' name='id_save' value='Y' ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>    
        </div>   
     
        <div class="form_input">
          <input maxlength="60" type='password' class="form-control" name='passwd' id='passwd' 
                    value="${ck_passwd }" required="required" 
                    style="font-family: '맑은 고딕'; margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 60%; height:50px; "
                     placeholder="비밀번호" autofocus="autofocus">
          <Label  style='margin-left:-48%; margin-bottom:0%;'>
            <input type='checkbox' name='passwd_save' value='Y' ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>                    
        </div>        
      </FORM>
    </div>
    <div style="margin-left:8%; margin-bottom:4%; ">
           <A href="./idFind.do" style="font-size:14px; font-weight: bold;">아이디 찾기</A>
              <span class='menu_divide' >│</span>
              <A href="./pwFind.do" style="font-size:14px; font-weight: bold;">비밀번호 찾기</A> 
        </div>
   
        <div style='text-align: center; style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; '>
      <button type="button"  id='btn_login' style="width:12%; height:45px; margin-bottom:8%;"class="btn btn-dark" onclick="login_ajax()">로그인</button>
      <button type='button'  style="width:12%; height:45px; margin-bottom:8%;" onclick="location.href='./create.do'" class="btn btn-outline-dark">회원가입</button>
    </div>
    
 
  
  </DIV>
  
    <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
  
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
