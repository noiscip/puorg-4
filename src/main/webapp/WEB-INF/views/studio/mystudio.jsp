<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<style>
	.img-size{
		width: 300px;
		height: 300px;
	}
	
	.user-img{
		width:45px;
		height:45px;
	}
</style>

<!-- get 파라미터 숨기기 -->
<!-- <script>
	history.replaceState({}, null, location.pathname);
</script> -->

  
  <div class="page-header header-filter" data-parallax="true" style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
  <div class="main main-raised">
    <div class="profile-content">
      <div class="container">
        <div class="row">
          <div class="col-md-6 ml-auto mr-auto">
            <div class="profile">
              <div class="avatar">
              	<c:choose>
	                <c:when test="${userinfo.prPicture eq null}">
	                	<img src="<%=request.getContextPath()%>/assets/img/user.png" alt="Circle Image" class="img-raised rounded-circle img-fluid">
              		</c:when>
              		<c:otherwise>
              			<img src="<%=request.getContextPath()%>${userinfo.prPicture}" alt="Circle Image" class="img-raised rounded-circle img-fluid">
              		</c:otherwise>
              	</c:choose>
              </div>
              <div class="name">
                <h3 class="title">${userinfo.userName}</h3>
              </div>
            </div>
          </div>
        </div>
        <div class="description text-center">
          <p>${userinfo.prContent}</p>
        </div>
        <div class="row">
          <div class="col-md-6 ml-auto mr-auto">
            <div class="profile-tabs">
              <ul class="nav nav-pills nav-pills-icons justify-content-center" role="tablist">
                <li class="nav-item">
                  <%-- <a class="nav-link active" href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${sessionScope.user.userNo}"> --%>
                  <a class="nav-link active" href="#studio"  role="tab" data-toggle="tab">
                    <i class="material-icons">photo_library</i> Studio
                  </a>
                </li>
                <li class="nav-item">
                  <%-- <a class="nav-link" href="<%=request.getContextPath()%>/user/follower.ps?userNo=${sessionScope.user.userNo}"> --%>
                  <a class="nav-link" href="#favorite"  role="tab" data-toggle="tab">
                    <i class="material-icons">favorite</i> Favorite
                  </a>
                </li>
              </ul>
            </div>
          </div>
        </div>
        
        <div class="tab-content tab-space">
          <div class="tab-pane active text-center gallery" id="studio">
            <div class="row">
            
              	<!-- DB에서 이미지 불러와서 해당 이미지의 상세페이지 요청 -->
              	<c:forEach items="${piclist}" var="pic">
              		<div class="col-md-3 mr-auto ml-auto" align="left">
	              		<a href="">
	                		<img src="<%=request.getContextPath()%>${pic.picPath}" class="rounded img-size">
	                	</a>
                	</div>
              	</c:forEach>
            
            </div>
          </div>
          
          <div class="tab-pane text-center" id="favorite">
          	<h4 align="center">팔로워</h4>
          	<div id="follower">
          		<!-- DB에서 해당 계정의 follower 프로필 불러와서 스튜디오로 이동하게끔 구현 -->
          		<c:forEach items="${followerlist}" var="follow">
          			<c:choose>
          				<c:when test="${follow.prPicture eq null}">
          					<!-- 해당 회원의 스튜디오로 이동하게 Controller 링크 -->
          					<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${follow.userNo}">
          						<img title="" src="<%=request.getContextPath()%>/assets/img/user.png" class="rounded user-img">
          					</a>
          				</c:when>
          				<c:otherwise>
          					<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${follow.userNo}">
          						<img title="" src="<%=request.getContextPath()%>${follow.prPicture}" class="rounded user-img">
          					</a>
          				</c:otherwise>
          			</c:choose>
          		</c:forEach>
            </div>
              
              
            <h4 align="center">팔로잉</h4>
            <div id="following">
            	<form action="" method="post">
            	<!-- DB에서 해당 계정의 following 프로필 불러와서 스튜디오로 이동하게끔 구현 -->
          		<c:forEach items="${followinglist}" var="following">
          			<c:choose>
          				<c:when test="${following.prPicture eq null}">
          					<!-- 해당 회원의 스튜디오로 이동하게 Controller 링크 -->
          					<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${following.userNo}">
          						<img title="" src="<%=request.getContextPath()%>/assets/img/user.png" class="rounded user-img">
          					</a>
          				</c:when>
          				<c:otherwise>
          					<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${following.userNo}">
          						<img title="" src="<%=request.getContextPath()%>${following.prPicture}" class="rounded user-img">
          					</a>
          				</c:otherwise>
          			</c:choose>
          		</c:forEach>
          		</form>
            </div>
            
          </div>
        </div>
      </div>
    </div>
  </div>


