<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<input type="hidden" value="${sessionScope.msgNotice}" id="msgNotice">
<script type="text/javascript">

	$(function(){
		var myNo = $('#loginUserNo').val();
		var removeDiv;
		
		//해당 유저와 대화 메시지 리스트 가져오기
		$(document).on('click', '.msgList', function(){
			var userNo = $(this).data("no");
			var msgUser = ($(this).parent()[0].children[0].innerText).split(" ")[0];
			
			removeDiv = $('#commentstart').find('p[data-no='+userNo+']').closest('.media');
			
			abb(userNo,myNo,msgUser)
			$('#msgContent-show').addClass('msg-show');
		})
		
		if($('#msgNotice').val() != "" ){
			var sendUser = $('#msgNotice').val().split(',')
			abb(sendUser[0],myNo,sendUser[1])
			<%session.removeAttribute("msgNotice");%>
			
		}
		
		//메시지 보내고, 메시지 대화창에 보낸 메시지 append, 회원 대화 목록 div에서 해당 div remove후 다시 append
		$(document).on('click', '.messageSend', function(){
			console.log("메시지 보내기 되는거야?")
			var msgContent = $('#msgContent').val();
			var receiveUserNo = $(this).data("no");
			
			removeDiv = $('#commentstart').find('p[data-no='+receiveUserNo+']').closest('.media');
			
			if(msgContent==""){
				alert("메시지 내용을 입력하세요!");
			}else{
				$.ajax({
					url:"/picsion/message/send.ps",
					data:{	msgContent:msgContent,
							sendUserNo:myNo,
							receiveUserNo:receiveUserNo
					},
					success: function(data){
						$('#msgContent').val('');
						removeDiv.remove();
						
						if($('.messageSend').data("no")==receiveUserNo && $('#msgContent-show').hasClass('msg-show')){
							
							/* 메시지 뿌려주고, 스크롤 고정 */
							var msg = "<div class='popover bs-popover-left bs-popover-left-docs message-send'>"+
				                      "<div class='arrow'></div>"+
				                      "<div class='popover-body'>"+
					                      "<p class='msg-content-p'>"+data.message.msgContent+"</p>"+
					                      "<p class='msg-reg-p' align='right'><small>"+moment(data.message.msgReg).format('MM-DD, HH:mm')+"</small></p>"+
				                      "</div></div>";
							$('#msg-body').append(msg);
							$('#msg-body').scrollTop($('#msg-body')[0].scrollHeight);
							
							/* userList div 삭제하고, 뿌려주기 */
							var userList = "<div class='media'>"+
										   "<a class='float-left'>"+
										   		"<div class='avatar'>"+
										   			"<a href='<%=request.getContextPath()%>/picture/mystudio.ps?userNo="+data.userinfo.userNo+"'><img class='media-object' src='<%=request.getContextPath()%>"+data.userinfo.prPicture+"'></a>"+
										   		"</div></a>"+
										   	"<div class='media-body media-body-custom'>"+
										   		"<h4 class='media-heading msgUserName'>"+data.userinfo.userName+"<small> · "+moment(data.message.msgReg).format('YYYY-MM-DD, HH:mm:ss')+"</small></h4>"+
										   		"<p class='msgList' style='cursor: pointer;' data-no='"+data.userinfo.userNo+"'>"+data.message.msgContent+"</p>"+
										   		"<a class='btn btn-rose btn-link float-right message-margin-del receiveMsgDel'><i class='material-icons'>clear</i>삭제</a>"+
										   		"<a class='btn btn-primary btn-link float-right message-margin-del' rel='tooltip' title='' data-original-title='보내버리기'><i class='material-icons'>reply</i> 신고</a>"+
										   	"</div></div>";
										   	
							$('#commentstart').prepend(userList);
							
							var tableNo=5+":"+data.message.msgNo;
							send(receiveUserNo,tableNo);
						}
					},
					error: function(){
					   	alert("메시지 보내는 도중 오류가 발생했습니다.");
					}
				})
				
			}
			
		})
		
		//받은 메시지함에서 삭제 버튼 눌렀을때  메시지 삭제
		$(document).on('click', '.receiveMsgDel', function(){
			var userListDel=$(this).closest('.media');
			var userNo=$(this).parent()[0].children[1].dataset.no;
			
			console.log(userListDel)
			console.log("여기 와?")
			if(confirm("회원과 대화목록을 정말 삭제하시겠습니까?")==true){
				console.log("삭제완료~")
				
				$.ajax({
					url:"/picsion/message/msgdel.ps",
					data:{userNo:userNo},
					success:function(data){
						userListDel.remove();
						$('#msgContent-show').empty();
					}
				})
			}
			
		})
		
		
		//검색 버튼 클릭시 메시지 검색 비동기 처리
		$('#searchBtn').click(function(){
			var userName = $('.selectMsg').val();
			console.log(userName)
			
			$.ajax({
				url:"/picsion/message/msguser.ps",
				data:{userName:userName},
				success:function(data){
					$('#msgContent-show').empty();
					$('#commentstart').empty();
					var selList;
					$.each(data.recentSelMsg, function(index,obj){
						selList="<div class='media'>"+
										"<a class='float-left'>"+
											"<div class='avatar'>"+
										"<a href='<%=request.getContextPath()%>/picture/mystudio.ps?userNo="+obj.user[0].userNo+"'><img class='media-object' src='<%=request.getContextPath()%>"+obj.user[0].prPicture+"'></a>"+
									"</div></a>"+
									"<div class='media-body media-body-custom'>"+
									"<h4 class='media-heading msgUserName' data-name='"+obj.user[0].userName+"'>"+
										obj.user[0].userName+"<small> · "+moment(obj.msgReg).format('YYYY-MM-DD, HH:mm:ss')+"</small>"+
									"</h4>"+
									"<p class='msgList' style='cursor: pointer;' data-no='"+obj.user[0].userNo+"'>"+obj.msgContent+"</p>"+
									"<a class='btn btn-rose btn-link float-right message-margin-del receiveMsgDel'><i class='material-icons'>clear</i>삭제</a>"+
									"<a class='btn btn-primary btn-link float-right message-margin-del' rel='tooltip' title='' data-original-title='보내버리기'> <i class='material-icons'>reply</i> 신고"+
									"</a></div></div>";
						$('#commentstart').append(selList);
					})
					/* $('#msg-body').scrollTop($('#msg-body')[0].scrollHeight); */
					
					console.log("대꾸할 힘도 없어~~")
				}
			});
		})
		
		
		////////////////////////////////////////////////////////////////
		
		
		
		//받은 메시지를 읽었을 때 메시지 상태 비동기로 update
		$(document).on('click', '.receiveMsgModal', function(){
			var msgNo=$(this).parent()[0].children[0].innerText;
			var msgState=$(this).parent()[0].children[4].innerText;
			var msgChange=$(this).parent()[0].children[4];
			var msgContent=$(this)[0].innerText;
			
			$('.modal-body').empty();
			$('.modal-body').append("<h5>메시지 내용</h5>"+msgContent);
			
			$.ajax({
				url:"/picsion/message/stateup.ps",
				data:{	msgNo:msgNo,
						msgState:msgState
					 },
				success : function(data){
					  if(data.result==1){
						  msgChange.innerText='읽음';
					  }
				}
			})
			
		})
		
		//받은 메시지함에서 삭제 버튼 눌렀을때  메시지 삭제
		/* $(document).on('click', '.receiveMsgDel', function(){
			var msgNo=$(this).parent().parent()[0].children[0].innerText;
			var removeMsg=$(this).parent().parent()[0];
			
			$.ajax({
				url:"/picsion/message/receivedel.ps",
				data : {msgNo:msgNo},
				success:function(data){
					if(data.result==1){
						removeMsg.remove();
					}
				}
			});
			
		}) */
		
		//보낸 메시지 내용 Modal창으로 띄우기
		$(document).on('click', '.sendMsgModal', function() {
			var msgContent=$(this)[0].innerText;
			
			$('.modal-body').empty();
			$('.modal-body').append("<h5>메시지 내용</h5>"+msgContent);			
		})
		
		//보낸 메시지함에서 삭제 버튼 눌렀을때 메시지 삭제
		$(document).on('click', '.sendMsgDel', function(){
			var msgNo=$(this).parent().parent()[0].children[0].innerText;
			var removeMsg=$(this).parent().parent()[0];
			
			$.ajax({
				url:"/picsion/message/senddel.ps",
				data : {msgNo:msgNo},
				success:function(data){
					if(data.result==1){
						removeMsg.remove();
					}
				}
			});
			
		})
		
		//보낸 메시지함 카테고리 선택시 tag 클래스 생성
		$('#receiveTag').click(function() {
			$('#receiveTag').addClass('tag');
			$('#sendTag').removeClass('tag');
			$('#receive').show();
			$('#send').hide();
			$('#selectInfoMsg').hide();
			
			console.log(this)
		})		
		
		//받은 메시지함 카테고리 선택시 tag 클래스 생성
		$('#sendTag').click(function() {
			$('#sendTag').addClass('tag');
			$('#receiveTag').removeClass('tag');
			$('#send').show();
			$('#receive').hide();
			$('#selectInfoMsg').hide();
			
			console.log(this)
		})		
		
		//검색 버튼 클릭시 메시지 검색 비동기 처리
		$('#123132123').click(function(){
			var userName = $('.selectMsg').val();
			console.log(userName)
			
			//받은 메시지함에서 검색할 경우
			if($('#receiveTag').hasClass('tag')){
				console.log("리시브 여기온거?")
				$('#receive').hide();
				$('#send').hide();
				
				$.ajax({
					url:"/picsion/message/receiveselect.ps",
					data:{userName:userName},
					success:function(data){
						
						var table="<thead><tr>"+
									"<th>번호</th><th>보낸이</th><th>내용</th><th>받은 날짜</th><th>상태</th><th>삭제</th>"+
						  		  "</tr></thead><tbody>";
						
						$('#selectMsgTab').empty();
						/* obj=data.receiveSelect[index] */
						$.each(data.receiveSelect, function(index,obj){
							
							if(obj.receiveMsgDel=="F"){
								console.log("몇개나 가져오니?")
								console.log(obj.msgNo);
								table+="<tr>"+
											"<td>"+obj.msgNo+"</td>"+
											"<td>"+data.receiveSelInfo[index].userName+"</td>"+
											"<td class='receiveMsgModal' data-toggle='modal' data-target='#myModal'>"+obj.msgContent+"</td>"+
											"<td>"+data.receiveSelReg[index]+"</td>"+
											"<td>";
												if(obj.msgState=="F"){
													table+="안읽음</td>";
												}else{
													table+="읽음</td>";
												}
												table+="<td><i class='material-icons receiveMsgDel' style='cursor: pointer;''>clear</i></td>"
										+"</tr>";
							}
						});
						table+="</tbody>";
						
						$('#selectMsgTab').append(table);
						$('#selectInfoMsg').show();
					}
				});
			//보낸 메시지함에서 검색할 경우 
			}else if($('#sendTag').hasClass('tag')){
				console.log("아니면 샌드온거?")
				$('#receive').hide();
				$('#send').hide();
				
				$.ajax({
					url:"/picsion/message/sendselect.ps",
					data:{userName:userName},
					success:function(data){
						
						var table="<thead><tr>"+
									"<th>번호</th><th>받은이</th><th>내용</th><th>보낸 날짜</th><th>상태</th><th>삭제</th>"+
						  		  "</tr></thead><tbody>";
						
						$('#selectMsgTab').empty();
						/* obj=data.receiveSelect[index] */
						$.each(data.sendSelect, function(index,obj){
							
							if(obj.sendMsgDel=="F"){
								console.log("몇개나 가져오니?")
								console.log(obj.msgNo);
								table+="<tr>"+
											"<td>"+obj.msgNo+"</td>"+
											"<td>"+data.sendSelInfo[index].userName+"</td>"+
											"<td class='sendMsgModal' data-toggle='modal' data-target='#myModal'>"+obj.msgContent+"</td>"+
											"<td>"+data.sendSelReg[index]+"</td>"+
											"<td>";
												if(obj.msgState=="F"){
													table+="안읽음</td>";
												}else{
													table+="읽음</td>";
												}
												table+="<td><i class='material-icons sendMsgDel' style='cursor: pointer;''>clear</i></td>"
										+"</tr>";
							}
						});
						table+="</tbody>";
						
						$('#selectMsgTab').append(table);
						$('#selectInfoMsg').show();
					}
				});
				
			}
		})
		
	})
	
