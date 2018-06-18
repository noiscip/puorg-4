<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

 <script>
  $( function() {
	  $('.datetimepicker').datetimepicker({
		    icons: {
		        time: "fa fa-clock-o",
		        date: "fa fa-calendar",
		        up: "fa fa-chevron-up",
		        down: "fa fa-chevron-down",
		        previous: 'fa fa-chevron-left',
		        next: 'fa fa-chevron-right',
		        today: 'fa fa-screenshot',
		        clear: 'fa fa-trash',
		        close: 'fa fa-remove'
		    }
		});
  } );
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
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/admin.ps">회원 관리</a></li>
		  <li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/adminComplainList.ps">신고글 관리</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/adminPurchase.ps">매출 내역</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/adminPurchase.ps">통계</a></li>
		</ul>
		
		
			<h1>전체 신고글 목록</h1>
			<div class="form-group">
			    <label class="label-control">Datetime Picker</label>
			    <input type="text" class="form-control datetimepicker"/>
			</div>
			<table border="3">
				<thead>
					<tr>
						<th>신고 번호</th>
						<th>신고 유저 아이디</th>
						<th>신고 내용</th>
						<th>신고 날짜</th>
						<th>신고 테이블 종류 변호</th>
						<th>게시판 번호</th>
						<th>댓글 번호</th>
						<th>사진 번호</th>
						<th>유저 번호</th>
					</tr>
				</thead>

				<tbody>
					<c:forEach var="complain" items="${blameList}">

						<tr>
							<td>${complain.blaNo}</td>
							<td>${complain.blaUserNo}</td>
							<td>${complain.blaContent}</td>
							<td>${complain.blaReg}</td>
							<td>${complain.tableNo}</td>	
							<td>${complain.brdNo}</td>
							<td>${complain.cmtNo}</td>
							<td>${complain.picNo}</td>
							<td>${complain.userNo}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>