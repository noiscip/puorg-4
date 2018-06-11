<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>



<div class="page-header header-filter clear-filter purple-filter" data-parallax="true" style="background-image: url(&quot;./assets/img/bg2.jpg&quot;); transform: translate3d(0px, 0px, 0px);">
    <div class="container">
        
    </div>
</div>
<div class="main main-raised">
<div class="section section-basic">
        <div class="container">
        <h1>
		보경이 페이지 
		</h1>

		<P>  The time on the server is ${serverTime}. </P>

		<c:forEach var="admin" items="${testbb}">
			유저넘버 : ${admin.userNo}<br>
			유저 아이디 : ${admin.userId}<br>
			유저 이름 : ${admin.userName}<br>
			유저 포인트 : ${admin.point}<br>
			유저 가입날짜 : ${admin.userReg}<br>
			유저 테이블 종류 번호 : ${admin.tableNo}<br>
			유저 권한 : ${admin.roleNo}<br>
			<br><br><br>
		</c:forEach>
           
        </div>
    </div>
 </div>