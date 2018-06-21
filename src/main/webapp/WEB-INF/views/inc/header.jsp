<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>
$(function(){
	$('#newNotice').click(function(){
		$('#noticeList').hide() 
		
		if($(this).closest('li').hasClass('show') != true){
			$('#noticeList').show() 
			$.ajax({
				url: "/picsion/notice/notice.ps",
				beforeSend : function () {
					$('#noticeList').append('&nbsp&nbsp<img src="/picsion/assets/img/loading_bar3.gif" style="width : 130px" >')  
				},
				success : function (data) {
					$('#noticeList').empty() 
					var noticeMenu = '';
					$.each(data.map, function(i, elt) {
						console.log(elt)
						noticeMenu += '<li class="divider"><a href="#">'
						noticeMenu += '<img style="width: 30px;" class="rounded-circle" src="/picsion/'+elt[1].prPicture + '">&nbsp&nbsp' 
						noticeMenu += '"'+ elt[1].userName +'"'
						var value = '' 
						
						if(elt[0].tableNo == 3){
							noticeMenu += '님이 ' + elt[2].brdTitle
							value = elt[0].brdNo + ','+  elt[0].tableNo
							if(elt[0].operNo == 0){
								noticeMenu += ' 작업을 신청 하였습니다'
							}else{
								noticeMenu += ' 작업을 수락 하였습니다'
							}
						}else if(elt[0].tableNo == 4){
							value = elt[0].cmtNo + ','+ elt[0].tableNo
						}else if(elt[0].tableNo == 5){
							value = elt[0].msgNo + ','+ elt[0].tableNo
							noticeMenu += '님이 메시지를 보냈습니다'
						}
						noticeMenu += '<input type="hidden" value="'+value+'">'
						noticeMenu += '</a></li>'
					})
					$('#noticeList').append(noticeMenu)
				}
			})
		}
	})
	
	
	$(document).on('click','.divider',function(){
		console.log($(this).find('input')[0].value)
		var value = ($(this).find('input')[0].value).split(',')
		console.log(value.length)
		
	})
	
})

</script>
<input type="hidden" value="${sessionScope.user.userNo}" id="loginUserNo">
<nav class="navbar navbar-transparent navbar-color-on-scroll fixed-top navbar-expand-lg" color-on-scroll="100" id="sectionsNav">
    <div class="container">
      <div class="navbar-translate">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/home.ps"><img src="<%=request.getContextPath()%>/assets/img/picsion-logo.png" style="width: 100px; height: 30px;"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
          <span class="navbar-toggler-icon"></span>
          <span class="navbar-toggler-icon"></span>
        </button>
      </div>
      <div class="collapse navbar-collapse">
      	<form class="form-inline">
                 <div class="form-group has-default bmd-form-group">
                            <input type="text" class="form-control" placeholder="Search">
                 </div>
                 <button type="submit" class="btn btn-white btn-raised btn-fab btn-fab-mini btn-round">
                    <i class="material-icons">search</i>
                </button>
           </form>
        <ul class="navbar-nav ml-auto">

          <c:choose>
					<c:when test="${sessionScope.user eq null}">
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/user/register.ps" onclick="scrollToDownload()"> 
								<i class="material-icons">accessibility_new</i> 회원가입
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/user/login.ps" onclick="scrollToDownload()"> 
								<i class="material-icons">camera_front</i>로그인
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="dropdown nav-item">
		                  <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
		                      <i class="material-icons">apps</i> Components
		                  </a>
		                  <div class="dropdown-menu dropdown-with-icons">
		                    <a href="<%=request.getContextPath()%>/board/board.ps" class="dropdown-item">
		                        <i class="material-icons">list</i> 요청 게시판
		                    </a>
		                    <a href="<%=request.getContextPath()%>/upload.ps" class="dropdown-item">
		                        <i class="material-icons">add_circle_outline</i>업로드
		                    </a>
		                    <a href="<%=request.getContextPath()%>/user/bookmarklist.ps" class="dropdown-item">
		                        <i class="material-icons">bookmark</i>즐겨찾기
		                    </a>
		                    <a href="<%=request.getContextPath()%>/user/followinglist.ps" class="dropdown-item">
		                        <i class="material-icons">favorite</i>팔로잉
		                    </a>
		                    <a href="<%=request.getContextPath()%>/message/receivemessage.ps" class="dropdown-item">
		                        <i class="material-icons">mail</i>메시지함
		                    </a>
		                    <a href="#" class="dropdown-item">
		                        <i class="material-icons">shop_two</i>거래내역
		                    </a>
		                    <a href="#" class="dropdown-item">
		                        <i class="material-icons">description</i>요청/작업
		                    </a>
		                    <a href="<%=request.getContextPath()%>/user/updateinfo.ps" class="dropdown-item">
		                        <i class="material-icons">settings</i>정보 수정
		                    </a>
		                    <c:if test="${sessionScope.user.naver eq null}">
			                    <a href="<%=request.getContextPath()%>/naver/login.ps" class="dropdown-item"> 
			                   		<i class="material-icons">visibility</i>네이버 계정 연동 
		                    	</a>
		                    </c:if>
		                    <c:if test="${sessionScope.user.google eq null}">
			                    <a href="<%=request.getContextPath()%>/google/login.ps" class="dropdown-item"> 
			                   		<i class="material-icons">visibility</i>구글 계정 연동 
		                    	</a>
	                    	</c:if>
		                  </div>
		                </li>
						<li class="nav-item">
							<a id="userProfile" class="nav-link" href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${sessionScope.user.userNo}">
								<c:choose>
									<c:when test="${sessionScope.user.prPicture eq null}">
									  <img style="width:30px;" class="rounded-circle" src="<%=request.getContextPath()%>/assets/img/user.png">
									</c:when>
									<c:otherwise>
									  <img style ="width: 30px;" class="rounded-circle" src="<%=request.getContextPath()%>${sessionScope.user.prPicture}">
									</c:otherwise>
								</c:choose> 
								  ${sessionScope.user.userName}
							</a>
						</li>
						<li class="nav-item">
							<a href="#" data-toggle="dropdown">
								<img id="newNotice" src="https://png.icons8.com/doodle/50/000000/new.png">
							</a>
								<ul class="dropdown-menu" id="noticeList">
								</ul>
															
						</li>
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/user/logout.ps" onclick="scrollToDownload()"> 
								<i class="material-icons">highlight_off</i> 로그아웃
							</a>
						</li>
					</c:otherwise>
				</c:choose>
        </ul>
      </div>
    </div>
  </nav>
