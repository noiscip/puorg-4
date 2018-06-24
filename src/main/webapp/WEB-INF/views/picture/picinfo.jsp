<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<style>
/* 메시지함 신고버튼, 삭제버튼 여백 삭제 */
.message-margin-del{
	margin: 5px;
	padding: 5px;
}
</style>
<script type="text/javascript">
$(document).ready(function() {
	
	var loginuser = ${sessionScope.user.userNo};
	var userInfoNo = ${userInfo.userNo};
	var picNo = ${picture.picNo}
	//댓글창 스크롤 가장 하단으로 내리기
	$(document).on('click','#scrolldown',function(){
		$('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
	})
	
	//댓글 텍스트 입력 클릭시 스크롤 하단으로 내리기
	$(document).on('click','#newComment',function(){
		if($('#scrolldown').attr("aria-expanded")=='false'){
			$('#scrolldown').click();
		}
	})
	
	//메시지 모달 종료시 내용 삭제
	$(document).on('click','#modaloff',function(){
		 $('#msgContent').val("");
	})
	
	//메시지 보내기 비동기 처리
	$(document).on('click','#messageSend',function(){
		if($('#msgContent').val()==''){
			alert("메시지 내용이 없습니다.");
		}else{
		var tableNo = 4;
		var data= {msgContent:$("#msgContent").val(), 
					sendUserNo:loginuser, 
					receiveUserNo:userInfoNo
				   };
		
		$.ajax({
			  url : "/picsion/message/send.ps",
			  data: data,
			  success : function(){
			      $('#msgContent').val("");
			      send();
			      $("#msgContent").val("");
			      send(receiveUserNo,tableNo);
			  },
			  error: function(){
			   	  alert("메시지 보내는 도중 오류가 발생했습니다.");
			  }
		})
		}
	})
	
	
	
	//팔로우 하기, 취소
	$(document).on('click','#follow',function(){
			var data = {userNo : loginuser, 
						followingUserNo : userInfoNo};			
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
	
	//사진 좋아요
	$(document).on('click','#like',function(){
		var data = {userNo : loginuse,
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
	})
	
	//사진 북마크
	$(document).on('click','#down',function(){
		var data = {userNo : loginuser,
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
	})
	
	//댓글 쓰기
	$(document).on('click','#commentbtn',function(){
		console.log($('#scrolldown').children()[0].innerHTML);
		if($('#newComment').val()==''){
			alert("댓글 내용이 없습니다.");
		}else{
		$('#scrolldown').children()[0].innerHTML++;
		var tableNo = 2; 
		var data= {cmtContent:$("#newComment").val(), 
					userNo:loginuser, 
					picNo:picNo,
					tableNo : tableNo
				   };
		
		$.ajax({
			  url : "<%=request.getContextPath()%>/comment/insertpiccomment.ps",
			  data: data,
			  success : function(data){
				  var media="";
			      $('#commentstart').empty();
			      console.log(data)
			      $.each(data.newcommentUserList,function(index,element){
			    	  console.log(element)
						media += "<div class='media'>"+
					    "<a class='float-left' href='<%=request.getContextPath()%>/picture/mystudio.ps?userNo="+element.userNo+"'>"+
						"<div class='avatar'>";
						if(element.prPicture == null){
							 media += "<img class='media-object' alt='64x64' src='<%=request.getContextPath()%>/assets/img/user.png'>";
						}else{
							media += "<img class='media-object' alt='64x64' src='<%=request.getContextPath()%>"+element.prPicture+"'>";
						}
						media += "</div></a><div class='media-body'><h4 class='media-heading'>"+
							element.userName+"<small>· "+moment(data.newcommentlist[index].cmtReg).format('YYYY-MM-DD, H:mm:ss')+"</small>"+
						    "</h4><p>"+data.newcommentlist[index].cmtContent+"</p><a id='commentDel' class='btn btn-rose btn-link float-right message-margin-del' value='"+data.newcommentlist[index].cmtNo+"'>"+
						    "<i class='material-icons'>clear</i>삭제</a>"+
							"<a class='btn btn-primary btn-link float-right message-margin-del' rel='tooltip' data-original-title='보내버리기' id='" + data.newcommentlist[index].tableNo + ","+element.userNo+",0,"+picNo+","+data.newcommentlist[index].cmtNo+"'><i class='material-icons'>reply</i>신고</a></div></div>";
					}) 
					$('#commentstart').append(media);
			       	$('a[rel=tooltip]').tooltip();
			        $('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
			      	$("#newComment").val("");
			     
			  },
			  error: function(){
			   	  alert("댓글 보내는 도중 오류가 발생했습니다.");
			  }
		});
		}
	})
	
	/* $(document).on('click','a[data-original-title=보내버리기]',function(){
		var info = (this.id).split(',')
		console.log(info)
		console.log(this.parentNode.children[1].innerHTML)
		var content = this.parentNode.children[1].innerHTML
		var data = {
						tableNo : info[0],
						userNo : info[1],
						picNo : info[2],
						cmtNo : info[3],
						blaContent : content
					}
		console.log(data)
	}) */
	
	//댓글 삭제
	$(document).on('click', '#commentDel', function(){
		var commbody = $(this).parent().parent()
		var cmtNo = $(this).attr("value")
		 $.ajax({
			url:"/picsion/comment/deletecomment.ps",
			data:{cmtNo:cmtNo},
			success:function(data){
				if(data.result==1){
				$(commbody).remove()
				$('#scrolldown').children()[0].innerHTML--
				alert("댓글 삭제 완료")
				}else{
					alert("댓글 삭제 실패")
				}
			}
		})
	})
	
})

</script>
<div class="page-header header-filter" data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/bg7.jpg');">
</div>

<input type="hidden" value="${picture.tableNo},${picture.userNo},0,${picture.picNo}" id="info">

<div class="section section-gray">
	<div class="container">
		<div class="main main-raised main-product">
			<div class="row">
				<div class="col-md-6 col-sm-6">
					<div class="card card-blog">
						<div class="card-header card-header-image">
							<a data-toggle="modal" data-target=".bd-example-modal-lg"> <img class="img"	src="<%=request.getContextPath()%>/${picture.picPath}">
								<div class="card-title">
								<c:choose>
								<c:when test="${respectresult eq 1}">
										<span><i id="like" value="${picture.picNo}" style="cursor: pointer;" class="material-icons">favorite</i>${respectCount}</span>
								</c:when>
								<c:otherwise>
										<span><i id="like" value="${picture.picNo}" style="cursor: pointer;" class="material-icons">favorite_border</i>${respectCount}</span>
								</c:otherwise>
								</c:choose>
								<c:choose>
								<c:when test="${bookmarkresult eq 1}">
										<span><i id="down" value="${picture.picNo}" style="cursor: pointer;" class="material-icons">bookmark</i>${bookmarkCount}</span>
								</c:when>
								<c:otherwise>
										<span><i id="down" value="${picture.picNo}" style="cursor: pointer;" class="material-icons">bookmark_border</i>${bookmarkCount}</span>
								</c:otherwise>
								</c:choose>
								</div>
							</a>
							<div class="colored-shadow colored-shadow-big"
								style="background-image: url(&quot;<%=request.getContextPath()%>/${picture.picPath}?auto=format&amp;fit=crop&amp;w=750&amp;q=80&amp;ixid=dW5zcGxhc2guY29tOzs7Ozs%3D&quot;); opacity: 1;"></div>
						</div>
						<div class="card-body"></div>
					</div>
					<div class="team">
						<div class="col-md-12">
							<div class="card card-profile card-plain">
								<div class="row">
									<div class="col-md-5">
										<div class="card-header card-header-image">
											<a
												href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${userInfo.userNo}">
												<c:choose>
													<c:when test="${userInfo.prPicture eq null}">
														<img class="img"
															src="<%=request.getContextPath()%>/assets/img/user.png">
													</c:when>
													<c:otherwise>
														<img class="img"
															src="<%=request.getContextPath()%>${userInfo.prPicture}">
													</c:otherwise>
												</c:choose>
											</a>
											<div class="colored-shadow"
												style="background-image: url(&quot;<%=request.getContextPath()%>/${userInfo.prPicture}&quot;); opacity: 1;"></div>
										</div>
									</div>
									<div class="col-md-7">
										<div class="card-body">
											<h4 class="card-title">${userInfo.userName}</h4>
											<h6 class="category text-muted">photographer</h6>
											<p class="card-description">${userInfo.prContent}</p>
										</div>
										<div class="card-footer justify-content-center">
											<c:choose>
												<c:when test="${sessionScope.user eq null}">
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-default btn-sm"
														data-toggle="modal" data-target="#exampleModal">
														<i class="material-icons"> mail</i> 메시지
													</button>
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
												</c:otherwise>
											</c:choose>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
				<div class="col-md-6 col-sm-6">
					<h2 class="title">${picture.picTitle}</h2>
					<!-- <h3 class="main-price">$335</h3> -->
					<div id="accordion" role="tablist">
						<div class="card card-collapse">
							<div class="card-header" id="headingOne">
								<h5 class="mb-0">
									<a>Content</a>
								</h5>
							</div>
							<div id="collapseOne"  role="tabpanel"
								aria-labelledby="headingOne" data-parent="#accordion" style="">
								<div class="card-body">
									<p>${picture.picContent}</p>
								</div>
							</div>
						</div>
						<div class="card card-collapse">
							<div class="card-header" id="headingTwo">
								<h5 class="mb-0">
									<a>Tag</a>
								</h5>
							</div>
							<div id="collapseTwo"  role="tabpanel"
								aria-labelledby="headingTwo" data-parent="#accordion" style="">
								<div class="card-body">
									<c:forEach var="tag" items="${tagList}">
										<a href="#pablo"> #${tag} </a>
									</c:forEach>
								</div>
							</div>
						</div>
						<div class="card card-collapse">
							<div class="card-header" role="tab" id="headingThree">
								<h5 class="mb-0">
								<a id="scrolldown" class="collapsed" data-toggle="collapse" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                 Comment : <span>${fn:length(commentList)}</span> 
                                 <i class="material-icons">keyboard_arrow_down</i>
                                 </a>
								</h5>
							</div>
							<div id="collapseThree" class="collapse" role="tabpanel"
								aria-labelledby="headingThree" data-parent="#accordion"
								style="max-height: 250px; overflow-x: hidden; overflow-y: inherit;">
								<div id="commentstart" class="card-body">
									<c:choose>
										<c:when test="${empty commentList}">
											<h3 class="category text-muted">아직 댓글이 없습니다.</h3>
										</c:when>
										<c:otherwise>
											<c:forEach var="comm" items="${commentList}" varStatus="status">
												<div class="media">
													<a class="float-left" href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${commentUserList[status.index].userNo}">
														<div class="avatar">
															<c:choose>
																<c:when
																	test="${commentUserList[status.index].prPicture eq null}">
																	<img class="media-object" alt="64x64"
																		src="<%=request.getContextPath()%>/assets/img/user.png">
																</c:when>
																<c:otherwise>
																	<img class="media-object" alt="64x64"
																		src="<%=request.getContextPath()%>${commentUserList[status.index].prPicture}">
																</c:otherwise>
															</c:choose>
														</div>
													</a>
													<div style="width: 70%;" class="media-body">
														<h4 class="media-heading">${commentUserList[status.index].userName}<small>·
																<fmt:formatDate pattern="yyyy-MM-dd, HH:mm:ss"
																	value="${comm.cmtReg}" />
															</small>
														</h4>
														<p>${comm.cmtContent}</p>
														<a id="commentDel" class="btn btn-rose btn-link float-right message-margin-del" value="${comm.cmtNo}"><i class="material-icons">clear</i>삭제</a>
														<a class="btn btn-primary btn-link float-right message-margin-del" rel="tooltip" data-original-title="보내버리기" id="${comm.tableNo},${comm.userNo},0,${comm.picNo},${comm.cmtNo}"><i	class="material-icons">reply</i>신고</a>
													</div>
												</div>
											</c:forEach>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
						<div class="card card-collapse">
							<div class="card-header" role="tab" id="headingTwo">
								<h5 class="mb-0">
									<a>Input Comment</a>
								</h5>
							</div>
							<div id="collapseTwo" role="tabpanel"
								aria-labelledby="headingTwo" data-parent="#accordion" style="">
								<div class="media media-post">
									<c:choose>
										<c:when test="${sessionScope.user eq null}">
											<h3 class="category text-muted">로그인 후 이용가능합니다.</h3>
										</c:when>
										<c:otherwise>
											<a class="author float-left" href="#pablo">
												<div class="avatar">
													<c:choose>
														<c:when test="${sessionScope.user.prPicture eq null}">
															<img class="media-object" alt="64x64"
																src="<%=request.getContextPath()%>/assets/img/user.png">
														</c:when>
														<c:otherwise>
															<img class="media-object" alt="64x64" src="<%=request.getContextPath()%>${sessionScope.user.prPicture}">
														</c:otherwise>
													</c:choose>
												</div>
											</a>
											<div class="media-body">
												<div class="form-group label-floating bmd-form-group">
													<label class="form-control-label bmd-label-floating"
														for="exampleBlogPost"> 댓글을 달아보세요...</label>
													<textarea id="newComment" class="form-control" rows="5"></textarea>
												</div>
												<div class="media-footer">
													<button type="button" id="commentbtn"
														class="btn btn-primary btn-round btn-wd float-right">Post
														Comment</button>
														<button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#reportModal">신고</button>
												</div>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-12 col-sm-12">
					<div align="center">

						<h1 class="card-title">
							<small>$</small>199
						</h1>
						<button class="btn btn-rose btn-round card-title">
							Buy &nbsp;<i class="material-icons">shopping_cart</i>
						</button>
					</div>

				</div>
			</div>
		</div>
		<div class="related-products">
			<h3 class="title text-center">You may also be interested in:</h3>
			<div class="row">
			<c:forEach var="rList" items="${respectList}" begin="0" end="3" varStatus="status">
			<div class="col-sm-6 col-md-3">
					<div class="card card-product">
						<div class="card-header card-header-image">
							<a href="<%=request.getContextPath()%>/picture/picinfo.ps?picNo=${rList.picNo}">
							<img class="img" src="<%=request.getContextPath()%>${rList.picPath}"></a>
							<div class="colored-shadow"	style="background-image: url(&quot;<%=request.getContextPath()%>${rList.picPath}&quot;); opacity: 1;"></div>
						</div>
						<div class="card-body">
							<h6 class="card-category text-rose">Popular</h6>
							<h4 class="card-title">
								${rList.picTitle}
							</h4>
							<div class="card-description"> ${rList.picContent}
						</div>
						<div class="card-footer justify-content-center">
							<div class="price">
								<span style="cursor: " class="btn btn-just-icon btn-link btn-rose">
									<i class="material-icons">favorite</i>
								</span> 
							</div>
							<div class="stats">
								<span class="btn btn-just-icon btn-link btn-rose">
									${rList.respectCount}
								</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			</c:forEach>
			</div>
		</div>
	</div>
</div>




<!-- 메시지 모달 -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="">
	<div class="modal-dialog modal-login" role="document">
		<div class="modal-content">
			<div class="card card-signup card-plain">
				<div class="modal-header">
					<div class="card-header card-header-primary text-center">
						<button type="button" id="modaloff"class="close" data-dismiss="modal"
							aria-hidden="true">
							<i class="material-icons">clear</i>
						</button>
						<h4 class="card-title">Message</h4>

					</div>
				</div>
				<div class="modal-body">
					<form class="form" method="" action="">
						<p class="description text-center">메시지를 전하세요...</p>
						<div class="card-body">
							<div class="form-group label-floating bmd-form-group">
								<label class="form-control-label bmd-label-floating"
									for="message"> Your message</label>
								<textarea class="form-control" rows="6" id="msgContent"
									name="msgContent"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer justify-content-center">
					<button type="button"
						class="btn btn-primary btn-link btn-wd btn-lg" id="messageSend"
						data-dismiss="modal">Send</button>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 사진 확대 모달 -->
<div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
     <div class="card card-blog">
    <div class="card-header card-header-image">
            <img class="img" src="<%=request.getContextPath()%>/${picture.picPath}">
    </div>
</div>
    </div>
  </div>
</div>