<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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

</script>

<style type="text/css">
.bootstrap-tagsinput .tag {
	background-color: #9c27b0;
}

/* 마이페이지 상단 메뉴 위,아래 여백 */
.my-ul {
	padding-top: 30px;
	padding-bottom: 30px;
}
</style>


<div id="changemain" class="page-header header-filter clear-filter purple-filter"
	data-parallax="true">
	<div class="container"></div>
</div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/history.ps">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
		</ul>
			<h1>upload</h1>
			<div class="row">
				<div class="col-md-6">
					<form id="fileForm" action="vision.ps"
						enctype="multipart/form-data" method="post">

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
						
						$('h1').after(logo)
					}
 					/*얼굴감지*/
 					 if(data.face != null){
 						console.log("얼굴그리기")
 						/* $('canvas').drawImage({
 							source: $('.fileinput-preview')["0"].children["0"].src,
 							x: 10, y: 10,
 							load:rec
 						});
 						function rec(){
 							console.log("이게 되낭?");
 							$('canvas').drawRect({
								strokeStyle:"#FF0000",
								strokeWidth:4,
								x:data.face["0"].x_0, y:data.face["0"].y_1,
								width:data.face["0"].width,
								height:data.face["0"].height
 							});
 						}
 						 */
 						 
 						  /* $('#aaaa').append("<img style='width:100%;height:100%' src='"+$('.fileinput-preview')['0'].children['0'].src+"'>"); */ 
 						//이 밑에 잠시 주석걸겠습니다
 						/* $('canvas').drawImage({
 							source: $('.fileinput-preview')['0'].children['0'].src,
 							x: 100, y: 100,
 							load:rec
 						});
 						function rec(){
 							console.log("이게 되낭?");
 							$('canvas').drawRect({
 							strokeStyle:"#FF0000",
 							strokeWidth:2,
 							x:100, y:100,
 							width:20,
 							height:20
 							});
 						}
 */ 						
 					} 
					var safe = ''
					if(data.safe != null){
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
					
					tags ='<br><br>태그추가: <input type="text" id="tagAddName">';
					tags +='<button type="button" class="btn btn-primary" id="tagAdd">추가</button><br>';
					tags += '<input type="text" name="picPath" value="' + data.picPath + '">';
					$('#tagA').append(tags)
					/* $('#taginputtest').attr("data-role","tagsinput"); */
					console.log('와요?')
					$("input[data-role=tagsinput]").tagsinput();
					/* console.log($('.fileinput-preview')["0"].children["0"].src); */
				}
			,beforeSend:function(){
				$("#loaderIcon").html("<img src='<%=request.getContextPath()%>/assets/img/LoaderIcon.gif'/>");
			}
				
			})
		})
	})
</script>