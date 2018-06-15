<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script type="text/javascript">
	
	
	$(document).on('click','#like',function(){
		var data = {userNo : ${sessionScope.user.userNo},
			    picNo : $(this).attr("value")};
		var respect =  $(this);
		 $.ajax({
			url : "<%=request.getContextPath()%>/picture/increaserespect.ps",
			data : data,
			success : function(data){
				if(data.result==1){
					  $(respect)[0].innerHTML = 'favorite_border';
				  }else{
					  $(respect)[0].innerHTML = 'favorite';
				  }
			}
		 }) 
	})
	
	$(document).on('click','#down',function(){
		var data = {userNo : ${sessionScope.user.userNo},
			    picNo : $(this).attr("value")};
		var bookmark = $(this);
		 $.ajax({
			url : "<%=request.getContextPath()%>/picture/increasebookmark.ps",
			data : data,
			success : function(data){
				if(data.result==1){
					  $(bookmark)[0].innerHTML = 'bookmark_border';
				  }else{
					  $(bookmark)[0].innerHTML = 'bookmark';
				  }
			}
		 }) 
	})
</script>

<style type="text/css">
.img-size {
	height: 300px;
}
</style>

<div class="page-header header-filter" data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
			<div class="row">
				<div class="col-md-6 ml-auto mr-auto">
					<div class="profile-tabs">
						<ul class="nav nav-pills nav-pills-icons justify-content-center"
							role="tablist">

							<li class="nav-item"><a class="nav-link"
								href="<%=request.getContextPath()%>/home.ps"> <i
									class="material-icons">keyboard_backspace</i> 돌아가기
							</a></li>

						</ul>
					</div>
				</div>
			</div>
			<div id="gallery">
				<div class="flex_grid credits">
					<c:forEach items="${imagelistall}" var="followinglistall"
						varStatus="status">
						<div class="item" data-w="640" data-h="426"
							style="width: 255px; height: 300px; display: block;">
							<a href=""> <img class="rounded img-size"
								src="<%=request.getContextPath()%>/${followinglistall.picPath}"
								alt="">
							</a>
							<div class="row">
								<div class="col-md-7">
									<a
										href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${ownlist[status.index].userNo}">${ownlist[status.index].userName}</a>
								</div>
								<div class="col-md-2">
									<a><i id="like" value="${followinglistall.picNo}"
										class="material-icons">favorite_border</i></a>
								</div>
								<c:choose>
								<c:when test="${bookcheck[status.index] eq 1}">
								<div class="col-md-2">
											<a><i id="down" value="${followinglistall.picNo}"
												class="material-icons">bookmark</i></a>
										</div>
								</c:when>
								<c:otherwise>
									<div class="col-md-2">
										<a><i id="down" value="${followinglistall.picNo}"
											class="material-icons">bookmark_border</i></a>
									</div>
								</c:otherwise>
								</c:choose>
							
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
</div>
