<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(function(){
		//메시지를 읽었을 때 메시지 상태 비동기로 update
		$(document).on('click', '.msgModal', function(){
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
		
		//메시지 삭제 버튼 눌렀을때 (받은 메시지 삭제)
		$(document).on('click', '.msgDel', function(){
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

</style>

<div class="page-header header-filter" data-parallax="true"<%-- style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');" --%>></div>
<div class="main main-raised">
	<div class="profile-content">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="#">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="#">거래/내역</a></li>
			<li class="nav-item"><a class="nav-link" href="#">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="#">정보 수정</a></li>
		</ul>
		

		<div class="container">
			<div class="gallery text-center">
				<div class="row">
					<div class="col-md-12" >
					
					<div class="col-md-3 dropdown" align="left" style="margin-bottom: 15px">
						<a href="#" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
					    	받은 메시지
						</a>
						<ul class="dropdown-menu" align="left">
							<li><a href="#">받은 메시지</a></li>
							<li><a href="#">보낸 메시지</a></li>
						</ul>
						
						<form class="form-inline">
			                 <div class="form-group has-default bmd-form-group">
			                            <input type="text" class="form-control" placeholder="Search">
			                 </div>
			                 <button type="submit" class="btn btn-white btn-raised btn-fab btn-fab-mini btn-round">
			                    <i class="material-icons">search</i>
			                </button>
			           </form>
					</div>
					
					<table class="table">
					    <thead>
					        <tr align="center">
					            <th>번호</th>
								<th>보낸이</th>
								<th>내용</th>
								<th>보낸 날짜</th>
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
											<td class="msgModal" data-toggle="modal" data-target="#myModal">${receiveMessage.msgContent}</td>
											<td>${msgReg[status.index]}</td>
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
											<td><i class="material-icons msgDel" style="cursor: pointer;">clear</i></td>
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
