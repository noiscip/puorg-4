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
	width:180px;
	height:180px;
}

</style>

<div class="page-header header-filter" data-parallax="true" style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="#">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="#">거래/내역</a></li>
			<li class="nav-item"><a class="nav-link" href="#">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/updateinfo.ps">정보 수정</a></li>
		</ul>
		
			<form>
			  <div class="form-row">
			    <div class="form-group col-md-6">
			      <label for="inputEmail4">Email</label>
			      <input type="email" class="form-control" id="inputEmail4" placeholder="Email">
			    </div>
			    <div class="form-group col-md-6">
			      <label for="inputPassword4">Password</label>
			      <input type="password" class="form-control" id="inputPassword4" placeholder="Password">
			    </div>
			  </div>
			  <div class="form-group">
			    <label for="inputAddress">Address</label>
			    <input type="text" class="form-control" id="inputAddress" placeholder="1234 Main St">
			  </div>
			  <div class="form-group">
			    <label for="inputAddress2">Address 2</label>
			    <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
			  </div>
			  <div class="form-row">
			    <div class="form-group col-md-6">
			      <label for="inputCity">City</label>
			      <input type="text" class="form-control" id="inputCity">
			    </div>
			    <div class="form-group col-md-4">
			      <label for="inputState">State</label>
			      <select id="inputState" class="form-control">
			        <option selected>Choose...</option>
			        <option>...</option>
			      </select>
			    </div>
			    <div class="form-group col-md-2">
			      <label for="inputZip">Zip</label>
			      <input type="text" class="form-control" id="inputZip">
			    </div>
			  </div>
			  <div class="form-group">
			    <div class="form-check">
			      <label class="form-check-label">
			          <input class="form-check-input" type="checkbox" value="">
			          Check me out
			          <span class="form-check-sign">
			            <span class="check"></span>
			          </span>
			      </label>
			    </div>
			  </div>
			  <button type="submit" class="btn btn-primary">Sign in</button>
			</form>
		</div>
	</div>
</div>


