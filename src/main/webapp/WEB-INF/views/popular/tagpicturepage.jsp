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
			console.log($('#loginUserNo').val());
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
                    url : '<%=request.getContextPath()%>/picture/tagpicList.ps',
                    data : { 
                        page: page
                    },
                    success : function(data){
                        
                        $.each(data.tagpicList, function(index, obj){
                        	
                        		
                        		scrollPage="<div class='item col-sm-12 col-md-4'>"+
                 			   "<a href='<%=request.getContextPath()%>/picture/picinfo.ps?picNo="+obj.picNo+"'>"+
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
			                    scrollPage+="</div><a href='<%=request.getContextPath()%>/picture/mystudio.ps?userNo="+data.tagUserList[index].userNo+"'>"+data.tagUserList[index].userName+"</a></div></div>";
			            		
				                $('#searchpic').append(scrollPage);
                        		
                        	
                        	
                        })
					    page+=data.endpage;
                    }
                });
                 
            }
            
        }

    })
    
    var slider2 = document.getElementById('sliderRefine');

    noUiSlider.create(slider2, {
        start: [101, 790],
        connect: true,
        range: {
            'min': [30],
            'max': [900]
        }
    });

    var limitFieldMin = document.getElementById('price-left');
    var limitFieldMax = document.getElementById('price-right');

    slider2.noUiSlider.on('update', function(values, handle) {
        if (handle) {
            limitFieldMax.innerHTML = $('#price-right').data('currency') + Math.round(values[handle]);
        } else {
            limitFieldMin.innerHTML = $('#price-left').data('currency') + Math.round(values[handle]);
        }
    });
})
</script>

<style type="text/css">
.img-size {
	height: 300px;
	width: 100%;
}
</style>

<div id="changemain"id="changemain" class="page-header header-filter" data-parallax="true">
	
