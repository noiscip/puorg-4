<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<div class="page-header header-filter clear-filter purple-filter"
	data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/bg2.jpg'); transform: translate3d(0px, 0px, 0px);">
	<div class="container"></div>
</div>
<div class="main main-raised">
	<div class="section section-basic">
		<div class="container">
		
		<ul class="nav nav-pills nav-pills-rose">
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/admin.ps">회원 관리</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blame/adminComplainList.ps">신고글 관리</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/adminPurchase.ps">매출 내역</a></li>
		  <li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/adminPurchase.ps">통계</a></li>
		</ul>
		
		
			<h1>전체 매출 내역</h1>
			<table border="3">
				<thead>
					<tr>
						<th>사진 번호</th>
						<th>구매 유저 번호</th>
						<th>판매 유저 번호</th>
						<th>구매 날짜</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="admin" items="${purchaseList}">

						<tr>
							<td>${admin.picNo}</td>
							<td>${admin.purchaseUserNo}</td>
							<td>${admin.saleUserNo}</td>
							<td>${admin.purchaseReg}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>