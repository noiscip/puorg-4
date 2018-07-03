<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function(){
	Highcharts.chart('sales', {
		  chart: {
		    type: 'line'
		  },
		  title: {
		    text: '매출 내역'
		  },
		  subtitle: {
		    text: 'PICSION'
		  },
		  xAxis: {
		    categories: ['2016-06-11', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
		  },
		  yAxis: {
		    title: {
		      text: '매출금액'
		    }
		  },
		  plotOptions: {
		    line: {
		      dataLabels: {
		        enabled: true
		      },
		      enableMouseTracking: false
		    }
		  },
		  series: [{
		    name: 'picsion',
		    data: [5000, 6.9, 9.5, 14.5, 18.4, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
		  }]

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

	
	$('#daySearch').click(function(){
		$.ajax({
			url:"/picsion/purchase/salesAmount.ps",
			data:{
				startDate:$('#datePicker1').val(),
				endDate:$('#datePicker2').val()
			},
			success: function(data){
				console.log(data)
			}
		})
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
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/admin.ps">회원 관리</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/blame/adminComplainList.ps">신고글 관리</a></li>
		  <li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/adminPurchase.ps">매출 내역</a></li>
		  <li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/adminStats.ps">통계</a></li>
		</ul>
		<div class="form-group">
			<input id="datePicker1" type="text" class="form-control datetimepicker"/>
			<input id="datePicker2" type="text" class="form-control datetimepicker"/>
			<button id="daySearch">검색</button>
		</div>
		<div id="sales" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
		</div>
	</div>
</div>