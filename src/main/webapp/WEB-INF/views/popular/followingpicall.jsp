<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<script type="text/javascript">
$(function() {
	var loginUserNo = $('#loginUserNo').val();

	
	$(document).on('click','#like',function(){
		if(loginUserNo == 0){
		}else{
			var data = {userNo : loginUserNo,
				    picNo : $(this).attr("value")};
			var respect =  $(this);
			var rpa = $(this).parent();
			 $.ajax({
				url : "<%=request.getContextPath()%>/picture/increaserespect.ps",
				data : data,
				success : function(data){
					if(data.result==1){
						  $(respect)[0].innerHTML = 'favorite_border';
						  $(rpa)[0].childNodes[1].nodeValue--;
					  }else{
						  $(respect)[0].innerHTML = 'favorite';
						  $(rpa)[0].childNodes[1].nodeValue++;
					  }
				}
			 }) 
		}
	})
	
	$(document).on('click','#down',function(){
		if(loginUserNo == 0){
		}else{
			var data = {userNo : loginUserNo,
				    picNo : $(this).attr("value")};
			var bookmark = $(this);
			var bpa = $(this).parent();
			 $.ajax({
				url : "<%=request.getContextPath()%>/picture/increasebookmark.ps",
				data : data,
				success : function(data){
					if(data.result==1){
						  $(bookmark)[0].innerHTML = 'bookmark_border';
						  $(bpa)[0].childNodes[1].nodeValue--;
					  }else{
						  $(bookmark)[0].innerHTML = 'bookmark';
						  $(bpa)[0].childNodes[1].nodeValue++;
					  }
				}
			 }) 
		}
	})
	
})
</script>

<style type="text/css">
.img-size {
	height: 300px;
	width: 100%;
} 
</style>

<div class="page-header header-filter" data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');">
</div>
<div class="main main-raised">
	<div class="profile-content">

		<div class="container-fluid">
			<div class="flex_grid credits">
			<div class="tz-gallery">
				<div class="row">
				<c:forEach items="${followingPicList}" var="followingListAll" varStatus="status">					
						  <div class="item col-sm-6 col-md-4"> 
			                    <a href="<%=request.getContextPath()%>/picture/picinfo.ps?picNo=${followingListAll.picNo}"> 
			                        <img class="rounded img-size" src="<%=request.getContextPath()%>/${followingListAll.picPath}"alt="No Image">
			                    </a>
			                    <div>
			                    <div class="counts hide-xs hide-sm ">
			                    <c:choose>
									<c:when test="${followingListAll.respectCheck eq 'T'}">
										<em><i id="like" value="${followingListAll.picNo}" class="material-icons">favorite</i>${followingListAll.respectCount}</em>
									</c:when>
									<c:otherwise>
										<em><i id="like" value="${followingListAll.picNo}" class="material-icons">favorite_border</i>${followingListAll.respectCount}</em>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${followingListAll.bookmarkCheck eq 'T'}">
										<em><i id="down" value="${followingListAll.picNo}" class="material-icons">bookmark</i>${followingListAll.bookmarkCount}</em>
									</c:when>
									<c:otherwise>
										<em><i id="down" value="${followingListAll.picNo}" class="material-icons">bookmark_border</i>${followingListAll.bookmarkCount}</em>
									</c:otherwise>
								</c:choose>
			                    </div>
			                    <a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${followingPicListOwner[status.index].userNo}">${followingPicListOwner[status.index].userName}</a>
               				</div>
			            </div>
						
					</c:forEach>
				</div>
			</div>
		</div>
		</div>
	</div>
</div>
