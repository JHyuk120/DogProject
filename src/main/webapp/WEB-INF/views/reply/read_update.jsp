<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="recipeno" value="${recipeVO.recipeno }" />
<c:set var="itemno" value="${recipeVO.itemno }" />
<c:set var="title" value="${recipeVO.title }" />        
<c:set var="file1" value="${recipeVO.file1 }" />
<c:set var="file1saved" value="${recipeVO.file1saved }" />
<c:set var="thumb1" value="${recipeVO.thumb1 }" />
<c:set var="article" value="${recipeVO.article }" />
<c:set var="youtube" value="${recipeVO.youtube }" />
<c:set var="word" value="${recipeVO.word }" />
<c:set var="size1_label" value="${recipeVO.size1_label }" />
<c:set var="rdate" value="${recipeVO.rdate.substring(0,16) }" />
 <c:set var="replycont" value="${replyVO.replycont}" />
<c:set var="replyno" value="${replyVO.replyno}" />

 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Daeng Kit</title>
 
<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script type="text/javascript">
<!--댓글 등록시 로그인 여부 확인 -->
    function checkLoginStatus() {
        var isLoggedIn = ${sessionScope.id != null}; // 로그인 상태 확인
        if (!isLoggedIn) {
            // 로그인하지 않은 상태이므로 폼 제출을 방지하고 로그인 알림을 표시
            alert('로그인이 필요합니다.');
            return false; // 폼 제출 중단
        }
        return true; // 폼 제출 진행
    }

    function confirmDelete(recipeno, replyno) {
        if (confirm("리뷰를 삭제하시겠습니까?")) {
            location.href = './delete.do?recipeno=${recipeno}&replyno=${replyno}';
        } else {

        }
    }
    
</script>

</head> 
 
<body>
<c:import url="/menu/top.do" />
 
<DIV class='title_line'><A href="./list_by_itemno.do?itemno=${itemno }" class='title_link'>${itemVO.item }</A></DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.admin_id != null }">
      <%--
      http://localhost:9091/recipe/create.do?itemno=1
      http://localhost:9091/recipe/create.do?itemno=2
      http://localhost:9091/recipe/create.do?itemno=3
      --%>
      <A href="./create.do?itemno=${itemVO.itemno }">등록</A>
      <span class='menu_divide' >│</span>
	    <A href="./update_text.do?recipeno=${recipeno}&now_page=${param.now_page == null ? 1 : param.now_page }&word=${param.word}">글 수정</A>
	    <span class='menu_divide' >│</span>
	    <A href="./update_file.do?recipeno=${recipeno}&now_page=${param.now_page == null ? 1 : param.now_page }">파일 수정</A>  
	    <span class='menu_divide' >│</span>
      <A href="./youtube.do?recipeno=${recipeno}">유튜브</A> 
      <span class='menu_divide' >│</span>
	    <A href="./delete.do?recipeno=${recipeno}&now_page=${param.now_page == null ? 1 : param.now_page }&itemno=${param.itemno}">삭제</A>  
    <span class='menu_divide' >│</span>
    </c:if>

    <A href="./list_by_itemno.do?itemno=${recipeVO.itemno }&now_page=${param.now_page == null?1:param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${itemno }&now_page=${param.now_page == null?1:param.now_page}&word=${param.word }">갤러리형</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>

   
  </ASIDE> 
  
  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_itemno.do'>
      <input type='hidden' name='itemno' value='${itemVO.itemno }'>  <%-- 게시판의 구분 --%>
      
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' class='input_word'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' class='input_word'>
        </c:otherwise>
      </c:choose>
      <button type='submit'class='btn btn-info'>검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_itemno.do?itemno=${itemVO.itemno}&word='"class='btn btn-info'>검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>

  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <DIV style="width:100%;">
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/recipe/storage/ --%>
                <img src="/dogproject/storage/${file1saved }" style='width: 50%; float:left; margin-top:0.5%; margin-right:1%'> 
              </c:when>
              <c:otherwise> <!-- 기본 이미지 출력 -->
                <img src="/recipe/images/none1.png" style='width: 50%; float:left; margin-top:0.5%; margin-right:1%'> 
              </c:otherwise>
            </c:choose>
          
         <span style="font-size: 1.5em; font-weight: bold;">${title }</span><br>
         <div style="font-size: 0.7em;">${mname}${rdate }</div><br>
        ${article }
        </DIV>
      </li>
      
      <c:if test="${youtube.trim().length() > 0 }">
          <li class="li_none" style="clear: both; padding-top: 15px; padding-bottom: 15px;">
                  <DIV style='width:640px; height: 380px; margin: 0px auto;'>
                    ${youtube }
                  </DIV>
          </li>
      </c:if>
        
     <li class="li_none" style="clear: both;">
        <DIV style='text-decoration: none;'>
        <br>
          검색어(키워드): ${word }
        </DIV>
      </li>
      <li class="li_none">
        <DIV>
          <c:if test="${file1.trim().length() > 0 }">
            첨부 파일: <A href='/download?dir=/recipe/storage&filename=${file1saved}&downname=${file1}'>${file1}</A> (${size1_label})  
          </c:if>
         
        </DIV>
      </li>   
    </ul>
  </fieldset>
