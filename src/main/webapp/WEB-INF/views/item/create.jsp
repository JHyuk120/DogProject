<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>댕키트</title>
 <link rel="shortcut icon" href="/images/ee.png" /> <%-- /static 기준 --%>
 

 
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <%-- /static/css/style.css 기준 --%>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
<%-- <jsp:include page="../menu/top.jsp" flush='false' /> --%>
 
<DIV class='title_line'>품목 등록</DIV>

<DIV class='content_body'>
  <FORM name='frm' method='POST' action='./create.do'> 
    <div>
       <label>품 목</label>
       <input type='text' name='item' value='' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 50%;'>
      <label>순서 지정</label>
      <input type='number' name='seqno' min="1" value='1' required="required" style='width: 5%;'>
    </div>
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-primary">등록</button>
      <button type="button" onclick="location.href='./list.do'" class="btn btn-light">목록</button>
    </div>
  
  </FORM>
</DIV>
 
</body>
 
</html>