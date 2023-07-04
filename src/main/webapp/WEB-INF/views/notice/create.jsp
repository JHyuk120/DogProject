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
<img src="/menu/images/notice.png" class="icon1" style='margin-left:42%; margin-right:10px; margin-bottom: 7px;'> <span style='font-size: 30px;'>공지사항 작성</span>
</DIV> <br>

  
  <DIV style="text-align: left; clear: both;">  
  <FORM name='frm' method='POST' action='./create.do' enctype="multipart/form-data"> 
    
    <div>
       <label>제목</label>
       <input type='text' name='title' value='🖤제목을 입력하시오🖤' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 100%;' maxlength='50'>
    </div>
    <br>
    <div>
       <label>글</label>
       <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'>
✒️글을 입력하시오


</textarea>
    </div>  
      <br>
    <div>
       <label>검색어</label>
       <input type='text' name='word' value='해시태그' required="required" 
                 class="form-control" style='width: 100%;'>
    </div>   
    <br>
    <div>
       <label>이미지</label>
       <input type='file' class="form-control" name='file1MF' id='file1MF' 
                 value='' placeholder="파일 선택">
    </div>   
    <br>
    <div>
       <label>패스워드</label>
       <input type='password' name='passwd' value='1234' required="required" 
                 class="form-control" style='width: 50%;'>
    </div>   
    <br>
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-dark">등록</button>
      <button type="button" onclick="location.href='./list_all.do'" class="btn btn-outline-dark">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>