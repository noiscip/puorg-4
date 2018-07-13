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
	
	
	function detailSearch(){
		var detailHtml="";
		 $.ajax({ 
			  url : "/picsion/picture/detailSearch.ps", 
			  data : {
				    userNo : loginUserNo,
				    tag : '${tag}',
				    order : $('input[name="viewSelect"]:checked').val(),
				    picPeople :  $('input[name="peopleSelect"]:checked').val() *1,
				    resolutionSize :  $('input[name="sizeSelect"]:checked').val() ,
				    lowPrice : $('#minp').val() *1,
				    highPrice : $('#maxp').val() *1,
				    colorR : $('#rcol').val() *1,
				    colorG : $('#gcol').val() *1,
				    colorB : $('#bcol').val() *1
				},
			  success : function(data){
				  $('#searchpic').empty();  
				     $.each(data.detailSearch, function(index, obj){
	             	
	        	detailHtml="<div class='item col-sm-12 col-md-4'>"+
	  			   "<a href='/picsion/picture/picinfo.ps?picNo="+obj.picNo+"'>"+
	          	   "<img class='rounded img-size' src='"+obj.picWater+"' alt='No Image'>"+
	      		   "</a><div><div class='counts hide-xs hide-sm'>";
	                if(obj.respectCheck=="T"){
	                	detailHtml+="<em><i id='like' value='"+obj.picNo+"' class='material-icons'>favorite</i>"+obj.respectCount+"</em>";
	               }else{
	            	   detailHtml+="<em><i id='like' value='"+obj.picNo+"' class='material-icons'>favorite_border</i>"+obj.respectCount+"</em>";
	               }
	               
	               if(obj.bookmarkCheck=="T"){
	            	   detailHtml+="<em><i id='down' value='"+obj.picNo+"' class='material-icons'>bookmark</i>"+obj.bookmarkCount+"</em>";
	               }else{
	            	   detailHtml+="<em><i id='down' value='"+obj.picNo+"' class='material-icons'>bookmark_border</i>"+obj.bookmarkCount+"</em>";
	               }
	               detailHtml+="</div><a href='/picsion/picture/mystudio.ps?userNo="+obj.userNo+"'>"+obj.userName+"</a></div></div>";
	             	
	              $('#searchpic').append(detailHtml);
	             })
			  },
			  error: function(){
			   	  alert("상세 검색 도중 오류가 발생했습니다.");
			  }
		}) 
		
	}
    
    var slider2 = document.getElementById('sliderRefine');

    noUiSlider.create(slider2, {
        start: [1000, 100000],  
        connect: true,
        range: {
            'min': [1000],
            'max': [100000]
        }
    });

    var limitFieldMin = document.getElementById('price-left');
    var limitFieldMax = document.getElementById('price-right');
	var max="";
	var min="";
    slider2.noUiSlider.on('update', function(values, handle) {
        if (handle) {
            limitFieldMax.innerHTML = $('#price-right').data('currency') + Math.round(values[handle]);
            $('#maxp').val(Math.round(values[handle]));
            max=Math.round(values[handle]);
        } else {
            limitFieldMin.innerHTML = $('#price-left').data('currency') + Math.round(values[handle]);
            $('#minp').val(Math.round(values[handle]));
            min=Math.round(values[handle]);
        }  
        if((max >= 1000 && max <= 100000) && (min >= 1000 && min <= 100000)){
       		detailSearch(); 
        }
    });
    
    
    var example = new iro.ColorPicker(".wrapper", {  
    	  width: 200,
    	  height: 200,
    	  color: {r: 256, g: 0, b: 0},
    	  anticlockwise: true,
    	  borderWidth: 1,
    	  borderColor: "#fff",
    	  css: {
    	    "#swatch": {
    	      "background-color": "$color" 
    	    }
    	  }
    	});

    	var values = document.getElementById("values");
    	var css = document.getElementById("css");

    	example.on("color:change", function(color){
    	  values.innerHTML = [
    	    "hex: " + color.hexString,
    	    "rgb: " + color.rgbString,  
    	  ].join("<br>");
    	  
    	  $('#rcol').val(color.rgb.r);
    	  $('#gcol').val(color.rgb.g);
    	  $('#bcol').val(color.rgb.b);
    	  detailSearch();
    	});
    	
    	$(document).on('change','.detailinput',function(){
    		detailSearch();
    		
    	})
    	
})  
</script>

<style type="text/css">
.img-size {
	height: 300px;
	width: 100%;
}

.wrapper svg {
  margin: 0 auto; 
}

.wrap {
  max-width: 720px;
  margin: 0 auto;
  display: flex;
  flex-direction: row;
  align-items: center;
  justify-content: center;
  
  .half {
    width: 50%;
    padding: 32px 0;
  }
}

#swatch {
  height: 24px;
  border-radius: 2px;
}


