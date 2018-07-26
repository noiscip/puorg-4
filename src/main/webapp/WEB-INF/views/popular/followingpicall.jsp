<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			 $.ajax({
				url : "<%=request.getContextPath()%>/picture/increasebookmark.ps",
				data : data,
				success : function(data){
					if(data.result==1){
						  $(bookmark)[0].innerHTML = 'bookmark_border';
						  $(bpa)[0].childNodes[1].nodeValue--;
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
                    url : '<%=request.getContextPath()%>/user/popular.ps',
                    data : { 
                        page: page
                    },
                    success : function(data){
                        
                        $.each(data.followingScrollPic, function(index, obj){
                        	
                        		
                        		scrollPage="<div class='item col-sm-12 col-md-4'>"+
                 			   "<a href='/picsion/picture/picinfo.ps?picNo="+obj.picNo+"'>"+
                         	   "<img class='rounded img-size' src='"+obj.picWater+"' alt='No Image'>"+
	                    		   "</a><div><div class='counts hide-xs hide-sm'>";
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
			                    scrollPage+="</div><a href='/picsion/picture/mystudio.ps?userNo="+obj.userNo+"'>"+obj.userName+"</a></div></div>";
			            		
				                $('#followpic').append(scrollPage);
                        		
                        	
                        })
					    page+=data.endpage;
                    }
                });
                 
            }
            
        }

    })
    
})
</script>

<style type="text/css">
.img-size {
	height: 300px;
	width: 100%;
}
</style>

<div id="changemain" class="page-header header-filter" data-parallax="true">
<div class="container">
				<div class="row">
					<div class="col-md-8 ml-auto mr-auto text-center">
						<div class="brand">
							<h1 class="title">Following Latest Photos</h1>
						</div>
					</div>
					
				</div>
			</div>
</div>
<div class="main">
	<div class="profile-content">

		<div class="container">
			<div class="flex_grid credits">
			<div class="tz-gallery">
				<div class="row" id="followpic">
				<c:forEach items="${followingPicList}" var="followingListAll" varStatus="status">
				 <fmt:parseNumber var="var3" value="${followingListAll.resolutionW/followingListAll.resolutionH}" pattern="#.#" />
						
						   <div class="item col-sm-12 col-md-4"> 
			                    <a href="/picsion/picture/picinfo.ps?picNo=${followingListAll.picNo}"> 
                                    <img class="rounded img-size" src="${followingListAll.picWater}"alt="No Image">
			                    </a>
			                    <div>
			                    <div class="counts hide-xs hide-sm ">
			                    <c:choose>
									<c:when test="${followingListAll.respectCheck eq 'T'}">
										<em><i id="like" value="${followingListAll.picNo}" class="material-icons">favorite</i>${followingListAll.respectCount}</em>
									</c:when>
									<c:otherwise>
										<em><i id="like" value="${followingListAll.picNo}" class="material-icons">favorite_border</i>${followingListAll.respectCount}</em>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${followingListAll.bookmarkCheck eq 'T'}">
										<em><i id="down" value="${followingListAll.picNo}" class="material-icons">bookmark</i>${followingListAll.bookmarkCount}</em>
									</c:when>
									<c:otherwise>
										<em><i id="down" value="${followingListAll.picNo}" class="material-icons">bookmark_border</i>${followingListAll.bookmarkCount}</em>
									</c:otherwise>
								</c:choose>
			                    </div>
			                    <a href="/picsion/picture/mystudio.ps?userNo=${followingListAll.userNo}">${followingListAll.userName}</a>
               				</div>
			            </div>
						
					</c:forEach>
				</div>
			</div>
		</div>
		</div>
	</div>
</div>
