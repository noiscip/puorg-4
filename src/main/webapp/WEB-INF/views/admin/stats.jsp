<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
$(function(){
	

Highcharts.chart('sales', {

  title: {
    text: ''
  },
 
  xAxis: {
    tickInterval: 1
  },

  yAxis: {
    type: 'logarithmic',
    minorTickInterval: 0.1
  },

  tooltip: {
    headerFormat: '<b>{series.name}</b><br />',
    pointFormat: 'x = {point.x}, y = {point.y}'
  },

  series: [{
    data: [1, 2, 3, 4, 5, 6, 7, 8, 8],
    pointStart: 1
  }]
});
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
		
		<div id="sales" style="min-width: 310px; height: 400px; margin: 0 auto"></div>
		</div>
	</div>
</div>