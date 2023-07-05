<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko">
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>댕키트</title>
 <link rel="shortcut icon" href="/images/ee.png" /> <%-- /static 기준 --%>
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    
<script type="text/javascript">
  function update_cnt(cartno) {  // 수량 변경
    var frm = $('#frm_post');
    frm.attr('action', './update_cnt.do');
    $('#cartno',  frm).val(cartno);
    
    var new_cnt = $('#' + cartno + '_cnt').val();  // $('#1_cnt').val()로 변환됨, 사용자가 변경한 수량을 다시 읽어옴 ★.

    if (new_cnt > 0) {
        $('#cnt',  frm).val(new_cnt);
     
        frm.submit();
    } else {
        alert('수량은 1개 이상이어야 합니다.');
    }
    
  }
  
  function delete_func(cartno) {  // GET -> POST 전송, 상품 삭제
    var frm = $('#frm_post');
    frm.attr('action', './delete.do');
    $('#cartno',  frm).val(cartno);
    
    frm.submit();
  }   


</script>

<style type="text/css">

    
</style>

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
        /* 스크롤 막대의 색상 설정 */
    ::-webkit-scrollbar {
        width: 8px; /* 스크롤 막대의 너비 */
    }
    
    /* 스크롤 막대의 바탕색 */
    ::-webkit-scrollbar-track {
        background-color: white;
    }
    
    /* 스크롤 막대의 색상 */
    ::-webkit-scrollbar-thumb {
        background-color: #FFDAD5;
    }
    
    /* 스크롤 막대의 색상 및 모서리 둥글게 */
::-webkit-scrollbar-thumb {
    background-color: #FFDAD5;
    border-radius: 4px;
}
    
    /* 마우스 호버 시 스크롤 막대의 색상 */
    ::-webkit-scrollbar-thumb:hover {
        background-color: #DAF5E0;
    }
    
  </style>

</head> 
 
<body>
<c:import url="/menu/top.do" />

<DIV class='content_body'>

<%-- GET -> POST: 수량 변경, 상품 삭제용 폼 --%>
<form name='frm_post' id='frm_post' action='' method='post'>
  <input type='hidden' name='cartno' id='cartno'>
  <input type='hidden' name='cnt' id='cnt'>
</form>
 
