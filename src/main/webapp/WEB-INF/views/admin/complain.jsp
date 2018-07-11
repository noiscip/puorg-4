<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


 <script>
  $( function() {
	  $('#datatable').DataTable( {
	        "order": [[ 0, "desc" ]],
  			"bInfo": false,    	
			"bLengthChange": false
	    } );
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

	
	  $('#complainSearch').click(function(){
		  var datePicker = $('#datePicker')[0].value
		console.log(datePicker)
		$.ajax({
			url:"/picsion/blame/adminComplainSearch.ps",
			data:{date:datePicker},
			success: function (data) {
				console.log(data.blameList)
				var table = ''
				$.each(data.blameList, function(i,elt){
					table += '<tr>'
					table += '<td>' + elt.blaNo + '</td>'
					table += '<td>' + elt.blaUserNo + '</td>'
					table += '<td>' + elt.blaContent+ '</td>'
					table += '<td>' + moment(elt.blaReg).format('YYYY-MM-DD, H:mm:ss') + '</td>' 
					table += '<td>' + elt.tableNo + '</td>'
					
					if(elt.brdNo==0){
						table += '<td>' + elt.brdNo + '</td>'
					}else{
						table += '<td><a href="/picsion/board/boardInfo.ps?brdNo='+elt.brdNo+'">'+elt.brdNo+'</a></td>'
					}
					
					table += '<td>' + elt.cmtNo + '</td>'
					table += '<td>' + elt.picNo + '</td>'
					table += '<td>' + elt.userNo + '</td>'
					table += '</tr>'
				})
				
				$('#tableBody').empty()
				$('#tableBody').append(table)
				
			}
		})
		
	  })	
	  
	  $('#allBlame').click(function(){
			blameFindAll()
		})
	  
		function blameFindAll(){
		  $.ajax({
				url:"/picsion/blame/adminAllComplain.ps",
				success: function (data) {
					console.log(data.blameList)
					var table = ''
					$.each(data.blameList, function(i,elt){
						table += '<tr>'
						table += '<td>' + elt.blaNo + '</td>'
						table += '<td>' + elt.blaUserNo + '</td>'
						table += '<td>' + elt.blaContent+ '</td>'
						table += '<td>' + moment(elt.blaReg).format('YYYY-MM-DD, H:mm:ss') + '</td>'
						table += '<td>' + elt.tableNo + '</td>'
						if(elt.brdNo==0){
							table += '<td>' + elt.brdNo + '</td>'
						}else{
							table += '<td><a href="/picsion/board/boardInfo.ps?brdNo='+elt.brdNo+'">'+elt.brdNo+'</a></td>'
						}
						table += '<td>' + elt.cmtNo + '</td>'
						if(elt.picNo==0){
							table += '<td>' + elt.picNo + '</td>'
						}else{
							table += '<td><a href="/picsion/picture/picinfo.ps?picNo='+elt.picNo+'">'+elt.picNo+'</a></td>'
						}
						if(elt.userNo==0){
							table += '<td>' + elt.userNo + '</td>'
						}else{
							table += '<td><a href="/picsion/picture/mystudio.ps?userNo='+elt.userNo+'">'+elt.userNo+'</a></td>'
						}
						table += '</tr>'
					})
					
					$('#tableBody').empty()
					$('#tableBody').append(table)
					
				}
			})
	  }
	  
  } );
</script>

<div id="changemain" class="page-header header-filter clear-filter purple-filter"
	data-parallax="true">
	<div class="container"></div>
</div>
<div class="main">
	<div class="section section-basic">
		<div class="container">
		
		<ul class="nav nav-pills nav-pills-rose">
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/admin.ps">회원 관리</a></li>
		  <li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/blame/adminComplainList.ps">신고글 관리</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/adminPurchase.ps">매출 내역</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/adminStats.ps">통계</a></li>
		</ul>
		
		
			<h2 class="text-center">전체 신고글 목록</h2>
			<table class="table" id="datatable">
				<thead>
					<tr>
						<th class="text-center">번 호</th>
						<th class="text-center">신고 유저 아이디</th>
						<th class="text-center">신고 내용</th>
						<th class="text-center">신고 날짜</th>
						<th class="text-center">신고 테이블 종류 번호</th>
						<th class="text-center">게시판 번호</th>
						<th class="text-center">댓글 번호</th>
						<th class="text-center">사진 번호</th>
						<th class="text-center">유저 번호</th>
					</tr>
				</thead>

				<tbody id="tableBody">
					<c:forEach var="complain" items="${blameList}" varStatus="i">

						<tr>
							<td class="text-center">${i.count} </td>
							<td class="text-center">${complain.blaUserNo}</td>
							<td class="text-center">${complain.blaContent}</td>
							<td class="text-center"><fmt:formatDate pattern = "yyyy-MM-dd, HH:mm:ss" value = "${complain.blaReg}" /></td>
							<td class="text-center">${complain.tableNo}</td>
							
							<c:choose>
								<c:when test="${complain.brdNo eq 0}"><td class="text-center">${complain.brdNo}</td></c:when>
								<c:otherwise>
									<td class="text-center"><a href="/picsion/board/boardInfo.ps?brdNo=${complain.brdNo}">${complain.brdNo}</a></td>
								</c:otherwise>
							</c:choose>
							<td class="text-center">${complain.cmtNo}</td>
							<c:choose>
								<c:when test="${complain.picNo eq 0}"><td class="text-center">${complain.picNo}</td></c:when>
								<c:otherwise>
									<td class="text-center"><a href="/picsion/picture/picinfo.ps?picNo=${complain.picNo}">${complain.picNo}</a></td>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${complain.userNo eq 0}"><td class="text-center">${complain.userNo}</td></c:when>
								<c:otherwise>
									<td class="text-center"><a href="/picsion/picture/mystudio.ps?userNo=${complain.userNo}">${complain.userNo}</a></td>
								</c:otherwise>
							</c:choose>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>