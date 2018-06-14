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
</style>

<div class="page-header header-filter" data-parallax="true"<%-- style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');" --%>></div>
<div class="main main-raised">
	<div class="profile-content">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="#">업로드</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="#">거래/내역</a></li>
			<li class="nav-item"><a class="nav-link" href="#">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="#">정보 수정</a></li>
		</ul>
		
		<div class="container">
			<div class="gallery text-center">
				<div class="row">
					<c:forEach items="${bookmarkPicList}" var="bookmark">
						<div class="col-md-3" align="left">
							<a href=""> <!-- ******이미지 상세페이지로 이동***** --> 
								<img src="<%=request.getContextPath()%>${bookmark.picPath}" class="rounded img-size">
							</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>


