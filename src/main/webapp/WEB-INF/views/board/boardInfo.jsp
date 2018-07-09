<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script type="text/javascript">
	//리뷰 쓰기
	$(function() {
		if(${boardInfo.operStateNo}==2){ 
		$('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
		}
		var myNo = $('#loginUserNo').val();
		if(${operation.operNo} != 0)
		{
		var receiveUserNo=${operation.requesterNo}; 
			if(myNo==receiveUserNo){
					receiveUserNo=${operation.operatorNo};
				}
		}
		/* $('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight); */
		$('#addreviewbutton').on("click",function() {
					console.log("click");
					var cmtcon=$("#reviewcontent").val();
					if ($('#reviewcontent').val().trim() == "") {
						alert("리뷰 내용을 입력해주세요.");
					} else {	
						$.ajax({
							url : "/picsion/comment/insertreview.ps",
							type : "post",
							data : {
								brdNo : ${boardInfo.brdNo},
								cmtContent : cmtcon
							},
							success : function(data) {
								console.log(data.addcomment);
								$("#reviewcontents").empty();
								  var media="";
							      $.each(data.commuserlist,function(index,element){
										media += "<div class='media'>"+
									    "<a class='float-left' href='#pablo'>"+
										"<div class='avatar'>";
										
										media += "<img class='media-object avatar-prPic-height' alt='64x64' src='"+element.prPicture+"'>";
										
										media += "</div></a><div class='media-body'><h4 class='media-heading'>"+
											element.userName+"<small>· "+moment(data.comment[index].cmtReg).format('YYYY-MM-DD, H:mm:ss')+"</small>"+
										    "</h4><p>"+data.comment[index].cmtContent+"</p>"+
										    "<a href='#pablo' class='btn btn-primary btn-link float-right'"+
											"rel='tooltip' title='' data-original-title='보내버리기' id='" + data.comment[index].tableNo + ","+element.userNo+","+data.comment[index].brdNo+",0,"+data.comment[index].cmtNo+"' > <i "+
											"class='material-icons'>reply</i>신고</a></div></div>";
									})
									$("#reviewcontents").append(media); 									
							        $('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
							      	$("#reviewcontent").val("");
							      	if(${boardInfo.operStateNo}==2){
							      	var tableNo=4+":"+data.addcomment.cmtNo;
									send(receiveUserNo,tableNo);
							      	}
							     
							  }, 
							  error: function(){
							   	  alert("메시지 보내는 도중 오류가 발생했습니다.");
							  }
						});	
					}
				});
		
		
		$('.datetimepicker').datetimepicker({
		    icons: {
		        time: "fa fa-clock-o",
		        date: "fa fa-calendar",
		        up: "fa fa-chevron-up",
		        down: "fa fa-chevron-down",
		        previous: 'fa fa-chevron-left',
		        next: 'fa fa-chevron-right',
		        today: 'fa fa-screenshot',
		        clear: 'fa fa-trash',
		        close: 'fa fa-remove'
		    }
		});
		
		
		
		$('#apply').on("click",function() {
					
		console.log("apply클릭");
		
					$.ajax({
						url : "/picsion/operationApply/apply.ps",
						type : "post",
						data : {
							operApplyAppeal : $("#operApplyAppeal").val(),
							operApplyPrice : $("#operApplyPrice").val(),
							operApplyReg : $("#operApplyReg").val(),
							requestUserNo : ${boardInfo.userNo},
							brdNo : ${boardInfo.brdNo}
						},
						success : function(data) {
							console.log(data);
						}
					});	
				});
		

		$('#applysummit').on("click",function() {
			var brdNo=${boardInfo.brdNo};
			var requesterNo=${boardInfo.userNo};
					$.ajax({
						url : "/picsion/operation/operok.ps",
						type : "post",
						data : {	
							requesterNo : requesterNo,
							operPrice : $("#oApplyPrice").val(),
							operEndReg : Date($("#oApplyReg").val()),
							brdNo : brdNo,
							operatorNo : $("#oUserNo").val(),
							operApplyNo : $("#operApplyNo").val()
						}, 
						success : function(data) {
							console.log("test");
							console.log(data.check);
							location.href="/picsion/board/boardInfo.ps?brdNo="+brdNo;
						}
					});	
				});
		
		$('#operpic').on("click",function() {
			console.log($(this))
			var formData = new FormData($('#fileForm')[0]);
			console.log(formData);
					$.ajax({
						url : "/picsion/picture/operpicupload.ps",
						data : formData,
						processData: false,
						contentType: false,
						type :'POST',						
						success : function(data) {
							console.log(data)
							console.log("성공");
						}
					});	
			});
		
		
		$('#opercomplete').on("click",function() {
			console.log("haha");
			var brdNo=${boardInfo.brdNo};
					$.ajax({
						url : "/picsion/operation/opercomplete.ps",						
						type :'POST',	
						data : {
							brdNo : brdNo
						},
						success : function(data) {
							console.log("성공");
						}
					});	
			});
		
		
		$('.applyModal').on("click",function() {
			var operApplyNo=$(this).attr("operApplyNo");
			var applyid=$(this).children()[0].innerText;
			console.log("applyid : "+applyid);
			var operApplyPrice=$(this).children()[1].innerText;
			console.log("operApplyPrice : "+operApplyPrice);
			var operApplyReg=$(this).children()[2].innerText;
			console.log("operApplyReg : "+operApplyReg);
			var operUserNo=$(this).attr("operUserNo");
			console.log("operUserNo : "+operUserNo);
			var operApplyAppeal=$(this).attr("operApplyAppeal");
			console.log("operApplyAppeal : "+operApplyAppeal);
			
			$('#oUserNo').val(operUserNo);
			$('#applyid').val(applyid);
			$('#oApplyPrice').val(operApplyPrice);
			$('#oApplyReg').val(operApplyReg);
			$('#oApplyAppeal').val(operApplyAppeal);
			$('#operApplyNo').val(operApplyNo);
		}); 
		
		$('.apply-table').hide();
		$('.apply-status').click(function(){
			if($('.apply-status').hasClass('open-table')){
				$('.apply-table').hide();
				$('.apply-status').removeClass('open-table');
			}else{
				$('.apply-table').show();
				$('.apply-status').addClass('open-table');
			}
		});
	});
	
	
	$(document).on("click", "#tagAdd", function() {
	    if($('#tagAddName').val()==0){
	        alert("태그를 입력해주세요.");
	    }else{
	        $('#picTags').append("<input type='text' value="+$('#tagAddName').val()+" name='tag' data-role='tagsinput'>");
	        $("input[data-role=tagsinput]").tagsinput();
	        $('#tagAddName').val("");
	    }
	    
	});
</script>

<style>
	/* 댓글 보여지는 창 프로필 사진 */
	.avatar-prPic-height{
		height: 64px;
	}
	
	/* 댓글 쓸때 작게 보여지는 프로필 */
	.avatar-sprPic-height{
		height: 30px;
	}
	
	/* 정보 보여주는곳 여백 */
	.board-info-pad{
		 padding-left: 100px;
   		 padding-top: 40px;
	}
	
	/* 게시판 내용 뿌려주는 곳 여백 */
	.board-card-pad{
	    padding-left: 130px;
	    padding-right: 30px;
	}
	
	/* 게시판 상세 페이지 위에 여백 조정 */
	.board-content-pad{
		padding-top: 40px;
	}
	
	/* container 아래 여백 */
	.board-container-pad{
		padding-bottom: 15px;
	}
	
	/* border 안 여백 */
	.board-border-pad{
		padding-right: 15px;
		padding-left: 15px;
	}
	
</style>

<input type="hidden" value="${boardInfo.tableNo},${boardInfo.userNo},${boardInfo.brdNo},0" id="info">

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
<div class="section section-gray">
		<div class="container board-container-pad">
<div class="main main-raised main-product">
			<div class="row" align="center" >
				<div class="col-md-12 ml-auto mr-auto">
					<h2 class="title">${boardInfo.brdTitle}</h2>
					
					<c:if test="${boardInfo.operStateNo eq 1}">
						<div class="board-border-pad">
						<div class="row board-content-pad">
							<div class="col-md-4 info-horizontal mr-auto ml-auto">
		                         <div class="description">
		                             <h4 class="info-title "><i class="material-icons" style="color: #00bcd4">date_range</i> 희망 완료 날짜</h4>
		                             <p class="description">
		                                 <fmt:formatDate pattern="yyyy-MM-dd, HH:mm:ss" value="${boardInfo.brdExpectEndDate}" />
		                             </p>
		                         </div>
		                    </div>
		                    <div class="col-md-4 info-horizontal mr-auto ml-auto">
		                        <div class="description">
		                            <h4 class="info-title"><i class="material-icons" style="color: #9c27b0">attach_money</i> 희망 가격</h4>
		                            <p class="description">
		                                ${boardInfo.brdExpectPrice}원
		                            </p>
		                        </div>
		                    </div>
		                    <div class="col-md-4 info-horizontal mr-auto ml-auto">
		                        <div class="description">
		                            <h4 class="info-title"><i class="material-icons" style="color: #f44336">copyright</i> 저작권</h4>
		                            <p class="description">
		                            	<c:choose>
		                            		<c:when test="${boardInfo.copyright eq 'T'}">
		                            			저작권 양도 허용
		                            		</c:when>
		                            		<c:otherwise>
		                            			저작권 양도 거부
		                            		</c:otherwise>
		                            	</c:choose>
		                            </p>
		                        </div>
		                    </div>
						
					</div>
					
					<div class="card card-collapse">
							<div class="card-header" id="headingOne">
								<h5 class="mb-0">
									
								</h5>
							</div>
							<div id="collapseOne" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordion">
								<div class="card-body">
									<p>${boardInfo.brdContent}</p>
								</div>
							</div>
							<div class="card-header" id="headingOne">
								<h5 class="mb-0">
									
								</h5>
							</div>
						</div>
					
					
					
					<div class="projects-4 board-content-pad" id="projects-4">
						<div class="row">
							<div class="col-md-12 ml-auto mr-auto" align="left">
								<h3 class="title">Comment</h3>
										<!-- <h3 class="main-price">$335</h3> -->
										<div id="accordion" role="tablist">
											<div class="card card-collapse">

												<div id="collapseThree" class="collapse show"
													role="tabpanel" aria-labelledby="headingThree"
													data-parent="#accordion"
													style="height: 250px; overflow-x: hidden; overflow-y: inherit;">
													<div class="card-body" id="reviewcontents">

														<c:forEach var="review1" items="${comment}"
															varStatus="status">

															<div class="media">
																<a class="float-left"
																	href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${review1.userNo}">
																	<div class="avatar">
																		<img class="media-object avatar-prPic-height" alt="Tim Picture"
																			src="${commentuser[status.index].prPicture}">
																	</div>
																</a>
																<div class="media-body">
																	<h4 class="media-heading">

																		${commentuser[status.index].userName} <small>·
																			<fmt:formatDate pattern="yyyy-MM-dd, HH:mm:ss"
																				value="${review1.cmtReg}" />
																		</small>

																	</h4>
																	<p>${review1.cmtContent}</p>
																	<a href="#pablo" class="btn btn-primary btn-link float-right" rel="tooltip" title="" data-original-title="보내버리기" id="${review1.tableNo},${review1.userNo},${review1.brdNo},0,${review1.cmtNo}">
																		<i class="material-icons">reply</i> 신고
																	</a>
																</div>
															</div>

														</c:forEach>

													</div>
												</div>
											</div>
											<div class="card card-collapse">
												<div class="card-header" role="tab" id="headingTwo">
													<h5 class="mb-0">
														<a>Input Comment</a>
													</h5>
												</div>
												<div id="collapseTwo" class="collapse show" role="tabpanel"
													aria-labelledby="headingTwo" data-parent="#accordion"
													style="">
													<div class="media media-post">
														<a class="author float-left" href="#pablo">
															<div class="avatar">
																<img class="media-object avatar-sprPic-height" alt="64x64"
																	src="${sessionScope.user.prPicture}">
															</div>
														</a>
														<div class="media-body">
															<div class="form-group label-floating bmd-form-group">
																<label class="form-control-label bmd-label-floating"
																	for="exampleBlogPost"> 댓글을 달아보세요...</label>
																<textarea class="form-control" rows="5"
																	id="reviewcontent"></textarea>
															</div>
															<div class="media-footer">
																<a href="#pablo"
																	class="btn btn-primary btn-round btn-wd float-right"
																	id="addreviewbutton">댓글 작성</a>
																
																<c:choose>
																	<c:when	test="${boardInfo.userNo ne user.userNo && boardInfo.operStateNo eq 1}">
																		<button type="button" class="btn btn-primary btn-md float-left" style="float:right" data-toggle="modal" data-target="#exampleModal">
																			<i class="material-icons">linked_camera</i> &nbsp;작업 신청
																		</button>
																	</c:when>
																	<c:otherwise>
																		<button type="button" class="btn btn-primary btn-md float-left apply-status" style="float:right">
																			<i class="material-icons">linked_camera</i> &nbsp;신청 현황
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
							</div>
						</div>
						</div>					
					</c:if>
				</div>
			</div>
			<c:choose>
				<c:when test="${boardInfo.operStateNo eq 2}">
					<div class="section section-comments">
						<div class="row">
							<div class="col-md-12 ml-auto mr-auto">

								<div class="row">
									<div class="col-md-6 col-sm-6">
										<h3 class="title" style="text-align: center">작업 정보</h3>
										<div class="card card-collapse">
											<div class="card-header" role="tab" id="headingTwo">
												<h5 class="mb-0">
													<a>요청자</a>
												</h5>
											</div>
											<div id="collapseTwo" class="collapse show" role="tabpanel"
												aria-labelledby="headingTwo" data-parent="#accordion"
												style="">
												<div class="card-body">${requestUser.userName}</div>
											</div>
										</div>
										<div class="card card-collapse">
											<div class="card-header" role="tab" id="headingTwo">
												<h5 class="mb-0">
													<a>작업자</a>
												</h5>
											</div>
											<div id="collapseTwo" class="collapse show" role="tabpanel"
												aria-labelledby="headingTwo" data-parent="#accordion"
												style="">
												<div class="card-body">${operatorUser.userName}</div>
											</div>
										</div>
										<div class="card card-collapse">
											<div class="card-header" role="tab" id="headingTwo">
												<h5 class="mb-0">
													<a>거래금액</a>
												</h5>
											</div>
											<div id="collapseTwo" class="collapse show" role="tabpanel"
												aria-labelledby="headingTwo" data-parent="#accordion"
												style="">
												<div class="card-body">${boardInfo.brdExpectPrice}</div>
											</div>
										</div>
										<div class="card card-collapse">
											<div class="card-header" role="tab" id="headingTwo">
												<h5 class="mb-0">
													<a>작업완료날짜</a>
												</h5>
											</div>
											<div id="collapseTwo" class="collapse show" role="tabpanel"
												aria-labelledby="headingTwo" data-parent="#accordion"
												style="">
												<div class="card-body">${boardInfo.brdExpectEndDate}</div>
											</div>
										</div>
										<div class="card card-collapse">
											<div class="card-header" role="tab" id="headingTwo">
												<h5 class="mb-0">
													<a>저작권 양도여부</a>
												</h5>
											</div>
											<div id="collapseTwo" class="collapse show" role="tabpanel"
												aria-labelledby="headingTwo" data-parent="#accordion"
												style="">
												<div class="card-body">${boardInfo.copyright}</div>
											</div>
										</div>
									</div>

									<div class="col-md-6 col-sm-6">
										<h3 class="title">작업 메시지함</h3>
										<!-- <h3 class="main-price">$335</h3> -->
										<div id="accordion" role="tablist">

											<div class="card card-collapse">

												<div id="collapseThree" class="collapse show"
													role="tabpanel" aria-labelledby="headingThree"
													data-parent="#accordion"
													style="height: 250px; overflow-x: hidden; overflow-y: inherit;">
													<div class="card-body" id="reviewcontents">

														<c:forEach var="review1" items="${comment}"
															varStatus="status">

															<div class="media">
																<a class="float-left"
																	href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${review1.userNo}">
																	<div class="avatar">
																		<img class="media-object avatar-prPic-height" alt="Tim Picture"
																			src="${commentuser[status.index].prPicture}">
																	</div>
																</a>
																<div class="media-body">
																	<h4 class="media-heading">

																		${commentuser[status.index].userName} <small>·
																			<fmt:formatDate pattern="yyyy-MM-dd, HH:mm:ss"
																				value="${review1.cmtReg}" />
																		</small>

																	</h4>
																	<p>${review1.cmtContent}</p>
																	<a href="#pablo" class="btn btn-primary btn-link float-right" rel="tooltip" title="" data-original-title="보내버리기" id="${review1.tableNo},${review1.userNo},${review1.brdNo},0,${review1.cmtNo}">
																		<i class="material-icons">reply</i> 신고
																	</a>
																</div>
															</div>

														</c:forEach>

													</div>
												</div>
											</div>
											<div class="card card-collapse">
												<div class="card-header" role="tab" id="headingTwo">
													<h5 class="mb-0">
														<a>Input Comment</a>
													</h5>
												</div>
												<div id="collapseTwo" class="collapse show" role="tabpanel"
													aria-labelledby="headingTwo" data-parent="#accordion"
													style="">
													<div class="media media-post">
														<a class="author float-left" href="#pablo">
															<div class="avatar">
																<img class="media-object avatar-sprPic-height" alt="64x64"
																	src="${sessionScope.user.prPicture}">
															</div>
														</a>
														<div class="media-body">
															<div class="form-group label-floating bmd-form-group">
																<label class="form-control-label bmd-label-floating"
																	for="exampleBlogPost"> 댓글을 달아보세요...</label>
																<textarea class="form-control" rows="5"
																	id="reviewcontent"></textarea>
															</div>
															<div class="media-footer">
																<a href="#pablo"
																	class="btn btn-primary btn-round btn-wd float-right"
																	id="addreviewbutton">Post Comment</a>
																<button class="btn btn-primary btn-sm"
																	data-toggle="modal" data-target="#reportModal">신고</button>
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
						
						<div align="center">
							<c:choose>
								<c:when test="${operation.operatorEnd ne 'T'}">
									<button type="button" class="btn btn-danger">작업자 확인</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-success">작업자 확인</button>
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${operation.requesterEnd ne 'T'}">
									<button type="button" class="btn btn-danger">요청자 확인</button>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn btn-success">요청자 확인</button>
								</c:otherwise>
							</c:choose>
						</div>
						
						
					</div>
				</c:when>
			</c:choose>

			<c:choose>
				<c:when
					test="${boardInfo.userNo eq user.userNo && boardInfo.operStateNo ne 2}">
					<table class="table apply-table">
						<thead>
							<tr>
								<th class="text-center">작업신청자</th>
								<th class="text-center">금액</th>
								<th class="text-center">마감 날짜</th>
							</tr>
						</thead>
						<tbody>

							<c:choose>
								<c:when test="${empty applylist}">
									<tr>
										<td colspan="3" style="text-align: center;">신청자가 없습니다.</td>
									</tr>
								</c:when>
								<c:otherwise>
									<div class="apply">
										<c:forEach var="apply" items="${applylist}" varStatus="status">
											<tr class="applyModal" style="cursor: pointer;"
												data-toggle="modal" data-target="#operModal"
												operApplyNo="${apply.operApplyNo}"
												operUserNo="${apply.operUserNo}"
												operApplyAppeal="${apply.operApplyAppeal}">
												<td class="text-center">${applyid[status.index]}</td>
												<td class="text-center">${apply.operApplyPrice}</td>
												<td class="text-center">${apply.operApplyReg}</td>
											</tr>
										</c:forEach>
									</div>
								</c:otherwise>
							</c:choose>

						</tbody>

					</table>
				</c:when>				
			</c:choose>
		</div>
	<!-- </div> -->
	<c:if test="${boardInfo.operStateNo eq 2 && user.userNo eq operation.operatorNo}">
		<c:choose>
			<c:when test="${operation.operatorEnd eq 'T' && operation.requesterEnd eq 'T'}">
			<div style="height: 350px; width : 350px;">
				<img alt="No Image" height="100%" id="filePath" width="100%" src="${operPicture.picPath}">
				</div>
				<input type="button" id ="operPicture" class="btn btn-primary btn-round" value="사진 업로드">
				
					<div class="col-md-6">
						<form action="<%=request.getContextPath()%>/picture/operationComplete.ps">
								<input type="hidden" name="picPrice" value="${operation.operPrice}">
								<input type="hidden" name="transferState" value="${boardInfo.copyright}">
								<input type="hidden" name="picPath" value="${operPicture.picPath}">
								<input type="hidden" name="userNo" value="${boardInfo.userNo}">
								<input type="hidden" name="brdNo" value="${boardInfo.brdNo}">
							<div class="form-group">
								<label for="title">제목</label> <input type="text"
									class="form-control" id="pictureTitle" name="picTitle">
							</div>
	
							<div class="form-group">
								<label for="description">설명</label> <input type="text"
									class="form-control" id="pictureDesc" name="picContent">
							</div>
	
							<!-- <form action=""> -->
							<div id="picTags" class="form-group">
								<label for="comment">Tags</label> <br>
									<div id="loaderIcon">
								
									</div>
							</div>
							<!-- </form> -->
					<%--	<div class="form-group">
								<input type="text" name="picPath" value="${picPath}"> 
							</div> --%>
							<div id="tagA">
							
							</div>
							<button type="submit" class="btn btn-primary">저장하기</button>
						</form>
					</div>
							
			</c:when>
			
			<c:otherwise>
				<div id="upload">
					<div class="card card-collapse">
						<div class="card-header" role="tab" id="picupload1">
							<h5 class="mb-0 title">
								<a class="collapsed" data-toggle="collapse" href="#picupload" style="text-align: center;"
									aria-expanded="false" aria-controls="picupload">사진 업로드</a>
							</h5>
						</div>
						<div id="picupload" class="collapse" role="tabpanel"
							aria-labelledby="picupload1" data-parent="#upload">
							<div class="card-body">
									<form id="fileForm" action=""
									enctype="multipart/form-data" method="post">
										<input type="hidden" name="operNo" value="${operation.operNo}">
										<input type="hidden" name="brdNo" value="${boardInfo.brdNo}">
									<div class="fileinput fileinput-new text-center"
										data-provides="fileinput">
										<div class="fileinput-new thumbnail img-raised" >
											<img
												src="https://epicattorneymarketing.com/wp-content/uploads/2016/07/Headshot-Placeholder-1.png"
												alt="...">
										</div>
										<div class="fileinput-preview fileinput-exists thumbnail img-raised"> 
										<%-- <canvas id="canvasdiv"></canvas> --%>
											
										</div> 
										<div>
											<span class="btn btn-raised btn-round btn-default btn-file"> 
												<span class="fileinput-new">Select image</span> <span
												class="fileinput-exists">Change</span> <input type="file"
												name="file" accept=".jpg, .png, .bmp" />
											</span> <a href="#pablo"
												class="btn btn-danger btn-round fileinput-exists"
												data-dismiss="fileinput"> <i class="fa fa-times"></i>
												Remove
											</a>
										</div>
									</div>
									<input type="button" id ="operpic" class="btn btn-primary btn-round" value="요청자 보여주기">
								</form>
							</div>
						</div>
					</div>
				</div>
			</c:otherwise>
		</c:choose>
		
	</c:if>
	<c:if test="${boardInfo.operStateNo eq 2 && user.userNo eq operation.requesterNo}">
	<div  align="center">
	<h5>작업자가 올린 사진</h5>
		<div>
			<c:choose>
				<c:when test="${empty operPicture}">
					아직 사진 안올림
				</c:when>
				<c:otherwise>
							
				
					<div style="height: 350px; width : 350px;">
						<img alt="No Image" height="100%" width="100%" src="${operPicture.picPath}">
					</div>
					<button type="button" id="opercomplete" class="btn btn-success">작업 수락</button>
					<button type="button" class="btn btn-success">재촬영신청</button>
					<button type="button" class="btn btn-success">신고</button>
				</c:otherwise>
			</c:choose>
			
		</div>
		
	</div>
	</c:if>
</div>
</div>

<!-- 신청Modal -->
<div class="modal fade" id="exampleModal" tabindex="1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">참여신청 페이지</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<div class="form-group">
					<label for="exampleInput1" class="bmd-label-floating">판매금액</label>
					<input type="text" class="form-control" id="operApplyPrice"
						name="operApplyPrice">
				</div>
				<div class="form-group">
					<label class="label-control">희망 완료 날짜</label> <input type="text"
						class="form-control datetimepicker" id="operApplyReg"
						name="operApplyReg" />
				</div>
				<div class="form-group">
					<label for="exampleFormControlTextarea1">간단한 소개글</label>
					<textarea class="form-control" id="operApplyAppeal"
						name="operApplyAppeal" rows="3"></textarea>
				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="apply"
					data-dismiss="modal">신청</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>

		</div>
	</div>
</div>

<!-- 신청자 상세  Modal Core -->
<div class="modal fade" id="operModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="myModalLabel">신청자 상제보기</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
			</div>
			<div class="modal-body">

				<form>
					<fieldset disabled>
						<input type="text" style="display: none;" id="oUserNo"
							name="operUserNo" class="form-control"> <input
							type="text" style="display: none;" id="operApplyNo"
							name="operApplyNo" class="form-control">
						<div class="form-group">
							<label for="disabledTextInput">신청자</label> <input type="text"
								id="applyid" class="form-control">
						</div>
						<div class="form-group">
							<label for="disabledTextInput">판매가격</label> <input type="text"
								id="oApplyPrice" name="operApplyPrice" class="form-control">
						</div>
						<div class="form-group">
							<label for="disabledTextInput">완료 예정일</label> <input type="text"
								id="oApplyReg" name="operApplyReg" class="form-control">
						</div>
						<div class="form-group">
							<label for="disabledTextInput">참고사항</label> <input type="text"
								id="oApplyAppeal" name="operApplyAppeal" class="form-control">
						</div>

					</fieldset>
					<button type="button" class="btn btn-primary" id="applysummit"
						data-dismiss="modal">수락</button>
				</form>

			</div>

		</div>
	</div>
</div>
<script>
	$(function() {		
		$('#operPicture').on("click",function() {
			console.log("클릭");
			var filePath = $("#filePath").attr("src");
			console.log(filePath);
			$.ajax({
				url : "/picsion/opervision.ps",
				data : {filePath:filePath},
				type :'POST',
				success : function(data){
					console.log(data)
					$("#loaderIcon").empty();
					if(data.logo != null){
					var logo =''
						logo += '<div class="alert alert-warning">'
						logo += 	'<div class="container-fluid">'
						logo += 		'<div class="alert-icon">'
						logo += 			'<i class="material-icons">warning</i>'
						logo += 		'</div>'
						logo += 		'<button type="button" class="close" data-dismiss="alert" aria-label="Close">'
						logo += 			'<span aria-hidden="true"><i class="material-icons">clear</i></span>'
						logo += 		'</button>'
						logo += 		'<b>Warning Alert</b>' + data.logo
						logo += 	'</div>'
						logo += '</div>'
						
						$('h1').after(logo)
					}
 					/*얼굴감지*/
 					 if(data.face != null){
 						console.log("얼굴그리기")
 						/* $('canvas').drawImage({
 							source: $('.fileinput-preview')["0"].children["0"].src,
 							x: 10, y: 10,
 							load:rec
 						});
 						function rec(){
 							console.log("이게 되낭?");
 							$('canvas').drawRect({
								strokeStyle:"#FF0000",
								strokeWidth:4,
								x:data.face["0"].x_0, y:data.face["0"].y_1,
								width:data.face["0"].width,
								height:data.face["0"].height
 							});
 						}
 						 */
 						 
 						  /* $('#aaaa').append("<img style='width:100%;height:100%' src='"+$('.fileinput-preview')['0'].children['0'].src+"'>"); */ 
 						//이 밑에 잠시 주석걸겠습니다
 						/* $('canvas').drawImage({
 							source: $('.fileinput-preview')['0'].children['0'].src,
 							x: 100, y: 100,
 							load:rec
 						});
 						function rec(){
 							console.log("이게 되낭?");
 							$('canvas').drawRect({
 							strokeStyle:"#FF0000",
 							strokeWidth:2,
 							x:100, y:100,
 							width:20,
 							height:20
 							});
 						}
 */ 						
 					} 
					var safe = ''
					if(data.safe != null){
						safe += '<div class="alert alert-danger">'
						safe += 	'<div class="container-fluid">'
						safe += 		'<div class="alert-icon">'
						safe += 			'<i class="material-icons">warning</i>'
						safe += 		'</div>'
						safe += 		'<button type="button" class="close" data-dismiss="alert" aria-label="Close">'
						safe += 			'<span aria-hidden="true"><i class="material-icons">clear</i></span>'
						safe += 		'</button>'
						safe += 		'<b>Warning Alert</b>' + data.safe
						safe += 	'</div>'
						safe += '</div>'
						$('h1').after(safe)
					}
					
					var tags = ''
					$.each(data.label, function(i, elt) {
						tags += '<input type="text" value="' + elt + '" data-role="tagsinput" name="tag">'
					})
					$.each(data.label2,function(i,elt){
						tags += '<input type="text" value="' + elt + '" data-role="tagsinput" name="tag">'
					})
					
					$('#picTags').append(tags)
					
					
					
					var cameraName = data.metaMap.cameraName=='undefined'? 'null' : data.metaMap.cameraName;
					var resolH = data.metaMap.resolH=='undefined'? 'null' : data.metaMap.resolH;
					var resolW = data.metaMap.resolW=='undefined'? 'null' : data.metaMap.resolW;
					var pictureDate = data.metaMap.pictureDate=='undefined'? 'null' : data.metaMap.pictureDate;
					var lensName = data.metaMap.lensName=='undefined'? 'null' : data.metaMap.lensName;
					
					
					tags ='<br><br>태그추가: <input type="text" id="tagAddName">';
					tags +='<button type="button" class="btn btn-primary" id="tagAdd">추가</button><br>';
					tags += '<input type="text" name="picPath" value="' + data.picPath + '">';
					tags += '<input type="hidden" name="camera" id="camera" value="'+cameraName+'"/>';
					tags += '<input type="hidden" name="resolutionH" id="resolutionH" value="'+resolH+'"/>';
					tags += '<input type="hidden" name="resolutionW" id="resolutionW" value="'+resolW+'"/>';
					tags += '<input type="hidden" name="photoDate" id="photoDate" value="'+Date(pictureDate)+'"/>';
					tags += '<input type="hidden" name="lens" id="lens" value="'+lensName+'"/>';
					
					
					$('#tagA').append(tags)
					/* $('#taginputtest').attr("data-role","tagsinput"); */
					console.log('와요?')
					$("input[data-role=tagsinput]").tagsinput();
					/* console.log($('.fileinput-preview')["0"].children["0"].src); */
				}
			,beforeSend:function(){
				$("#loaderIcon").html("<img src='<%=request.getContextPath()%>/assets/img/LoaderIcon.gif'/>");
			}
				
			})
		})
	})
</script>
