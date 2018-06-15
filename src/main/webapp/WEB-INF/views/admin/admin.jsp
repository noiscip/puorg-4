<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script type="text/javascript">
$(function(){
	$('button[title=userDelete]').click(function () {
		console.log($(this)[0].id)
	})
	
	
	
	
	
	
})




</script>
<div class="page-header header-filter clear-filter purple-filter"
	data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/bg2.jpg'); transform: translate3d(0px, 0px, 0px);">
	<div class="container"></div>
</div>
<div class="main main-raised">
	<div class="section section-basic">
		<div class="container">
		
		<ul class="nav nav-pills nav-pills-rose">
		  <li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/admin.ps">회원 관리</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/adminComplainList.ps">신고글 관리</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/adminPurchase.ps">매출 내역</a></li>
		</ul>
		
		
			<h1>전체 회원 목록</h1>
			<table border="3">
				<thead>
					<tr>
						<th>유저 번호</th>
						<th>유저 아이디</th>
						<th>유저 이름</th>
						<th>유저 포인트</th>
						<th>유저 가입날짜</th>
						<th>삭제</th>
						
					</tr>
				</thead>

				<tbody>
					<c:forEach var="admin" items="${userList}">

						<tr>
							<td>${admin.userNo}</td>
							<td>${admin.userId}</td>
							<td>${admin.userName}</td>
							<td>${admin.point}</td>
							<td>${admin.userReg}</td>
							<td><button class="btn btn-primary btn-link" title="userDelete" id="${admin.userNo}">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>