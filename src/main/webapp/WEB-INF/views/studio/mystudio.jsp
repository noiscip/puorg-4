<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
	
	$(function() {
		var receiveUserNo = ${userinfo.userNo};
		var loginUserNo = $('#loginUserNo').val();
		/* 메시지 보내기 비동기 처리 */
		$('#messageSend').click(function(){
			var tableNo = 4;
			var data= {msgContent:$("#msgContent").val(), 
						sendUserNo:loginUserNo, 
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
			var data = {userNo:loginUserNo, 
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
	 	
		
		var lastScrollTop = 0;
		var page=${page};
		
		$(window).scroll(function(){ // ① 스크롤 이벤트 최초 발생
	        console.log(page);
	        var currentScrollTop = $(window).scrollTop();
	        var scrollPage="";
	        
	        if( currentScrollTop - lastScrollTop > 0 ){
	            
	            // 2. 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
	            if ($(window).scrollTop() >= ($(document).height() - $(window).height()) ){ //② 현재스크롤의 위치가 화면의 보이는 위치보다 크다면
	            	if($('#photo-library').hasClass('active')){
		            	console.log("여기 오는거야?")
		            	
		            	$.ajax({
		                    type : 'post',  
		                    url : '/picsion/picture/mystudio.ps',
		                    data : { 
		                        page: page,
		                        userNo: receiveUserNo
		                    },
		                    success : function(data){
		                        console.log("정상적으로 실행된거?")
		                        
		                        $.each(data.scrollPicList, function(index, obj){
		                        	
		                        	console.log(obj);
		                        	console.log(data.scrollOwnerList[index].userName)
		                        	
		                        	scrollPage="<div class='item col-sm-6 col-md-4'>"+
												"<a href='<%=request.getContextPath()%>/picture/picinfo.ps?picNo="+obj.picNo+"'>"+
												"<img class='rounded img-size' src='"+obj.picWater+"' alt=''>"+
												"</a><div>"+
					                    		"<div class='counts hide-xs hide-sm'>";
					                    		if(obj.respectCheck=="T"){
													scrollPage+="<em><i id='like' value='"+obj.picNo+"' class='material-icons'>favorite</i>"+obj.respectCount+"</em>";
					                    		}else{
					                    			scrollPage+="<em><i id='like' value='"+obj.picNo+"' class='material-icons'>favorite_border</i>"+obj.respectCount+"</em>";
					                    		}
					                    		
					                    		if(obj.bookmarkCheck=="T"){
					                    			scrollPage+="<em><i id='down' value='"+obj.picNo+"' class='material-icons'>bookmark</i>"+obj.bookmarkCount+"</em>";
					                    		}else{
					                    			scrollPage+="<em><i id='down' value='"+obj.picNo+"' class='material-icons'>bookmark_border</i>"+obj.bookmarkCount+"</em>";
					                    		}
									scrollPage+="</div><a href='<%=request.getContextPath()%>/picture/mystudio.ps?userNo="+obj.userNo+"'>"+data.scrollOwnerList[index].userName+"</a></div></div>";
									
									console.log(scrollPage);
		                        	$('#studioview').append(scrollPage);
		                        })
		                        
							    page+=data.endpage;
		                    }
		                });
	                }
	            }
	        }
	    })
		
		
		
	})
</script>

<style>
	/* 뿌려주는 이미지의 크기 */
	.img-size {
		height: 300px;
		width: 100%;
	}
	
	/* 사용자의 프로필 사진의 크기 */
	.user-img{
		width:50px;
		height:50px;
	}
	
	/* 스튜디오 프로필 사진 크기 */
	.studio-prPic-wid{
		height: 160px;
	}
</style>

<input type="hidden" value="${userinfo.tableNo},${userinfo.userNo},0,0" id="info">

  <div id="changemain" class="page-header header-filter" data-parallax="true"></div>
  <div class="main main-raised">
    <div class="profile-content">
      <div class="container-fluid">
        <div class="row">
          <div class="col-md-6 ml-auto mr-auto">
            <div class="profile">
              <div class="avatar">
              	<c:choose>
	                <c:when test="${userinfo.prPicture eq null}">
	                	<img src="<%=request.getContextPath()%>/assets/img/user.png" alt="Circle Image" class="img-raised rounded-circle img-fluid">
              		</c:when>
              		<c:otherwise>
              			<img src="${userinfo.prPicture}" alt="Circle Image" class="img-raised rounded-circle img-fluid studio-prPic-wid">
              		</c:otherwise>
              	</c:choose>
              </div>
              
              <c:choose>
              <c:when test="${sessionScope.user eq null}">
              </c:when>
              <c:otherwise>
              <div class="name">
                <h3 class="title">${userinfo.userName}</h3>
              </div>
              <c:if test="${sessionScope.user.userNo ne userinfo.userNo}">
	              <div align="center" style="float: inherit;">
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
				  	<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#exampleModal">메시지</button>
	              	<button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#reportModal">신고</button>
				  </div>
			  </c:if>
              </c:otherwise>
              </c:choose>
			  
            </div>
          </div>
        </div>

				
        <div class="description text-center">
          <p style="font-size: large"><%-- ${userinfo.prContent} --%>
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
                  <a class="nav-link active" href="#studio"  role="tab" data-toggle="tab" id="photo-library">
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
          <div class="tab-pane active" id="studio">
            
            <div id="gallery">
				<div class="flex_grid credits">
				<div class="tz-gallery">
				<div class="row" id="studioview">
					<c:forEach items="${piclist}" var="studioPic" varStatus="status">
						<div class="item col-sm-6 col-md-4">
							<a href="<%=request.getContextPath()%>/picture/picinfo.ps?picNo=${studioPic.picNo}">
							<img class="rounded img-size" src="${studioPic.picWater}" alt="">
							</a>
							<div>
			                    <div class="counts hide-xs hide-sm ">
			                    <c:choose>
									<c:when test="${studioPic.respectCheck eq 'T'}">
										<em><i id="like" value="${studioPic.picNo}" class="material-icons">favorite</i>${studioPic.respectCount}</em>
									</c:when>
									<c:otherwise>
										<em><i id="like" value="${studioPic.picNo}" class="material-icons">favorite_border</i>${studioPic.respectCount}</em>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${studioPic.bookmarkCheck eq 'T'}">
										<em><i id="down" value="${studioPic.picNo}" class="material-icons">bookmark</i>${studioPic.bookmarkCount}</em>
									</c:when>
									<c:otherwise>
										<em><i id="down" value="${studioPic.picNo}" class="material-icons">bookmark_border</i>${studioPic.bookmarkCount}</em>
									</c:otherwise>
								</c:choose>
			                    </div>
			                    <a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${studioPic.userNo}">${ownerList[status.index].userName}</a>
               				</div>
						</div>
					</c:forEach>
					</div>
					</div>
				</div>
			</div> 
            
          </div>
          
          <div class="tab-pane text-center" id="favorite">
          	<h4 align="center"><b>팔로워</b></h4><hr>
          	<div id="follower">
          		<c:choose>
						<c:when test="${empty followerlist}">
							<h3 class="text-center">팔로워가 아무도 없네요ㅠㅠ</h3><br>
						</c:when>
						<c:otherwise>
			          		<!-- DB에서 해당 계정의 follower 프로필 불러와서 스튜디오로 이동하게끔 구현 -->
			          		<c:forEach items="${followerlist}" var="follow">
			          			<c:choose>
			          				<c:when test="${follow.prPicture eq null}">
			          					<!-- 해당 회원의 스튜디오로 이동하게 Controller 링크 -->
			          					<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${follow.userNo}" data-toggle="popover" data-placement="top" data-trigger="hover" data-content="${follow.userName}">
			          						<img src="<%=request.getContextPath()%>/assets/img/user.png" class="rounded user-img">
			          					</a>
			          				</c:when>
			          				<c:otherwise>
			          					<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${follow.userNo}" data-toggle="popover" data-placement="top" data-trigger="hover" data-content="${follow.userName}">
			          						<img src="${follow.prPicture}" class="rounded user-img">
			          					</a>
			          				</c:otherwise>
			          			</c:choose>
			          		</c:forEach>
          				</c:otherwise>
				</c:choose>
            </div>
              
              
            <h4 align="center"><b>팔로잉</b></h4><hr>
            <div id="following">
            		<c:choose>
						<c:when test="${empty followinglist}">
							<h3 class="text-center">팔로잉을 시작해보세요~</h3><br>
						</c:when>
						<c:otherwise>
			            	<!-- DB에서 해당 계정의 following 프로필 불러와서 스튜디오로 이동하게끔 구현 -->
			          		<c:forEach items="${followinglist}" var="following">
			          			<c:choose>
			          				<c:when test="${following.prPicture eq null}">
			          					<!-- 해당 회원의 스튜디오로 이동하게 Controller 링크 -->
			          					<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${following.userNo}" data-toggle="popover" data-placement="top" data-trigger="hover" data-content="${following.userName}">
			          						<img title="${following.userId}" src="<%=request.getContextPath()%>/assets/img/user.png" class="rounded user-img">
			          					</a>
			          				</c:when>
			          				<c:otherwise>
			          					<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${following.userNo}" data-toggle="popover" data-placement="top" data-trigger="hover" data-content="${following.userName}">
			          						<img title="${following.userId}" src="${following.prPicture}" class="rounded user-img">
			          					</a>
			          				</c:otherwise>
			          			</c:choose>
			          		</c:forEach>
		          		</c:otherwise>
          			</c:choose>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

	<!-- 메시지 Modal -->
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
		    	<textarea class="form-control" id="msgContent" name="msgContent" rows="3" placeholder="최대 300자까지 가능"></textarea>
		    </div>
		    
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary" id="messageSend" data-dismiss="modal">보내기</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	      
	    </div>
	  </div>
	</div>

	