</DIV>
<%-- 댓글 조회 --%>

 <FORM name='frm' method='POST' action='../reply/update.do' enctype="multipart/form-data"  onsubmit="return checkLoginStatus();">
    <input type="hidden" name="recipeno" value="${recipeno}"/><!-- 현재 recipe의 recipeno -->
     <input type="hidden" name="replyno" value="${replyno}"/>
    <input type="hidden" name="memberno" value="${sessionScope.memberno}"/>
    <input type="hidden" name="id" value="${sessionScope.id}"/>
    <td>
      <textarea name='replycont' required="required" rows="7" cols="63">${replyVO.replycont }</textarea>
    </td>
  
   <button type='submit' class='btn btn-info btn-sm'>리뷰 수정</button>
   <button type='button' onclick="confirmDelete(${recipeno}, ${replyno})" class='btn btn-info btn-sm'>리뷰 삭제</button>
 </FORM>    
 
 <!-- 댓글 목록 -->
   <table class="table table-striped" style='width: 100%; table-layout: fixed;'>
    <colgroup>
      <c:choose>
          <c:when test="${sessionScope.admin_id != null}">
              <col style="width: 10%;"></col>
              <col style="width: 70%;"></col>
              <col style="width: 10%;"></col>
              <col style="width: 10%;"></col>
          </c:when>

      </c:choose>

    </colgroup>

    <thead>
      <tr>
        <th style='text-align: center;'>id</th>
        <th style='text-align: center;'>리뷰</th>
        <th style='text-align: center;'>작성일</th>
        <th style='text-align: center;'>수정/삭제</th>
      </tr>
     <tbody>
      <c:forEach var="replyVO" items="${list}">
        <c:set var="replycont" value="${replyVO.replycont}" />
        <c:set var="rdate" value="${replyVO.rdate}" />
         <c:set var="mid" value="${memberVO.id}" />
         
        <tr style="height: 112px;"  class='hover'>
          
          <td style='vertical-align: middle; text-align: center;'>
           <div> ${replyVO.mid }</div>
          </td>  
          
          <td style='vertical-align: middle;'>
            <div>${replycont}</div>
          </td> 
          
          <td style='vertical-align: middle;'>
            <div>${rdate}</div>
          </td>
          <td style='vertical-align: middle;'>
            <div><a href="/reply/update.do?recipeno=${recipeno }&replyno=${replyVO.replyno}">수정</a>/<a href="/reply/delete.do?recipeno=${recipeno }&replyno=${replyVO.replyno}" onclick="return confirm('리뷰를 삭제하시겠습니까?')">삭제</a></div>
          </td>
          
          
        </tr>
      </c:forEach>

    </tbody>
  </table>
    <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>