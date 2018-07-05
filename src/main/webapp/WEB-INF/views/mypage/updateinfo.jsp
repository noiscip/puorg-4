<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<script type="text/javascript">
/* 
	$(function(){
		$('#pointCharge').click(function(){
			var chargePoint = $('#chargePrice').val()
			var nowPoint = $('#point').val()
			var regNumber = /^[0-9]*$/;
			
			
			if($('#chargePrice').val() == ""){
				alert('충전 금액을 입력하세요!');
				$('#chargePrice').val("");
			}else if(!regNumber.test($('#chargePrice').val())){
				alert('잘못 입력하셨습니다! 숫자만 입력해주세요.');
				$('#chargePrice').val("");
			}else{
				
				
			}
		})
		
		
	}) 
*/
	$(function(){
		var nowPoint = $('#point').val()
		
		var IMP = window.IMP
		IMP.init('imp27054314')
		
		$('#pointCharge').click(function(){
			IMP.request_pay({
			    pg : 'inicis', // version 1.1.0부터 지원.
			    pay_method : 'card',
			    merchant_uid : 'merchant_' + new Date().getTime(),
			    name : '주문명:포인트 충전',
			    amount : $('#chargePrice').val(),
			    buyer_name : $('#userName').val(),
			    m_redirect_url : 'http://localhost:8090/user/updateinfo.ps'
		}, function(rsp) {
			if ( rsp.success ) {
				var msg = '결제가 완료되었습니다.'
				msg += '결제 금액 : ' + rsp.paid_amount
				msg += '카드 승인번호 : ' + rsp.apply_num
				
				$.ajax({
					url:"/picsion/user/charge.ps",
					data: {point:rsp.paid_amount},
					success: function(data){
						if(data.result == 0){
							msg = '결제 완료 BUT 업데이트 실패'
						}else{
							console.log(data.point)
							$('#point').val(data.point)
						}
						
					}
				})
			
				$('#chargePrice').val("")
			} else {
			    var msg = '결제에 실패하였습니다.'
			    msg += '에러내용 : ' + rsp.error_msg
			}
			alert(msg)
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

/* 정보 수정페이지에서 프로필 사진 크기 */
.update-pr{
	width: 300px;
	height:200px;
}

/* 정보 수정페이지 상단 여백 */
.update-margin{
	margin-top: 40px;
}
/* 정보 수정페이지 하단 여백 */
.update-padding{
	padding-bottom: 50px;
}

/* 정보 수정페이지 버튼 상단 여백 */
.update-btn-margin{
	margin-top: 10px;
}

/* 정보 수정페이지 라벨 여백 */
.update-lab-padding{
	padding-top: 35px;
}

/* 정보 수정페이지 저장 버튼 하단 여백 */
.update-btn-save{
	margin-bottom:30px
}

/* 네이버, 구글 아이콘 너비 */
.linked-icon-width{
	width:40px
}

/* 사진 연동 여부 라벨 색 */
.linked-lab-color{
	color:black;
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
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/history.ps">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
		</ul>
		
			<form class="form" method="post" enctype="multipart/form-data" action="<%=request.getContextPath()%>/user/updateinfo.ps">
			  <!--  -->
			  <div class="col-md-12 ml-auto mr-auto update-margin update-padding">
	              <div class="row">
	              	<div class="col-md-5 ml-auto">
	                  	<div class="form-group text-center">
	                  	<!-- 프로필 수정 -->
	                  	<div class="fileinput fileinput-new text-center" data-provides="fileinput">
						   <div class="fileinput-new">
							<img src="${userinfo.prPicture}" class="img-raised rounded-circle img-fluid update-pr">
							<%-- <input value="${userinfo.prPicture}" name="prPicture" style="display: none;"> --%>
						   </div>
						   <div class="fileinput-preview fileinput-exists thumbnail img-raised rounded-circle img-fluid update-pr"></div>
						   <div>
							<span class="btn btn-raised btn-default btn-file update-btn-margin">
							   <span class="fileinput-new changPr">프로필 변경</span>
							   <span class="fileinput-exists changePr">프로필 변경</span>
							   <input type="file" name="file" />
							</span>
						   </div>
						</div>
	                  		<%-- <img src="<%=request.getContextPath()%>${userinfo.prPicture}" class="img-raised rounded-circle img-fluid update-pr"><br>
				      		<button type="button" class="btn btn-default update-btn-margin btn-file">프로필 수정</button> --%>
	                  	</div>
	                  	<div class="form-group update-margin">
	                  		<div class="row">
		                  		<div class="col-md-6">
		                  			<label for="exampleInput1" class="bmd-label-floating">다음 계정으로 연동</label>
		                  		</div>
		                  		<div class="col-md-6" align="right">
		                  			<label for="exampleInput1" class="bmd-label-floating">계정 연동 여부</label>
		                  		</div>
	                  		</div>
		                      <div class="form-check update-btn-margin">
			                      <c:choose>
			                      	<c:when test="${userinfo.google eq null}">
								       <a class="btn btn-secondary" href="<%=request.getContextPath()%>/google/login.ps">Google</a>
			                      	</c:when>
			                      	<c:otherwise>
			                      	   <a class="btn btn-secondary disabled" role="button" aria-disabled="true">Google</a>
			                      	</c:otherwise>
			                      </c:choose>
			                      
			                      <c:choose>
			                      	<c:when test="${userinfo.naver eq null}">
	                        		  <a class="btn btn-secondary" href="<%=request.getContextPath()%>/naver/login.ps">Naver</a>
			                      	</c:when>
			                      	<c:otherwise>
			                      	  <a class="btn btn-secondary disabled" role="button" aria-disabled="true">Naver</a>
			                      	</c:otherwise>
			                      </c:choose>
                        		  
							      <!-- 구글, 네이버 아이콘 만드는곳~~~ -->
							      <div align="center" style="float: right">
								      <c:if test="${userinfo.google ne null}">
									      <img alt="구글 로그인" src="<%=request.getContextPath()%>/assets/img/portalsite/google_icon.png" class="linked-icon-width">
						              </c:if>
						              <c:if test="${userinfo.naver ne null}">
							              <img alt="네이버 로그인" src="<%=request.getContextPath()%>/assets/img/portalsite/naver_icon.png" class="linked-icon-width">
						              </c:if>    
							      </div>
							  	</div>
	                  </div>
                      <div class="form-check update-btn-margin">
	                      <label class="form-check-label linked-lab-color"><b>
						      <c:choose>
						      	<c:when test="${userinfo.naver eq null && userinfo.google eq null}">
						      		<input class="form-check-input" type="checkbox" disabled>
						          		계정 연동하셔야 사진을 등록할 수 있습니다. 
						          <span class="form-check-sign">
						              <span class="check"></span>
						          </span>
						      	</c:when>
						      	<c:otherwise>
						      		<input class="form-check-input" type="checkbox" disabled checked>
						          		사진을 등록하실 수 있습니다. 
						          <span class="form-check-sign">
						              <span class="check"></span>
						          </span>
						      	</c:otherwise>
						      </c:choose></b>
					      </label>
					  </div>      
	                  <div class="form-group update-margin">
	                  	<label for="exampleInput1" class="bmd-label-floating">자기 소개</label>
	                    <div class="input-group form-default">
	                        <input type="text" class="form-control" id="prContent" name="prContent" value="${userinfo.prContent}">
	                     </div>
	                  </div>
	                    
	                </div>
	                <div class="col-md-1"></div>
	                <div class="col-md-5 mr-auto update-margin">
	                	<div class="form-group update-lab-padding">
		                      <label for="exampleInput1" class="bmd-label-floating">아이디</label>
		                      <div class="input-group">
		                        <input type="text" class="form-control" id="userId" name="userId" value="${userinfo.userId}" readonly="readonly">
		                      </div>
		                 </div>
	                    <div class="form-group">
	                      <label for="exampleInput1" class="bmd-label-floating">이름</label>
	                      <div class="input-group">
	                        <input type="text" class="form-control" id="userName" name="userName" value="${userinfo.userName}">
	                      </div>
		                    </div>
		                    <div class="form-group">
		                      <label for="exampleInput1" class="bmd-label-floating">비밀번호</label>
		                      <div class="input-group">
		                        <input type="password" name="pwd" class="form-control" />
		                      </div>
		                    </div>
		                    <div class="form-group">
		                      <label for="exampleInput1" class="bmd-label-floating">비밀번호 확인</label>
		                      <div class="input-group">
		                        <input type="password" class="form-control" />
		                      </div>
                   		 </div> 
	                    
	                  <div class="form-group text-center update-lab-padding">
	                  	<label for="exampleInput1" class="bmd-label-floating">현재 캐시</label>
	                    <div class="input-group">
	                        <input type="text" class="form-control" id="point" name="point" value="${userinfo.point}" readonly="readonly">
	                     </div>
	                     <button type="button" class="btn btn-default update-margin" data-toggle="modal" data-target="#exampleModal">충전하기</button>
	                  </div>
	                  
	                </div>
	                
	              </div>
	        	</div>
        	<!-- submit -->
        		<div align="center">
                  	<button type="submit" class="btn btn-info update-btn-save">저장하기</button>
                 </div>
			</form>
		</div>
	</div>
</div>

	<!-- 충전하기 Modal -->
	<div class="modal fade" id="exampleModal" tabindex="1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">충전하기</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body">
		    <div class="form-group bmd-form-group">
					<label for="exampleInput1" class="bmd-label-floating">충전금액</label>
					<input type="text" class="form-control" id="chargePrice">
			</div>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary" id="pointCharge" data-dismiss="modal">충전하기</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	      
	    </div>
	  </div>
	</div>

