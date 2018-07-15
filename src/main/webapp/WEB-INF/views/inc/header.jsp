<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
$(function(){
	
	window.onscroll = function() {scrollFunction()};

	function scrollFunction() {
	    if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
	        document.getElementById("topbtn").style.display = "block";
	    } else {
	        document.getElementById("topbtn").style.display = "none";
	    }
	}
	
	// When the user clicks on the button, scroll to the top of the document
	function topFunction() {
	    document.body.scrollTop = 0;
	    document.documentElement.scrollTop = 0;
	} 

	$.ajax({
		url:"/picsion/userCount.ps",
		success: function(data){
			console.log(data)
			$('#userCount')[0].innerHTML = "현재 접속자 수 : "  + data.count
		}
		
	})
	console.log($('#loginUserNo').val())
	
	$(window).scroll(function(){
		if($(this).scrollTop() >= 90){ 
			$('#logo').attr('src','<%=request.getContextPath()%>/assets/img/picsion-logo.png');
		}else{
			$('#logo').attr('src','<%=request.getContextPath()%>/assets/img/picsion-logo-white.png');
		}
	});
	
	if($('#loginUserNo').val() != 0){
		newNoticeCount();
		myCart();
	}
	
	$('#userProfile').click(function(){
		console.log('클릭클릭')
		$.ajax({
			url:"/picsion/user/sessionReset.ps",
			success: function(){
				
			}
		})
	})
	
	$(document).on('click','#alram',function(){
		$('#noticeList').hide() 
			$('#noticeList').show() 
			$.ajax({
				url: "/picsion/notice/notice.ps",
				beforeSend : function () {
					$('#noticeList').append('&nbsp&nbsp<img src="/picsion/assets/img/loading_bar3.gif" style="width : 130px" >')  
				},
				success : function (data) {
					var noticeMenu = '';
					var j = -1
					$('#noticeList').empty() 
					$.each(data.map, function(i, elt) {
						j = i
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
					if (j == -1){
						noticeMenu = '<li class="divider"><a>도착한 알림이 없습니다</a></li>'
					}
					$('#noticeList').append(noticeMenu)
				}
			})
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
	$(".searchAll").autocomplete({
					matchContains: true,
					source : function(request, response) {
						if($('.searchAll').val()!=''){
						$.ajax({
							type : 'post',
							url : "/picsion/picture/searchpicture.ps",
							dataType : "json",
							data : {tagParam : request.term},
							success : function(data) {
								response(data.searchTagList);
							}
						});
						}
					},
					//조회를 위한 최소글자수 
					minLength : 1,
					select : function(event, ui) {
						$('.searchAll').val(ui.item.value);
						$('.autosend').submit();
					},
				});

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
	$('#changemain').css('background-image','url(<%=request.getContextPath()%>/assets/img/main2/main'+generateRandom(1,11)+'.jpg)');
	
	var nowPoint = $('#nowPoint').val();
	
	var IMP = window.IMP;
	IMP.init('imp27054314');
	
	$('.pointCharge').click(function(){
		IMP.request_pay({
		    pg : 'inicis', // version 1.1.0부터 지원.
		    pay_method : 'card',
		    merchant_uid : 'merchant_' + new Date().getTime(),
		    name : '포인트 충전',
		    amount : $('#chargePrice').val(),
		    buyer_name : $('.userName').val(),
		    m_redirect_url : 'http://localhost:8090/user/updateinfo.ps'
	}, function(rsp) {
		$('#chargePrice').val("")
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
						$('.point').val(data.point)
						$('#fmtPoint')[0].innerHTML = '포인트 : '+ numberWithCommas(data.point)
					}
					
				}
			})
		
		} else {
		    var msg = '결제에 실패하였습니다.'
		    msg += '에러내용 : ' + rsp.error_msg
		}
		alert(msg)
	});
		
	})	
	
})
function numberWithCommas(x) {
    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function newNoticeCount() {
		$.ajax({
			url : "/picsion/notice/noticeMsg.ps",
			success: function (data) {
				$('#alram')[0].childNodes[2].nodeValue = data.count
			}
		})
	}

</script>

<style>
	/* 헤더 프로필 사진 크기 고정 */
	.header-prPic{
		width: 30px;
		height: 30px;
	}
	#topbtn {
  display: none;
  position: fixed;
  bottom: 20px;
  right: 30px;
  z-index: 99;
  font-size: 18px;
  border: none;
  outline: none;
  color: white;
  cursor: pointer;
  padding: 15px;
  border-radius: 4px;
}
</style>

