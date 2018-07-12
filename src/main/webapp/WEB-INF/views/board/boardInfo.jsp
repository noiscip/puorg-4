<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style type="text/css">
.bootstrap-tagsinput .tag {
	background-color: #9c27b0;
}
</style>

<script type="text/javascript">
    //리뷰 쓰기
    $(function() {
    	baguetteBox.run('.picturezoom');
        $('#savePicture').hide();
        if(${boardInfo.operStateNo}==2){ 
        $('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
        }
        
        //댓글창 스크롤 가장 하단으로 내리기
        $(document).on('click','#scrolldown',function(){
            $('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
        })
        
        //댓글 텍스트 입력 클릭시 스크롤 하단으로 내리기
        $(document).on('click','#reviewcontent',function(){
            if($('#scrolldown').attr("aria-expanded")=='false'){
                $('#scrolldown').click();
            }
        })
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
                        $('#scrolldown').children()[0].innerHTML++;
                        $.ajax({
                            url : "/picsion/comment/insertreview.ps",
                            type : "post",
                            data : {
                                brdNo : ${boardInfo.brdNo},
                                cmtContent : cmtcon
                            },
                            success : function(data) {
                                if(data.result == 0){
                                    alert("댓글 작성 실패");
                                }else{
                                    $("#reviewcontents").empty();
                                      var media="";
                                      $.each(data.commuserlist,function(index,element){
                                            media += "<div class='media'>"+
                                            "<a class='float-left' href='#pablo'>"+
                                            "<div class='avatar'>";
                                            
                                            media += "<img class='media-object avatar-prPic-height' alt='64x64' src='"+element.prPicture+"'>";
                                            
                                            media += "</div></a><div class='media-body'><h4 class='media-heading'>"+
                                                element.userName+"<small>· "+moment(data.comment[index].cmtReg).format('YYYY-MM-DD, H:mm:ss')+"</small>"+
                                                "</h4><p>"+data.comment[index].cmtContent+"</p>";                                            
                                            if($('#loginUserNo').val()==moment(data.comment[index].userNo)){ media += "<a id='commentDel' class='btn btn-rose btn-link float-right message-margin-del' value='"+data.comment[index].cmtNo+"'><i class='material-icons'>clear</i>삭제</a>";}
                                                media+="</div></div>";
                                        })
                                        $("#reviewcontents").append(media);                                   
                                        $('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
                                        $("#reviewcontent").val("");
                                        if(${boardInfo.operStateNo}==2){
                                        var tableNo=4+":"+data.addcomment.cmtNo;
                                        send(receiveUserNo,tableNo);
                                        }
                                }
                              }, 
                              error: function(){
                                  alert("메시지 보내는 도중 오류가 발생했습니다.");
                              }
                        }); 
                    }
                });
        
        
        
        //댓글 삭제
        $(document).on('click', '#commentDel', function(){
            var commbody = $(this).parent().parent()
            var cmtNo = $(this).attr("value")
             $.ajax({
                url:"/picsion/comment/deletecomment.ps",
                data:{cmtNo:cmtNo},
                success:function(data){
                    if(data.result==1){
                    $(commbody).remove();
                    $('#scrolldown').children()[0].innerHTML--;
                    alert("댓글 삭제 완료");
                    }else{
                        alert("댓글 삭제 실패");
                    }
                }
            })
        })
        
        
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
                    
        console.log($("#operApplyPrice").val());
        
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
                            if(data.check == true){
                                alert('성공')
                            }else{
                                var check =''
                                    check += '<div class="alert alert-warning">'
                                    check +=    '<div class="container-fluid">'
                                    check +=        '<div class="alert-icon">'
                                    check +=            '<i class="material-icons">warning</i>'
                                    check +=        '</div>'
                                    check +=        '<button type="button" class="close" data-dismiss="alert" aria-label="Close">'
                                    check +=            '<span aria-hidden="true"><i class="material-icons">clear</i></span>'
                                    check +=        '</button>'
                                    check +=        '<b>Warning Alert</b> 이미 신청 되었습니다'
                                    check +=    '</div>'
                                    check += '</div>'
                                $('.media-footer').after(check)
                            }
                        }
                    }); 
                });
        
        $('#applysummit').on("click",function() {
            var brdNo=${boardInfo.brdNo};
            var requesterNo=${boardInfo.userNo};
            var operPrice=$('#oApplyPrice').attr("operApplyPrice");
            console.log(operPrice);
                    $.ajax({
                        url : "/picsion/operation/operok.ps",
                        type : "post",
                        data : {    
                            requesterNo : requesterNo,
                            operPrice : operPrice,
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
            var html="";
            console.log(formData);
                    $.ajax({
                        url : "/picsion/picture/operpicupload.ps",
                        data : formData,
                        processData: false,
                        contentType: false,
                        type :'POST',                       
                        success : function(data) {
                            console.log(data)
                            $('#upload').remove();
                            html+='<div style="height: 350px; width : 350px; text-align: center;">';
                            html+='<img alt="No Image"  height="100%" width="100%" src="'+data.operPicture.picPath+'">';
                            html+='</div>';
                            $('.apply-register').append(html);
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
            console.log("operApplyPrice : "+$(this).attr("operApplyPrice"));
            var operApplyReg=$(this).children()[2].innerText;
            console.log("operApplyReg : "+operApplyReg);
            var operUserNo=$(this).attr("operUserNo");
            console.log("operUserNo : "+operUserNo);
            var operApplyAppeal=$(this).attr("operApplyAppeal");
            console.log("operApplyAppeal : "+operApplyAppeal);
            
            $('#oUserNo').val(operUserNo);
            $('#applyid').val(applyid);
            $('#oApplyPrice').val(operApplyPrice);
            $('#oApplyPrice').attr("operApplyPrice",$(this).attr("operApplyPrice"));
            $('#oApplyReg').val(operApplyReg);
            $('#oApplyAppeal').val(operApplyAppeal);
            $('#operApplyNo').val(operApplyNo);
        }); 
        
        $('.apply-confirm').hide();
        $('.apply-pic-confirm').click(function(){
            if($('.apply-pic-confirm').hasClass('open-confirm')){
                $('.apply-confirm').hide();
                $('.apply-pic-confirm').removeClass('open-confirm');
            }else{
                $('.apply-confirm').show();
                $('.apply-pic-confirm').addClass('open-confirm');
            }
        });
        
        $('.apply-register').hide();
        $('.apply-pic-register').click(function(){
            if($('.apply-pic-register').hasClass('open-register')){
                $('.apply-register').hide();
                $('.apply-pic-register').removeClass('open-register');
            }else{
                $('.apply-register').show();
                $('.apply-pic-register').addClass('open-register');
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
.avatar-prPic-height {
	height: 64px !important;
}

/* 댓글 쓸때 작게 보여지는 프로필 */
.avatar-sprPic-height {
	height: 30px !important;
}

/* 정보 보여주는곳 여백 */
.board-info-pad {
	padding-left: 100px;
	padding-top: 40px;
}

/* 게시판 내용 뿌려주는 곳 여백 */
.board-card-pad {
	padding-left: 130px;
	padding-right: 30px;
}

/* 게시판 상세 페이지 위에 여백 조정 */
.board-content-pad {
	padding-top: 50px;
}

/* container 아래 여백 */
.board-container-pad {
	padding-bottom: 15px;
}

/* border 안 여백 */
.board-border-pad {
	padding-right: 15px;
	padding-left: 15px;
}

/* 진행중일때 아래 여백 없애기 */
.board-processing-pad {
	padding-top: 40px;
	padding-bottom: 0px;
}

/* 게시판 내용 위 여백 삭제  */
.board-content-toppad {
	padding-top: 0px !important;
}

/* 게시판 내용 패딩 삭제 */
.board-content-paddel {
	padding-top: 0px !important;
	padding-bottom: 0px !important;
}

/* 작업 내용 margin top */
.board-description-mar {
	margin-top: 30px !important;
}

/* 작업자가 작업 사진 등록 버튼 눌렀을때 상단 여백 */
.apply-register {
	padding-top: 40px;
}

.container ul li a.active{
	border-bottom: 2px solid #9c27b0; 
} 
</style>

<input type="hidden"
	value="${boardInfo.tableNo},${boardInfo.userNo},${boardInfo.brdNo},0"
	id="info">

<div id="changemain" class="page-header header-filter"
	data-parallax="true"></div>
	
	
<div class="section section-gray">
	<div class="container board-container-pad">
		<div class="main main-raised main-product">
		
		<ul class="nav nav-tabs-center justify-content-center"  id="myTab"  role="tablist">
		  <li class="nav-item">
		    <a class="nav-link active" id="brdinfo-tab" data-toggle="tab" href="#brdinfo" role="tab" aria-controls="brdinfo" aria-selected="false">상세 정보</a>
		  </li>
		  <c:if test="${boardInfo.operStateNo eq 1 && user.userNo eq boardInfo.userNo }">
		  <li class="nav-item">
		    <a class="nav-link" id="apply-tab" data-toggle="tab" href="#applytablist" role="tab" aria-controls="applytablist" aria-selected="false" >신청 현황</a>
		  </li>
		  </c:if>
		</ul>
		
			<!-- Tab panes -->
		<div class="tab-content">
	
		<!-- 상세 정보 탭 -->
		  <div class="tab-pane active" id="brdinfo" role="tabpanel" aria-labelledby="photo-tab">
		
	
			<div class="row">
				<div class="col-md-12 ml-auto mr-auto">
					<c:choose>
					<c:when test="${boardInfo.operStateNo ne 1}">
						<div class="row">
						<div class="col-md-6">
						<h2 class="title text-center" style="margin: 0">${boardInfo.brdTitle}</h2>
						</div>
						<div class="col-md-3 mr-auto ml-auto">
							<div class="row">
							<div class="col-md-12">
							<div class="row">
							<div class="col-md-5">
							<h4>요청자</h4>
							</div>
							<div class="col-md-4">
							<a data-toggle="popover" data-placement="top" data-trigger="hover" data-content="${requestUser.userName}">
							<img class="rounded img" style="width: 60px;height: 60px"src="${requestUser.prPicture}">
							</a>
							</div>
							</div>
							</div>
							</div>
						</div>
						<div class="col-md-3 mr-auto ml-auto">
						<div class="row">
							<div class="col-md-12">
							<div class="row">
							<div class="col-md-5">
							<h4>작업자</h4>
							</div>
							<div class="col-md-4">
							<a data-toggle="popover" data-placement="top" data-trigger="hover" data-content="${operatorUser.userName}">
							<img class="rounded img" style="width: 60px;height: 60px"src="${operatorUser.prPicture}">
							</a>
							</div>
							</div>
							</div>
							</div>
						</div>
						</div>
					</c:when>
					<c:otherwise>
					<div class="row">
					<div class="col-md-12">
					<h2 class="title text-center"  style="margin: 0">${boardInfo.brdTitle}</h2>
					</div>
					</div>
					</c:otherwise>
					</c:choose>
						<div class="board-border-pad">
							<div class="projects-4 board-processing-pad">
								<div class="row">
								
									<div class="col-md-1"></div>
									<div class="col-md-3 ml-auto">
										<div class="info info-horizontal">
											<div class="icon icon-info">
												<i class="material-icons">date_range</i>
											</div>
											<div class="description">
												<h4 class="info-title">희망 완료 날짜</h4>
												<p class="description">
													<fmt:formatDate pattern="yyyy-MM-dd"
														value="${boardInfo.brdExpectEndDate}" />
												</p>
											</div>
										</div>
										<div class="info info-horizontal">
											<div class="icon icon-success">
												<i class="material-icons">attach_money</i>
											</div>
											<div class="description">
												<h4 class="info-title">희망 금액</h4>
												<p class="description">
													<fmt:formatNumber value="${boardInfo.brdExpectPrice}"
														pattern="#,###" />
													원
												</p>
											</div>
										</div>
										<div class="info info-horizontal">
											<div class="icon icon-rose">
												<i class="material-icons">copyright</i>
											</div>
											<div class="description">
												<h4 class="info-title">저작권</h4>
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

									<div class="col-md-7 mr-auto">
										<div class="card card-background"
											style="background-image:url('<%=request.getContextPath()%>/assets/img/examples/camera-581126_1920.jpg')">
											<a href="#pablo"></a>
											<div class="card-body board-content-paddel card-title">
												<h3 class="card-title">Content</h3>
												<p class="card-title card-description board-description-mar">
													${boardInfo.brdContent}</p>
											</div>
										</div>
									</div>
									<div class="col-md-1"></div>
								</div>
							</div>

							<div class="projects-4 board-content-pad" id="projects-4">
								<div class="row">
									<div class="col-md-12 ml-auto mr-auto" align="left">
										<h3 class="title">Comment</h3>
										<!-- <h3 class="main-price">$335</h3> -->
										<div id="accordion" role="tablist">
											<div class="card card-collapse">
												<div class="card-header" role="tab" id="headingThree">
													<h5 class="mb-0">
														<a id="scrolldown" class="collapsed"
															data-toggle="collapse" href="#collapseThree"
															aria-expanded="false" aria-controls="collapseThree">
															Comment : <span>${fn:length(comment)}</span> <i
															class="material-icons">keyboard_arrow_down</i>
														</a>
													</h5>
												</div>
												<div id="collapseThree" class="collapse" role="tabpanel"
													aria-labelledby="headingThree" data-parent="#accordion"
													style="max-height: 250px; overflow-x: hidden; overflow-y: inherit;">
													<div id="reviewcontents" class="card-body">
														<c:choose>
															<c:when test="${empty comment}">
																<h3 class="category text-muted">아직 댓글이 없습니다.</h3>
															</c:when>
															<c:otherwise>
																<c:forEach var="comm" items="${comment}"
																	varStatus="status">
																	<div class="media">
																		<a class="float-left"
																			href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${commentuser[status.index].userNo}">
																			<div class="avatar">
																				<img class="media-object avatar-prPic-height"
																					alt="64x64"
																					src="${commentuser[status.index].prPicture}">
																			</div>
																		</a>
																		<div style="width: 70%;" class="media-body">
																			<h4 class="media-heading">${commentuser[status.index].userName}<small>·
																					<fmt:formatDate pattern="yyyy-MM-dd, HH:mm:ss"
																						value="${comm.cmtReg}" />
																				</small>
																			</h4>
																			<p>${comm.cmtContent}</p>
																			<c:if test="${comm.userNo==user.userNo}">
																				<a id="commentDel"
																					class="btn btn-rose btn-link float-right message-margin-del"
																					value="${comm.cmtNo}"><i class="material-icons">clear</i>삭제</a>
																			</c:if>
																			<c:if
																				test="${comm.userNo!=user.userNo and sessionScope.user.userNo ne null}">
																				<a
																					class="btn btn-primary btn-link float-right message-margin-del"
																					rel="tooltip" data-original-title="보내버리기"
																					id="${comm.tableNo},${comm.userNo},0,${comm.picNo},${comm.cmtNo}"><i
																					class="material-icons">reply</i>신고</a>
																			</c:if>
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
													aria-labelledby="headingTwo" data-parent="#accordion"
													style="">
													<div class="media media-post">
														<c:choose>
															<c:when test="${sessionScope.user eq null}">
																<h3 class="category text-muted">로그인 후 이용가능합니다.</h3>
															</c:when>
															<c:otherwise>
																<a class="author float-left" href="#pablo">
																	<div class="avatar">
																		<img class="media-object avatar-sprPic-height"
																			alt="64x64" src="${sessionScope.user.prPicture}">
																	</div>
																</a>
																<div class="media-body">
																	<div class="form-group label-floating bmd-form-group">
																		<label class="form-control-label bmd-label-floating"
																			for="exampleBlogPost"> 댓글을 달아보세요...</label>
																		<textarea id="reviewcontent" class="form-control"
																			rows="5"></textarea>
																	</div>
																	<div class="media-footer">
																		<button type="button" id="addreviewbutton"
																			class="btn btn-primary btn-round btn-wd float-right">Post
																			Comment</button>
																			
																			
																		<c:if test="${boardInfo.operStateNo eq 1}">
																		<c:choose>
																			<c:when
																				test="${boardInfo.userNo ne user.userNo && boardInfo.operStateNo eq 1}">
																				<button type="button"
																					class="btn btn-primary btn-md float-left"
																					data-toggle="modal" data-target="#opersend">
																					<i class="material-icons">linked_camera</i>
																					&nbsp;작업 신청
																				</button>
																			</c:when>	
																		</c:choose>
																		</c:if>
																		<c:if test="${boardInfo.operStateNo ne 1}">
																		<c:choose>
																		<c:when test="${boardInfo.userNo eq user.userNo && boardInfo.operStateNo eq 2}">
																				<button type="button"
																					class="btn btn-primary btn-md float-left apply-pic-confirm">
																					<i class="material-icons">linked_camera</i>
																					&nbsp;작업 사진 확인
																				</button>
																			</c:when>
																			<c:otherwise>
																				<c:choose>
																					<c:when test="${boardInfo.operStateNo eq 3}">
																						<button type="button" data-toggle="modal" data-target="#completePicModal"
																							class="btn btn-primary btn-md float-left apply-pic-complete">
																							<i class="material-icons">linked_camera</i>
																							&nbsp;거래된 사진 보기
																						</button>
																					</c:when>
																					<c:otherwise>
																						<button type="button"
																							class="btn btn-primary btn-md float-left apply-pic-register">
																							<i class="material-icons">linked_camera</i>
																							&nbsp;작업 사진 등록
																						</button>
																					</c:otherwise>
																				</c:choose>
																			</c:otherwise>
																		</c:choose>
																		</c:if>
																	</div>
																</div>
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
						<c:if test="${boardInfo.operStateNo eq 2}">
									<div align="center">
										<c:choose>
											<c:when test="${operation.operatorEnd ne 'T'}">
												<button type="button" class="btn btn-danger">작업자 확인</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-success">작업자
													확인</button>
											</c:otherwise>
										</c:choose>
										<c:choose>
											<c:when test="${operation.requesterEnd ne 'T'}">
												<button type="button" class="btn btn-danger">요청자 확인</button>
											</c:when>
											<c:otherwise>
												<button type="button" class="btn btn-success">요청자
													확인</button>
											</c:otherwise>
										</c:choose>
									</div>
								</c:if>
					
				</div>
			</div>
			</div>

			 <!-- 신청 현황 탭-->
			 <div class="tab-pane" id="applytablist" role="tabpanel" aria-labelledby="apply-tab">
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
												operApplyAppeal="${apply.operApplyAppeal}"
												operApplyPrice="${apply.operApplyPrice}">
												<td class="text-center">${applyid[status.index]}</td>
												<td class="text-center"><fmt:formatNumber
														value="${apply.operApplyPrice}" pattern="#,###" />원</td>
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

			<c:if
				test="${boardInfo.operStateNo eq 2 && user.userNo eq operation.operatorNo}">
				<div class="apply-register" align="center">
					<c:choose>
						<c:when
							test="${operation.operatorEnd eq 'T' && operation.requesterEnd eq 'T'}">
							<div class="row">
								<div class="col-md-6">
									<div style="height: 350px; width: 350px;">
										<img alt="No Image" height="100%" id="filePath" width="100%"
											src="${operPicture.picPath}">
									</div>
									<div></div>
								</div>
								<div class="col-md-6">
									<form
										action="<%=request.getContextPath()%>/picture/operationComplete.ps">
										<input type="hidden" name="picPrice"
											value="${operation.operPrice}"> <input type="hidden"
											name="transferState" value="${boardInfo.copyright}">
										<input type="hidden" name="picPath"
											value="${operPicture.picPath}"> <input type="hidden"
											name="userNo" value="${boardInfo.userNo}"> <input
											type="hidden" name="brdNo" value="${boardInfo.brdNo}">
										<div class="form-group">
											<label for="title">제목</label> <input type="text"
												class="form-control" id="pictureTitle" name="picTitle"
												autocomplete="off">
										</div>

										<div class="form-group">
											<label for="description">설명</label> <input type="text"
												class="form-control" id="pictureDesc" name="picContent"
												autocomplete="off">
										</div>

										<!-- <form action=""> -->
										<div id="picTags" class="form-group">
											<label for="comment">Tags</label> <br>
											<div id="loaderIcon"></div>
										</div>
										<!-- </form> -->
										<%--	<div class="form-group">
										<input type="text" name="picPath" value="${picPath}"> 
									</div> --%>
										<div id="tagA"></div>
										<input type="button" id="operPicture" class="btn btn-primary"
											value="사진 검증">
										<button type="submit" id="savePicture" class="btn btn-primary">저장하기</button>
									</form>
								</div>
							</div>
						</c:when>

						<c:otherwise>
							<c:choose>
								<c:when test="${operation.operatorEnd eq 'T'}">
									<div style="height: 350px; width: 350px; text-align: center;">
										<img alt="No Image" height="100%" width="100%"
											src="${operPicture.picPath}">
									</div>
								</c:when>
								<c:otherwise>
									<div id="upload">
										<div id="picupload" align="center">
											<form id="fileForm" action="" enctype="multipart/form-data"
												method="post">
												<input type="hidden" name="operNo"
													value="${operation.operNo}"> <input type="hidden"
													name="brdNo" value="${boardInfo.brdNo}">
												<div class="fileinput fileinput-new text-center"
													data-provides="fileinput">
													<div class="fileinput-new thumbnail img-raised">
														<img
															src="https://epicattorneymarketing.com/wp-content/uploads/2016/07/Headshot-Placeholder-1.png"
															alt="...">
													</div>
													<div
														class="fileinput-preview fileinput-exists thumbnail img-raised">
														<%-- <canvas id="canvasdiv"></canvas> --%>

													</div>
													<div>
														<span
															class="btn btn-raised btn-round btn-default btn-file">
															<span class="fileinput-new">Select image</span> <span
															class="fileinput-exists">Change</span> <input type="file"
															name="file" accept=".jpg, .png, .bmp" />
														</span> <a href="#pablo"
															class="btn btn-danger btn-round fileinput-exists"
															data-dismiss="fileinput"> <i class="fa fa-times"></i>
															Remove
														</a> <input type="button" id="operpic"
															class="btn btn-primary btn-round" value="요청자 보여주기">
													</div>
												</div>

											</form>
										</div>
									</div>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>

			<c:if
				test="${boardInfo.operStateNo eq 2 && user.userNo eq operation.requesterNo}">
				<div class="apply-confirm" align="center">
					<h5>작업자가 올린 사진</h5>
					<div>
						<c:choose>
							<c:when test="${empty operPicture}">
								작업자가 사진을 아직 업로드 하지 않았습니다 :)
							</c:when>
							<c:otherwise>
								<div style="height: 350px; width: 350px;">
									<img alt="No Image" height="100%" width="100%"
										src="${operPicture.picPath}">
								</div>
								<button type="button" id="opercomplete" class="btn btn-success">작업
									수락</button>
							</c:otherwise>
						</c:choose>

					</div>

				</div>
			</c:if>

				<%-- <div class="apply-complete" align="center">
					<h5>
						거래 완료된 사진 <a id="download" href="${operPicture.picPath}"> <i
							class="material-icons">vertical_align_bottom</i>
						</a>
					</h5>
					<div>
						<div style="height: 350px; width: 350px;">
							<img alt="No Image" height="100%" width="100%"
								src="${operPicture.picPath}">
						</div>
					</div>

				</div> --%>
			
			
			
			</div>
			 
			<!-- 0------------------------------------- -->
			
			</div>
			
			</div>
       
		
</div>

<!-- 신청Modal -->
<div class="modal fade" id="opersend" tabindex="1" role="dialog"
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

<!-- 사진 모달 -->
<div class="modal fade" id="completePicModal" tabindex="-1" role="dialog" aria-labelledby="completePicLabel"aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completePicLabel">거래 완료된 사진</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <i class="material-icons">clear</i>
                </button>
            </div>
            <div class="modal-body">
            <div class="row">
            <div class="col-md-12">
            <div class="picture">
            			<div class="picturezoom">
							<a href="${operPicture.picPath}"> 
							<img class="rounded img-fluid" src="${operPicture.picPath}">
							</a></div>
            </div>
            </div>
            </div>
            </div>
            <div class="modal-footer">
                <a id="download" class="btn btn-success btn-link" href="${operPicture.picPath}">Down</a>
                <button type="button" class="btn btn-danger btn-link" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
	$(function() {		
		$('#operPicture').on("click",function() {
			console.log("클릭");
			$('#operPicture').remove();
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
					
					/*색깔*/
					var color =''
					$.each(data.color,function(i,elt){
						
						/* color += '<input type="hidden" name="colorList['+i+']" id="colorList['+i+']" value="'+elt.red +','+ elt.green +','+ elt.blue+'"/>'; */
					 	color += '<input type="hidden" name="colorList['+i+'].colorR" id="colorList['+i+'].colorR" value="'+elt.red+'"/>';
						color += '<input type="hidden" name="colorList['+i+'].colorG" id="colorList['+i+'].colorG" value="'+elt.green+'"/>';
						color += '<input type="hidden" name="colorList['+i+'].colorB" id="colorList['+i+'].colorB" value="'+elt.blue+'"/>';
						
					}) 
					$('#tagA').append(color);
					
					
					$("input[data-role=tagsinput]").tagsinput();
					/* console.log($('.fileinput-preview')["0"].children["0"].src); */
					$('#savePicture').show();
				}
			,beforeSend:function(){
				$("#loaderIcon").html("<img src='<%=request.getContextPath()%>/assets/img/LoaderIcon.gif'/>");
			}
				
			})
		})
	})
</script>
