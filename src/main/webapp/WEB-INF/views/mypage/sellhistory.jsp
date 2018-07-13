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

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
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
					<li><a class="tab-active" href="<%=request.getContextPath()%>/purchase/sellhistory.ps">판매 내역</a></li>
					<li><a href="<%=request.getContextPath()%>/user/myStats.ps">통계 차트</a></li>
					<li style="float:right;"><b>총 판매 금액 : </b><small><fmt:formatNumber value="${sumSell}" pattern="#,###"/>원</small></li>
				</ul>
				<div class="table-responsive">
				
					<table class="table table-shopping">
						<thead>
							<tr>
								<th class="text-center"></th>
								<th>사진</th>
								<th class="text-center">해상도</th>
								<th class="text-center">판매일</th>
								<th class="text-center">가격</th>
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
									<br> <small>to ${userInfo[status.index].userName}</small></td>
								<td class="text-center">${picture.resolutionH} X ${picture.resolutionW}</td>
								<td class="td-number text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${purchaseInfo[status.index].purchaseReg}" /></td>
								<td class="td-number text-center"><fmt:formatNumber value="${picture.picPrice}" pattern="#,###"/><small>원</small></td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
					<nav aria-label="Page navigation example">
					  <ul class="pagination justify-content-center">
					  
					  	<!-- 처음 이전 링크 -->
	                    <c:if test="${pg>block}">
	                         <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/purchase/sellhistory.ps?pg=${fromPage-1}">Previous</a></li>
	                    </c:if>
                     	
                     	<!-- 블록 범위 찍기 -->
	                    <c:forEach begin="${fromPage}" end="${toPage}" var="i">
	                         <c:if test="${i==pg}">
	                             <li class="page-item active">
	                             	<a class="page-link" href="#">${i}</a>
	                             </li>
	                         </c:if>
	                         <c:if test="${i!=pg}">
	                             <li class="page-item"><a href="<%=request.getContextPath()%>/purchase/sellhistory.ps?pg=${i}"
	                                 class="page-link">${i}</a></li>
	                         </c:if>
	                    </c:forEach>
					    
					    <!-- 다음, 이후 -->
	                    <c:if test="${toPage<allPage}">
	                        <li class="page-item">
					      		<a class="page-link" href="<%=request.getContextPath()%>/purchase/sellhistory.ps?pg=${toPage+1}">Next</a>
					    	</li>
	                    </c:if>
					    
					  </ul>
					</nav>
				
				</div>
			</div>
			
		</div>
	</div>
</div>


