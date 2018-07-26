<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style type="text/css">
.bootstrap-tagsinput .tag {
	background-color: #9c27b0;
}
/*얼굴 영역 잡기 */
.face-rectangle {
	/* id:faceIt; */
	position: absolute;
	height: 100px;
	width: 100px;
	border-width: 3px;
	border-style: solid;
	border-color: #F2F2F2;
	background-color: transparent;
	/*  background-position: inherit; */
}

input[type=radio] {
	display: none;
}

input[type=radio]+label {
	display: inline-block;
	cursor: pointer;
	/* 	line-height: 22px; */
	padding-left: 22px;
	/* 	background: url('/picsion/assets/img/favicon.png') left/22px no-repeat; */
	border-width: 2px;
	border-style: solid;
	border-color: #BDBDBD;
}

input[type=radio]:checked+label {
	/* background-image: url('/picsion/assets/img/loading_bar2.gif'); */
	border-width: 2px;
	border-style: solid;
	border-color: #9c27b0;
}

.bootstrap-tagsinput .tag {
	border: 2px solid;
	background-color: #fff;
	color: #9c27b0;
}
</style>

<script type="text/javascript">
    //리뷰 쓰기
    $(function() {
    	baguetteBox.run('.picturezoom');
        $('#savePicture').hide();
        if(${boardInfo.operStateNo}==2){ 
        	if(${operation.step}==2){
        		
        	}else{
        	$('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
        	}
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
        var brdNo = ${boardInfo.brdNo};
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
                                brdNo : brdNo,
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
                            brdNo : brdNo
                        },
                        success : function(data) {
                            console.log(data);
                            if(data.check == "true"){
                            	var tableNo=10+":"+brdNo+":새로운 작업신청이 있습니다.";
                            	send(${boardInfo.userNo},tableNo);
                                alert('성공');                                
                                
                            }else{
                                /* var check =''
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
                                $('.media-footer').after(check) */
                            	alert("이미 신청 되었습니다.");
                            }
                        }
                    }); 
                });
        
        $('#applysummit').on("click",function() {
            
            var requesterNo=${boardInfo.userNo};
            var userPoint=${user.point};
            var operPrice=$('#oApplyPrice').attr("operApplyPrice");
            if((userPoint-operPrice)>0){
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
                            var tableNo=10+":"+brdNo+":요청자가 작업을 수락하였습니다.";
                            send($("#oUserNo").val(),tableNo);
                        }
                    }); 
            }
            else{
            	alert("돈이 부족합니다.");
            }
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
                            var tableNo=10+":"+brdNo+":작업자가 사진을 올렸습니다 확인해주세요";
                            send(receiveUserNo,tableNo);
                        }
                    }); 
            });
        
        
        $('#opercomplete').on("click",function() {
            console.log("haha");
            
                    $.ajax({
                        url : "/picsion/operation/opercomplete.ps",                       
                        type :'POST',   
                        data : {
                            brdNo : brdNo
                        },
                        success : function(data) {
                            console.log("성공");
                            location.href="/picsion/board/boardInfo.ps?brdNo="+brdNo;
                            var tableNo=10+":"+brdNo+":요청자가 사진을 마음에 들어합니다.";
                            send(receiveUserNo,tableNo);
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
    
    function drawFace(imgId,rectX,rectY,rectWid,rectHei){
    	var img,sagac;
    	var wid,hei,scalWid,scalHei;
    	img = document.getElementById(imgId);
    	sagac = document.createElement("DIV");
    	sagac.setAttribute("class","face-rectangle");
    	
    	img.parentElement.insertBefore(sagac,img);
    /* 	sagac.style.backgroundImage = "url('"+img.src+"')"; */
    	sagac.style.backgroundRepeat = "no-repeat";
    	/* sagc.style.background-origin = "padding-box"; */
    	sagac.style.width= rectWid + "px";
    	sagac.style.height=rectHei + "px";
    	
    	sagac.style.backgroundSize = img.width + "px " + img.height + "px";
    	showRect();
    	function showRect(){
    		var x,y;
    		
    		x = rectX; 
    		y = rectY;
    		x*=1;
    		sagac.style.left = x+"px";
    		sagac.style.top = y+"px";
    	}
    	
    }
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

<div id="changemain" class="page-header header-filter"	data-parallax="true">
	<div class="container">
       <div class="row title-row">
           <div class="col-md-4 ml-auto">
           
           <div class="tab-content tab-space">
			<div class="tab-pane <c:if test='${operation.step == 0}'>active</c:if>" id="step-1">
		<c:choose>
			<c:when
				test="${boardInfo.userNo ne user.userNo}">
				<button type="button"
					class="btn btn-primary btn-md float-right"
					data-toggle="modal" data-target="#opersend">
					<i class="material-icons">linked_camera</i>
					&nbsp;작업 신청
				</button>
			</c:when>	
		</c:choose>
			</div>
			<div class="tab-pane <c:if test='${operation.step == 1}'>active</c:if>" id="step-2">
			<c:choose>
				<c:when test="${boardInfo.userNo eq user.userNo}">
				<c:choose>
					<c:when test="${operation.operatorEnd eq 'T'}">
						<button type="button" data-toggle="modal" data-target="#checkPicModal"
							class="btn btn-primary btn-md float-right">
							<i class="material-icons">linked_camera</i>
							&nbsp;작업 사진 확인
						</button>
					</c:when>
					<c:when test="${operation.requesterEnd eq 'T'}">
						<button type="button" data-toggle="modal" data-target="#checkPicModal"
							class="btn btn-success btn-md float-right">
							<i class="material-icons">linked_camera</i>
							&nbsp;검증 대기
						</button>
					</c:when>
					<c:otherwise>
						<button type="button" data-toggle="modal" data-target="#checkPicModal"
							class="btn btn-danger btn-md float-right">
							<i class="material-icons">linked_camera</i>
							&nbsp;사진 등록 대기
						</button>
					</c:otherwise>
				</c:choose>
				
				</c:when>
				<c:otherwise>
				<c:choose>
				<c:when test="${operation.requesterEnd ne 'T'}">
						<button type="button" data-toggle="modal" data-target="#uploadPicModal"
					class="btn btn-primary btn-md apply-pic-register float-right">
					<i class="material-icons">linked_camera</i>
					&nbsp;작업 사진 등록
				</button>
				</c:when>
				<c:otherwise>
						<button type="button"
						class="btn btn-success btn-md apply-pic-register float-right">
						<i class="material-icons">linked_camera</i>
						&nbsp;사진 검증
						</button>
				</c:otherwise>
				</c:choose>
			
				</c:otherwise>
			</c:choose>
			
			</div>
			<div class="tab-pane <c:if test='${operation.step == 2}'>active</c:if>" id="step-3">
			</div>
			<div class="tab-pane <c:if test='${operation.step == 3}'>active</c:if>" id="step-4">
			<button type="button" data-toggle="modal" data-target="#completePicModal"
					class="btn btn-primary btn-md apply-pic-complete float-right">
					<i class="material-icons">linked_camera</i>
					&nbsp;거래된 사진 보기
			</button>
			</div>
		</div>
           
           </div>
       </div>
    </div>
</div>
	
	
<div class="section section-gray">
	<div class="container board-container-pad">
		<div class="main main-raised main-product">
		
		<div class="row">
		<div class="col-md-12">
		<!-- 전체 진행 탭-->
			<ul class="nav nav-pills nav-pills-icons justify-content-center"" role="tablist">
				<!-- 진행 전 -->
			    <li class="nav-item">
			        <div class="nav-link <c:if test='${operation.step == 0}'>active</c:if>" 
			        data-toggle="popover" data-placement="top" data-trigger="hover" data-content="요청자와 작가의 매칭이 이루어집니다">
			            <i class="material-icons">people</i> 
			                            step1 매칭하기
			        </div>
			    </li>
			    <!-- 진행 중 -->
			    <li class="nav-item">
			        <div class="nav-link <c:if test='${operation.step == 1}'>active</c:if>"
			        data-toggle="popover" data-placement="top" data-trigger="hover" data-content="작가의 사진을 요청자가 확인합니다">
			            <i class="material-icons">add_photo_alternate</i>
			                           step2 사진확인
			        </div>
			    </li>
			    <!-- 진행 중 -->
			    <li class="nav-item">
			        <div class="nav-link <c:if test='${operation.step == 2}'>active</c:if>"
			        data-toggle="popover" data-placement="top" data-trigger="hover" data-content="PICSION에서 사진을 검증합니다">
			            <i class="material-icons">verified_user</i>
			                         step3 사진검증
			        </div>
			    </li>
			    <!-- 진행 완료 -->
			    <li class="nav-item ">
			        <div class="nav-link <c:if test='${operation.step == 3}'>active</c:if>"
			        data-toggle="popover" data-placement="top" data-trigger="hover" data-content="요청자는 사진을 받을 수 있습니다">
			            <i class="material-icons">collections</i>
			                           step4 완료
			        </div>
			    </li>
			</ul>
		
		</div>
		</div>
		<hr>
		<br>
	
	    <c:if test='${operation.step == 2}'>
	    
			<c:if test="${user.userNo eq operation.operatorNo}">
				<div class="apply-register">
					<c:choose>
						<c:when
							test="${operation.operatorEnd eq 'T' && operation.requesterEnd eq 'T'}">
							<div class="row">
								<div class="col-md-6">
								<!--  -->
										<div class="fileinput fileinput-new text-center" style="height: 350px; width: 350px;"
											data-provides="fileinput">
											<div class="fileinput-new thumbnail">
												<!-- <img src="assets/img/up.png" alt="..."> -->
												<div style="height: 350px; width: 350px;" id ="preview">
													<img alt="No Image" height="100%" id="filePath" width="100%"
														src="${operPicture.picPath}">
												</div>
											</div>
											<!-- <div class="fileinput-preview fileinput-exists thumbnail">
				
											</div> -->
											
											<div id="peopleRadio" class="form-group" style="display: none;">
												<br> 
												<label for="numberPeople">사람수</label> 
												<input type="radio" name="picPeople" id="zero" value="0">
												<label for="zero"> 0 
													<img src="/picsion/assets/img/userNo.png" width="30px" height="30px">
												</label> 
												<input type="radio" name="picPeople" id="one" value="1">
												<label for="one"> 1 
													<img src="/picsion/assets/img/user1.png" width="30px" height="30px">
												</label> 
												<input type="radio" name="picPeople" id="two" value="2">
												<label for="two"> 2 
													<img src="/picsion/assets/img/user2.png" width="30px" height="30px">
												</label> 
												<input type="radio" name="picPeople" id="thr" value="3">
												<label for="thr"> 3~5 
													<img src="/picsion/assets/img/user5.png" width="30px" height="30px">
												</label> 
												<input type="radio" name="picPeople" id="six" value="6">
												<label for="six"> 6+ 
													<img src="/picsion/assets/img/user6.png" width="30px" height="30px">
												</label>
											</div>
											<div class="form-group" id="price" style="display: none;">
												<label for="price">희망 가격</label> 
												<input type="text" class="form-control" id="picPrice" name="picPrice" style="width: 90%">
											</div>
										</div>
								<!--  -->
									
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
										<div id="tagA"></div>
										<input type="button" id="operPicture" class="btn btn-primary"
											value="사진 검증">
										<button type="submit" id="savePicture" class="btn btn-primary">저장하기</button>
									</form>
								</div>
							</div>
						</c:when>

						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</div>
			</c:if>
			<c:if test="${user.userNo eq operation.requesterNo}">
					<div class="col-md-8 mr-auto ml-auto">
                            <div class="card card-blog card-plain text-center">
                                <div>
                                    <a>
                                        <img class="img" src="<%=request.getContextPath()%>/assets/img/eyeMove.gif">
                                    </a>
                                </div>
                                <div class="card-body ">
                                    <h4 class="card-category text-success">검증</h4>

                                    <p class="card-description">작업자의 사진을 검증 중입니다.</p>
                                    <p class="card-description">작업자의 사진이 검증될 때까지 기다려주세요.</p>
                                </div>
                            </div>

                        </div>
			
			
			</c:if>
	    
	    </c:if>
	    <c:if test='${operation.step != 2}'>
	   
		
		<!-- step 0, 1 -->	
		<div>
		<!-- 상세 탭 -->
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
			
			</div>
			 </div>
			 <!-- step 0, 1 -->
			</c:if>
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
				<h5 class="modal-title" id="myModalLabel">신청자 상세보기</h5>
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

<!-- 요청자 사진 확인 모달-->
<div class="modal fade" id="checkPicModal" tabindex="-1" role="dialog" aria-labelledby="checkPicLabel"aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
        
	       <c:if test="${user.userNo eq operation.requesterNo}">
            <div class="modal-header">
                <h5 class="modal-title" id="checkPicLabel">작업자가 올린 사진</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <i class="material-icons">clear</i>
                </button>
            </div>
            <div class="modal-body">
            <div class="row">
            <div class="col-md-12">
           	<c:choose>
				<c:when test="${empty operPicture}">
					작업자가 사진을 아직 업로드 하지 않았습니다
				</c:when>
				<c:otherwise>
					  <div class="picture">
            			<div class="picturezoom">
							<a href="${operPicture.wpicPath}"> 
							<img class="rounded img-fluid" src="${operPicture.wpicPath}">
							</a>
						</div>
         			</div>
					
				</c:otherwise>
			</c:choose>
            </div>
            </div>
            </div>
            <div class="modal-footer">
            	<c:choose>
				<c:when test="${empty operPicture}"></c:when>
				<c:otherwise>
				<button type="button" id="opercomplete" class="btn btn-success btn-link">사진이 마음에 들어요</button>
				</c:otherwise>
				</c:choose>
                <button type="button" class="btn btn-danger btn-link" data-dismiss="modal">닫기</button>
            </div>
            </c:if>
        </div>
    </div>
</div>

<!-- 작업자 사진 업로드  모달 -->
<div class="modal fade" id="uploadPicModal" tabindex="-1" role="dialog" aria-labelledby="uploadPicLabel"aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="uploadPicLabel">사진 등록</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <i class="material-icons">clear</i>
                </button>
            </div>
            <div class="modal-body">
            <div class="row">
            <div class="col-md-12">
            
            <c:choose>
			<c:when test="${operation.operatorEnd eq 'T'}">
			  <div class="picture">
          		<div class="picturezoom">
					<a href="${operPicture.wpicPath}"> 
					<img class="rounded img-fluid" src="${operPicture.wpicPath}">
					</a>
				</div>
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
							<div class="fileinput-new thumbnail">
								<img src="<%=request.getContextPath()%>/assets/img/up.png" alt="...">
							</div>
							<div
								class="fileinput-preview fileinput-exists thumbnail img-raised">

							</div>
							<div>
								<span
									class="btn btn-raised btn-default btn-file">
									<span class="fileinput-new">사진 선택</span> <span
									class="fileinput-exists">바꾸기</span> <input type="file"
									name="file" accept=".jpg, .png, .bmp" />
								</span> <a href="#pablo"
									class="btn btn-danger fileinput-exists"
									data-dismiss="fileinput">취소
								</a> <input type="button" id="operpic"
									class="btn btn-success" value="요청자 보여주기">
							</div>
						</div>

					</form>
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
					/*사람수 측정*/
					$('#peopleRadio').show();
					var peopleNum = data.face.length;
					console.log(peopleNum);
					if(peopleNum==0){
						$('#zero').attr('checked',true);
					}else if(peopleNum==1){
						$('#one').attr('checked',true);
					}else if(peopleNum==2){
						$('#two').attr('checked',true);
					}else if(peopleNum>=3&&peopleNum<=5){
						$('#thr').attr('checked',true);
					}else{
						$('#six').attr('checked',true);
					}
 					/*얼굴감지*/
 					/* $(".fileinput-preview").children().attr({id:"preview"}); */
 					/* console.log($(".fileinput-preview").children()); */
					
					var chaHei = 350;
					var natHei = data.metaMap.resolH.split(" ")[0];
					var chaWid = 350;
					var natWid = data.metaMap.resolW.split(" ")[0];
					var moveLeft = 0;
					chaHei *= 1;
					natHei *= 1;
					chaWid *= 1;
					natWid *= 1;					
					var scalH = (chaHei/natHei).toFixed(3);
					var scalW = (chaWid/natWid).toFixed(3);
					console.log(scalH);
					console.log(scalW);
					
 					 if(data.face != 0){
						
 						var modelUse =''
 						modelUse += '<div class="alert alert-info">'
 						modelUse += 	'<div class="container-fluid">'
 						modelUse += 		'<div class="alert-icon">'
 						modelUse += 			'<i class="material-icons">warning</i>'
 						modelUse += 		'</div>'
 						modelUse += 		'<button type="button" class="close" data-dismiss="alert" aria-label="Close">'
 						modelUse += 			'<span aria-hidden="true"><i class="material-icons">clear</i></span>'
 						modelUse += 		'</button>'
 						modelUse += 		'<b>Warning Alert</b>' + ' 사진 속에 사람이 감지되었습니다. 모델 사용권을 확인해주세요.'
 						modelUse += 	'</div>'
 						modelUse += '</div>'
 						$('h1').after(modelUse)
 						console.log("얼굴그리기")
 						$("#preview").attr({
 							position:"relative"
 						})
 						
 						/* drawFace("preview",scalW*data.face["0"].x_0,scalH*data.face["0"].y_1,scalW*data.face["0"].width,
 								scalH*data.face["0"].height); */
 						$.each(data.face,function(i,val){
 							console.log(val.x_0,val.y_1,val.width,
 									val.height);
 							drawFace("preview",Math.ceil(scalW*val.x_0)+moveLeft,scalH*val.y_1,scalW*val.width,
 	 								scalH*val.height);
 							console.log(Math.ceil(scalW*val.x_0)+moveLeft,scalH*val.y_1,scalW*val.width,
 	 								scalH*val.height);
 						})
 						
  						
 					} 
					
					if(data.safe != null){

						var safe = '';
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
				$("#loaderIcon").html("<img style='height:250px;'src='<%=request.getContextPath()%>/assets/img/eyeMove.gif'/>");
			}
				
			})
		})
	})
	$(document).ready(function() {

		$(document).on('mouseover', '.face-rectangle', function() {
			$(this).css("border-color", "#9c27b0");
		});
		$(document).on('mouseout', '.face-rectangle', function() {
			$(this).css("border-color", "#F2F2F2");
		});

		/* $(".face-rectangle").mouseover(function(){
			consol.log("띠띠");
			$(".face-rectangle").style("border-color","red");
		
		/* $("#preview").css("class", "rainbow-color"); 
		}); */
	});
</script>
