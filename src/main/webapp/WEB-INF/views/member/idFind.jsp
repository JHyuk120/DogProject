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
function setFocus() {  // focus 이동
    // console.log('btn_close click!');
    
    let tag = $('#btn_close').attr('data-focus'); // data-focus 속성에 선언된 값을 읽음 
    // alert('tag: ' + tag);
    
    $('#' + tag).focus(); // data-focus 속성에 선언된 태그를 찾아서 포커스 이동
  }

  function id_show() { 
    let mname = $('#mname').val().trim();// 태그의 아이디가 'mname'인 태그의 값
   // console.log($('#mname').val());
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
      let postData = {'mname' : mname , 'tel' : tel};
      $.ajax({
        url: '/member/idFind.do',
        type: 'POST',
        cache: false,
        async: true,
        dataType: 'json',
        data: postData,
        success: function(data) {
          // 성공적으로 응답을 받았을 때의 처리 로직
          var memberVO = data.memberVO;
          console.log(memberVO);

          // 추가적인 작업 수행 가능
          // 예시: 입력한 값을 화면에 출력
          $('#result').text('이름: ' + memberVO.mname + ', 전화번호: ' + memberVO.tel);

          $('#frm').submit(); // required="required" 작동 안됨.
        },
        error: function(request, status, error) {
          // 요청이 실패했을 때의 처리 로직
          console.log(error);
        }
      });
        
 
  }  
    
    
	
</script> 

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
    

  <ASIDE class="aside_right" style="margin-right:20px;">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>회원 가입</A>
    <span class='menu_divide' >│</span> 
    <A href='./list.do'>목록</A>
  </ASIDE> 
  <br>
 
  <DIV style='text-align: center; margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; font-size:30px; font-weight: bold;'>아이디 찾기</DIV>

  <DIV class='content_body'> 
    <DIV style='width: 40%;  margin: 0px auto; '>
     <FORM name='frm' id='frm' method='POST' action='/member/idFind.do' class="">
        <div class="form_input"  >
          <input type='text' class="form-control" name='mname' id='mname'  
                    value="" required="required" style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 50%; height:50px;  margin-top:40px;  margin-bottom:30px;"
                     placeholder="이름" autofocus="autofocus"> 
        </div>   

        <div class="form_input" >
          <input type='text' class="form-control" name='tel' id='tel'
                    value='' required="required"  style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 50%; height:50px;  margin-bottom:50px;" placeholder="휴대폰 번호">            
        </div> 
        
      
      </FORM>
    </div>
   
    <div style='text-align: center; style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; '>
      <button type="button"  id='id_code' onclick="id_show()" style="width:340px; height:55px; margin-bottom:50px;"class="btn btn-dark">아이디 찾기</button>

      
    </div>
    

  
  </DIV>
  
    <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
  
  </DIV> <%-- <DIV class='content_body'> END --%>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>