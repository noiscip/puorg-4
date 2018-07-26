<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function(){
	console.log(new Date($.now()))
	
	console.log(new Date(24*60*60*1000*49))
	
	var mainDate = {
			startDate:new Date(($.now()-(24*60*60*1000*49))),
			endDate:new Date($.now())
		}
	statistics(mainDate)
	
	function chart(date, sales){
		
		Highcharts.chart('sales', {
			  chart: { type: 'line' },
			  title: { text: '매출 내역' },
			  subtitle: { text: 'PICSION' },
			  xAxis: { categories: date },
			  yAxis: {  title: {  text: '매출금액' } },
			  plotOptions: { line: { dataLabels: { enabled: true }, enableMouseTracking: false } },
			  series: [{ name: 'picsion', data: sales }] })
	}
	
	
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
	var selectDate = {
			startDate:$('#datePicker1').val(),
			endDate:$('#datePicker2').val()
		}
	statistics(selectDate)
	})
	
	function statistics(date){
		$.ajax({
			url:"/picsion/purchase/mySalesAmount.ps",
			data:date,
			success: function(data){
				console.log(data)
				chart(data.map[1],data.map[2])
			}
		})
	}
})
</script>
<style>
	/* 마이페이지 상단 메뉴 위,아래 여백 */
	.my-ul {
		padding-top: 30px;
		padding-bottom: 30px;
	}
</style>

<div id="changemain" class="page-header header-filter clear-filter purple-filter"
	data-parallax="true">
	<div class="container"></div>
</div>
<div class="main">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/purchase/history.ps">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
		</ul>
		
			<div id="tables" class="my-ul">
				<div class="tabs-underline">
				<ul>
					<li><a href="<%=request.getContextPath()%>/purchase/history.ps">구매 내역</a></li>
					<li><a href="<%=request.getContextPath()%>/purchase/sellhistory.ps">판매 내역</a></li>
					<li><a class="tab-active" href="<%=request.getContextPath()%>/user/myStats.ps">통계 차트</a></li>
					
				</ul>
				<div class="row">
					<div class="col-md-1"></div>
					<div class="col-md-4">
						<input id="datePicker1" type="text" class="form-control datetimepicker"/>
					</div>
					~
					<div class="col-md-4">
						<input id="datePicker2" type="text" class="form-control datetimepicker"/>
					</div>
					<div class="col-md-2">
						<button class="btn btn-primary btn-sm" id="daySearch">검색</button>
					</div>
				</div>
				<br>
				<div id="sales" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
				</div>
				
				</div>
			</div>
			
		</div>
	</div>