function abb(userNo,myNo,msgUser) {
	$.ajax({
		url:"/picsion/message/msglist.ps",
		data:{userNo:userNo},
		success : function(data){
			$('#msgContent-show').empty();
			var msgContent="<div class='modal-dialog modal-login message-header'>"+
						   "<div class='modal-content'>"+
						   "<div class='card card-signup card-plain'>"+
						   "<div class='modal-header'>"+
						   "<div class='card-header card-header-primary text-center message-header-user'>"+
						   "<h4 class='card-title'>"+msgUser+"</h4>"+
						   "</div></div><div class='modal-body form-msg-body' id='msg-body'>";
						   
			$.each(data.msgList, function(index, obj){
				
				if(obj.receiveUserNo==myNo){
					msgContent+="<div class='popover bs-popover-right bs-popover-right-docs message-receive'>"+
				    	 	 	"<div class='arrow'></div>"+
				    	 	 	"<div class='popover-body'>"+
				      			"<p class='msg-content-p'>"+obj.msgContent+"</p>"+
				      			"<p class='msg-reg-p' align='right'><small>"+moment(obj.msgReg).format('MM-DD, HH:mm')+"</small></p>"+
				    			"</div></div>";
				}else if(obj.sendUserNo==myNo){
					msgContent+="<div class='popover bs-popover-left bs-popover-left-docs message-send'>"+
		                        "<div class='arrow'></div>"+
		                        "<div class='popover-body'>"+
		                        "<p class='msg-content-p'>"+obj.msgContent+"</p>"+
		                        "<p class='msg-reg-p' align='right'><small>"+moment(obj.msgReg).format('MM-DD, HH:mm')+"</small></p>"+
		                        "</div></div>";
				}
			})
			msgContent+="</div>"+
						"<div class='modal-footer justify-content-center'>"+
							"<form class='form'>"+
								"<div class='form-group label-floating bmd-form-group'>"+
									"<textarea class='form-control form-sendmsg' rows='3' name='msgContent' id='msgContent' placeholder='Your Message..'></textarea>"+
								"</div>"+
							"</form>"+
							"<button type='button' class='btn btn-primary btn-link btn-wd btn-lg messageSend' data-no='"+userNo+"' data-name='"+msgUser+"'>Send</button>"+
						"</div></div></div></div>";
			
			$('#msgContent-show').append(msgContent);
			$('#msg-body').scrollTop($('#msg-body')[0].scrollHeight);
			$('#msgContent-show').show();
		}
	})
}
</script>

