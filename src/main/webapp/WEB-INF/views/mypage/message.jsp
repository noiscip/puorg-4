<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(function(){
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
			
			/* tr로 묶었을때... */
			/* var msgNo=$(this)[0].children[0].innerText;
			var msgState=$(this)[0].children[4].innerText;
			var msgChange=$(this)[0].children[4];
			
			$('.modal-body').empty();
			$('.modal-body').append("<h5>메시지 내용</h5>"+$(this)[0].children[2].innerText);
			
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
			}); */
		})
		
		//받은 메시지함에서 삭제 버튼 눌렀을때  메시지 삭제
		$(document).on('click', '.receiveMsgDel', function(){
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
			
		})
		
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
			$('#sendTag').removeClass('tag')
			
			console.log(this)
		})		
		
		//받은 메시지함 카테고리 선택시 tag 클래스 생성
		$('#sendTag').click(function() {
			$('#sendTag').addClass('tag');
			$('#receiveTag').removeClass('tag');
			
			console.log(this)
		})		
		
		//검색 버튼 클릭시 메시지 검색 비동기 처리
		$('#searchBtn').click(function(){
			var userName = $('.selectMsg').val();
			console.log(userName)
			
			if($('#receiveTag').hasClass('tag')){
				console.log("리시브 여기온거?")
				
				$.ajax({
					url:"/picsion/message/receiveselect.ps",
					data:{userName:userName},
					success:function(data){
						
					}
				});
			}else{
				console.log("아니면 샌드온거?")
				
				/* $.ajax({
					url:"/picsion/message/sendselect",
					data:data,
					success:function(data){
						
					}
				}); */
				
			}
		})
		
	})

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


.container-2{
  width: 300px;
  vertical-align: middle;
  white-space: nowrap;
  position: relative;
}

.container-2 input#search{
  width: 50px;
  height: 50px;
  background: #2b303b;
  border: none;
  font-size: 10pt;
  float: left;
  color: #262626;
  padding-left: 35px;
  -webkit-border-radius: 5px;
  -moz-border-radius: 5px;
  border-radius: 5px;
  color: #fff;
 
  -webkit-transition: width .55s ease;
  -moz-transition: width .55s ease;
  -ms-transition: width .55s ease;
  -o-transition: width .55s ease;
  transition: width .55s ease;
}

.container-2 input#search::-webkit-input-placeholder {
   color: #65737e;
}
 
.container-2 input#search:-moz-placeholder { /* Firefox 18- */
   color: #65737e;  
}
 
.container-2 input#search::-moz-placeholder {  /* Firefox 19+ */
   color: #65737e;  
}
 
.container-2 input#search:-ms-input-placeholder {  
   color: #65737e;  
}

.container-2 input#search:focus, .container-2 input#search:active{
  outline:none;
  width: 300px;
}
 
.container-2:hover input#search{
width: 300px;
}
 
.container-2:hover .icon{
  color: #93a2ad;
}
</style>

<div class="page-header header-filter" data-parallax="true" style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="#">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="#">거래/내역</a></li>
			<li class="nav-item"><a class="nav-link" href="#">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="#">정보 수정</a></li>
		</ul>
			<div class="gallery text-center">
				<div class="row">
					<!-- <div class="col-md-12"> -->
					<div class="col-md-3" align="left"><!-- style="margin-bottom: 15px" -->
						<a href="#" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					    	메시지함 선택
						</a>
						<ul class="nav dropdown-menu" role="tablist">
							<li class="nav-item"><a class="nav-link tag" id="receiveTag" href="#receive" role="tab" data-toggle="tab">받은 메시지</a></li>
							<li class="nav-item"><a class="nav-link" id="sendTag" href="#send" role="tab" data-toggle="tab">보낸 메시지</a></li>
						</ul>
					</div>
					<div class="col-md-6">
					</div>
					<div class="col-md-3" align="right">
                        <form class="form-inline">
			                 <div class="form-group has-default bmd-form-group" style="padding-top:0; margin-top: 10px">
	                            <input type="text" class="form-control selectMsg" placeholder="userName 검색">
			                 </div>
			                 <i class="material-icons" style="cursor: pointer; margin-top: 10px" id="searchBtn">search</i>
			           </form>
					</div>
					
					<div class="col-md-12">
					<div class="tab-content tab-space">
						<!-- ******* 받은 메시지 테이블 ******* -->
						<div class="tab-pane active" id="receive">
							<table class="table">
							    <thead>
							        <tr >
							            <th>번호</th>
										<th>보낸이</th>
										<th>내용</th>
										<th>받은 날짜</th>
										<th>상태</th>
										<th>삭제</th>
							        </tr>
							    </thead>
							    <tbody>
							    	<c:forEach items="${receiveList}" var="receiveMessage" varStatus="status">
							    			<!-- 받은사람의 Del가 False인 경우만 메시지 리스트 가져오기 -->
											<c:if test="${receiveMessage.receiveMsgDel eq 'F'}">
												<tr class="url-tr" data-url="">
													<td>${receiveMessage.msgNo}</td>
													<td>${receiveInfo[status.index].userName}</td>
													<!-- 상세 메시지를 Modal에 보여주는 내용 -->
													<td class="receiveMsgModal" data-toggle="modal" data-target="#myModal">${receiveMessage.msgContent}</td>
													<td>${receiveMsgReg[status.index]}</td>
													<td>
														<c:choose>
															<c:when test="${receiveMessage.msgState eq 'F'}">
																안읽음
															</c:when>
															<c:otherwise>
																읽음
															</c:otherwise>
														</c:choose>
													</td>
													<td><i class="material-icons receiveMsgDel" style="cursor: pointer;">clear</i></td>
												</tr>
											</c:if>
									</c:forEach>
							    </tbody>
							</table>
						</div>
						
						<!-- ******* 보낸 메시지 테이블 ******* -->
						<div class="tab-pane" id="send">
							<table class="table">
							    <thead>
							        <tr>
							            <th>번호</th>
										<th>받은이</th>
										<th>내용</th>
										<th>보낸 날짜</th>
										<th>상태</th>
										<th>삭제</th>
							        </tr>
							    </thead>
							    <tbody>
							    	<c:forEach items="${sendList}" var="sendMessage" varStatus="status">
							    			<!-- 받은사람의 Del가 False인 경우만 메시지 리스트 가져오기 -->
											<c:if test="${sendMessage.sendMsgDel eq 'F'}">
												<tr class="url-tr" data-url="">
													<td>${sendMessage.msgNo}</td>
													<td>${sendInfo[status.index].userName}</td>
													<!-- 상세 메시지를 Modal에 보여주는 내용 -->
													<td class="sendMsgModal" data-toggle="modal" data-target="#myModal">${sendMessage.msgContent}</td>
													<td>${sendMsgReg[status.index]}</td>
													<td>
														<c:choose>
															<c:when test="${sendMessage.msgState eq 'F'}">
																안읽음
															</c:when>
															<c:otherwise>
																읽음
															</c:otherwise>
														</c:choose>
													</td>
													<td><i class="material-icons sendMsgDel" style="cursor: pointer;">clear</i></td>
												</tr>
											</c:if>
									</c:forEach>
							    </tbody>
							</table>
						</div>
					</div>
					
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

<!-- 메시지 삭제 Modal -->
<!-- <div class="modal fade" id="msgDelModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
    
      <div class="modal-body">
        	정말 삭제하시겠습니까?
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" id="msgDel">삭제</button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>
 -->