<input type="hidden" value='<c:choose><c:when test="${sessionScope.user eq null}">0</c:when><c:otherwise>${sessionScope.user.userNo}</c:otherwise></c:choose>' id="loginUserNo">
<button onclick="topFunction()" id="topbtn" class="btn btn-primary"title="Go to top">Top</button>
<nav class="navbar navbar-transparent navbar-color-on-scroll fixed-top navbar-expand-lg" color-on-scroll="100" id="sectionsNav">
    <div class="container">
      <div class="navbar-translate">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/home.ps"><img id="logo" src="<%=request.getContextPath()%>/assets/img/picsion-logo-white.png" style="width: 100px; height: 30px;"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
          <span class="navbar-toggler-icon"></span>
          <span class="navbar-toggler-icon"></span>
        </button>
      </div>
      <div class="collapse navbar-collapse">
      	<form action="/picsion/picture/tagpicList.ps" class="form-inline autosend">
                 <div class="form-group has-default bmd-form-group">
                       <input type="text" name="tag" class="form-control searchAll" placeholder="Search">
                 </div>
                <button type="submit" class="btn btn-white btn-fab btn-round">
                      <i class="material-icons">search</i>
                 </button>
           </form>
			
        <ul class="navbar-nav ml-auto">
        <h6 id="userCount">현재 접속자 수 : </h6>
          <c:choose>
					<c:when test="${sessionScope.user eq null}">
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/register.ps"> 
								<i class="material-icons">how_to_reg</i> 회원가입
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/login.ps"> 
								<i class="material-icons">account_circle</i>로그인
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item">
							<a href="" class="nav-link" data-toggle="dropdown" id="alram">
								<i id='newNotice' class='material-icons'>notifications_active</i>
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
		                      <i class="material-icons">apps</i> 메뉴
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
	                    	<c:if test="${sessionScope.user.roleNo eq 3}">
			                    <a href="<%=request.getContextPath()%>/user/admin.ps" class="dropdown-item"> 
			                   		<i class="material-icons">build</i>회원/매출/신고
		                    	</a>
	                    	</c:if>
		                  </div>
		                </li>
						<li class="dropdown nav-item">
							<a id="userProfile" class="dropdown-toggle nav-link" href=""data-toggle="dropdown">
									  <img class="rounded-circle header-prPic" src="${sessionScope.user.prPicture}">
							  	${sessionScope.user.userName}
							  	<input type="hidden" class="userName" value="${sessionScope.user.userName}">
							</a>
							 <div class="dropdown-menu dropdown-with-icons dropdown-menu-right">
                                 <h6 class="dropdown-header">홈</h6>
                                 <a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${sessionScope.user.userNo}" class="dropdown-item">
                                 <i class="material-icons">face</i> 마이 스튜디오</a>
                                 <fmt:formatNumber var="fmtmoney" value="${sessionScope.user.point}" pattern="#,###"/>
                                 <h6 id="fmtPoint" class="dropdown-header">포인트 : ${fmtmoney}</h6>
                                 <input type="hidden" class="point" id="nowPoint" value="${sessionScope.user.point}">
                                 <a href="#pablo" class="dropdown-item" data-toggle="modal" data-target="#exampleModal">
                                 <i class="material-icons">credit_card</i> 충전하기</a>
                                 <div class="dropdown-divider"></div>
                                 <a href="<%=request.getContextPath()%>/logout.ps?userId=${sessionScope.user.userId}" class="dropdown-item">
                                 <i class="material-icons">highlight_off</i> 로그아웃</a>
                             </div>
						</li>
						
					</c:otherwise>
				</c:choose>
        </ul>
      </div>
    </div>
  </nav>
  
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
	      	<button type="button" class="btn btn-primary pointCharge" data-dismiss="modal">충전하기</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	      
	    </div>
	  </div>
	</div>
