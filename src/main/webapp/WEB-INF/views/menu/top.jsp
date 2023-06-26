<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page import="java.util.ArrayList" %>
<%@ page import="dev.mvc.item.ItemVO" %>

<DIV class='container_main'> 

    <!-- 헤더 start -->
    <div class="header">
        <nav class="navbar navbar-expand-md fixed-top navbar-custom">
            <style>

                .navbar-custom {
                  height: 80px; /* 높이 설정 */
                  width: 100%; /* 넓이 설정 */
                  background-color: #DAF5E0;
                }
            </style>
    
    
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle Navigation">
                <span class="navbar-toggler-icon"></span>
            </button>    
    
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <a class="navbar-brand" href="/"><img src="/menu/images/deng.png" class="icon"  style=' width: 185px;  height: 70px;  '></a>

                <ul class="navbar-nav mr-auto">

                </ul>

                <ul class="navbar-nav float-right" style='margin-right: 20px'>

                    <li class="nav-item">
                        <c:choose>
                            <c:when test="${sessionScope.id == null && sessionScope.admin_id == null}">
                                <a class="nav-link" href="/member/login.do">
                                    <img src="/menu/images/lock.png" class="icon" style='margin-left:30px'>&nbsp;login
                                </a>
                            </c:when>
                        <c:otherwise>
                        <c:choose>
                            <c:when test="${sessionScope.admin_id == null}">
                                <a class="nav-link" href='/member/logout.do'>
                                    <img src="/menu/images/unlock.png" class="icon" style='margin-left:10px'>&nbsp;${sessionScope.mname }&nbsp;(logout)
                                </a>
                            </c:when>
                        <c:otherwise>
                        <!-- This block is empty to hide the "login" button for administrators -->
                        </c:otherwise>
                        </c:choose>
                        </c:otherwise>
                        </c:choose>
                    </li>

                    <c:choose>
                        <c:when test="${sessionScope.admin_id != null }">
                        </c:when>
                        
                        <c:when test="${sessionScope.id == null}">
                            <li class="nav-item dropdown">
                                <%-- 회원 서브 메뉴 --%>
                                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">
                                    <img src="/menu/images/pcircle.svg" class="icon" style='margin-left:20px'>&nbsp;마이페이지
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="/member/create.do">
                                        <img src="/menu/images/pheart.svg" class="icon" style='margin-left:5px'>&nbsp; 회원 가입</a>
                                   
                                    <a class="dropdown-item" href="/member/idFind.do">
                                        <img src="/menu/images/sheart.svg" class="icon" style='margin-left:5px'>&nbsp; 아이디 찾기</a>
                                    <a class="dropdown-item" href="member/pwFind.do">
                                        <img src="/menu/images/sh2.svg" class="icon" style='margin-left:5px'>&nbsp; 비밀번호 찾기</a>
                                </div>
                            </li>
                        </c:when>
                        
                        <c:when test="${sessionScope.id != null }">
                          <li class="nav-item dropdown">
                                <%-- 회원 서브 메뉴 --%>
                                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">
                                    <img src="/menu/images/pcircle.svg" class="icon" style='margin-left:20px'>&nbsp;마이페이지
                                </a>
                                <div class="dropdown-menu">
                                    <a class="dropdown-item" href="/member/read.do">
                                        <img src="/menu/images/pg.svg" class="icon" style='margin-left:5px'>&nbsp; 회원 정보 수정</a>
                                    <a class="dropdown-item" href="/recom/memberList.do?memberno=${sessionScope.memberno }">
                                        <img src="/menu/images/save.png" class="icon" style='margin-left:5px'>&nbsp; 레시피 저장 목록</a>
                                    <a class="dropdown-item" href="/wish/memberList.do?memberno=${sessionScope.memberno }">
                                     <img src="/menu/images/wish.png" class="icon" style='margin-left:5px'>&nbsp; 재료 찜 목록</a>
                                    <a class="dropdown-item" href="/cart/list_by_memberno.do">
                                        <img src="/menu/images/cart4.svg" class="icon" style='margin-left:5px'>&nbsp;  장바구니</a>
                                    <a class="dropdown-item" href="/pay/pay_list.do">
                                        <img src="/menu/images/receipt.svg" class="icon" style='margin-left:5px'>&nbsp;결제 리스트</a>
                                    <a class="dropdown-item" href="/member/delete_mem.do?memberno=${sessionScope.memberno}">
                                        <img src="/menu/images/px.svg" class="icon" style='margin-left:5px'>&nbsp; 회원 탈퇴</a>
                                </div>
                            </li>
                        </c:when>
                                                
                        <c:otherwise>
                          
                        </c:otherwise>
                    </c:choose>

                      <ul class="navbar-nav float-right" style='margin-right: 10px'>
                          <li class="nav-item dropdown">
                              <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">
                                  <img src="/menu/images/call.png" class="icon"  style='margin-left:5px'>‍&nbsp;고객센터</a>
          
                              <div class="dropdown-menu">                       
                                  <a class="dropdown-item" href="/notice/list_all.do">
                                      <img src="/menu/images/a.png" class="icon"  style='margin-left:5px'>&nbsp; 공지사항</a>                         
                                  <a class="dropdown-item" href="/qna/list_by_search.do">
                                      <img src="/menu/images/qa.png" class="icon"  style='margin-left:5px'>&nbsp; Q&A</a>
                              </div>
                          </li>
          
                      </ul>

                    <c:choose>
                        <c:when test="${sessionScope.id != null  && sessionScope.admin_id == null}">
                          <li></li>
                        </c:when>
                        
                        <c:when test="${sessionScope.admin_id == null && sessionScope.id == null }">
                            <li class="nav-item">
                                <a class="nav-link" href="/admin/login.do">
                                    <img src="/menu/images/user2.png" class="icon"  style='margin-left:5px'>&nbsp;관리자</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item dropdown" > <%-- 관리자 서브 메뉴 --%>
                                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#">
                                    <img src="/menu/images/user.png" class="icon"  style='margin-left:5px'>&nbsp;관리자 페이지</a>

                                <div class="dropdown-menu dropdown-menu-right">
                                    <a class="dropdown-item" href='/item/list_all.do'>
                                        <img src="/menu/images/list.png" class="icon"  style='margin-left:5px'>&nbsp;카테고리 전체 목록</a>       
                                    <a class="dropdown-item" href='/member/list.do'>
                                        <img src="/menu/images/team.png" class="icon"  style='margin-left:5px'>&nbsp; 회원 목록</a>  
                                    <a class="dropdown-item" href='/detail/order_list.do'>
                                        <img src="/menu/images/commu.png" class="icon"  style='margin-left:5px'>&nbsp; 고객 주문 사항</a>
                                    <a class="dropdown-item" href='/recom/adminList.do'>
                                        <img src="/menu/images/commu.png" class="icon"  style='margin-left:5px'>&nbsp; 좋아요 많은 글</a>
                                    <a class="dropdown-item" href='/admin/logout.do'>
                                        <img src="/menu/images/user2.png" class="icon"  style='margin-left:5px'>&nbsp; 관리자 [${sessionScope.admin_id }] 로그아웃</a>

                                </div>
                            </li>
                        </c:otherwise>
                    </c:choose>
              
                </ul>
            </div>    
        
        </nav>

    </div>
    <!-- 헤더 end -->

    <nav class="navbar navbar-expand-md navbar-main border-bottom">
    

        <button class="navbar-toggler collapsed " type="button" data-toggle="collapse" data-target="#dropdown6" aria-expanded="false"> <span class="navbar-toggler-icon"></span> </button>
        <div class="navbar-collapse collapse d-flex align-items-center" id="dropdown6" style="margin-top:70px" >

            <ul class="navbar-nav float-center mr-auto ">
                <c:forEach var="itemVO" items="${list_y}">
                    <c:set var="itemno" value="${itemVO.itemno }" />
                    <c:set var="item" value="${itemVO.item }" />

                    <li class="nav-item">
                        <c:choose>

                            <c:when test="${itemno != 6}">
                                <a class="nav-link" href="/recipe/list_by_itemno_grid.do?itemno=${itemno}&now_page=1" style="font-size: 15px;">                           
                                    <img src="/menu/images/menu2.png" class="icon0"  style='margin-left:9px'>&nbsp;${item}</a>
                            </c:when>
                            <c:otherwise>
                                <a class="nav-link" href="/goods/list_by_itemno_grid.do?itemno=${itemno}&now_page=1" style="font-size: 17px; margin-top: 6px">🥗${item}🥗</a>
                            </c:otherwise>
                        </c:choose>
                    </li>
                </c:forEach>
            </ul>


            
        </div>
    </nav>
</DIV>

