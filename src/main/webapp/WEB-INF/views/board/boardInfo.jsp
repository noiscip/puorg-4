<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	//리뷰 쓰기
	$(function() {
		$('#addreviewbutton').on("click",function() {
					console.log("click");
					if ($('#reviewcontent').val().trim() == "") {
						alert("리뷰 내용을 입력해주세요.");
					} else {	
						$.ajax({
							url : "insertreview.ps",
							type : "post",
							data : {
								brdNo : ${boardInfo.brdNo},
								cmtContent : $("#reviewcontent").val()
							},
							success : function(data) {
								var html="";
								$.each(data.comment,function(index,obj){
									html+=data.commuserid[index]+" : "+obj.cmtContent+"<br>";
									html+="<hr style='margin-top: 5px; margin-bottom: 5px;'>";
								}); 
								console.log(html);
								$(".review").empty();
								$(".review").append(html); 
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
						url : "apply.ps",
						type : "post",
						data : {
							operApplyAppeal : $("#operApplyAppeal").val(),
							operApplyPrice : $("#operApplyPrice").val(),
							operApplyReg : $("#operApplyReg").val(),
							requestUserNo : ${boardInfo.userNo},
							brdNo : ${boardInfo.brdNo}
						},
						success : function(data) {}
					});	
				});
		

		$('#applysummit').on("click",function() {
			var brdNo=${boardInfo.brdNo};
			var requesterNo=${boardInfo.userNo};
					$.ajax({
						url : "operok.ps",
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
							console.log(data.check);
							location.href="boardInfo.ps?brdNo="+brdNo;
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
	});
</script>



<div class="page-header header-filter" data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
			<div class="row" style="border-width: 1px; text-align: center;">
				<div class="col-md-12 ml-auto mr-auto">
				<h2 class="title">${boardInfo.brdTitle}</h2>
					<p>
						<font>${boardInfo.brdContent}</font>
					</p>
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
								<a>거래금액</a>
							</h5>
						</div>
						<div id="collapseTwo" class="collapse show" role="tabpanel"
							aria-labelledby="headingTwo" data-parent="#accordion" style="">
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
							aria-labelledby="headingTwo" data-parent="#accordion" style="">
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
							aria-labelledby="headingTwo" data-parent="#accordion" style="">
							<div class="card-body">${boardInfo.copyright}</div>
						</div>
					</div>
				</div>

				<div class="col-md-6 col-sm-6">
					<div id="re" style="text-align: center;">
						<h3 class="title">작업 메시지함</h3>
						<!-- <h3 class="main-price">$335</h3> -->
						<div id="accordion" role="tablist">

							<div class="card card-collapse">
								
								<div id="collapseThree" class="collapse show" role="tabpanel"
									aria-labelledby="headingThree" data-parent="#accordion"
									style="height: 250px; overflow-x: hidden; overflow-y: inherit;">
									<div class="card-body">	
										
								<c:forEach var="review1" items="${comment}" varStatus="status">
						
										<div class="media">
											<a class="float-left" href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${review1.userNo}">
												<div class="avatar">
												<c:choose>
													<c:when test="${review1.userNo eq sessionScope.user.userNo}">			
																			
														<img class="media-object" alt="Tim Picture"
															src="<%=request.getContextPath()%>/${sessionScope.user.prPicture}">
													</c:when>
													<c:otherwise>
														<img class="media-object" alt="Tim Picture"
															src="<%=request.getContextPath()%>/${operuser.prPicture}">
													</c:otherwise>
												</c:choose>
												
											
												
												</div>
											</a>
											<div class="media-body">
												<h4 class="media-heading">
													${commuserid[status.index]}<small>· Yesterday</small>
												</h4>
												<p>${review1.cmtContent} </p>
												<div class="media-footer">
													<a href="#pablo"
														class="btn btn-primary btn-link float-right" rel="tooltip"
														title="" data-original-title="보내버리기"> <i
														class="material-icons">reply</i> 신고
													</a>
												</div>
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
									aria-labelledby="headingTwo" data-parent="#accordion" style="">
									<div class="media media-post">
										<a class="author float-left" href="#pablo">
											<div class="avatar">
												<img class="media-object" alt="64x64"
													src="<%=request.getContextPath()%>/${sessionScope.user.prPicture}">
											</div>
										</a>
										<div class="media-body">
											<div class="form-group label-floating bmd-form-group">
												<label class="form-control-label bmd-label-floating"
													for="exampleBlogPost"> 댓글을 달아보세요...</label>
												<textarea class="form-control" rows="5" id="reviewcontent"></textarea>
											</div>
											<div class="media-footer">
												<a href="#pablo"
													class="btn btn-primary btn-round btn-wd float-right" id="addreviewbutton">Post
													Comment</a>
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
                </div>
            </div>
		</c:when>
	</c:choose>	


			<table class="table">
				<thead>
					<tr>
						<th class="text-center">작업신청자</th>
						<th class="text-center">금액</th>
						<th class="text-center">마감 날짜</th>
					</tr>
				</thead>
				<tbody>

					<c:choose>
						<c:when test="${boardInfo.userNo eq user.userNo}">
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
						</c:when>
						<c:otherwise>
							<button type="button" class="btn btn-default btn-sm"
								data-toggle="modal" data-target="#exampleModal">신청하기</button>
						</c:otherwise>
					</c:choose>

				</tbody>
			</table>



		</div>

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

