<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
/* 뿌려주는 이미지의 크기 */
.img-size {
	height: 300px;
}

/* 사용자의 프로필 사진의 크기 */
.user-img {
	width: 50px;
	height: 50px;
}

/* 마이페이지 상단 메뉴 위,아래 여백 */
.my-ul {
	padding-top: 30px;
	padding-bottom: 30px;
}

/* 팔로잉 회원 프로필 사진 크기 이미지 */
.following-pr{
	width:100% !important;
	height:100% !important;
}

/* 팔로잉한 회원 이미지 margin-bottom 제거 */
.following-pr-mar{
	margin-bottom: 0px !important;
}

/* 팔로잉 리스트 패딩 탑 제거 */
.following-pr-pad{
	padding-top: 0px;
}

</style>

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
<div class="main">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/history.ps">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
		</ul>
			<div class="gallery text-center">
					<c:choose>
						<c:when test="${empty followingList}">
							<h1 class="text-center"><b>팔로잉한 회원이 없네요!</b></h1>
							<h3 class="text-center">팔로잉을 시작해보세요~</h3>
						</c:when>
						<c:otherwise>
							
						  <div class="flex_grid credits">
							<div class="tz-gallery following-pr-pad">
								<div class="row">
									<c:forEach items="${followingList}" var="following">
											<div class="item col-md-2">
												<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${following.userNo}">
													<c:choose>
														<c:when test="${following.prPicture eq null}">
															<img title="${following.userName}" src="<%=request.getContextPath()%>/assets/img/user.png" class="rounded following-pr following-pr-mar">
														</c:when>
														<c:otherwise>
															<img title="${following.userName}" src="${following.prPicture}" class="rounded following-pr following-pr-mar">
														</c:otherwise>
													</c:choose>
												</a>
													<div class="counts hide-xs hide-sm ">
														<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${following.userNo}">${following.userName}</a>
													</div>
											</div>
										
									</c:forEach>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
					
					<nav aria-label="Page navigation example">
					  <ul class="pagination justify-content-center">
					  
					  	<!-- 처음 이전 링크 -->
	                    <c:if test="${pg>block}">
	                         <li class="page-item"><a class="page-link" href="<%=request.getContextPath()%>/user/followinglist.ps?pg=${fromPage-1}">Previous</a></li>
	                    </c:if>
                     	
                     	<!-- 블록 범위 찍기 -->
	                    <c:forEach begin="${fromPage}" end="${toPage}" var="i">
	                         <c:if test="${i==pg}">
	                             <li class="page-item active">
	                             	<a class="page-link" href="#">${i}</a>
	                             </li>
	                         </c:if>
	                         <c:if test="${i!=pg}">
	                             <li class="page-item"><a href="<%=request.getContextPath()%>/user/followinglist.ps?pg=${i}"
	                                 class="page-link">${i}</a></li>
	                         </c:if>
	                    </c:forEach>
					    
					    <!-- 다음, 이후 -->
	                    <c:if test="${toPage<allPage}">
	                        <li class="page-item">
					      		<a class="page-link" href="<%=request.getContextPath()%>/user/followinglist.ps?pg=${toPage+1}">Next</a>
					    	</li>
	                    </c:if>
					    
					  </ul>
					</nav>
			</div>
		</div>
	</div>
</div>