</div>
<div class="main">
	<div class="profile-content">
		<div class="container"> 
		
			<div class="row">
				<div class="col-md-12">
					<div class="card card-refine card-plain card-rose">
						<div class="card-body">
							<h4 style="text-transform: uppercase;border-bottom: 1px solid #888;"class="card-title filter-option">
								#${tag}
								<button class="btn btn-default btn-fab btn-fab-mini btn-link pull-right" rel="tooltip" title="" data-original-title="Reset Filter">
									<i class="material-icons">cached</i>
								<div class="ripple-container"></div></button>
							</h4>
							<div id="accordion" role="tablist" class="row">
							
							  <!-- 태그들 -->
							  <div class="card card-collapse col-md-3">
								<div class="card-header" role="tab" id="headingTwo">
								  <h5 class="mb-0">
									<a class="" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
										Tags
		  							    <i class="material-icons">keyboard_arrow_down</i>
									</a>
								  </h5>
								</div>
								<div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo" style="">
								  <div class="card-body">
									  <div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="" checked="">
		  									Blazers
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Casual Shirts
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Formal Shirts
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Jeans
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Polos
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Pyjamas
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Shorts
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Trousers
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>
								  </div>
								</div>
							  </div>
							  
							  <!-- 가격 -->
							  <div class="card card-collapse col-md-3">
								<div class="card-header" role="tab" id="headingOne">
								  <h5 class="mb-0">
									<a data-toggle="collapse" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne" class="">
									  	Price Range
		  							  <i class="material-icons">keyboard_arrow_down</i>
									</a>
								  </h5>
								</div>

								<div id="collapseOne" class="collapse" role="tabpanel" aria-labelledby="headingOne" style="">
								  <div class="card-body card-refine">
									  <span id="price-left" class="price-left pull-left" data-currency="원"></span>
		  							<span id="price-right" class="price-right pull-right" data-currency="원"></span>
		  							<div class="clearfix"></div>
		  							<div id="sliderRefine" class="slider slider-rose noUi-target noUi-ltr noUi-horizontal">
		  						<!-- 	<div class="noUi-base">
		  							<div class="noUi-origin" style="left: 7.59912%;">
		  							<div class="noUi-handle noUi-handle-lower" data-handle="0" tabindex="0" role="slider" aria-orientation="horizontal" aria-valuemin="0.0" aria-valuemax="100.0" aria-valuenow="7.6" aria-valuetext="96.11" style="z-index: 5;">
		  							</div>
		  							</div>
		  							<div class="noUi-connect" style="left: 7.59912%; right: 0%;">
		  							</div>
		  							<div class="noUi-origin" style="left: 100%;">
		  							<div class="noUi-handle noUi-handle-upper" data-handle="1" tabindex="0" role="slider" aria-orientation="horizontal" aria-valuemin="7.6" aria-valuemax="100.0" aria-valuenow="100.0" aria-valuetext="900.00" style="z-index: 4;">
		  							</div>
		  							</div>
		  							</div> -->  
		  							</div>
								  </div>
								</div>
							  </div>
							  
							  <!-- 사람 수 -->
							  <div class="card card-collapse col-md-3">
								<div class="card-header" role="tab" id="headingThree">
								  <h5 class="mb-0">
									<a class="" data-toggle="collapse" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
										People
		  							  <i class="material-icons">keyboard_arrow_down</i>
									</a>
								  </h5>
								</div>
								<div id="collapseThree" class="collapse" role="tabpanel" aria-labelledby="headingThree" style="">
								  <div class="card-body">
									  <div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="" checked="">
		  									All
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Polo Ralph Lauren
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Wooyoungmi
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Alexander McQueen
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Tom Ford
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									AMI
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Berena
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Thom Sweeney
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Burberry Prorsum
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Calvin Klein
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Kingsman
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Club Monaco
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Dolce &amp; Gabbana
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Gucci
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Biglioli
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Lanvin
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Loro Piana
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input" type="checkbox" value="">
		  									Massimo Alba
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>
								  </div>
								</div>
							  </div>
							  
							  
							  <!-- 크기 -->
							  <div class="card card-collapse col-md-3">
								<div class="card-header" role="tab" id="headingFour">
								  <h5 class="mb-0">
									<a class="" data-toggle="collapse" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
										Size
										<i class="material-icons">keyboard_arrow_down</i>
									</a>
								  </h5>
								</div>
								<div id="collapseFour" class="collapse" role="tabpanel" aria-labelledby="headingFour" style="">
								  <div class="card-body">
									  <div class="form-check">
										  <label class="form-check-label">
											  <input class="form-check-input" type="checkbox" value="" checked="">
											  All
											  <span class="form-check-sign">
												  <span class="check"></span>
											  </span>
										  </label>
									  </div>

									  <div class="form-check">
										  <label class="form-check-label">
											  <input class="form-check-input" type="checkbox" value="">
											  Black
											  <span class="form-check-sign">
												  <span class="check"></span>
											  </span>
										  </label>
									  </div>

									  <div class="form-check">
										  <label class="form-check-label">
											  <input class="form-check-input" type="checkbox" value="">
											  Blue
											  <span class="form-check-sign">
												  <span class="check"></span>
											  </span>
										  </label>
									  </div>

									  <div class="form-check">
										  <label class="form-check-label">
											  <input class="form-check-input" type="checkbox" value="">
											  Brown
											  <span class="form-check-sign">
												  <span class="check"></span>
											  </span>
										  </label>
									  </div>

									  <div class="form-check">
										  <label class="form-check-label">
											  <input class="form-check-input" type="checkbox" value="">
											  Gray
											  <span class="form-check-sign">
												  <span class="check"></span>
											  </span>
										  </label>
									  </div>

									  <div class="form-check">
										  <label class="form-check-label">
											  <input class="form-check-input" type="checkbox" value="">
											  Green
											  <span class="form-check-sign">
												  <span class="check"></span>
											  </span>
										  </label>
									  </div>

									  <div class="form-check">
										  <label class="form-check-label">
											  <input class="form-check-input" type="checkbox" value="">
											  Neutrals
											  <span class="form-check-sign">
												  <span class="check"></span>
											  </span>
										  </label>
									  </div>

									  <div class="form-check">
										  <label class="form-check-label">
											  <input class="form-check-input" type="checkbox" value="">
											  Purple
											  <span class="form-check-sign">
												  <span class="check"></span>
											  </span>
										  </label>
									  </div>
								  </div>
								</div>
							  </div>
							</div>
						</div>
					</div>
				</div>
				
			</div>
			
				<div class="flex_grid credits">
				<div class="tz-gallery">
				<div class="row" id="searchpic">
					<c:forEach items="${tagpicList}" var="tagpic" varStatus="status">
					<fmt:parseNumber var="var3" value="${tagpic.resolutionW/tagpic.resolutionH}" pattern="#.#" />
			  			
			  				<div class="item col-sm-12 col-md-4">
							<a href="<%=request.getContextPath()%>/picture/picinfo.ps?picNo=${tagpic.picNo}">
							<img class="rounded img-size" src="${tagpic.picWater}"	alt="No Image">
							</a>
							<div>
			                    <div class="counts hide-xs hide-sm ">
			                    <c:choose>
									<c:when test="${tagpic.respectCheck eq 'T'}">
										<em><i id="like" value="${tagpic.picNo}" class="material-icons">favorite</i>${tagpic.respectCount}</em>
									</c:when>
									<c:otherwise>
										<em><i id="like" value="${tagpic.picNo}" class="material-icons">favorite_border</i>${tagpic.respectCount}</em>
									</c:otherwise>
								</c:choose>
								<c:choose>
									<c:when test="${tagpic.bookmarkCheck eq 'T'}">
										<em><i id="down" value="${tagpic.picNo}" class="material-icons">bookmark</i>${tagpic.bookmarkCount}</em>
									</c:when>
									<c:otherwise>
										<em><i id="down" value="${tagpic.picNo}" class="material-icons">bookmark_border</i>${tagpic.bookmarkCount}</em>
									</c:otherwise>
								</c:choose>
			                    </div>
			                    <a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${tagUserList[status.index].userNo}">${tagUserList[status.index].userName}</a>
               				</div>
						</div>
					
					</c:forEach>
				</div>	
			</div>
		</div>
		</div>
	</div>
</div>
