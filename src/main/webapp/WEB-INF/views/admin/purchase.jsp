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
	  
	  $('#purchaseSearch').click(function(){
		  var datePicker = $('#datePicker')[0].value
		console.log(datePicker)
		$.ajax({
			url:"/picsion/purchase/adminPurchaseSearch.ps",
			data:{date:datePicker},
			success: function (data) {
				console.log(data)
				var table = ''
				$.each(data.purchaseList, function(i,elt){
				console.log(elt)
				
				table += '<tr>'
				table += '<td>' + elt.picNo + '</td>'
				table += '<td>' + elt.purchaseUserNo + '</td>'
				table += '<td>' + elt.saleUserNo + '</td>'
				table += '<td>' + moment(elt.purchaseReg).format('YYYY-MM-DD, H:mm:ss') + '</td>'
				table += '</tr>'
				})
				
				$('#tableBody').empty()
				$('#tableBody').append(table) 
				
			}
		})
		
	  })
	  
	  $('#allPurchase').click(function(){
			purchaseFindAll()
		})
	  function purchaseFindAll(){
		  $.ajax({
				url:"/picsion/purchase/adminAllPurchase.ps",
				success: function (data) {
					console.log(data)
					var table = ''
					$.each(data.purchaseList, function(i,elt){
					console.log(elt)
					
					table += '<tr>'
					table += '<td>' + (++i) + '</td>'
					table += '<td>' + elt.picNo + '</td>'
					table += '<td>' + elt.purchaseUserNo + '</td>'
					table += '<td>' + elt.saleUserNo + '</td>'
					table += '<td>' + moment(elt.purchaseReg).format('YYYY-MM-DD, H:mm:ss') + '</td>'
					table += '</tr>'
					})
					
					$('#tableBody').empty()
					$('#tableBody').append(table) 
					
				}
			})
	  }
  })
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
			  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blame/adminComplainList.ps">신고글 관리</a></li>
			  <li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/purchase/adminPurchase.ps">매출 내역</a></li>
			  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/adminStats.ps">통계</a></li>
			</ul>
			
			<h2 class="text-center">전체 매출 내역</h2>
			<table class="table" id="datatable">
				<thead>
					<tr>
						<th class="text-center">매출 번호</th>
						<th class="text-center">사진 번호</th>
						<th class="text-center">구매 유저 번호</th>
						<th class="text-center">판매 유저 번호</th>
						<th class="text-center">구매 날짜</th>
					</tr>
				</thead>
				<tbody id="tableBody">
					<c:forEach var="admin" items="${purchaseList}" varStatus="i">
						<tr>
							<td class="text-center">${i.count}</td>
							<td class="text-center">${admin.picNo}</td>
							<td class="text-center">${admin.purchaseUserNo}</td>
							<td class="text-center">${admin.saleUserNo}</td>
							<td class="text-center"><fmt:formatDate pattern = "yyyy-MM-dd, HH:mm:ss" value = "${admin.purchaseReg}" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</div>