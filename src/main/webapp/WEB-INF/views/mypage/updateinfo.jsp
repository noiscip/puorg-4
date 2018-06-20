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

/* 정보 수정페이지에서 프로필 사진 크기 */
.update-pr{
	width: 250px;
	height: 250px;
}

/* 정보 수정페이지 상단 여백 */
.update-margin{
	margin-top: 50px;
}
/* 정보 수정페이지 하단 여백 */
.update-padding{
	padding-bottom: 50px;
}

/* 정보 수정페이지 버튼 상단 여백 */
.update-btn-margin{
	margin-top: 10px;
}
</style>

<div class="page-header header-filter" data-parallax="true" style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="#">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="#">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="#">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/updateinfo.ps">정보 수정</a></li>
		</ul>
		
			<form class="form" method="post" action="">
			  <!--  -->
			  <div class="col-md-12 ml-auto mr-auto update-margin update-padding">
              <div class="row">
              	<div class="col-md-6 mr-auto text-center">
                  	<div class="form-group">
                  		<img src="<%=request.getContextPath()%>${sessionScope.user.prPicture}" class="img-raised rounded-circle img-fluid update-pr"><br>
			      		<button type="submit" class="btn btn-default update-btn-margin">프로필 수정</button>
                  	</div>
                    <div class="form-group">
                      <label>아이디</label>
                      <div class="input-group">
                        <input type="text" class="form-control" id="userId" name="userId" value="${sessionScope.user.userId}" readonly="readonly">
                      </div>
                    </div>
                    <div class="form-group">
                      <label>이름</label>
                      <div class="input-group">
                        <input type="text" class="form-control" name="userName" value="${sessionScope.user.userName}">
                      </div>
                    </div>
                    <div class="form-group">
                      <label>비밀번호</label>
                      <div class="input-group">
                        <input type="password" placeholder="비밀번호..." name="pwd" class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <label>비밀번호 확인</label>
                      <div class="input-group">
                        <input type="password" placeholder="비밀번호 확인..." class="form-control" />
                      </div>
                    </div>
                </div>
                
                
                <div class="col-md-6 ml-auto">
                  <div class="form-group update-margin">
                  		<label>계정 연동 여부</label>
	                    <!-- <h5 class="info-title">계정 연동 여부</h5> -->
	                      <div class="form-check">
						      <label class="form-check-label">
						      <c:choose>
						      	<c:when test="${sessionScope.user.naver eq null && sessionScope.user.google eq null}">
						      		<input class="form-check-input" type="checkbox" disabled>
						          		계정 연동하셔야 사진을 등록할 수 있습니다. 
						          <span class="form-check-sign">
						              <span class="check"></span>
						          </span>
						      	</c:when>
						      	<c:otherwise>
						      		<input class="form-check-input" type="checkbox" disabled checked>
						          		사진을 등록하실 수 있습니다. 
						          <span class="form-check-sign">
						              <span class="check"></span>
						          </span>
						      	</c:otherwise>
						      </c:choose>
						          <!-- <input class="form-check-input" type="checkbox" value="" disabled checked>
						          		사진을 등록하실 수 있습니다. 
						          <span class="form-check-sign">
						              <span class="check"></span>
						          </span> -->
						      </label>
						      <!-- 구글, 네이버 아이콘 만드는곳~~~ -->
						      <div align="center" style="float: right">
						      	  <i class="material-icons">highlight_off</i>
							      <i class="material-icons">highlight_off</i>
						      </div>
						  </div>
						  
                  </div>
                  <!-- <div class="form-group update-margin">
                  	<label>인증 계정</label>
                    <h5 class="info-title">인증 계정</h5>
                    <div class="input-group">
                        <input type="text" class="form-control" id="accountLiked" name="accountLiked" placeholder="인증계정" readonly="readonly">
                     </div>
                  </div> -->
                  
                  <div class="form-group text-center update-margin">
                  	<label>현재 캐시</label>
                    <!-- <h5 class="info-title">현재 캐시</h5> -->
                    <div class="input-group">
                        <input type="text" class="form-control" id="point" name="point" value="${sessionScope.user.point}" readonly="readonly">
                     </div>
                     <button type="submit" class="btn btn-default update-btn-margin">충전하기</button>
                  </div>
                  
                  <div class="form-group update-margin">
                  	<label>자기 소개</label>
                    <div class="input-group form-default">
                        <input type="text" class="form-control" id="prContent" name="prContent" value="${sessionScope.user.prContent}">
                     </div>
                  </div>
                  <div align="center">
                  	<button type="button" class="btn btn-info" >저장하기</button>
                  </div>
                </div>
                
              </div>
        	</div>
        	<!--  -->
        	
			</form>
		</div>
	</div>
</div>


