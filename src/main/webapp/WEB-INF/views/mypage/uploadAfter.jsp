<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<head>
  
    
     
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
					<div class="form-group">
						<label for="comment">Tags</label> <br>
						<!-- <textarea class="form-control" rows="5" id="comment"> -->
						<!-- </textarea> -->
						<c:forEach var="t" items="${label}">
							<button id="tagbtn" class="btn btn-primary btn-sm" >${t}<i
                                    class="material-icons" id="tagDel">clear</i>
                            </button>
                            <input type="text" style="display: none;" name="tag" value="${t}">
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