.readout {
  font-family: monospace;
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
							</h4>
							<div id="accordion" role="tablist" class="row">
							
							  <!-- 최신, 인기 순 -->
							  <div class="card card-collapse col-md-2">
								<div class="card-header" role="tab" id="headingOne">
								  <h5 class="mb-0">
									<a class="" data-toggle="collapse" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
										Order
		  							    <i class="material-icons">keyboard_arrow_down</i>
									</a>
								  </h5>
								</div>
								<div id="collapseOne" class="collapse" role="tabpanel" aria-labelledby="headingOne" style="">
								  <div class="card-body">
									   <div class="form-check">
			  								<label class="form-check-label">
			  									<input class="form-check-input detailinput" name="viewSelect" type="radio" value="Latest" checked="checked">
			  									Latest 
			  									<span class="form-check-sign">
			  										<span class="check"></span>
			  									</span>
			  								</label>
			  							</div>
									  
										  <div class="form-check">
			  								<label class="form-check-label">
			  									<input class="form-check-input detailinput" name="viewSelect" type="radio" value="Popular">
			  									Popular
			  									<span class="form-check-sign">
			  										<span class="check"></span>  
			  									</span>
			  								</label>
			  							</div>
								  </div>
								</div>
							  </div>
							  
							   <!-- 크기 -->
							  <div class="card card-collapse col-md-2">
								<div class="card-header" role="tab" id="headingTwo">
								  <h5 class="mb-0">
									<a class="" data-toggle="collapse" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
										Size
										<i class="material-icons">keyboard_arrow_down</i>
									</a>
								  </h5>
								</div>
								<div id="collapseTwo" class="collapse" role="tabpanel" aria-labelledby="headingTwo" style="">
								  <div class="card-body">
								  
								  <div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input detailinput" name="sizeSelect" type="radio" value="-1" checked="checked">
		  									All 
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>
								  
									<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input detailinput" name="sizeSelect" type="radio" value="Horizontal">
		  									Horizontal 
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>
								  
									  <div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input detailinput" name="sizeSelect" type="radio" value="Vertical">
		  									Vertical
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>
		  							
		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input detailinput" name="sizeSelect" type="radio" value="Square">
		  									Square
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>
									  
								  </div>
								</div>
							  </div>
							  
							  
							  <!-- 사람 수 -->
							  <div class="card card-collapse col-md-2">
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
		  									<input class="form-check-input detailinput" name="peopleSelect" type="radio" value="-1" checked="checked">
		  									All 
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>
								  
									  <div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input detailinput" name="peopleSelect" type="radio" value="0">
		  									0
		  									<span class="form-check-sign">
		  										<span class="check"></span> 
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input detailinput" name="peopleSelect" type="radio" value="1">
		  									1
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input detailinput" name="peopleSelect" type="radio" value="2">
		  									 2
		  									<span class="form-check-sign">
		  										<span class="check"></span>
		  									</span>
		  								</label>
		  							</div>

		  							<div class="form-check">
		  								<label class="form-check-label">
		  									<input class="form-check-input detailinput" name="peopleSelect" type="radio" value="3">
		  									3+
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
								<div class="card-header" role="tab" id="headingFour">
								  <h5 class="mb-0">
									<a data-toggle="collapse" href="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
									  	Price Range
		  							  <i class="material-icons">keyboard_arrow_down</i>
									</a>
								  </h5>
								</div>

								<div id="collapseFour" class="collapse" role="tabpanel" aria-labelledby="headingFour" style="">
								  <div class="card-body card-refine">
									<span id="price-left" class="price-left pull-left" data-currency="최저"></span>
		  							<span id="price-right" class="price-right pull-right" data-currency="최고"></span>
		  							<div class="clearfix"></div>
		  							<div id="sliderRefine" class="slider slider-success noUi-target noUi-ltr noUi-horizontal">
		  							</div>
		  							<input type="hidden" id="maxp" class="detailinput"value="100000"/>
		  							<input type="hidden" id="minp" class="detailinput"value="1000"/>
								  </div>
								</div>
							  </div>
							 
							  
							  <!-- 색상 -->
							   <div class="card card-collapse col-md-3"> 
								<div class="card-header" role="tab" id="headingFive">
								  <h5 class="mb-0">
									<a class="" data-toggle="collapse" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive">
										Color
		  							    <i class="material-icons">keyboard_arrow_down</i>
									</a>
								  </h5>
								</div>
								<div id="collapseFive" class="collapse" role="tabpanel" aria-labelledby="headingFive" style="">
								  <div class="card-body">
								  
								   <div class="wrap">
								   <div class="col mr-auto ml-auto">
								      <div class="half">
								        <div class="wrapper"></div>  
								      </div>
								      <div class="half readout">
								        <div id="swatch"></div>
								        <div id="values"></div>
								        <input id ='rcol' class="detailinput" type='hidden' value='256'/>
								        <input id ='gcol' class="detailinput" type='hidden' value='0'/>
								        <input id ='bcol' class="detailinput" type='hidden' value='0'/> 
								        <div id="css"></div>
								      </div> 
								      </div>
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
			                    <a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${tagpic.userNo}">${tagpic.userName}</a>
               				</div>
						</div>
					
					</c:forEach>
				</div>	
			</div>
		</div>
		</div>
	</div>
</div>
