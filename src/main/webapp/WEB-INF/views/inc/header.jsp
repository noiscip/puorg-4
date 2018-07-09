<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<script>

function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

$(function(){
	console.log($('#loginUserNo').val())
	if($('#loginUserNo').val() != 0){
		newNoticeCount();
		myCart();
	}
	
	var isRun =false
	$(document).on('click','#newNotice',function(){
		
		$('#noticeList').hide() 
 
		if(isRun == true) {
       		return;
  	  	}
    
		if($(this).closest('li').hasClass('show') != true){
	    	isRun = true;
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
						noticeMenu += '<li class="divider"><a>'
						noticeMenu += '<img class="rounded-circle header-prPic" src="'+elt[1].prPicture + '">&nbsp&nbsp' 
						noticeMenu += '"'+ elt[1].userName +'"'
						var value = elt[0].tableNo + ',' + elt[0].sendUserNo
						
						if(elt[0].tableNo == 3){
							value += ',' +  elt[0].brdNo + ',0' 
							noticeMenu += '님이 ' + elt[2].brdTitle
							noticeMenu += ((elt[0].operNo ==0)? ' 작업을 신청 하였습니다':' 작업을 수락 하였습니다' )
						}else if(elt[0].tableNo == 4){
							if(elt[2].tableNo == 2){
								value += ',0,' + elt[2].picNo + ',' + elt[2].tableNo 
							}else if(elt[2].tableNo == 3){
								value += ',' + elt[2].brdNo + ',0,' + elt[2].tableNo
							}
							noticeMenu += '님이 ' + elt[3] + '글에 댓글을 달았습니다'
						}else if(elt[0].tableNo == 5){
							value += ',0,0' 
							noticeMenu += '님이 메시지를 보냈습니다'
						}
						noticeMenu += '<input type="hidden" value="'+value+'">'
						noticeMenu += '</a></li>' 
					})
					$('#noticeList').append(noticeMenu)
					isRun =false
				}
			})
		}
	})
	
	
	$(document).on('click','.divider',function(){
		var value = ($(this).find('input')[0].value).split(',')
			
		$.ajax({
			url : "/picsion/notice/readCheck.ps",
			data : {
					receiveUserNo : $('#loginUserNo').val(),
					tableNo : value[0],
					sendUserNo : value[1],
					brdNo : value[2],
					picNo : value[3]
			}
		})
		
		if(value[0] == 3 || value[4] == 3){
			self.location = '/picsion/board/boardInfo.ps?brdNo=' + value[2]
		}else if(value[4] == 2){
			self.location = '/picsion/picture/picinfo.ps?picNo=' + value[3]
		}else if(value[0] == 5){
			self.location = '/picsion/message/messageNotice.ps?userNo=' + value[1]
		}
		
	})
	
	//검색 태그 autocomplete
	$("#searchAll").autocomplete({
		          
					matchContains: true,
					source : function(request, response) {
						if($('#searchAll').val()!=''){
						$.ajax({
							type : 'post',
							url : "/picsion/picture/searchpicture.ps",
							dataType : "json",
							//request.term = $("#autocomplete").val() 
							data : {tagParam : request.term},
							success : function(data) {
								console.log(data.searchTagList);
								response(data.searchTagList);
							}
						});
						}
					},
					//조회를 위한 최소글자수 
					minLength : 1,
					select : function(event, ui) {
						console.log(ui.item.value);
						$('#searchAll').val(ui.item.value);
						$('form[class="form-inline"]').submit();
					},
				});
	
	
	function newNoticeCount() {
		var alon = "<i id='newNotice' class='material-icons'>notifications_active</i>";
		$.ajax({
			url : "/picsion/notice/noticeMsg.ps",
			success: function (data) {
				if (data.count > 0 ){
					$('#al').empty();
					$('#al').append(alon);
					$('#newNotice').css('color','red');
				}
			}
		})
	}
	var nocart ='<li class="divider" id="nonecart"><a>장바구니가 비었습니다</a></li>';
	function myCart(){
		$.ajax({
			data : {userNo : $('#loginUserNo').val()},
			url : "/picsion/purchase/myCart.ps", 
			success: function (data) {
				$('#cartnav').append(data.myCartCount);
				var mycartlist ='<li class="divider"><a href="/picsion/purchase/myCartPage.ps?userNo='+$('#loginUserNo').val()+'">장바구니</a></li>'; 
				mycartlist+='<div class="dropdown-divider"></div>';
				if(data.myCartCount==0){
					$('#addcartnav').append(nocart);
				}else{
					$('#addcartnav').empty();
					mycartlist+='<h6 class="dropdown-header">장바구니 목록</h6>';
					$.each(data.cartPicList, function(i, elt){
						mycartlist += '<li class="divider"><a href="/picsion/picture/picinfo.ps?picNo='+elt.picNo+'">';
						mycartlist += '<img style="width: 30px;" class="rounded" src="'+elt.picWater+'">&nbsp&nbsp';
						mycartlist += elt.picTitle+'<i class="material-icons">chevron_right</i>'+elt.picPrice+'원';
						mycartlist += '<input id="'+elt.picNo+'tt" type="hidden">';
						mycartlist += '</a></li>'; 	
					})					
					$('#addcartnav').append(mycartlist);
					
				}
			}
		})
		
	}
	
	var generateRandom = function (min, max) {
		  var ranNum = Math.floor(Math.random()*(max-min+1)) + min;
		  return ranNum;
	}
	$('#changemain').css('background-image','url(<%=request.getContextPath()%>/assets/img/main2/main'+generateRandom(1,15)+'.jpg)');
	
})
</script>

