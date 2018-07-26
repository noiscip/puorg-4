<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(function() {
	var loginUserNo = $('#loginUserNo').val();

    
	$(document).on('click','#like',function(){
			if(loginUserNo == 0){
			}else{
				var data = {userNo : loginUserNo,
					    picNo : $(this).attr("value")};
				var respect =  $(this);
				var rpa = $(this).parent();
				 $.ajax({
					url : "<%=request.getContextPath()%>/picture/increaserespect.ps",
					data : data,
					success : function(data){
						if(data.result==1){
							  $(respect)[0].innerHTML = 'favorite_border';
							  $(rpa)[0].childNodes[1].nodeValue--;
						  }else{
							  $(respect)[0].innerHTML = 'favorite';
							  $(rpa)[0].childNodes[1].nodeValue++;
						  }
					}
				 }) 
			}
	})
	
	$(document).on('click','#down',function(){
		if(loginUserNo == 0){
		}else{
			var data = {userNo : loginUserNo,
				    picNo : $(this).attr("value")};
			var bookmark = $(this);
			var bpa = $(this).parent();
			var removeDiv = bookmark.closest('.item');
			 $.ajax({
				url : "<%=request.getContextPath()%>/picture/increasebookmark.ps",
				data : data,
				success : function(data){
					if(data.result==1){
						  $(bookmark)[0].innerHTML = 'bookmark_border';
						  $(bpa)[0].childNodes[1].nodeValue--;
						  removeDiv.remove();
					  }else{
						  $(bookmark)[0].innerHTML = 'bookmark';
						  $(bpa)[0].childNodes[1].nodeValue++;
					  }
				}
			 }) 
		}
	})
	
	
	var lastScrollTop = 0;
    var page = ${page};

	$(window).scroll(function(){ // ① 스크롤 이벤트 최초 발생
         
        var currentScrollTop = $(window).scrollTop();
        var scrollPage="";
        
        if( currentScrollTop - lastScrollTop > 0 ){
            
            // 2. 현재 스크롤의 top 좌표가  > (게시글을 불러온 화면 height - 윈도우창의 height) 되는 순간
            if ($(window).scrollTop() >= ($(document).height() - $(window).height()) ){ //② 현재스크롤의 위치가 화면의 보이는 위치보다 크다면
                 
                $.ajax({
                    type : 'post',  
                    url : '<%=request.getContextPath()%>/user/bookmarklist.ps',
                    data : { 
                        page: page
                    },
                    success : function(data){
                        
                        $.each(data.scrollPicList, function(index, obj){
                        	
                        		scrollPage="<div class='item col-sm-12 col-md-4'>"+
								"<a href='<%=request.getContextPath()%>/picture/picinfo.ps?picNo="+obj.picNo+"'>"+
								"<img class='rounded img-size' src='"+obj.picWater+"' alt='No Image'>"+
								"</a>"+
							   "<div>"+
			                   "<div class='counts hide-xs hide-sm'>";
			                   if(obj.respectCheck=="T"){
			                	   scrollPage+="<em><i id='like' value='"+obj.picNo+"' class='material-icons'>favorite</i>"+obj.respectCount+"</em>";
			                   }else{
			                	   scrollPage+="<em><i id='like' value='"+obj.picNo+"' class='material-icons'>favorite_border</i>"+obj.respectCount+"</em>";
			                   }
			                   
			                   if(obj.bookmarkCheck=="T"){
			                	   scrollPage+="<em><i id='down' value='"+obj.picNo+"' class='material-icons'>bookmark</i>"+obj.bookmarkCount+"</em>";
			                   }else{
			                	   scrollPage+="<em><i id='down' value='"+obj.picNo+"' class='material-icons'>bookmark_border</i>"+obj.bookmarkCount+"</em>";
			                   }
			                   
			                   scrollPage+="</div><a href='<%=request.getContextPath()%>/picture/mystudio.ps?userNo="+data.scrollPicUserList[index].userNo+"'>"+data.scrollPicUserList[index].userName+"</a></div></div>";
			                 
                			   $('#bookpic').append(scrollPage);
                        })
					    page+=data.endpage;
         				
                    }
                });
                 
            }
            
        }

    })
})

</script>
<style>
/* 뿌려주는 이미지의 크기 */
.img-size {
	height: 300px;
	width: 100%;
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
</style>

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
<div class="main">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/history.ps">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
		</ul>
		
			<div id="gallery">
				<div class="flex_grid credits">
				<div class="tz-gallery">
					<c:choose>
						<c:when test="${empty bookmarkPicList}">
							<h1 class="text-center"><b>즐겨찾기한 사진이 없네요!</b></h1>
							<h3 class="text-center">원하는 사진을 담아보세요~</h3>
						</c:when>
						<c:otherwise>
							<div class="row" id="bookpic">
								<c:forEach items="${bookmarkPicList}" var="bookmarkpic" varStatus="status">
								 <fmt:parseNumber var="var3" value="${bookmarkpic.resolutionW/bookmarkpic.resolutionH}" pattern="#.#" />
						  			<div class="item col-sm-12 col-md-4">
										<a href="<%=request.getContextPath()%>/picture/picinfo.ps?picNo=${bookmarkpic.picNo}">
										<img class="rounded img-size" src="${bookmarkpic.picWater}"	alt="No Image">
										</a>
										<div>
						                    <div class="counts hide-xs hide-sm ">
						                    <c:choose>
												<c:when test="${bookmarkpic.respectCheck eq 'T'}">
													<em><i id="like" value="${bookmarkpic.picNo}" class="material-icons">favorite</i>${bookmarkpic.respectCount}</em>
												</c:when>
												<c:otherwise>
													<em><i id="like" value="${bookmarkpic.picNo}" class="material-icons">favorite_border</i>${bookmarkpic.respectCount}</em>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${bookmarkpic.bookmarkCheck eq 'T'}">
													<em><i id="down" value="${bookmarkpic.picNo}" class="material-icons">bookmark</i>${bookmarkpic.bookmarkCount}</em>
												</c:when>
												<c:otherwise>
													<em><i id="down" value="${bookmarkpic.picNo}" class="material-icons">bookmark_border</i>${bookmarkpic.bookmarkCount}</em>
												</c:otherwise>
											</c:choose>
						                    </div>
						                    <a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${bookmarkPicUserList[status.index].userNo}">${bookmarkPicUserList[status.index].userName}</a>
			               				</div>
									</div>
						  			
								
									
								</c:forEach>
							</div>
						</c:otherwise>
					</c:choose>
				
					</div>
				</div>
			</div>
			
			
		</div>
	</div>
</div>


