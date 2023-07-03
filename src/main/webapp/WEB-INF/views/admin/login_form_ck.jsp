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
    $('#btn_loadDefault').on('click', loadDefault); // 기본 로그인 정보 설정
  });

  // 테스트용 기본값 로딩
  function loadDefault() {
    $('#id').val('admin1');
    $('#passwd').val('1234');
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
 

<body style="background-color: #FEFCE6;">
<c:import url="/menu/top.do" />
 

  <DIV class='content_body'> 
    <DIV style='width: 40%; margin: 0px auto;'>
      <FORM name='frm' method='POST' action='./login.do'>
        <DIV style=' margin-bottom:11%;'>
          <img src="/menu/images/pg.svg" class="icon0" style='margin-left:0%; '> <span style='font-size: 28px;'>관리자 로그인</span>
        </DIV> 
      
        <div class="form_input">
          <input type='text' class="form-control" name='id' id='id' 
                    value="${cookie.ck_admin_id.value }" required="required" 
                    style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 60%; height:50px;  margin-top:40px;"
                     placeholder="아이디" autofocus="autofocus">
          <Label  style='margin-bottom:13px; margin-left:-48%;'>   
            <input type='checkbox' name='id_save' value='Y' ${cookie.ck_admin_id_save.value == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>    
        </div>   
     
        <div class="form_input">
          <input type='password' class="form-control" name='passwd' id='passwd' 
                    value='${cookie.ck_admin_passwd.value }' required="required" style="font-family:'맑은 고딕'; margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 60%; height:50px;" placeholder="패스워드">
          <Label style="margin-bottom:40px; margin-left:-48%;">
            <input type='checkbox' name='passwd_save' value='Y' ${cookie.ck_admin_passwd_save.value == 'Y' ? "checked='checked'" : "" }> 저장
          </Label>                    
        </div>   
     
        <div class="form_input">
          <button type="submit"  style="width:60%; height:45px;  margin-left:0%; margin-bottom:25%"class="btn btn-dark" >로그인</button>
        </div>   
        
      </FORM>
    </DIV>
  </DIV> <%-- <DIV class='content_body'> END --%>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>