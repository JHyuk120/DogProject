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
<c:set var="gname" value="${recipeVO.gname }" />
<c:set var="ingredient" value="${recipeVO.ingredient }" />
<c:set var="article" value="${recipeVO.article }" />
<c:set var="youtube" value="${recipeVO.youtube }" />
<c:set var="word" value="${recipeVO.word }" />
<c:set var="size1_label" value="${recipeVO.size1_label }" />
<c:set var="rdate" value="${recipeVO.rdate.substring(0,16) }" />
<c:set var="recom" value="${recipeVO.recom }" />
<c:set var="time" value="${recipeVO.time }" />
<c:set var="difficulty" value="${recipeVO.difficulty }" />

 
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
<A href="./list_by_itemno.do?itemno=${itemno }" class='title_link' style='background-color:#FEFCF0; margin-left: 280px; font-size: 25px;'><img src="/menu/images/menu2.png" class="icon0"> ${itemVO.item } 레시피</A></DIV>

<DIV class='content_body'  style='background-color:#FEFCF0;'>
  <ASIDE class="aside_right">

    <c:if test="${sessionScope.id != null }">
      <%--
      http://localhost:9091/recipe/create.do?itemno=1
      http://localhost:9091/recipe/create.do?itemno=2
      http://localhost:9091/recipe/create.do?itemno=3
      --%>
      <A href="./create.do?itemno=${itemVO.itemno }">등록</A>
      <span class='menu_divide' >│</span>
      <A href="./update.do?recipeno=${recipeno}&now_page=${param.now_page == null ? 1 : param.now_page }&word=${param.word}">수정</A>
      <span class='menu_divide' >│</span>
      <A href="./delete.do?recipeno=${recipeno}&now_page=${param.now_page == null ? 1 : param.now_page }&itemno=${param.itemno}">삭제</A>  
    <span class='menu_divide' >│</span>
    </c:if>

    <A href="./list_by_itemno.do?itemno=${recipeVO.itemno }&now_page=${param.now_page == null?1:param.now_page}&word=${param.word }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_itemno_grid.do?itemno=${itemno }&now_page=${param.now_page == null?1:param.now_page}&word=${param.word }">갤러리형</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>

   
  </ASIDE> <br>
  
  <DIV class='menu_line'></DIV><br>
  
            <span style="font-size: 1.7em; font-weight: bold;">${title }</span>
                      <div style="font-size: 0.8em; margin-left: 78%;">${mname } / ${rdate }</div> <br>
                      
                      <!-- 좋아요 -->


<div style="display: flex; justify-content: flex-end; align-items: center; margin-right: 50px;">
  <form name="frm" action="/recom/create.do" method="POST">
    <input type="hidden" name="recipeno" value="${recipeno}" />
    <input type="hidden" name="check" value="${check}" />

    <c:choose>
     <c:when test="${sessionScope.adminno != null}">
        <button type="submit" id="recom" class="btn btn-outline-danger btn-sm" style="font-size: 0.8em;"title="저장">
        <img src="/recipe/images/save.png" class="icon" style="width:25px; margin-bottom:3px;">${recom}</button> 
      </c:when>
      <c:when test="${sessionScope.memberno == null}">
        <button type="submit" id="recom" class="btn btn-outline-danger btn-sm" style="font-size: 0.8em;"title="저장">
        <img src="/recipe/images/save.png" class="icon" style="width:25px; margin-bottom:3px;">${recom}</button> 
      </c:when>
      <c:when test="${check == 1}">
        <button type="submit" id="recom" class="btn btn-outline-danger btn-sm" style="font-size: 0.8em;"title="저장취소">
        <img src="/recipe/images/pullsave.png" class="icon" style="width:25px; margin-bottom:3px;"> ${recom}</button>
      </c:when>
      <c:otherwise>
        <button type="submit" id="recom" class="btn btn-outline-danger btn-sm" style="font-size: 0.8em;"title="저장">
         <img src="/recipe/images/save.png" class="icon" style="width:25px; margin-bottom:3px;"> ${recom}</button>
      </c:otherwise>
    </c:choose>
  </form>

 <button onclick="sharePage()" class="btn btn-outline-secondary btn-sm" style="font-size: 0.8em; margin-left: 10px;"title="링크복사">
  <img src="/recipe/images/gong.png" class="icon" style="width:25px; margin-bottom:3px;"></button>
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


    <ul>
      <li class="li_none">
        <DIV style="width:100%;">
          <c:choose>
            <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/recipe/storage/ --%>
                <IMG src="/dogproject/storage/${file1saved }" 
                style="width: 25%; height: 250px; float:left; margin-top: 1%; margin-right: 20px; margin-left: 6%; margin-bottom: 5px;'"> 
            </c:when>
            <c:otherwise> <!-- 기본 이미지 출력 -->
                <img src="/goods/images/ee.png" 
                style="width: 25%; height: 250px; float: left; margin-top: 1%; margin-right:5%; margin-left: 6%; margin-bottom: 5px;"> 
            </c:otherwise>
            </c:choose>

