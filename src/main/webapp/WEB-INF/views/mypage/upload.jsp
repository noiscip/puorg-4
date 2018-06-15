<%@ page language="java" contentType="text/html; charset=UTF-8"
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
	/* $("#file-4").fileinput({
	       theme: 'fa',
	       allowedFileExtensions: ['jpg', 'png', 'gif']
	     });  */
</script>


<div class="page-header header-filter clear-filter purple-filter"
	data-parallax="true"
	style="background-image: url(&quot;./assets/img/bg2.jpg&quot;); transform: translate3d(0px, 0px, 0px);">
	<div class="container"></div>
</div>
<div class="main main-raised">
	<div class="section section-basic">
		<div class="container">
<c:choose>
<c:when test="${logo eq null}"></c:when>
<c:otherwise>
<div class="alert alert-warning">
    <div class="container-fluid">
	  <div class="alert-icon">
		<i class="material-icons">warning</i>
	  </div>
	  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		<span aria-hidden="true"><i class="material-icons">clear</i></span>
	  </button>
      <b>Warning Alert</b>
      ${logo}
    </div>
</div>
</c:otherwise>
</c:choose>

<c:choose>
<c:when test="${safe eq null}"></c:when>
<c:otherwise>
<div class="alert alert-danger">
    <div class="container-fluid">
	  <div class="alert-icon">
		<i class="material-icons">warning</i>
	  </div>
	  <button type="button" class="close" data-dismiss="alert" aria-label="Close">
		<span aria-hidden="true"><i class="material-icons">clear</i></span>
	  </button>
      <b>Warning Alert</b>
      ${safe}
    </div>
</div>
</c:otherwise>
</c:choose>

			<h1>upload</h1>
			

			<div class="row">
				<div class="col-md-6">
					<form action="amazontest.ps" enctype="multipart/form-data"
						method="post">

						<div class="file-loading">
							<!-- <input id="input-b1" name="input-b1" type="file" class="file"> -->
							<input type="file" name="filePath">
						</div>
						<input type="submit" class="btn btn-primary btn-round" value="보내기">
					</form> 
					<!-- <form action="amazontest.ps" enctype="multipart/form-data"
						method="post"> -->
				 	<!-- 	<form enctype="multipart/form-data">
				       
				        <div class="form-group">
           <div class="file-loading">
               <input id="file-4" type="file" class="file" data-upload-url="amazontest.ps">
           </div>
       </div>
				    </form>  -->
					
					
				</div>
				<div class="col-md-6">
				<form method="post" action="<%=request.getContextPath()%>/picture/upload.ps">
				
					<div class="form-group">
						<label for="title">제목</label> <input type="text"
							class="form-control" id="pictureTitle" name="picTitle">
					</div>

					<div class="form-group">
						<label for="description">설명</label> <input type="text"
							class="form-control" id="pictureDesc" name="picContent">
					</div>


					<!-- <form action=""> -->
					<div class="form-group">
						<label for="comment">Tags</label> <br>
						<!-- <textarea class="form-control" rows="5" id="comment"> -->
						<!-- </textarea> -->
						<c:forEach var="t" items="${label}">
							<button id="tagbtn" class="btn btn-primary btn-sm" name="tagContent">${t}<i
									class="material-icons" id="tagDel">clear</i>
							</button>
						</c:forEach>
					</div>
					<!-- </form> -->
					<div class="form-group">
					<input type="text" name="picPath" value="${picPath}">
					</div>

					<button type="submit" class="btn btn-primary">저장하기</button>
				
				</form>
				</div>
			</div>
		</div>
	</div>
</div>






