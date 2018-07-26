<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>






<style type="text/css">

	/* 마이페이지 상단 메뉴 위,아래 여백 */
	.my-ul {
		padding-top: 30px;
		padding-bottom: 30px;
	}
	
	.oper-category{
		margin-bottom: 0px;
		margin-top: 15px;
		float:left;
	}
</style>
<script type="text/javascript">
$(document).ready( function () {
	 
    $('#datatable').DataTable({
        "order": [[ 0, "desc" ]],
    	"bInfo": false,
    	"bLengthChange": false
    });
    $('#datatable2').DataTable({
        "order": [[ 0, "desc" ]],
    	"bInfo": false,
    	"bLengthChange": false
    });
    
    
} );

</script>

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
<div class="main">
	<div class="profile-content">
		<div class="container">
			<ul class="nav nav-pills justify-content-center my-ul">
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
				<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/history.ps">거래 내역</a></li>
				<li class="nav-item"><a class="nav-link active"
					href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
				<li class="nav-item"><a class="nav-link"
					href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
			</ul>
				<form class="form-inline oper-category">
					<a href="#" class="btn btn-default dropdown-toggle"
						data-toggle="dropdown"> 요청/작업 리스트 </a>
					<ul class="nav dropdown-menu" role="tablist">
						<li class="nav-item"><a class="nav-link tag" id="receiveTag"
							href="#request" role="tab" data-toggle="tab">나의 요청 리스트</a></li>
						<li class="nav-item"><a class="nav-link" id="sendTag"
							href="#operation" role="tab" data-toggle="tab">나의 작업 리스트</a></li>
					</ul>
				</form>
				<div class="tab-content tab-space">
					<!-- ******* 요청  리스트 ******* -->
					<div class="tab-pane active" id="request">
						<table id="datatable" class="table" style="text-align: center">
							<thead>
								<tr class="info">
									<th>#</th>
									<th>작업자</th>
									<th>제목</th>
									<th>금액</th>
									<th>시작날짜</th>
									<th>완료예정 날짜</th>
									<th>작업 상태</th>
								</tr>
							</thead>
							<!-- 데이터가 한건도 없는 경우  -->
							<tbody>
								<c:forEach var="item" items="${requestBoardList}"
									varStatus="status">
									<tr id="${item.brdNo}">
										<td>${item.brdNo}</td>
										<td>${item.userName}</td>
										<td><a
											href="<%=request.getContextPath()%>/board/boardInfo.ps?brdNo=${item.brdNo}">${item.brdTitle}</a></td>
										<td><fmt:formatNumber value="${item.brdExpectPrice}" pattern="#,###"/>원</td>
										<td><small> ·<fmt:formatDate
													pattern="yyyy-MM-dd, HH:mm:ss" value="${item.brdReg}" />
										</small></td>
										<td><small> ·<fmt:formatDate
													pattern="yyyy-MM-dd, HH:mm:ss"
													value="${item.brdExpectEndDate}" />
										</small></td>
										<td>${item.operState}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>

					<!-- ******* 작업 리스트 ****** -->
					<div class="tab-pane" id="operation">

						<table id="datatable2" class="table" style="text-align: center">
							<thead>
								<tr class="info">
									<th>#</th>
									<th>요청자</th>
									<th>제목</th>
									<th>금액</th>
									<th>날짜</th>
									<th>완료예정 날짜</th>
									<th>작업 상태</th>
								</tr>
							</thead>
							<!-- 데이터가 한건도 없는 경우  -->
							<tbody>
								<c:forEach var="item" items="${operationBoardList}"
									varStatus="status">
									<tr id="${item.brdNo}">
										<td>${item.brdNo}</td>
										<td>${item.userName}</td>
										<td><a
											href="<%=request.getContextPath()%>/board/boardInfo.ps?brdNo=${item.brdNo}">${item.brdTitle}</a></td>
										<td><fmt:formatNumber value="${item.brdExpectPrice}" pattern="#,###"/>원</td>
										<td><small> ·<fmt:formatDate
													pattern="yyyy-MM-dd, HH:mm:ss" value="${item.brdReg}" />
										</small></td>
										<td><small> ·<fmt:formatDate
													pattern="yyyy-MM-dd, HH:mm:ss"
													value="${item.brdExpectEndDate}" />
										</small></td>
										<td>${item.operState}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>

					</div>

				</div>
		</div>
	</div>
</div>
