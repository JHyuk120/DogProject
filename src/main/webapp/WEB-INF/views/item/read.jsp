<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="dev.mvc.item.ItemVO" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport"
  content="user-scalable=yes, initial-scale=1.0, minimum-scale=1.0,
                                 maximum-scale=5.0, width=device-width" />
<title>http://localhost:9093/item/read.jsp?itemno=1</title>
<style type="text/css">
* {
  font-family: Malgun Gothic;
  font-size: 26px;
}
</style>
</head>
<body>

  <DIV style="font-size: 24px;">
    <%
    ItemVO itemVO = (ItemVO) request.getAttribute("itemVO");
    %>
    itemno : <%=itemVO.getItemno()%><br> 
    name : <%=itemVO.getItem()%><br>
    cnt :<%=itemVO.getCnt()%><br> 
  </DIV>

</body>
</html>