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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/i18n/datepicker-ko.js"></script>
<style>
    .btn-custom {
      background-color: #B6EADA; /* 원하는 색상 코드로 변경 */
      color: white; /* 버튼 텍스트 색상 설정 (선택적) */
    }
 </style>
 
<script>
  $( function() {
    $( "#datepicker" ).datepicker({
        dateFormat: "yy-mm-dd",
        closeText: "닫기",
        prevText: "이전달",
        nextText: "다음달",
        currentText: "오늘",
        monthNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
        dayNamesMin: ["일","월","화","수","목","금","토"]
    });
  } );

  function clearFileInput(file1MF) {
	  file1MF.value = "";
	  }
</script>
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
  .gallery_item {
    width: 22%;
    height: 300px;
    margin: 1.5%;
    padding: 0.5%;
    text-align: center;
  }
    </style>
    
</head> 
<body>
<c:import url="/menu/top.do" />
 
  <DIV class='content_body'>
  <DIV>
    <span style='font-size: 30px; margin-left: 35%;'>🥗 ${itemVO.item  } > 글 등록</span>
</DIV> 
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">🔄 새로고침</A>
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
      <button type='submit' class='btn btn-custom btn-sm'  >검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' class='btn btn-custom btn-sm' 
                     onclick="location.href='./list_by_itemno.do?itemno=${itemVO.itemno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <FORM name='frm' method='POST' action='./create.do' enctype="multipart/form-data">
    <input type="hidden" name="itemno" value="${param.itemno }">
    
    <div>
       <label>재료 이름</label>
       <input type='text' name='gname' value='' required="required" 
                 autofocus="autofocus" class="form-control" style='width: 30%;' maxlength='50'><br>
    </div>

    <div class="row" style='width:60% '>
      <div class="col-sm-4">
        <label for="price">가격</label>
        <input type="number" class="form-control" id="price" name="price" value="" maxlength='10'>
      </div>
      <div class="col-sm-4">
        <label for="dc">DC</label>
          <div class="input-group">
            <input type="number" class="form-control" id="dc" name="dc" min="0" max="100" value="10" maxlength='10'>
            <div class="input-group-append">
              <span class="input-group-text">%</span>
            </div>
          </div>
        </div>
        <div class="col-sm-4">
          <label for="cnt">수량</label>
          <input type="number" class="form-control" id="cnt" name="cnt" value="100" min="0" style='width:80%' maxlength='7'>
        </div>
        <div class="col-sm-4">
          <label for="cnt">원산지</label>
          <input type="text" class="form-control" id="origin" name="origin" value="국산" style='width:80%'maxlength='30'>
        </div>
        <div class="col-sm-4">
          <label for="cnt">유통기한</label>
          <input type="date" class="form-control" id="exdate" name="exdate" id="datepicker" style='width:80%' maxlength='16'>
        </div>
        <div class="col-sm-4">
          <label for="cnt">보관방법</label>
          <input type="text" class="form-control" id="storage" name="storage" value="냉장/냉동/실온" style='width:80%' maxlength='20'>
        </div>
        <div class="col-sm-4">
          <label for="cnt">그램 수</label>
          <div class="input-group">
          <input type="number" class="form-control" id="grams" name="grams" value="100" min="1" style='width:80%' maxlength='5'>
           <div class="input-group-append">
              <span class="input-group-text">g</span></div>
           </div>
        </div>
    </div>
    <br>
    
    <div>
       <label>내용</label>
       <textarea name='content' required="required" class="form-control" rows="12" style='width: 100%;'></textarea><br>
    </div>
    
    <div>
       <label>검색어</label>
       <input type='text' name='word' value='해시태그' required="required" 
                 class="form-control" style='width: 100%;' maxlength='100'><br>
    </div>   
    <div>
       <label>이미지</label>
       <input type='file' class="form-control" name='file1MF' id='file1MF' 
                 value='' placeholder="파일 선택"><br>
       <button type="button" onclick="clearFileInput(document.getElementById('file1MF'));" 
                                  class="btn btn-sm btn-outline-dark" style= "margin-left: 80%;">파일 초기화</button>
    </div>  
     
    <div >
      <button type="submit" class="btn btn-dark" style="margin-left: 89%;">등록</button>
      <button type="button" onclick="location.href='./list_by_itemno.do?itemno=${param.itemno}'" class="btn btn-outline-dark">목록</button>
    </div>
  
  </FORM>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>