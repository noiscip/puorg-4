<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style type="text/css">
.bootstrap-tagsinput .tag {
	background-color: #9c27b0;
}

/* 마이페이지 상단 메뉴 위,아래 여백 */
.my-ul {
	padding-top: 30px;
	padding-bottom: 30px;
}
/*얼굴 영역 잡기 */
.face-rectangle {
  /* id:faceIt; */
  position:absolute;
  height: 100px;
  width: 100px; 
  border:3px solid;
  border-color:#555;
  background-color: transparent;
 /*  background-position: inherit; */
}
@-webkit-keyframes rainbow {
  0% {color: hsl(0, 100%, 50%);}
  100% {color: hsl(255, 100%, 50%);}
}

.rainbow-color {
  -webkit-animation: rainbow 5s infinite alternate;
}
</style>

<script type="text/javascript">
$(document).on("click", "#tagAdd", function() {
    if($('#tagAddName').val()==0){
        alert("태그를 입력해주세요.");
    }else{
        $('#picTags').append("<input type='text' value="+$('#tagAddName').val()+" name='tag' data-role='tagsinput'>");
        $("input[data-role=tagsinput]").tagsinput();
        $('#tagAddName').val("");
    }
    
});

function drawFace(imgId,rectX,rectY,rectWid,rectHei){
	var img,sagac;
	var wid,hei,scalWid,scalHei;
	img = document.getElementById(imgId);
	sagac = document.createElement("DIV");
	sagac.setAttribute("class","face-rectangle");
	
	img.parentElement.insertBefore(sagac,img);
/* 	sagac.style.backgroundImage = "url('"+img.src+"')"; */
	sagac.style.backgroundRepeat = "no-repeat";
	/* sagc.style.background-origin = "padding-box"; */
	sagac.style.width= rectWid + "px";
	sagac.style.height=rectHei + "px";
	
	sagac.style.backgroundSize = img.width + "px " + img.height + "px";
	showRect();
	function showRect(){
		var x,y;
		
		x = rectX; 
		y = rectY;
		x*=1;
		sagac.style.left = x+"px";
		sagac.style.top = y+"px";
	}
	
}
/* $("#preview").mouseover(function(){
	$("#preview").style("color","red");
	
	 $("#preview").css("class", "rainbow-color"); }) */
</script>

<div id="changemain" class="page-header header-filter clear-filter purple-filter"
	data-parallax="true">
	<div class="container"></div>