<style>
/* 뿌려주는 이미지의 크기 */
.img-size {
	height: 300px;
}

/* 사용자의 프로필 사진의 크기 */
.user-img {
	width: 50px;
	height: 50px;
}

/* 마이페이지 상단 메뉴 위,아래 여백 */
.my-ul {
	padding-top: 30px;
	padding-bottom: 30px;
}

/* 팔로잉 회원 프로필 사진 크기 이미지 */
.following-pr{
	width:180px;
	height:180px;
}

/* 메시지함 신고버튼, 삭제버튼 여백 삭제 */
.message-margin-del{
	margin: 5px;
	padding: 5px;
}

/* 메시지함 보더? */
.message-border{
	border: 1px red solid;
	border-radius:10px;
}


/* 메시지창  상단 너비 잡는거*/
.message-header{
	max-width: 600px;
    margin-top: 100px;
}

/* ****** */

/* 메시지창 어떤 유저와 대화하는지 헤더 여백 */
.message-header-user{
	margin-top: 0px;
}

/* 받은 메시지 스타일 */
.message-receive{
	position: relative;
	margin-top: 20px;
}

/* 메시지 말풍선내 내용 여백 */
.msg-content-p{
	margin-bottom: 15px;
}

/* 메시지 날짜 표시 여백, 메시지 검색폼 여백 */
.msg-reg-p{
	margin-bottom: 0px;
}

