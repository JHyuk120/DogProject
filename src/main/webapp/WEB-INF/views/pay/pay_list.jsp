<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=5.0, width=device-width" /> 
<title>댕키트</title>
<link rel="shortcut icon" href="/images/star.png" /> <%-- /static 기준 --%>
<link href="/css/style.css" rel="Stylesheet" type="text/css"> <!-- /static 기준 -->
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js">
<script type="text/javascript">
$(function(){

});
</script>
    
</head> 
 
<body>
<c:import url="/menu/top.do" />
 <DIV class='title_line'>
    ${sessionScope.mname }님 주문결재 내역
  </DIV>

  <DIV class='content_body' style='width: 100%;'>

    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style='width: 5%;'/>
      <col style='width: 5%;'/>
      <col style='width: 7%;'/>
      <col style='width: 15%;'/>
      <col style='width: 30%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 13%;'/>
      <col style='width: 5%;'/>
    </colgroup>
    <TR>
      <TH class='th_bs'>주문<br>번호</TH>
      <TH class='th_bs'>회원<br>번호</TH>
      <TH class='th_bs'>수취인<br>성명</TH>
      <TH class='th_bs'>수취인<br>전화번호</TH>
      <TH class='th_bs'>수취인<br>주소</TH>
      <TH class='th_bs'>결재 타입</TH>
      <TH class='th_bs'>결재 금액</TH>
      <TH class='th_bs'>주문일</TH>
      <TH class='th_bs'>조회</TH>
    </TR>
   
    <c:forEach var="payVO" items="${list }">
      <c:set var="payno" value ="${payVO.payno}" />
      <c:set var="memberno" value ="${payVO.memberno}" />
      <c:set var="tname" value ="${payVO.tname}" />
      <c:set var="ttel" value ="${payVO.ttel}" />
      <c:set var="address" value ="(${payVO.tzipcode}) ${payVO.taddress1} ${payVO.taddress1}" />
      <c:set var="ptype" value ="${payVO.ptype}" />
      <c:set var="amount" value ="${payVO.amount}" />
      <c:set var="rdate" value ="${payVO.rdate}" />
         
       
    <TR>
      <TD class=td_basic>${payno}</TD>
      <TD class=td_basic><A href="/member/read.do?memberno=${memberno}">${memberno}</A></TD>
      <TD class='td_basic'>${tname}</TD>
      <TD class='td_left'>${ttel}</TD>
      <TD class='td_basic'>${address}</TD>
      <TD class='td_basic'>
        <c:choose>
          <c:when test="${ptype == 1}">신용 카드</c:when>
          <c:when test="${ptype == 2}">모바일</c:when>
          <c:when test="${ptype == 3}">포이트</c:when>
        </c:choose>
      </TD>
      <TD class='td_basic'><fmt:formatNumber value="${amount }" pattern="#,###" /></TD>
      <TD class='td_basic'>${rdate.substring(1,16) }</TD>
      <TD class='td_basic'>
        <A href="/detail/detail_list.do?payno=${payno}"><img src="/pay/images/bu6.png" title="주문 내역 상세 조회"></A>
      </TD>
      
    </TR>
    </c:forEach>
    
  </TABLE>
   
  <DIV class='bottom_menu'>
    <button type='button' onclick="location.reload();" class="btn btn-primary">새로 고침</button>
    <button type='button' onclick="location.href='/cart/list_by_memberno.do'" class="btn btn-primary">장바구니</button>
  </DIV>
</DIV>
 

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>