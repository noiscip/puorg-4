<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	//리뷰 쓰기
	$(function() {
		$('#addreviewbutton').on(
				"click",
				function() {
					
					console.log("click");
					if ($('#reviewcontent').val().trim() == "") {
						alert("리뷰 내용을 입력해주세요.");
					} else {	

						$.ajax({
							url : "insertreview.ps",
							type : "post",
							data : {
								brdNo : ${boardInfo.brdNo},
								cmtContent : $("#reviewcontent").val()
							},
							success : function(data) {
								alert("리뷰 작성 성공");
							}
						});
					}
				});
	});
</script>



<div class="page-header header-filter" data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
			<div class="row">
				<div class="col-md-12 ml-auto mr-auto">
					<input type="text" value="${boardInfo.brdTitle}">
					<textarea rows="10" cols="10">${boardInfo.brdContent}</textarea>



				</div>
			</div>

		</div>
		<div id="reviews">
			<h4 style="margin-bottom: 20px;">
				<b>리뷰</b>
			</h4>
			<hr style="margin-top: 5px; margin-bottom: 5px;">
			<c:forEach var="review" items="${comment}">
				<div class="review">

					<h5>${review.userNo}</h5>
					<p>${review.cmtContent}</p>
					<hr style="margin-top: 5px; margin-bottom: 5px;">
				</div>				
			</c:forEach>
			
		</div>

		<div id="comment">
			<!-- comment -->
			<div class="row">
				<textarea rows="2" maxlength="45" placeholder="리뷰를 입력해주세요(최대 45자)"
					id="reviewcontent"></textarea>
				<button id="addreviewbutton" class="btn">
					<font><b>리뷰 쓰기</b></font>
				</button>
			</div>
		</div>
	</div>
</div>


