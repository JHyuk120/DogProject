<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="aname" value="${adminVO.mname }" />
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
    
    background-color:#FEFCF0;
  }

  .gallery_item {
    width: 22%;
    height: 300px;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
    .btn-custom {
      background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
      color: white; /* 버튼 텍스트 색상 설정 (선택적) */
    }  
    </style>
    
</head> 
<body>
<c:import url="/menu/top.do" />
 
  <DIV class='content_body'>
  <DIV>
<img src="/menu/images/qna1.png" class="icon1" style='margin-left:34%; margin-right:10px; margin-bottom: 7px;'> <span style='font-size: 30px;'>${qnaVO.title } > 답변</span>
</DIV> 

  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${itemVO.itemno }">목록</A>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  

  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <FORM name='frm' method='POST' action='./create.do' >
    <input type="hidden" name="qnano" value="${param.qnano }">
    
    
    <div>
       <label>🤍제목🤍</label>
       <div class="row" style='width:60%; padding-right:0px'>
          <div class="col-sm-2" >
            <input type="text" class="form-control" value="[답변]">
          </div>
          <div class="col-sm-10" style='padding:0px'>
              <input type='text' name='title' value="" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
          </div>
       </div>
    </div><br>
    <label>🤍작성자🤍</label>
    <div>
        <input type="text" name='aname' class="form-control" value="${aname}"style="width:20%;">
    </div>
    <br>
    <div>
       <label>🤍내용🤍</label>
       <textarea name='text' required="required" class="form-control" 
                            rows="20" style="overflow-y: scroll; width: 100%;"></textarea>
    </div>
    <br>
   <div>
     <label>패스워드</label>
     <input maxlength="30" type='password' name='passwd' value='' required="required" 
                 class="form-control" style='width: 30%;'><br>
   </div>  

    <div class="content_body_bottom">
      <button type="submit" class="btn btn-dark" style="width:5%; height:45px;">등록</button>
      <button type="button" onclick="location.href='./list_by_itemno.do?itemno=${param.itemno}'" class="btn btn-outline-dark" style="width:5%; height:45px;">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>