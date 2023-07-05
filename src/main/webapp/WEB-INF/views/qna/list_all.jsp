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
<DIV>
    <img src="/menu/images/qna1.png" class="icon0" style='margin-left:10px; margin-right:10px; margin-bottom: 7px;'> <span style='font-size: 30px;'>전체 Q&A 상담</span>
</DIV> 
  <ASIDE class="aside_right">
  <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
  
    <c:choose>
      <c:when test="${sessionScope.id != null }">
        <A href="./create.do"> ✒️Q&A 등록</A>
        <span class='menu_divide' >│</span>
      </c:when>
    </c:choose>
    <A href="javascript:location.reload();">🔄새로고침</A>
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_search.do'>
      
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input maxlength="100" type='text' name='word' id='word' value='${param.word }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input maxlength="100" type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type="submit" class="btn0 btn0-custom btn-sm">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type="button" class="btn0 btn0-custom btn-sm" 
        onclick="location.href='./list_by_search.do'">검색 취소</button>
      </c:if>
          <style>
          .btn0-custom {
            background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
            color: white; /* 버튼 텍스트 색상 설정 (선택적) */
            border: white;
            }
          </style>
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <table class="table table-striped">
    <colgroup>
    <c:choose>
        <c:when test="${sessionScope.id != null }">
      <col style="width: 30%; "></col>
      <col style="width: 40%;"></col>
      <col style="width: 1%;"></col>
      <col style="width: 29%;"></col>
        </c:when>
    </c:choose>
    
    </colgroup>

    <thead>
      <tr>
        <th style="text-align: center;">Q&A</th>
        <th style="text-align: center;">제목</th>
        <th style="text-align: center;"></th>
        <th style="text-align: center;">등록 날짜</th>
      </tr>
    </thead>

 
<tbody>
  <c:forEach var="qnaVO" items="${list}" varStatus="loop">
    <c:set var="title" value="${qnaVO.title}" />
    <c:set var="content" value="${qnaVO.content}" />
    <c:set var="qnano" value="${qnaVO.qnano}" />
    <c:set var="rdate" value="${qnaVO.rdate.substring(0, 10)}" />
    <c:set var="mname" value="${qnaVO.mname}" />

    <tr style="height: 50px;">
      <td style='vertical-align: middle; text-align: center;'>
        ${mname} 님 질문
      </td>
      <td style='vertical-align: middle; text-align: center;'>
        <a href="./read.do?qnano=${qnano}&now_page=${param.now_page == null?1:now_page}" style="display: block;">
          <div style='font-weight:bold;'>${title}</div>
        </a>
      </td>
      <td style='vertical-align: middle; text-align: center;'>

      </td>
      <td style='vertical-align: middle; text-align: center;'>
        <div>${rdate}</div>
      </td>
    </tr>

    <c:forEach var="answerVO" items="${list2}" varStatus="loop">
      <c:if test="${answerVO.qnano == qnano}">
        <c:set var="answer_no" value="${answerVO.answer_no}" />
        <c:set var="title" value="${answerVO.title}" />
        <c:set var="aname" value="${answerVO.aname}" />
        <c:set var="text" value="${answerVO.text}" />
        <c:set var="rdate" value="${answerVO.rdate.substring(0, 10)}" />

        <tr style="height: 50px;">
          <td style='vertical-align: middle; text-align: center;'>
              <img src="/menu/images/ddq.png" class="icon4"> ${aname }의 답변
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <a href="../answer/read.do?answer_no=${answer_no}&now_page=${param.now_page == null ? 1 : now_page}" style="display: block;">
              <div style='font-weight:bold;'>${title}</div>
            </a>
          </td>
          <td style='vertical-align: middle; text-align: center;'>

          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <div>${rdate}</div>
          </td>
        </tr>
      </c:if>
    </c:forEach>
  </c:forEach>
</tbody>

</table>
  
     <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
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