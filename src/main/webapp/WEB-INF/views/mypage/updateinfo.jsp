<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script>
	$(function(){
  		var regPwd = /^[a-zA-Z0-9!@#$%^&*()?_~]{4,15}$/  //영문 숫자 특수문자 혼용해서 4~15글자
	  	var pwCheck = false
	  	
	  	$('#pwd').focusout(function(){
  			pwCheck = false
  			var reg = '사용 가능 합니다!!'
  			if( !regPwd.test($('#pwd').val()) ){
  				alert('비밀번호는 영문 숫자 특수문자 혼용하여 4~15글자 입니다')
  				reg = '사용 불가능 합니다!!'
  			}
  			
  			$('#pwd').closest('.form-group')[0].childNodes[4].remove()
  			$('#pwd')[0].parentElement.after(reg)
  		})
  		
  		$('#pwCheck').keyup(function(){
  			var isPwCheck = '사용 불가능 합니다!!'
  			if( $('#pwd').val() == $('#pwCheck').val() ){
  				isPwCheck = '사용 가능 합니다!!'
	  			pwCheck = true
  			}else{
  				pwCheck = false
  			}
  			$('#pwCheck').closest('.form-group')[0].childNodes[4].remove()
  			$('#pwCheck')[0].parentElement.after(isPwCheck)
  		})
  		
  		if($('#pwd').val()==""){
  			console.log("패스워드 변경 안하는거지?")
  		}else{
	  		$('#pwdConfirm').click(function(){
	  			if(!pwCheck){
	  				alert('비밀번호를 다시 확인 해주세요')
	  				$('#pwd').focus()
	  			}else if(pwCheck){
		  			$('form').submit()
	  			}
	  		})
  		}
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

/* input 내용 좌측 여백 */
.input-content-pad{
	padding-left: 7px;
}


</style>

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
<div class="main">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
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
	                        <input type="text" class="form-control input-content-pad" id="prContent" name="prContent" value="${userinfo.prContent}" autocomplete="off">
	                     </div>
	                  </div>
	                    
	                </div>
	                <div class="col-md-1"></div>
	                <div class="col-md-5 mr-auto update-margin">
	                	<div class="form-group update-lab-padding">
		                      <label for="exampleInput1" class="bmd-label-floating">아이디</label>
		                      <div class="input-group">
		                        <input type="text" class="form-control input-content-pad" id="userId" name="userId" value="${userinfo.userId}" readonly="readonly">
		                      </div>
		                 </div>
	                    <div class="form-group">
	                      <label for="exampleInput1" class="bmd-label-floating">이름</label>
	                      <div class="input-group">
	                        <input type="text" class="form-control userName input-content-pad" name="userName" value="${userinfo.userName}" autocomplete="off">

	                      </div>
		                </div>
	                    <div class="form-group">
	                      <label for="exampleInput1" class="bmd-label-floating">비밀번호</label>
	                      <div class="input-group">
	                        <input type="password" id="pwd" name="pwd" class="form-control input-content-pad" />
	                      </div>
	                    </div>
	                    <div class="form-group">
	                      <label for="exampleInput1" class="bmd-label-floating">비밀번호 확인</label>
	                      <div class="input-group">
	                        <input type="password" id="pwCheck" class="form-control input-content-pad" />
	                      </div>
                   		 </div> 
	                    
	                  <div class="form-group text-center update-lab-padding">
	                  	<label for="exampleInput1" class="bmd-label-floating">현재 캐시</label>
	                    <div class="input-group">
	                    	<fmt:formatNumber var="fmtmoney" value="${userinfo.point}" pattern="#,###"/>

	                        <input type="text" class="form-control point input-content-pad" value="${fmtmoney}" readonly="readonly">
  
	                     </div>
	                     <button type="button" class="btn btn-default update-margin" data-toggle="modal" data-target="#exampleModal">충전하기</button>
	                  </div>
	                  
	                </div>
	                
	              </div>
	        	</div>
        	<!-- submit -->
        		<div align="center">
                  	<button type="submit" id="pwdConfirm" class="btn btn-info update-btn-save">저장하기</button>
                 </div>
			</form>
		</div>
	</div>
</div>

	

