<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="recipeno" value="${recipeVO.recipeno }" />
<c:set var="itemno" value="${recipeVO.itemno }" />
<c:set var="ingredient" value="${recipeVO.ingredient }" />
<c:set var="title" value="${recipeVO.title }" />        
<c:set var="file1" value="${recipeVO.file1 }" />
<c:set var="file1saved" value="${recipeVO.file1saved }" />
<c:set var="thumb1" value="${recipeVO.thumb1 }" />
<c:set var="ingredient" value="${recipeVO.ingredient }" />
<c:set var="article" value="${recipeVO.article }" />
<c:set var="youtube" value="${recipeVO.youtube }" />
<c:set var="word" value="${recipeVO.word }" />
<c:set var="size1_label" value="${recipeVO.size1_label }" />
<c:set var="rdate" value="${recipeVO.rdate.substring(0,16) }" />
<c:set var="recom" value="${recipeVO.recom }" />



 
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

<script type="text/javascript">

<!--댓글 등록시 로그인 여부 확인 -->
function checkLoginStatus() {
    var isMemberLoggedIn = ${sessionScope.id != null};
    
    // 일반 사용자가 로그인한 경우 댓글을 작성할 수 있음
    if (!isMemberLoggedIn) {
        // 로그인하지 않은 상태이므로 폼 제출을 방지하고 로그인 알림을 표시
        
        alert('로그인이 필요합니다.');
        window.location.href = "../member/login.do";
        return false; // 폼 제출 중단
    }
    return true; // 폼 제출 진행
}

// 레시피에서 구매 Ajax
function cart_ajax_post(goodsno) {
    //var f = $('#frm_order');
    //var cntc = $('#cntc', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
    let cntc = 1;
    var params = "";
    // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params += 'goodsno=' + goodsno + '&cntc=' + cntc;
    // alert('-> cart_ajax_post: ' + params);
    // return;
    // 쇼핑카트 등록시 사용할 상품 번호.

    $.ajax(
      {
        url: '/cart/create.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,     // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          // console.log('-> cart_ajax_post cnt: ' + rdata.cnt);  // 1: 쇼핑카트 등록 성공
          
          if (rdata.cnt == 1) {
        	   alert('상품이 장바구니에 담겼습니다.')
          } else {
            alert('선택한 상품을 장바구니에 담지못했습니다.<br>잠시후 다시 시도해주세요.');
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

  }    

</script>

</head>

<style>
  .content_body {
    width: 100%;
    max-width: 1200px;
    text-align: center;
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
 
<body style="background-color: #FEFCE6;">
<c:import url="/menu/top.do" />
 
<br>
<A href="./list_by_itemno.do?itemno=${itemno }" class='title_link'  style='background-color:#FEFCF0; margin-left: 280px;'><img src="/menu/images/menu2.png" class="icon0"> ${itemVO.item } 레시피</A></DIV>

<DIV class='content_body'  style='background-color:#FEFCF0;'>
  <ASIDE class="aside_right">
    <%-- 관리자로 로그인해야 메뉴가 출력됨 --%>
    <c:if test="${sessionScope.id != null }">
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
      <button type="submit" class="btn btn-custom btn-sm">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type="button" class="btn btn-custom btn-sm" onclick="location.href='./list_by_itemno.do?itemno=${itemVO.itemno}&word='">검색 취소</button>
      </c:if>
      <style>
      .btn-custom {
        background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
        color: white; /* 버튼 텍스트 색상 설정 (선택적) */
      }
      </style>
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV><br>
  
            <span style="font-size: 1.7em; font-weight: bold;">${title }</span>
                      <div style="font-size: 0.7em;">${mname } ${rdate }</div> <br>
                      
                      <!-- 좋아요 -->


<div style="display: flex; justify-content: flex-end; align-items: center; margin-right: 50px;">
  <form name="frm" action="/recom/create.do" method="POST">
    <input type="hidden" name="recipeno" value="${recipeno}" />
    <input type="hidden" name="check" value="${check}" />

    <c:choose>
      <c:when test="${sessionScope.adminno != null}">
        <button type="submit" id="recom" class="btn btn-outline-danger btn-sm" style="font-size: 0.8em;">🤍 ${recom}</button>
      </c:when>
      <c:when test="${sessionScope.memberno == null}">
        <button type="submit" id="recom" class="btn btn-outline-danger btn-sm" style="font-size: 0.8em;">🤍 ${recom}</button>
      </c:when>
      <c:when test="${check == 1}">
        <button type="submit" id="recom" class="btn btn-danger btn-sm" style="font-size: 0.8em;">❤️ ${recom}</button>
      </c:when>
      <c:otherwise>
        <button type="submit" id="recom" class="btn btn-outline-danger btn-sm" style="font-size: 0.8em;">🤍 ${recom}</button>
      </c:otherwise>
    </c:choose>
  </form>

  <button onclick="sharePage()" class="btn btn-outline-secondary btn-sm" style="font-size: 0.8em; margin-left: 10px;">공유하기</button>

  <script>
    function sharePage() {
      const url = window.location.href;
      navigator.clipboard.writeText(url)
        .then(() => {
          alert('현재 보고 있는 페이지 주소가 복사되었습니다.');
        })
        .catch((error) => {
          console.error('페이지 주소 복사 실패:', error);
        });
    }
  </script>
</div>
<br>

<fieldset class="fieldset_basic" style='background-color:#FEFCF0;'>
    <ul>
      <li class="li_none">
        <DIV style="width:100%;">
          <c:choose>
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/recipe/storage/ --%>
                <IMG src="/dogproject/storage/${file1saved }" 
                style="width: 25%; height: 250px; float:left; margin-top: 0.5%; margin-right: 20px; margin-left: 20px; margin-bottom: 5px;'"> 
            </c:when>
            <c:otherwise> <!-- 기본 이미지 출력 -->
                <img src="/goods/images/ee.png" 
                style="width: 25%; height: 250px; float: left; margin-top: 0.5%; margin-right:5%; margin-left: 20px; margin-bottom: 5px;"> 
            </c:otherwise>
            </c:choose>
            
            
            <div style='float: left; margin-left: 110px'>🍚재료🍚<br><br>
              <form name="frm" action="/cart/create.do" method="POST">
                  <input type="hidden" name="recipeno" value="${recipeno}" />
                  
                <table class="table table">
                  <c:forEach var="map" items="${map}">
                    <input type="hidden" name="title" value="${(map.key)}" />
                    <tbody>
                      <tr>
                        <th>${(map.key)}</th>
                        <th><button type=button id=${(map.value)} onclick="cart_ajax_post(${map.value})" style='border-radius: 10px;'>담기</button></th>
                      </tr>
                    </tbody>
                  </c:forEach>
                </table>
              </form>
            </div><br>          
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
        <DIV style='text-decoration: none;'>🍚조리순서🍚
            <br>
            ${article }
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

 
<!-- 댓글 조회 -->
<jsp:include page="../reply/reply_read.jsp"  flush='true'/>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>