/* 보낸 메시지 스타일 */
.message-send{
	position: relative; 
	margin-left: 280px; 
	margin-top: 20px;
}


/* media-body */
.media-body-custom{
	width:70%;
}

/* form-width */
.form-sendmsg{
	width:250px;
}

/* 메시지 뿌려주는 곳 */
.form-msg-body{
	max-height: 550px;
	overflow-x:hidden;
	overflow-y: auto;
}

/* 메시지함 div 마진 */
.msg-user-form{
	padding-bottom:0px !important;
}

/* 메시지함 검색 폼 */
.msg-search-btn{
	cursor: pointer; 
	margin-top: 10px; 
	float: right;
}

/* 메시지함 하단 여백 */
.msg-pad-bottom{
    padding-bottom: 100px !important;
}

</style>

<div class="page-header header-filter" data-parallax="true" style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="#">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
		</ul>
			<div class="gallery msg-pad-bottom">
				<div class="row">
					
					<div class="col-md-5">
						<div class="card card-collapse">
							<div class="card-header msg-user-form" role="tab" id="headingThree">
								<h5 class="mb-0">
									<a>Message</a>
								</h5>
								<div class="form-group has-default bmd-form-group input-group msg-reg-p" style="padding-top:0; margin-top: 10px;">
		                            <input type="text" class="form-control selectMsg" placeholder="userName 검색">
				                 	<i class="material-icons msg-search-btn" id="searchBtn">search</i>
				                </div>
							</div>
							<div id="collapseThree" class="collapse show" role="tabpanel" aria-labelledby="headingThree" data-parent="#accordion" style="max-height: 700px; overflow-x: hidden; overflow-y: inherit;">
								<div id="commentstart" class="card-body">
									<!--  -->
									<c:forEach items="${recentMsg}" var="recentMsg2">
										<div class="media"> <!-- style="border: 1px red solid; border-radius:10px;" -->
											<a class="float-left">
												<div class="avatar">
												  <a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${recentMsg2.user[0].userNo}"><img class="media-object" src="<%=request.getContextPath()%>${recentMsg2.user[0].prPicture}"></a>
												</div>
											</a>
											<div class="media-body media-body-custom">

												<h4 class="media-heading msgUserName" data-name="${recentMsg2.user[0].userName}">
													${recentMsg2.user[0].userName}<small> · <fmt:formatDate pattern="yyyy-MM-dd, HH:mm:ss" value="${recentMsg2.msgReg}" /></small>

												</h4>
												<p class="msgList" style="cursor: pointer;" data-no="${recentMsg2.user[0].userNo}">${recentMsg2.msgContent}</p>
												<a class="btn btn-rose btn-link float-right message-margin-del receiveMsgDel"><i class="material-icons">clear</i>삭제</a>
												<a class="btn btn-primary btn-link float-right message-margin-del" rel="tooltip" title="" data-original-title="보내버리기"> <i class="material-icons">reply</i> 신고
												</a>
											</div>

										</div>
									</c:forEach>
									
								</div>
							</div>
						</div>
						<!-- <form class="form-inline">
							<a href="#" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
						    	메시지함 선택
							</a>
							<ul class="nav dropdown-menu" role="tablist">
								<li class="nav-item"><a class="nav-link tag" id="receiveTag" href="#receive" role="tab" data-toggle="tab">받은 메시지</a></li>
								<li class="nav-item"><a class="nav-link" id="sendTag" href="#send" role="tab" data-toggle="tab">보낸 메시지</a></li>
							</ul>
			                 
			           </form> -->
					</div>

					<div class="col-md-7" id="msgContent-show">
							
					</div>
					
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 메시지 상세  Modal Core -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      	<h5 class="modal-title" id="myModalLabel">메시지</h5>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <div class="modal-body">
      	
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-simple" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>


