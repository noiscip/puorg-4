<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
	$(function() {
		/* 메시지 보내기 비동기 처리 */
		var sendUserNo : ${user.userNo};
		var receiveUserNo : ${userinfo.userNo};
		
		$('#messageSend').click(function(){
			var tableNo = 4
			var data= {msgContent:$("#msgContent").val(), 
						sendUserNo:sendUserNo, 
						receiveUserNo:receiveUserNo
					   };
			
			$.ajax({
				  url : "/picsion/message/send.ps",
				  data: data,
				  success : function(){
				      $("#msgContent").val("");
				      send(receiveUserNo,tableNo);
				  },
				  error: function(){
				   	  alert("메시지 보내는 도중 오류가 발생했습니다.");
				  }
			});
		})
		
		/* 팔로우가 되있으면 팔로우 취소 처리, 팔로우가 안되있으면 팔로잉 처리 (비동기)*/
		$('#follow').click(function(){
			var data = {userNo:sendUserNo, 
						followingUserNo:receiveUserNo};			
			$.ajax({
				  url : "/picsion/user/following.ps",
				  data: data,
				  success : function(data){
					  console.log(data.result);
					  if(data.result==1){
						  $('#follow-icon')[0].innerHTML = 'favorite_border';
						  $('#follow')[0].childNodes[2].data = '팔로우';
					  }else{
						  $('#follow-icon')[0].innerHTML = 'favorite';
						  $('#follow')[0].childNodes[2].data = '팔로우 취소'; 
					  }
				  }
			});
		}) 
		
	})
</script>

<style>
	/* 뿌려주는 이미지의 크기 */
	.img-size{
		height: 300px;
	}
	
	/* 사용자의 프로필 사진의 크기 */
	.user-img{
		width:50px;
		height:50px;
	}
</style>


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
              
              <c:if test="${sessionScope.user.userNo ne userinfo.userNo}">
	              <div align="right" style="float: right;">
				  	<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#exampleModal">메시지</button>
				  	<button class="btn btn-primary btn-sm" id="follow">
				  		<c:choose>
				  			<c:when test="${followResult eq 1}">
				  				<i class="material-icons" id="follow-icon">favorite</i> 팔로우 취소
				  			</c:when>
				  			<c:otherwise>
				  				<i class="material-icons" id="follow-icon">favorite_border</i> 팔로우
				  			</c:otherwise>
				  		</c:choose>
					</button>
				  </div>
			  </c:if>
			  
              <div class="name">
                <h3 class="title">${userinfo.userName}</h3>
              </div>
            </div>
          </div>
        </div>

				
        <div class="description text-center">
          <p><%-- ${userinfo.prContent} --%>
	          <c:choose>
	          	<c:when test="${userinfo.prContent eq null}">
	          		사용자의 자기 소개 정보가 없습니다.
	          	</c:when>
	          	<c:otherwise>
	          		${userinfo.prContent}
	          	</c:otherwise>
	          </c:choose>
          </p>
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
              		<div class="col-md-3" >
	              		<a href="">  <!-- *******이미지 상세페이지로 이동******** -->
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
          						<img title="${following.userId}" src="<%=request.getContextPath()%>/assets/img/user.png" class="rounded user-img">
          					</a>
          				</c:when>
          				<c:otherwise>
          					<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${following.userNo}">
          						<img title="${following.userId}" src="<%=request.getContextPath()%>${following.prPicture}" class="rounded user-img">
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

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">메시지</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body">
	        <!-- <div class="form-group">
			     <label for="exampleInput1" class="bmd-label-floating">제목</label>
			     <input type="text" class="form-control" id="msgNo" name="msgNo" placeholder="제목">
		    </div> -->
		    <div class="form-group">
		    	<label for="exampleFormControlTextarea1">내용</label>
		    	<textarea class="form-control" id="msgContent" name="msgContent" rows="3"></textarea>
		    </div>
		    
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary" id="messageSend" data-dismiss="modal">보내기</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	      
	    </div>
	  </div>
	</div>

	
