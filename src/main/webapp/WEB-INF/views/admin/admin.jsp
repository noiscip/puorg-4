<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<script type="text/javascript">
	$(function() {
		 $('#datatable').DataTable( {
		        "order": [[ 0, "desc" ]],
	  			"bInfo": false,    	
				"bLengthChange": false
		    } );
		$(document).on('click', 'button[title=userDelete]', function() {
			var tr = $(this).closest('tr')
			
			/* 삭제 ajax */
			 $.ajax({
				url : "/picsion/user/adminUserDel.ps",
				data : {
					userNo : $(this)[0].id
				},
				success : function(data) {
					console.log(data.result)
					if (data.result == 0) {
						alert("삭제실패")
					} else {
						alert("삭제")
						tr.remove()
					}
				}
			}) 
			/* 삭제 ajax */
		})

		/* 유저 1명 검색*/
		$('#searchbtn').click(function(){
			console.log($('#search').val())
			
			$.ajax({
				url: "/picsion/user/adminUserSearch.ps",
				data:{userId:$('#search').val()},
				success: function(data){
					console.log(data.searchUser)
					var table = '<tr>'
						table += '<td>' + data.searchUser.userNo+ '</td>'
						table += '<td>' + data.searchUser.userId+ '</td>'
						table += '<td>' + data.searchUser.userName+ '</td>'
						table += '<td>' + data.searchUser.point+ '</td>'
						table += '<td>' + moment(data.searchUser.userReg).format('YYYY-MM-DD, H:mm:ss') + '</td>'
						table += '<td><button class="btn btn-primary btn-link" title="userDelete" id="'+data.searchUser.userNo+'">삭제</button></td>'
						table += '</tr>'
					
						$('#tableBody').empty()
						$('#tableBody').append(table)
					
				}
			})
		})
		
		$('#allUser').click(function(){
			userFindAll()
		})
		
	})

	/* 유저 전체 검색*/
	function userFindAll() {
		$.ajax({
			url : "/picsion/user/adminAllUser.ps",
			async : false,
			success : function(data) {
				console.log(data)
				var table = ''
				$.each(data.allUser,function(i, elt) {
						table += '<tr>'
						table += '<td>' + elt.userNo+ '</td>'
						table += '<td>' + elt.userId+ '</td>'
						table += '<td>' + elt.userName+ '</td>'
						table += '<td>' + elt.point+ '</td>'
						table += '<td>' + moment(elt.userReg).format('YYYY-MM-DD, H:mm:ss')+ '</td>'
						table += '<td><button class="btn btn-primary btn-link" title="userDelete" id="'+elt.userNo+'">삭제</button></td>'
						table += '</tr>'
					})

				$('#tableBody').empty()
				$('#tableBody').append(table)
			}
		})
	}
</script>
<div id="changemain" class="page-header header-filter clear-filter purple-filter"
	data-parallax="true">
	<div class="container"></div>
</div>
<div class="main">
	<div class="section section-basic">
		<div class="container">

			<ul class="nav nav-pills nav-pills-rose">
				<li class="nav-item"><a class="nav-link active"
					href="<%=request.getContextPath()%>/user/admin.ps">회원 관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath()%>/blame/adminComplainList.ps">신고글
						관리</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath()%>/purchase/adminPurchase.ps">매출
						내역</a></li>
				<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/adminStats.ps">통계</a></li>
			</ul>


			<h2 class="text-center">전체 회원 목록</h2>
			
			<table class="table" id="datatable">
				<thead>
					<tr>
						<th class="text-center">번호</th>
						<th class="text-center">유저 아이디</th>
						<th class="text-center">유저 이름</th>
						<th class="text-center">유저 포인트</th>
						<th class="text-center">유저 가입날짜</th>
						<th class="text-center">삭제</th>
					</tr>
				</thead>
				<tbody id="tableBody" style="text-align: center">
					<c:forEach var="admin" items="${userList}" varStatus="i">
						<tr>
							<td class="text-center">${i.count}</td>
							<td class="text-center">${admin.userId}</td>
							<td class="text-center">${admin.userName}</td>
							<td class="text-center">${admin.point}</td>
							<td class="text-center"><fmt:formatDate pattern = "yyyy-MM-dd, HH:mm:ss" value = "${admin.userReg}" /></td>
							<td class="text-center"><button class="btn btn-primary btn-link" title="userDelete" id="${admin.userNo}">삭제</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>