<div style="float: left; margin-left: 10%; margin-bottom: 2%; width: 53%;  height: 50px; background-color: #FBFCF5; text-align: left;">
  <span style="font-size: 1.2em; margin-right: 2%; margin-left: 11%; color: #78776C;">🤍소요시간🤍</span>
  <span style="font-size: 1.2em; margin-right: 9%; color: #78776C;">${time}</span>
  <span style="font-size: 1.2em; margin-right: 2%; color: #78776C;">🤍난이도🤍</span>
  <span style="font-size: 1.2em; color: #78776C;">${difficulty}</span>
</div>


</div><br>

            
<div style="float: left; margin-left: 10%; margin-bottom: 13%; width: 53%; background-color: #FBFCF5;">
  🤍재료박스🤍<br><br>
  <form name="frm" action="/cart/create.do" method="POST">
    <input type="hidden" name="recipeno" value="${recipeno}" />
    <table class="table">
      <tbody>
        <c:forEach var="map" items="${map}" varStatus="loop">
          <c:if test="${loop.index % 4 == 0}">
            <tr>
          </c:if>
          <input type="hidden" name="title" value="${map.key}" />
          <td>${map.key}</td>
          <td>
            <button type="button" id="${map.value}" onclick="cart_ajax_post(${map.value})" class="btn btn-sm btn-custom" style="border: 2px solid #FFDAD5; color: #78776C;" onmouseover="this.style.backgroundColor='#FFDAD5';" onmouseout="this.style.backgroundColor='transparent';">
              담기
            </button>
          </td>
          <c:if test="${loop.index % 4 == 3 || loop.last}">
            </tr>
          </c:if>
        </c:forEach>
      </tbody>
    </table>
  </form>
</div>


  <span style="font-size:1.2em; margin-right: 2%; margin-left: 3%; margin-bottom: 1%;" >🤍레시피 요약🤍</span>
  <br>
<div style="float: left; margin-left: 8%; margin-bottom: 2%; width: 90%;  height: 100px; overflow: auto;
background-color: #FBFCF5; text-align: left; border-radius: 10px; border: 1px solid #FFDAD5;">

  <span style="font-size:0.8em; margin-right: 2%; margin-left: 5%; margin-bottom: 5%;" >${article} </span>
</div>
<br>

     <!--<c:if test="${youtube.trim().length() > 0 }">
          <li class="li_none" style="clear: both; padding-top: 15px; padding-bottom: 15px;">
                  <DIV style='width:640px; height: 380px; margin: 0px auto;'>
                    ${youtube }
                  </DIV>
          </li>
      </c:if> -->
   <span style="font-size:1.2em; margin-right: 2%; margin-left: 3%;" >🤍조리순서🤍</span>       
<DIV style="width:100%; ">

    <c:forEach var="cook_multiVO" items="${list2}">
      <c:set var="cookfile" value="${cook_multiVO.cookfile }" />
      <c:set var="cookfilesaved" value="${cook_multiVO.cookfilesaved }" />
      <c:set var="thumb" value="${cook_multiVO.thumb }" />
      <c:set var="exp" value="${cook_multiVO.exp }" />
     
      <div style="display: flex;">
        <div style="width: 20%; float: left; margin-top: 0.2%; margin-right: 7%; margin-left: 12%; margin-bottom: 2%;">
    		  <c:choose>
    		    <c:when test="${thumb.endsWith('jpg') || thumb.endsWith('png') || thumb.endsWith('gif')}">
    		      <%-- /static/recipe/storage/ --%>
    		      <img src="/dogproject/storage/${thumb}" style="width: 100%; height: 160px;  border-radius: 10px;">
        		</c:when>
        		  <c:otherwise> <!-- 기본 이미지 출력 -->
        		    <img src="/goods/images/ee.png" style="width: 100%; height:  160px; #FFDAD5; border-radius: 10px;">
    		      </c:otherwise>
    		    </c:choose>
        </div>
        <div style="width: 60%; height: 160px; border: 1px solid #FFDAD5; margin-top: 0.5%; margin-right: 5%; 
                    margin-bottom: 5px; overflow: auto; border-radius: 10px; ">
            ${exp}
        </div>
      </div>    
  </c:forEach>
</DIV>

     <li class="li_none" style="clear: both;">
          🤍검색어🤍: ${word }
        </DIV>
      </li>



 
<!-- 댓글 조회 -->
<jsp:include page="../reply/reply_read.jsp"  flush='true'/>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>