<DIV class='title_line'><img src="/menu/images/cart4.svg" class="icon0" style='margin-left:5px;margin-bottom: 7px;'><img src="/goods/images/arrow.png" class="icon"  style='margin-left:5px; width: 2%; margin-bottom: 5px;'>총 ${cart_cnt }건</DIV>

  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 40%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col> <%-- 수량 --%>
      <col style="width: 10%;"></col> <%-- 합계 --%>
      <col style="width: 10%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>상품명</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <%-- table 내용 --%>
    <tbody>
      <c:choose>
        <c:when test="${list.size() > 0 }"> <%-- 상품이 있는지 확인 --%>
          <c:forEach var="cartVO" items="${list }">  <%-- 상품 목록 출력 --%>
            <c:set var="cartno" value="${cartVO.cartno }" />
            <c:set var="goodsno" value="${cartVO.goodsno }" />
            <c:set var="gname" value="${cartVO.gname }" />
            <c:set var="thumb1" value="${cartVO.thumb1 }" />
            <c:set var="price" value="${cartVO.price }" />
            <c:set var="dc" value="${cartVO.dc }" />
            <c:set var="saleprice" value="${cartVO.saleprice}" />
            <c:set var="point" value="${cartVO.point }" />
            <c:set var="memberno" value="${cartVO.memberno }" />
            <c:set var="cnt" value="${cartVO.cnt }" />
            <c:set var="tot" value="${cartVO.tot}" />     
            <c:set var="rdate" value="${cartVO.rdate }" />
            
            <tr> 
              <td style='vertical-align: middle; text-align: center;'>
                <c:choose>
                  <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                    <%-- /static/contents/storage/ --%>
                    <a href="/goods/read.do?goodsno=${goodsno}"><IMG src="/dogproject/storage/${thumb1 }" style="width: 130px; height: 120px;"></a> 
                  </c:when>
                  
                  <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                  <IMG src="/recipe/images/ee.png" style="width: 100%; height: 100px; margin-bottom:4px; margin-top:4px; "><br>
                    ${goodsVO.file1}
                  </c:otherwise>
                </c:choose>
              </td>  
              <td style='vertical-align: middle;'>
                <a href="/goods/read.do?goodsno=${goodsno}"><strong style="margin-right:60%;">${gname}</strong></a> 
              </td> 
              <td style='vertical-align: middle; text-align: center;'>
                <del><fmt:formatNumber value="${price}" pattern="#,###원" /></del><br>
                <span style="color: #FF0000; font-size: 1.2em;">${dc} %</span>
                <strong><fmt:formatNumber value="${saleprice}" pattern="#,###원" /></strong><br>
                <img src="/cart/images/point.png" class="icon">
                <span style="font-size: 0.8em;"><fmt:formatNumber value="${point}" pattern="#,###" />원 (2%)</span>
              </td>
              <td style='vertical-align: middle; text-align: center;'>
              <%-- 레코드에 따라 ID를 고유하게 구분할 목적으로 id 값 생성, 예) 1_cnt, 2_cnt, c_cnt... --%>
                <input type='number' id='${cartno }_cnt' min='1' max='100' step='1' value="${cnt }" style='width: 52px;'><br>
                <button type='button' onclick="update_cnt(${cartno})" class='btn btn-outline-dark btn-sm' style='margin-top: 5px;'>변경</button>
              </td>
              <td style='vertical-align: middle; text-align: center;'>
                <strong><fmt:formatNumber value="${tot}" pattern="#,###원" /></strong>
              </td>
              <td style='vertical-align: middle; text-align: center;'>
                <A href="javascript: delete_func(${cartno })"><IMG src="/wish/images/de2.png" class="icon"></A>
              </td>
            </tr>
          </c:forEach>
        
        </c:when>
        <c:otherwise>
          <tr>
            <td colspan="6" style="text-align: center; font-size: 1.3em;">쇼핑 카트에 상품이 없습니다.</td>
          </tr>
        </c:otherwise>
      </c:choose>
      
      
    </tbody>
  </table>
  
  <table class="table table-striped" style='margin-top: 50px; margin-bottom: 50px; width: 100%;'>
    <tbody>
      <tr>
        <td style='width: 50%;'>
          <div class='cart_label'>상품 금액</div>
          <div class='cart_price'><fmt:formatNumber value="${tot_sum }" pattern="#,###" /> 원</div>
          
          <div class='cart_label'>추가 적립금</div>
          <div class='cart_price'><fmt:formatNumber value="${point_tot }" pattern="#,###" /> 원 </div>
          

          
          <div class='cart_label'>배송비</div>
          <div class='cart_price'><fmt:formatNumber value="${baesong_tot }" pattern="#,###" /> 원</div>
        </td>
        <td style='width: 50%;'>
          <div class='cart_label' style='font-size: 2.0em;'>전체 주문 금액</div>
          <div class='cart_price'  style='font-size: 2.0em; color: #FF0000; margin-bottom:13px;'><fmt:formatNumber value="${total_order }" pattern="#,###" /> 원</div>
          
          <form name='frm' id='frm' style='margin-top: 50px;' action="/pay/create.do" method='get'>
            <c:choose>
              <c:when test="${total_order == 0}">
              <br>
               <div style='font-size: 1.5em; text-align: right; color: #FF0000;'>상품을 선택해주세요.</div>
              </c:when>
              <c:when test="${g_cnt - cnt < 0 }">
               <div style='font-size: 1.5em; text-align: right; color: #FF0000;'>상품이 선택하신 수량보다 적습니다.</div>
              </c:when>
              <c:otherwise>
                <button type='submit' id='btn_order' class='btn btn-dark ' style='font-size: 1.5em; margin-right:0.5%; width:80%; height:60px;'>주문하기</button>
              </c:otherwise>
            </c:choose>
          </form>
        <td>
      </tr>
    </tbody>
  </table>   
</DIV>
   <!-- 플로팅 메뉴 -->
<style>
    .float {
        position: fixed;
        bottom: 30px;
        right: 20px;
        z-index: 999;
    }
</style>

<div class="float">
    <div class="btn-group-vertical">
      <c:choose>
        <c:when test="${sessionScope.id != null }">
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';" onclick="location.href='../cart/list_by_memberno.do'">장바구니</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';" onclick="location.href='../recom/memberList.do?memberno=${memberno}'">저장한 레시피</button>
          <button type="button"class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"  onclick="location.href='../pay/pay_list.do'">주문내역</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='../qna/list_by_search.do'">고객상담</button>
        </c:when>
        <c:otherwise>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='../member/create.do'">회원가입</button>
          <button type="button" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" 
          onmouseout="this.style.backgroundColor='transparent';"onclick="location.href='../qna/list_by_search.do'">고객상담</button>
        </c:otherwise>
      </c:choose>
    </div>
</div>

<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>