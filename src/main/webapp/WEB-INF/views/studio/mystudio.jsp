<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


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
				  success : function(data){
					  if(data.result == 0){
						  alert("메시지 보내는 도중 오류가 발생했습니다.");
					  }else{
						  $("#msgContent").val("");
					      send(receiveUserNo,tableNo);
					  }
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
	        var currentScrollTop = $(window).scrollTop();
	        var scrollPage="";
	        
	        if( currentScrollTop - lastScrollTop > 0 ){
	            if ($(window).scrollTop() >= ($(document).height() - $(window).height()) ){ 
	            	if($('#photo-library').hasClass('active')){
		            	$.ajax({
		                    type : 'post',  
		                    url : '/picsion/picture/mystudio.ps',
		                    data : { 
		                        page: page,
		                        userNo: receiveUserNo
		                    },
		                    success : function(data){
		                        
		                        $.each(data.scrollPicList, function(index, obj){
		                        		scrollPage="<div class='item col-sm-12 col-md-4'>"+
										"<a href='/picsion/picture/picinfo.ps?picNo="+obj.picNo+"'>"+
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
										scrollPage+="</div><a href='/picsion/picture/mystudio.ps?userNo="+obj.userNo+"'>"+obj.userName+"</a></div></div>";
										
			                        	$('#studioview').append(scrollPage);
		                        })
							    page+=data.endpage;
		                    }
		                });
	                }
	            }
	        }
	    })
		
	    var userNo = ${userNo};
	    
	    $(document).on('click','#followPre',function(){
	    	var pg = $(this).data("pg");
	    	
	    	followingPaging(userNo, pg)
	    })
	    
	    $(document).on('click', '#followCha', function(){
	    	var pg = $(this).data("pg");
	    	
	    	followingPaging(userNo, pg)
	    })
	    
	    $(document).on('click', '#followNe', function(){
	    	var pg = $(this).data("pg");
	    	
	    	followingPaging(userNo, pg)
	    })
	    
	    $(document).on('click','#followerPre',function(){
	    	var pg = $(this).data("pg");
	    	
	    	followerPaging(userNo, pg)
	    })
	    
	    $(document).on('click', '#followerCha', function(){
	    	var pg = $(this).data("pg");
	    	
	    	followerPaging(userNo, pg)
	    })
	    
	    $(document).on('click', '#followerNe', function(){
	    	var pg = $(this).data("pg");
	    	
	    	followerPaging(userNo, pg)
	    })
	    
	})
	
function followingPaging(userNo, pg){
		var following = "";
		
		$.ajax({
			url:"/picsion/picture/followpaging.ps",
			data:{
					userNo:userNo,
					pg:pg
				},
			success:function(data){
				$('#followPage').empty();
				
				var fromPage = data.fromPage-1;
				var toPage = data.toPage+1;
				
				following="<div class='row'>";
				$.each(data.followingPaging, function(index, obj){
					following+="<div class='col-md-1 col-lg-2'>"+
							   "<div class='card card-profile card-plain'>"+
							   	"<div class='card-header card-header-image'>"+
							   		"<a href='<%=request.getContextPath()%>/picture/mystudio.ps?userNo="+obj.userNo+"' class='prPic-height'>"+
							   				"<img class='img prPic-height' src='"+obj.prPicture+"'></a>"+
							   	"<div class='colored-shadow' style='background-image: url(&quot;"+obj.prPicture+"&quot;); opacity: 1;'></div></div>"+
							   	"<div class='card-body'>"+
							   		"<h4 class='card-title'>"+obj.userName+"</h4>"+
							   	"</div></div></div>";
				})
				
				following+="</div><div class='row'>"+
							"<div class='com-md-12 mr-auto ml-auto'>"+
								"<nav aria-label='Page navigation example'>"+
								"<ul class='pagination justify-content-center'>";
								
								if(data.pg>data.block){
									following+="<li class='page-item'><a class='page-link' data-pg='"+ fromPage + "' id='followPre'>Previous</a></li>";
								}
								
								for(var i=data.fromPage; i<=data.toPage; i++){
									if(i==data.pg){
										following+="<li class='page-item active'>"+
		                             				"<a class='page-link' href='#'>"+i+"</a></li>";
									}else{
										following+="<li class='page-item'>"+
		                             			"<a class='page-link' data-pg='"+i+"' id='followCha'>"+i+"</a></li>";
									}
								}
								
								if(data.toPage<data.allPage){
									following+="<li class='page-item'>"+
						      					"<a class='page-link' data-pg='"+toPage+"' id='followNe'>Next</a>"+
						    				   "</li>";
								}
				following+=	"</ul></nav></div></div>";
				$('#followPage').append(following);
			}
		})
}
	
