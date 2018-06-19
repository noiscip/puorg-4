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

<div class="page-header header-filter clear-filter purple-filter"
	data-parallax="true"
	style="background-image: url(&quot;./assets/img/bg2.jpg&quot;); transform: translate3d(0px, 0px, 0px);">
	<div class="container"></div>
</div>
<div class="main main-raised">
	<div class="section section-basic">
		<div class="container">

			<h1>upload</h1>
			
				<div class="col-md-10">
					<form action="amazontest.ps" enctype="multipart/form-data"
						method="post">

						<div class="fileinput fileinput-new text-center"
							data-provides="fileinput">
							<div class="fileinput-new thumbnail img-raised">
								<img src="https://epicattorneymarketing.com/wp-content/uploads/2016/07/Headshot-Placeholder-1.png"
									alt="...">
							</div>
							<div
								class="fileinput-preview fileinput-exists thumbnail img-raised"></div>
							<div>
								<span class="btn btn-raised btn-round btn-default btn-file">
									<span class="fileinput-new">Select image</span> <span
									class="fileinput-exists">Change</span> <input type="file"
									name="filePath" accept=".jpg, .png, .bmp"/>
								</span> <a href="#pablo"
									class="btn btn-danger btn-round fileinput-exists"
									data-dismiss="fileinput"> <i class="fa fa-times"></i>
									Remove
								</a>
							</div>
						</div>
						<input type="submit" class="btn btn-primary btn-round" value="보내기">
					</form>
				</div>
		
		</div>
	</div>
</div>