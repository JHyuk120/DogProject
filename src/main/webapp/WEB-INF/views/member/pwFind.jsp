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
 
  <DIV style='text-align: center; margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; font-size:30px; font-weight: bold;'>비밀번호 찾기</DIV>

  <DIV class='content_body'> 
    <DIV style='width: 40%;  margin: 0px auto; '>
     <FORM name='memberVO' id='frm' method='POST' action='/member/pwFind.do' class="">
        <div class="form_input"  >
          <input  maxlength="30" type='text' class="form-control" name='id' id='id'  
                    value="" required="required" style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 50%; height:50px;  margin-top:40px;  margin-bottom:30px;"
                     placeholder="아이디" autofocus="autofocus">
        </div>   

        <div class="form_input" >
          <input  maxlength="14" type='text' class="form-control" name='tel' id='tel'
                    value='' required="required"  style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; width: 50%; height:50px;  margin-bottom:50px;" placeholder="휴대폰 번호">            
        </div> 
        <div style='text-align: center; style="margin: 0 auto; display: flex; justify-content: center; align-items: center; flex-direction: column; '>
      <button type="submit"  id='idFind_btn' style="width:340px; height:55px; margin-bottom:50px;"class="btn btn-dark">비밀번호 찾기</button>
        </div>
      
      </FORM>
    </div>
   
    
      
    </div>
    

  
  </DIV>
  
    <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
  
  </DIV> <%-- <DIV class='content_body'> END --%>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>