function followerPaging(userNo, pg){
	var follower = "";
	
	$.ajax({
		url:"/picsion/picture/followerpaging.ps",
		data:{
				userNo:userNo,
				pg:pg
			},
		success:function(data){
			$('#followerPage').empty();
			
			var fromPage = data.fromPage-1;
			var toPage = data.toPage+1;
			
			follower="<div class='row'>";
			$.each(data.followerPaging, function(index, obj){
				follower+="<div class='col-md-1 col-lg-2'>"+
						   "<div class='card card-profile card-plain'>"+
						   	"<div class='card-header card-header-image'>"+
						   		"<a href='<%=request.getContextPath()%>/picture/mystudio.ps?userNo="+obj.userNo+"' class='prPic-height'>"+
						   				"<img class='img prPic-height' src='"+obj.prPicture+"'></a>"+
						   	"<div class='colored-shadow' style='background-image: url(&quot;"+obj.prPicture+"&quot;); opacity: 1;'></div></div>"+
						   	"<div class='card-body'>"+
						   		"<h4 class='card-title'>"+obj.userName+"</h4>"+
						   	"</div></div></div>";
			})
			
			follower+="</div><div class='row'>"+
						"<div class='com-md-12 mr-auto ml-auto'>"+
							"<nav aria-label='Page navigation example'>"+
							"<ul class='pagination justify-content-center'>";
							
							if(data.pg>data.block){
								follower+="<li class='page-item'><a class='page-link' data-pg='"+ fromPage + "' id='followerPre'>Previous</a></li>";
							}
							
							for(var i=data.fromPage; i<=data.toPage; i++){
								if(i==data.pg){
									follower+="<li class='page-item active'>"+
	                             				"<a class='page-link' href='#'>"+i+"</a></li>";
								}else{
									follower+="<li class='page-item'>"+
	                             			"<a class='page-link' data-pg='"+i+"' id='followerCha'>"+i+"</a></li>";
								}
							}
							
							if(data.toPage<data.allPage){
								follower+="<li class='page-item'>"+
					      					"<a class='page-link' data-pg='"+toPage+"' id='followerNe'>Next</a>"+
					    				   "</li>";
							}
			follower+=	"</ul></nav></div></div>";
			$('#followerPage').append(follower);
		}
	})
}
	
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
	
	/* 팔로잉 잡고 있는 div 크기 고정 */
	.following-div{
		width:160px;
		height:160px;
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
	
	/* tab 좌우 여백 */
	.following-tab-pad{
		padding-left: 50px;
    	padding-right: 50px;
	}
	
	/* 팔로잉, 팔로워 위 아래 여백 */
	.following-tab-tb{
		padding-top: 50px !important;
		padding-bottom: 70px !important;
	}
	
	/* 프로필 사진 높이 고정 */
	.prPic-height{
		height: 110px;
	}
	
	.container ul li a.active{
		border-bottom: 2px solid #9c27b0; 
	}
</style>

<input type="hidden" value="${userinfo.tableNo},${userinfo.userNo},0,0" id="info">

  <div id="changemain" class="page-header header-filter" data-parallax="true"></div>
  <div class="main">
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
              			<img src="${userinfo.prPicture}" alt="Circle Image" class="img-raised rounded-circle img-fluid studio-prPic-wid">
              		</c:otherwise>
              	</c:choose>
              </div>
              
              <div class="name">
                <h3 class="title">${userinfo.userName}</h3>
              </div>
              
              <c:choose>
              <c:when test="${sessionScope.user eq null}">
              </c:when>
              <c:otherwise>
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
				  	<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#messageModal">
				  		<i class="material-icons">mail</i> 메시지
				  	</button>
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
                  <a class="nav-link active" href="#studio"  role="tab" data-toggle="tab" id="photo-library">
                    <i class="material-icons">photo_library</i> Studio
                  </a>
                </li>
                <li class="nav-item">
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
					 <fmt:parseNumber var="var3" value="${studioPic.resolutionW/studioPic.resolutionH}" pattern="#.#" />
						  <div class="item col-sm-12 col-md-4">
							<a href="/picsion/picture/picinfo.ps?picNo=${studioPic.picNo}">
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
			                    <a href="/picsion/picture/mystudio.ps?userNo=${studioPic.userNo}">${studioPic.userName}</a>
               				</div>
						</div>
						
					</c:forEach>
					</div>
					</div>
				</div>
			</div> 
            
          </div>
          
          <div class="tab-pane text-center following-tab-pad" id="favorite">
          		<ul class="nav nav-tabs-center justify-content-center following-tab-tb"  id="myTab"  role="tablist">
				  <li class="nav-item">
				    <a class="nav-link active" id="following-tab" data-toggle="tab" href="#following" role="tab" aria-controls="following" aria-selected="true">팔로잉</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" id="follower-tab" data-toggle="tab" href="#follower" role="tab" aria-controls="follower" aria-selected="false" >팔로워</a>
				  </li>
				</ul>
				
				<div class="tab-content">
					<div class="tab-pane active" id="following" role="tabpanel" aria-labelledby="following-tab">
						<div class="col-md-10 col-lg-10 mr-auto ml-auto" id="followPage">
		 		 			<div class="row">
			 		 			<c:choose>
									<c:when test="${empty followingList}">
										<div class="col-md-12 mr-auto ml-auto">
											<h3 class="text-center">팔로잉을 시작해보세요~</h3><br>
										</div>
									</c:when>
									<c:otherwise>
										<c:forEach items="${followingList}" var="following">
								 		   <div class="col-md-1 col-lg-2">
						                        <div class="card card-profile card-plain">
						                            <div class="card-header card-header-image">
						                                <a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${following.userNo}" class="prPic-height">
						                                    <img class="img prPic-height" src="${following.prPicture}">
						                                </a>
						                            <div class="colored-shadow" style="background-image: url(&quot;${following.prPicture}&quot;); opacity: 1;"></div></div>
						                            <div class="card-body ">
						                                <h4 class="card-title">${following.userName}</h4>
						                            </div>
						                        </div>
						                    </div>
						                 </c:forEach>
									</c:otherwise>
								</c:choose>
								</div>
								<div class="row">
			 		 				<div class="com-md-12 mr-auto ml-auto">
				 		 				<nav aria-label="Page navigation example">
										  <ul class="pagination justify-content-center">
										  
										  	<!-- 처음 이전 링크 -->
						                    <c:if test="${pg>block}">
						                         <li class="page-item"><a class="page-link" data-pg="${fromPage-1}" id="followPre">Previous</a></li>
						                    </c:if>
					                     	
					                     	<!-- 블록 범위 찍기 -->
						                    <c:forEach begin="${fromPage}" end="${toPage}" var="i">
						                         <c:if test="${i==pg}">
						                             <li class="page-item active">
						                             	<a class="page-link" href="#">${i}</a>
						                             </li>
						                         </c:if>
						                         <c:if test="${i!=pg}">
						                             <li class="page-item">
						                             	<a class="page-link" data-pg="${i}" id="followCha">${i}</a>
						                             </li>
						                         </c:if>
						                    </c:forEach>
										    
										    <!-- 다음, 이후 -->
						                    <c:if test="${toPage<allPage}">
						                        <li class="page-item">
										      		<a class="page-link" data-pg="${toPage+1}" id="followNe">Next</a>
										    	</li>
						                    </c:if>
										    
										  </ul>
										</nav>
									</div>
		 		 			</div>
	 		 			</div>
					</div>
					
					<div class="tab-pane" id="follower" role="tabpanel" aria-labelledby="follower-tab">
						<div class="col-md-10 col-lg-10 mr-auto ml-auto" id="followerPage">
			 		 			<div class="row">
				 		 			<c:choose>
					 		 			<c:when test="${empty followerList}">
					 		 				<div class="col-md-12 mr-auto ml-auto">
												<h3 class="text-center">팔로워가 없네요..ㅠㅠ</h3><br>
											</div>
										</c:when>
										<c:otherwise>
											<c:forEach items="${followerList}" var="follower" >
									 		   <div class="col-md-1 col-lg-2">
							                        <div class="card card-profile card-plain">
							                            <div class="card-header card-header-image">
							                                <a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${follower.userNo}" class="prPic-height">
							                                    <img class="img prPic-height" src="${follower.prPicture}">
							                                </a>
							                            <div class="colored-shadow" style="background-image: url(&quot;${follower.prPicture}&quot;); opacity: 1;"></div></div>
							                            <div class="card-body ">
							                                <h4 class="card-title">${follower.userName}</h4>
							                            </div>
							                        </div>
							                    </div>
						                    </c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="row">
			 		 				<div class="com-md-12 mr-auto ml-auto">
				 		 				<nav aria-label="Page navigation example">
										  <ul class="pagination justify-content-center">
										  
										  	<!-- 처음 이전 링크 -->
						                    <c:if test="${pg>block}">
						                         <li class="page-item"><a class="page-link" data-pg="${werFromPage-1}" id="followerPre">Previous</a></li>
						                    </c:if>
					                     	
					                     	<!-- 블록 범위 찍기 -->
						                    <c:forEach begin="${werFromPage}" end="${werToPage}" var="i">
						                         <c:if test="${i==pg}">
						                             <li class="page-item active">
						                             	<a class="page-link" href="#">${i}</a>
						                             </li>
						                         </c:if>
						                         <c:if test="${i!=pg}">
						                             <li class="page-item">
						                             	<a class="page-link" data-pg="${i}" id="followerCha">${i}</a>
						                             </li>
						                         </c:if>
						                    </c:forEach>
										    
										    <!-- 다음, 이후 -->
						                    <c:if test="${werToPage<werAllPage}">
						                        <li class="page-item">
										      		<a class="page-link" data-pg="${werToPage+1}" id="followerNe">Next</a>
										    	</li>
						                    </c:if>
										    
										  </ul>
										</nav>
									</div>
			 		 			</div>
						</div>
					</div>
				</div>
          	
          </div>
        </div>
      </div>
    </div>
  </div>

	<!-- 메시지 Modal -->
	<div class="modal fade" id="messageModal" tabindex="1" role="dialog" aria-labelledby="messageModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="messageModalLabel">메시지</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body">
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

	
