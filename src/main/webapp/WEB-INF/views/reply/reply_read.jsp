<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="replycont" value="${replyVO.replycont}" />
<c:set var="replyno" value="${replyVO.replyno}" />
<c:set var="recipeno" value="${recipeVO.recipeno }" />


 
<!DOCTYPE html> 
<html lang="ko"> 
 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 

<link href="/css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript" src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


</head>  
 
<body style="background-color: #FEFCE6;">
<br>


<%-- 댓글 조회 --%>

 <FORM name='frm' method='POST' action='../reply/reply_create.do' enctype="multipart/form-data"  onsubmit="return checkLoginStatus();">
    <input type="hidden" name="recipeno" value="${recipeno}"/><!-- 현재 recipe의 recipeno -->
    <input type="hidden" name="memberno" value="${sessionScope.memberno}"/>
    <input type="hidden" name="id" value="${sessionScope.id}"/>
   <div style='width: 70%; table-layout: fixed; margin: 0 auto;'> 
      <img src="/recipe/images/comm.png" class="icon3" > 댓글 ${replycnt.replycnt } 

    </div>   <br>
  <div style='width: 70%; max-width: 70%; margin:0 auto; '>
    <textarea name='replycont' required="required" rows="2" cols="145"  style='background-color:#FEFCF0; width: 100%;'></textarea>
    
    <br>
   <button type='submit' class='btn btn-outline-dark btn-sm' style='margin-left: 92%; margin-top: 0.5%; width:7%;'>댓글 등록</button>
  </div>
 </FORM>    
    <br>

 
 <!-- 댓글 목록 -->
 <br>
<table class="table table-striped" style='width: 70%; table-layout: fixed; margin: 0 auto; background-color: #FEFCF0;'>

    <colgroup>
              <col style="width: 10%;"></col>
              <col style="width: 70%;"></col>
              <col style="width: 10%;"></col>
              <col style="width: 10%;"></col>
    </colgroup>

    <thead>
      <tr>
        <th style='text-align: center;'>작성자</th>
        <th style='text-align: center;'>댓글</th>
        <th style='text-align: center;'>작성일</th>
        <th style='text-align: center;'>수정 / 삭제</th>
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
          
          <td style='vertical-align: middle; text-align: center;' >
            <div>${replycont}</div>
          </td> 
          
          <td style='vertical-align: middle; text-align: center;'>
            <div>${rdate}</div>
          </td>
          
  
          
          <td style='vertical-align: middle; text-align: center;'>
            <div><a href="/reply/update.do?recipeno=${recipeno }&replyno=${replyVO.replyno}">수정 </a>/<a href="/reply/delete.do?recipeno=${recipeno }&replyno=${replyVO.replyno}" onclick="return confirm('리뷰를 삭제하시겠습니까?')"> 삭제</a></div>
          </td>
        </tr>
      </c:forEach>

    </tbody>
  </table>
     <c:choose>
     <c:when test="${replycnt.replycnt == 0 }">
        <tr style="height: 112px;" class='hover'>
           <td style='vertical-align: middle; text-align: center;' colspan='6'>
               <div class="empty-review-message">
                   <p>작성된 댓글이 없습니다.</p>
               </div>
           </td>
        </tr>
        <style>
           .empty-review-message {        
               padding: 20px;
               text-align: center;
           }
           
           .empty-review-message p {
               color: #888;
               font-size: 18px;
               font-weight: bold;
               margin: 0;
           }
        </style>
   </c:when>
   </c:choose>
    <!-- 페이지 목록 출력 부분 시작 -->
  <DIV class='bottom_menu'>${paging }</DIV> <%-- 페이지 리스트 --%>
  <!-- 페이지 목록 출력 부분 종료 -->
  
</body>
 
</html>