</div>
<div class="main">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/history.ps">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
		</ul>
			<h1>upload</h1>
			<div class="row">
				<div class="col-md-6">
					<form id="fileForm" enctype="multipart/form-data" method="post">

						<div class="fileinput fileinput-new text-center"
							data-provides="fileinput">
							<div class="fileinput-new thumbnail img-raised">
								<img
									src="assets/img/up.png"
									alt="...">
							</div>
							<div class="fileinput-preview fileinput-exists thumbnail img-raised"> 
							<%-- <canvas id="canvasdiv"></canvas> --%> 
								
							</div> 
							<div>
								<span class="btn btn-raised btn-round btn-default btn-file"> 
									<span class="fileinput-new">Select image</span> <span
									class="fileinput-exists">Change</span> <input type="file"
									name="filePath" accept=".jpg, .png, .bmp" />
								</span> <a href="#pablo"
									class="btn btn-danger btn-round fileinput-exists"
									data-dismiss="fileinput"> <i class="fa fa-times"></i>
									Remove
								</a>
							</div>
							<div id="peopleRadio" style="display: none; float: left;">
								<input type="radio" id="zero"> 0명<br>
  								<input type="radio" id="one"> 1명<br>
  								<input type="radio" id="two"> 2명<br> 
  								<input type="radio" id="thr"> 3~5명<br> 
  								<input type="radio" id="six"> 6명 이상<br> 
							</div>
						</div>
					
					</form>
				</div>

				<div class="col-md-6">
					<form action="<%=request.getContextPath()%>/picture/uploadAfter.ps">

						<div class="form-group">
							<label for="title">제목</label> <input type="text"
								class="form-control" id="pictureTitle" name="picTitle">
						</div>

						<div class="form-group">
							<label for="description">설명</label> <input type="text"
								class="form-control" id="pictureDesc" name="picContent">
						</div>

						<!-- <form action=""> -->
						<div id="picTags" class="form-group">
							<label for="comment">Tags</label> <br>
								<div id="loaderIcon">
							
								</div>
						</div>
						<!-- </form> -->
				<%--	<div class="form-group">
							<input type="text" name="picPath" value="${picPath}"> 
						</div> --%>
						<div id="tagA">
						
						</div>
						<button type="submit" class="btn btn-primary">저장하기</button>
					
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(function() {
		

		$('input[type=file]').change(function() {
			console.log($(this))
			var formData = new FormData($('#fileForm')[0])
			console.log("클릭가능????")
			console.log(formData)
			$("fileinput-preview fileinput-exists thumbnail img-raised:first").attr({
				id:"preview"
			})
			console.log($("#preview").attr("src"))
			$.ajax({
				url : "/picsion/vision.ps",
				data : formData,
				processData: false,
				contentType: false,
				type :'POST',
				success : function(data){
					console.log(data)
					$("#loaderIcon").empty();
					if(data.logo != null){
					var logo =''
						logo += '<div class="alert alert-warning">'
						logo += 	'<div class="container-fluid">'
						logo += 		'<div class="alert-icon">'
						logo += 			'<i class="material-icons">warning</i>'
						logo += 		'</div>'
						logo += 		'<button type="button" class="close" data-dismiss="alert" aria-label="Close">'
						logo += 			'<span aria-hidden="true"><i class="material-icons">clear</i></span>'
						logo += 		'</button>'
						logo += 		'<b>Warning Alert</b>' + data.logo
						logo += 	'</div>'
						logo += '</div>'
						
						$('h1').append(logo)
						
					}
					/*사람수 측정*/
					$('#peopleRadio').show();
					var peopleNum = data.face.length;
					console.log(peopleNum);
					if(peopleNum==0){
						$('#zero').attr('checked',true);
					}else if(peopleNum==1){
						$('#one').attr('checked',true);
					}else if(peopleNum==2){
						$('#two').attr('checked',true);
					}else if(peopleNum>=3&&peopleNum<=5){
						$('#thr').attr('checked',true);
					}else{
						$('#six').attr('checked',true);
					}
 					/*얼굴감지*/
 					console.log($(".fileinput-preview").children());
 					$(".fileinput-preview").children().attr({
						id:"preview"
						});
 					console.log($(".fileinput-preview").children());
					console.log($("#preview")["0"].naturalHeight);
					console.log($("#preview")["0"].height);
					console.log($("#preview")["0"].naturalWidth);
					console.log($("#preview")["0"].width);
					var chaHei = $("#preview")["0"].height;
					var natHei = $("#preview")["0"].naturalHeight;
					var chaWid = $("#preview")["0"].width;
					var natWid = $("#preview")["0"].naturalWidth;
					var moveLeft = $("#preview")["0"].offsetLeft;
					chaHei *= 1;
					natHei *= 1;
					chaWid *= 1;
					natWid *= 1;					
					var scalH = (chaHei/natHei).toFixed(3);
					var scalW = (chaWid/natWid).toFixed(3);
					console.log(scalH);
					console.log(scalW);
					
 					 if(data.face != 0){
						
 						var modelUse =''
 						modelUse += '<div class="alert alert-info">'
 						modelUse += 	'<div class="container-fluid">'
 						modelUse += 		'<div class="alert-icon">'
 						modelUse += 			'<i class="material-icons">warning</i>'
 						modelUse += 		'</div>'
 						modelUse += 		'<button type="button" class="close" data-dismiss="alert" aria-label="Close">'
 						modelUse += 			'<span aria-hidden="true"><i class="material-icons">clear</i></span>'
 						modelUse += 		'</button>'
 						modelUse += 		'<b>Warning Alert</b>' + ' 사진 속에 사람이 감지되었습니다. 모델 사용권을 확인해주세요.'
 						modelUse += 	'</div>'
 						modelUse += '</div>'
 						$('h1').after(modelUse)
 						console.log("얼굴그리기")
 						$(".fileinput-preview").attr({
 							position:"relative"
 						})
 						
 						/* drawFace("preview",scalW*data.face["0"].x_0,scalH*data.face["0"].y_1,scalW*data.face["0"].width,
 								scalH*data.face["0"].height); */
 						$.each(data.face,function(i,val){
 							console.log(val.x_0,val.y_1,val.width,
 									val.height);
 							drawFace("preview",Math.ceil(scalW*val.x_0)+moveLeft,scalH*val.y_1,scalW*val.width,
 	 								scalH*val.height);
 							console.log(Math.ceil(scalW*val.x_0)+moveLeft,scalH*val.y_1,scalW*val.width,
 	 								scalH*val.height);
 						})
 						
  						
 					} 
					
					if(data.safe != null){
						var safe = ''
						safe += '<div class="alert alert-danger">'
						safe += 	'<div class="container-fluid">'
						safe += 		'<div class="alert-icon">'
						safe += 			'<i class="material-icons">warning</i>'
						safe += 		'</div>'
						safe += 		'<button type="button" class="close" data-dismiss="alert" aria-label="Close">'
						safe += 			'<span aria-hidden="true"><i class="material-icons">clear</i></span>'
						safe += 		'</button>'
						safe += 		'<b>Warning Alert</b>' + data.safe
						safe += 	'</div>'
						safe += '</div>'
						$('h1').after(safe)
					}
					
					var tags = ''
					$.each(data.label, function(i, elt) {
						tags += '<input type="text" value="' + elt + '" data-role="tagsinput" name="tag">'
					})
					$.each(data.label2,function(i,elt){
						tags += '<input type="text" value="' + elt + '" data-role="tagsinput" name="tag">'
					})
					
					$('#picTags').append(tags)
					
					
					
					var cameraName = data.metaMap.cameraName=='undefined'? 'null' : data.metaMap.cameraName;
					var resolH = data.metaMap.resolH=='undefined'? 'null' : data.metaMap.resolH;
					var resolW = data.metaMap.resolW=='undefined'? 'null' : data.metaMap.resolW;
					var pictureDate = data.metaMap.pictureDate=='undefined'? 'null' : data.metaMap.pictureDate;
					var lensName = data.metaMap.lensName=='undefined'? 'null' : data.metaMap.lensName;
					
					 
					
					tags ='<br><br>태그추가: <input type="text" id="tagAddName">';
					tags +='<button type="button" class="btn btn-primary" id="tagAdd">추가</button><br>';
					tags += '<input type="text" name="picPath" value="' + data.picPath + '">';
					tags += '<input type="hidden" name="camera" id="camera" value="'+cameraName+'"/>';
					tags += '<input type="hidden" name="resolutionH" id="resolutionH" value="'+resolH+'"/>';
					tags += '<input type="hidden" name="resolutionW" id="resolutionW" value="'+resolW+'"/>';
					tags += '<input type="hidden" name="photoDate" id="photoDate" value="'+Date(pictureDate)+'"/>';
					tags += '<input type="hidden" name="lens" id="lens" value="'+lensName+'"/>';
					tags += '<input type="hidden" name="picPeople" id="picPeople" value="'+peopleNum+'"/>';

					$('#tagA').append(tags)
					/* $('#taginputtest').attr("data-role","tagsinput"); */
					console.log('와요?')
					$("input[data-role=tagsinput]").tagsinput();
					/* console.log($('.fileinput-preview')["0"].children["0"].src); */
					
					/*색깔*/
					var color =''
					$.each(data.color,function(i,elt){
						
						/* color += '<input type="hidden" name="colorList['+i+']" id="colorList['+i+']" value="'+elt.red +','+ elt.green +','+ elt.blue+'"/>'; */
					 	color += '<input type="hidden" name="colorList['+i+'].colorR" id="colorList['+i+'].colorR" value="'+elt.red+'"/>';
						color += '<input type="hidden" name="colorList['+i+'].colorG" id="colorList['+i+'].colorG" value="'+elt.green+'"/>';
						color += '<input type="hidden" name="colorList['+i+'].colorB" id="colorList['+i+'].colorB" value="'+elt.blue+'"/>';
						
					}) 
					$('#tagA').append(color);
				}
			,beforeSend:function(){
				$("#loaderIcon").html("<img src='<%=request.getContextPath()%>/assets/img/LoaderIcon.gif'/>");
			}
				
			})
		})
	})
$(document).ready(function(){
	
	$(document).on('mouseover','.face-rectangle',function(){
		 $(this).css("border-color","#000");
	});
	$(document).on('mouseout','.face-rectangle',function(){
		 $(this).css("border-color","#555");
	});
	
	
	/* $(".face-rectangle").mouseover(function(){
		consol.log("띠띠");
		$(".face-rectangle").style("border-color","red");
	
	/* $("#preview").css("class", "rainbow-color"); 
	}); */
});
</script>