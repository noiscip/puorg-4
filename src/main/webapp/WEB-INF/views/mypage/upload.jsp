﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<head>
<%-- <meta charset="UTF-8"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <link href="<%=request.getContextPath()%>/uploadassets/css/fileinput.css" media="all" rel="stylesheet" type="text/css"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" media="all" rel="stylesheet" type="text/css"/> 
    <link href="<%=request.getContextPath()%>/uploadassets/themes/explorer-fa/theme.css" media="all" rel="stylesheet" type="text/css"/>
    <script src="<%=request.getContextPath()%>/uploadassets/js/plugins/sortable.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/uploadassets/js/fileinput.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/uploadassets/js/locales/fr.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/uploadassets/js/locales/es.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/uploadassets/themes/explorer-fa/theme.js" type="text/javascript"></script>
    <script src="<%=request.getContextPath()%>/uploadassets/themes/fa/theme.js" type="text/javascript"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" type="text/javascript"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>  --%>


</head>

<script type="text/javascript">
	$(document).on("click", "#tagDel", function() {
		$('#tagbtn').remove();
	});
	$(document).on("click", "#tagAdd", function() {
		console.log("뚜뚜")
		
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


<div class="page-header header-filter clear-filter purple-filter"
	data-parallax="true"
	style="background-image: url(&quot;./assets/img/bg2.jpg&quot;); transform: translate3d(0px, 0px, 0px);">
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
			<li class="nav-item"><a class="nav-link" href="#">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="#">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/updateinfo.ps">정보 수정</a></li>
		</ul>
			<h1>upload</h1>
			<div class="row">
				<div class="col-md-6">
					<form id="fileForm" action="amazontest.ps"
						enctype="multipart/form-data" method="post">

						<div class="fileinput fileinput-new text-center"
							data-provides="fileinput">
							<div class="fileinput-new thumbnail img-raised">
								<img
									src="https://epicattorneymarketing.com/wp-content/uploads/2016/07/Headshot-Placeholder-1.png"
									alt="...">
							</div>
							<div
								class="fileinput-preview fileinput-exists thumbnail img-raised"></div>
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
						<!-- <input type="submit" class="btn btn-primary btn-round" value="보내기"> -->
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
						
						<input type="text" id="taginputtest" value="ddd,fff,ggg" data-role="">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
	$(function() {
		$('input[type=file]').change(function() {
			var formData = new FormData($('#fileForm')[0])
			console.log("클릭가능????")
			console.log(formData)
			$.ajax({
				url : "/picsion/amazontest.ps",
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
					
					var safe = ''
					if(data.safe != null){
						safe += '<div class="alert alert-danger">'
						safe += 	'<div class="container-fluid">'
						safe += 		'<div class="alert-icon">'
						safe += 			'<i class="material-icons">warning</i>'
						safe += 		'</div>'
						safe += 		'<button type="button" class="close" data-dismiss="alert aria-label="Close">'
						safe += 			'<span aria-hidden="true"><i class="material-icons">clear</i></span>'
						safe += 		'</button>'
						safe += 		'<b>Warning Alert</b>' + data.safe
						safe += 	'</div>'
						safe += '</div>'
						$('h1').after(safe)
					}
					
					var tags = ''
					$.each(data.label, function(i, elt) {
						tags += '<input type="text" value="' + elt + '" data-role="tagsinput">'
					})
					
					$('#picTags').append(tags)
					
					tags ='<br><br>태그추가: <input type="text" id="tagAddName">';
					tags +='<button type="button" class="btn btn-primary" id="tagAdd">추가</button><br>';
					tags += '<input type="text" name="picPath" value="' + data.picPath + '">';
					$('#tagA').append(tags)
					$('#taginputtest').attr("data-role","tagsinput");
					console.log('와요?')
					$("input[data-role=tagsinput]").tagsinput();
				}
			,beforeSend:function(){
				$("#loaderIcon").html("<img src='<%=request.getContextPath()%>/assets/img/LoaderIcon.gif'/>");
			}
				
			})
		})
	})
</script>