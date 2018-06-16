<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(function(){
		$('.messageModal').click(function() {
			var msgNo=$(this)[0].children[0].innerText;
			var msgState=$(this)[0].children[4].innerText;
			
			console.log('messageModal 여기는 들어오는거지?');
			console.log($(this)[0].children[4].innerText)
			console.log(msgNo)
			
			$('.modal-body').empty();
			$('.modal-body').append("<h5>메시지 내용</h5>"+$(this)[0].children[2].innerText);
			
			$.ajax({
				url:"/picsion/message/stateup.ps",
				data:{	msgNo:msgNo,
						msgState:msgState
					 },
				success : function(data){
					  console.log(data.result)
					  console.log(data.result + '상태 변환된겨???')
					  
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
										<tr class="url-tr messageModal" data-url="" data-toggle="modal" data-target="#myModal">
											<td>${receiveMessage.msgNo}</td>
											<td>${receiveInfo[status.index].userName}</td>
											<!-- 상세 메시지 내용을 보여주는 Modal -->
											<td title="content">${receiveMessage.msgContent}</td>
											<td>${receiveMessage.msgReg}</td>
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
											<td><i class="material-icons" id="msgDel-icon">clear</i></td>
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

<!-- Modal Core -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      	<h5 class="modal-title" id="myModalLabel">메시지</h5>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <div class="modal-body">
      	<%--<c:forEach items="${receiveList}" var="receiveMessage" varStatus="status">
      		 <c:if test="${receiveList.msgNo eq $('#msgNo')}">
      			${receiveInfo[status.index].userName}<br>
      			${receiveMessage.msgContent}<br>
      		</c:if> 
      	</c:forEach>--%>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default btn-simple" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
