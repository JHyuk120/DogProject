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

<script>
function clearFileInput(fileInput) {
    fileInput.value = "";
  }
</script>
    
</head> 

</head> 
 
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
    background-color: #FEFCF0;
  }

  .fieldset_basic {
    width: 100%;
    height: 100%;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
  

</style>
</head>
 
<body>
<c:import url="/menu/top.do" />
 
<DIV style='background-color:#FEFCF0; margin-right: 5%; font-size: 30px;'><img src="/menu/images/qna1.png" class="icon1"> Q&A 등록</DIV>

<DIV class='content_body'>
  
  <DIV style="text-align: left; clear: both;">  
  <FORM name='frm' method='POST' action='./create.do'
                   enctype="multipart/form-data" class="form-horizontal"> 
    
    <div>
       <label>제목</label>
       <input maxlength="100" type='text' name='title' value='🖤제목을 입력하시오🖤' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;'>
    </div>
    
    <div>
       <label>글</label>
       <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'>
✒️글을 입력하시오


</textarea>
    </div>  
      
    <div>
       <label>검색어</label>
       <input maxlength="100" type='text' name='word' value='해시태그' required="required" 
                 class="form-control" style='width: 100%;'>
    </div>  
    <br> 
    <div>
     <label>첨부 파일</label>
    </div>
    <DIV style='width: 50%;'>
      
        <div class="form-group">   
          <div class="col-md-12">
            <input type='file' class="form-control" name='fnamesMF' id='fileInput' 
                         value='' placeholder="파일 선택" multiple="multiple">
            <button type="button" onclick="clearFileInput(document.getElementById('fileInput'));" class="btn btn-sm btn-outline-dark" style= "margin-left: 80%;">첨부파일 초기화</button>
          </div>
        </div>

       
   </DIV>
   <br>
   <div>
     <label>패스워드</label>
     <input maxlength="30" type='password' name='passwd' value='' required="required" 
                 class="form-control" style='width: 30%;'><br>
   </div>   
   <div class="content_body_bottom">
     <button type="submit" class="btn btn-dark">등록</button>
     <button type="button" onclick="location.href='./list_all.do'" class="btn btn-outline-dark">목록</button>
   </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>