<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>
	/* 마이페이지 상단 메뉴 위,아래 여백 */
	.my-ul {
		padding-top: 30px;
		padding-bottom: 30px;
	}
	
	/* 카테고리 하단 여백 삭제 */
	.cat-margin-bot{
		margin-bottom: 0px;
	}
</style>

<div class="page-header header-filter" data-parallax="true" style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/purchase/history.ps">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
		</ul>
		
			<div id="tables" class="my-ul">
				<div class="tabs-underline">
				<ul>
					<li><a class="tab-active" href="<%=request.getContextPath()%>/purchase/history.ps">구매 내역</a></li>
					<li><a href="<%=request.getContextPath()%>/purchase/sellhistory.ps">판매 내역</a></li>
				</ul>
				<div class="table-responsive">
				
					<table class="table table-shopping">
						<thead>
							<tr>
								<th class="text-center"></th>
								<th>사진</th>
								<th class="text-center">해상도</th>
								<th class="text-center">구매일</th>
								<th class="text-center">가격</th>
								<th class="text-center">다운로드</th>
							</tr>
						</thead>
						<tbody>
						
						<c:forEach items="${pictureInfo}" var="picture" varStatus="status">
							<tr>
								<td>
									<div class="img-container">
										<img src="${picture.picWater}" alt="No Image">
									</div>
								</td>
								<td class="td-name"><a href="<%=request.getContextPath()%>/picture/picinfo.ps?picNo=${picture.picNo}">${picture.picTitle}</a>
									<br> <small>by ${userInfo[status.index].userName}</small></td>
								<td class="text-center"></td>
								<td class="td-number text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${purchaseInfo[status.index].purchaseReg}" /></td>
								<td class="td-number text-center">${picture.picPrice}<small>원</small></td>
								<td class="text-center"><a id="download" href="${picture.picPath}"><i class="material-icons">vertical_align_bottom</i></a></td>
							</tr>
						</c:forEach>
						
							<tr>
								<td colspan="2"></td>
								<td colspan="1"></td>
								<td class="td-total">Total</td>
								<td id="total2" class="td-price text-center">${sumPurchase}<small>원</small></td>
								<td colspan="1"></td>
							</tr>
						</tbody>
					</table>
				</div>
					<nav aria-label="Page navigation example">
					  <ul class="pagination justify-content-center">
					    <li class="page-item disabled">
					      <a class="page-link" href="#" tabindex="-1">Previous</a>
					    </li>
					    <li class="page-item active"><a class="page-link" href="#">1</a></li>
					    <li class="page-item"><a class="page-link" href="#">2</a></li>
					    <li class="page-item"><a class="page-link" href="#">3</a></li>
					    <li class="page-item">
					      <a class="page-link" href="#">Next</a>
					    </li>
					  </ul>
					</nav>
				</div>
			</div>
			
		</div>
	</div>
</div>


