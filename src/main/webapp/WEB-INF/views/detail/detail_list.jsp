<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    ${sessionScope.mname }님 주문 결재 상세 내역
  </DIV>
   
    <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style='width: 5%;'/>
      <col style='width: 5%;'/>
      <col style='width: 10%;'/>
      <col style='width: 10%;'/>
      <col style='width: 30%;'/>
      <col style='width: 5%;'/>
      <col style='width: 5%;'/>
      <col style='width: 5%;'/>
      <col style='width: 10%;'/>
      <col style='width: 15%;'/>
     
    </colgroup>
    <TR>
      <TH class='th_bs'>주문<br>결재</TH>
      <TH class='th_bs'>주문<br>상세</TH>
      <TH class='th_bs'>회원<br>번호</TH>
      <TH class='th_bs'>컨텐츠<br>번호</TH>
      <TH class='th_bs'>상품명</TH>
      <TH class='th_bs'>가격</TH>
      <TH class='th_bs'>수량</TH>
      <TH class='th_bs'>금액</TH>
      <TH class='th_bs'>배송상태</TH>
      <TH class='th_bs'>주문일</TH>
    </TR>
   
    <c:forEach var="detailVO" items="${list }">
      <c:set var="payno" value ="${detailVO.payno}" />
      <c:set var="detailno" value ="${detailVO.detailno}" />
      <c:set var="memberno" value ="${detailVO.memberno}" />
      <c:set var="goodsno" value ="${detailVO.goodsno}" />
      <c:set var="gname" value ="${detailVO.gname}" />
      <c:set var="saleprice" value ="${detailVO.saleprice}" />
      <c:set var="cnt" value ="${detailVO.cnt}" />
      <c:set var="tot" value ="${detailVO.tot}" />
      <c:set var="stateno" value ="${detailVO.stateno}" />
      <c:set var="rdate" value ="${detailVO.rdate}" />
         
    <TR>
      <TD class=td_basic>${payno}</TD>
      <TD class=td_basic>${detailno}</TD>
      <TD class=td_basic><A href="/member/read.do?memberno=${memberno}">${memberno}</A></TD>
      <TD class=td_basic><A href="/goods/read.do?goodsno=${goodsno}">${goodsno}</A></TD>
      <TD class='td_left'>${gname}</TD>
      <TD class='td_left'><fmt:formatNumber value="${saleprice }" pattern="#,###" /></TD>
      <TD class='td_basic'>${cnt }</TD>
      <TD class='td_basic'><fmt:formatNumber value="${tot }" pattern="#,###" /></TD>
      <TD class='td_basic'>
        <c:choose>
          <c:when test="${stateno == 1}">상품 준비중</c:when>
          <c:when test="${stateno == 2}">배달중</c:when>
          <c:when test="${stateno == 3}">배달 완료</c:when>
        </c:choose>
      </TD>
      
      <TD class='td_basic'>${rdate.substring(1,16) }</TD>
      
    </TR>
    </c:forEach>
    
  </TABLE>
  
  <table class="table table-striped" style='width: 100%;'>
    <TR>
      <TD colspan="10"  style="text-align: right; font-size: 1.3em;">
        배송비: <fmt:formatNumber value="${baesong_tot }" pattern="#,###" />  
        총 주문 금액: <fmt:formatNumber value="${total_order }" pattern="#,###" />  
      </TD>
    </TR>  
  </table>    
   
  <DIV class='bottom_menu'>
    <button type='button' onclick="location.reload();" class="btn btn-primary">새로 고침</button>
    <button type='button' onclick="location.href='/pay/pay_list.do?memberno=${memberno}'" class="btn btn-primary">결재 목록</button>
  </DIV>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>