<style>
	/* 헤더 프로필 사진 크기 고정 */
	.header-prPic{
		width: 30px;
		height: 30px;
	}
</style>

<input type="hidden" value='<c:choose><c:when test="${sessionScope.user eq null}">0</c:when><c:otherwise>${sessionScope.user.userNo}</c:otherwise></c:choose>' id="loginUserNo">
<nav class="navbar navbar-transparent navbar-color-on-scroll fixed-top navbar-expand-lg" color-on-scroll="100" id="sectionsNav">
    <div class="container-fluid">
      <div class="navbar-translate">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/home.ps"><img src="<%=request.getContextPath()%>/assets/img/picsion-logo.png" style="width: 100px; height: 30px;"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
          <span class="navbar-toggler-icon"></span>
          <span class="navbar-toggler-icon"></span>
        </button>
      </div>
      <div class="collapse navbar-collapse">
      	<form action="/picsion/picture/tagpicList.ps" class="form-inline">
                 <div class="form-group has-default bmd-form-group">
                       <input id="searchAll" type="text" name="tag" class="form-control" placeholder="Search">
                 </div>
                 <button id="submitbtn" class="btn btn-white btn-raised btn-fab btn-fab-mini btn-round">
                    <i class="material-icons">search</i>
                </button>
           </form>
        <ul class="navbar-nav ml-auto">
          <c:choose>
					<c:when test="${sessionScope.user eq null}">
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/user/register.ps"> 
								<i class="material-icons">accessibility_new</i> 회원가입
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/user/login.ps"> 
								<i class="material-icons">camera_front</i>로그인
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item">
							<a href="" class="nav-link" data-toggle="dropdown" id="al">
						
							</a>
								<ul class="dropdown-menu" id="noticeList">
								</ul>
															
						</li>
		                <li class="nav-item">
							<a href="" class="nav-link" data-toggle="dropdown" id="cartnav">
							 <i class="material-icons">shopping_cart</i>
							</a>						
								<ul class="dropdown-menu" id="addcartnav">
								</ul>
															
						</li>
					
					
						<li class="dropdown nav-item">
		                  <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
		                      <i class="material-icons">apps</i> Components
		                  </a>
		                  <div class="dropdown-menu dropdown-with-icons">
		                  <h6 class="dropdown-header">게시판</h6>
		                    <a href="<%=request.getContextPath()%>/board/board.ps" class="dropdown-item">
		                        <i class="material-icons">list</i> 요청 게시판
		                    </a>
		                    <div class="dropdown-divider"></div>
		                      <h6 class="dropdown-header">마이 페이지</h6>
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
		                    <a href="<%=request.getContextPath()%>/purchase/history.ps" class="dropdown-item">
		                        <i class="material-icons">shop_two</i>거래내역
		                    </a>
		                    <a href="<%=request.getContextPath()%>/operation/operequest.ps" class="dropdown-item">
		                        <i class="material-icons">description</i>요청/작업
		                    </a>
		                    <a href="<%=request.getContextPath()%>/user/updatebefore.ps" class="dropdown-item">
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
	                    	<c:if test="${sessionScope.user.roleNo eq 3}">
			                    <a href="<%=request.getContextPath()%>/user/admin.ps" class="dropdown-item"> 
			                   		<i class="material-icons">build</i>회원/매출/신고
		                    	</a>
	                    	</c:if>
		                  </div>
		                </li>
						<li class="nav-item">
							<a id="userProfile" class="nav-link" href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${sessionScope.user.userNo}">
									  <img class="rounded-circle header-prPic" src="${sessionScope.user.prPicture}">
							  	${sessionScope.user.userName}
							</a>
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
