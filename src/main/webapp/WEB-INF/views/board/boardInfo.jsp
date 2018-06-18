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
								var html="";
								
								$.each(data.comment,function(index,obj){
									
									html+=data.commuserid[index]+" : "+obj.cmtContent+"<br>";
									html+="<hr style='margin-top: 5px; margin-bottom: 5px;'>";
								}); 
								
								console.log(html);
								$(".review").empty();
								$(".review").append(html); 
								
							}
						});	
					}
				});
		
		
		$('.datetimepicker').datetimepicker({
		    icons: {
		        time: "fa fa-clock-o",
		        date: "fa fa-calendar",
		        up: "fa fa-chevron-up",
		        down: "fa fa-chevron-down",
		        previous: 'fa fa-chevron-left',
		        next: 'fa fa-chevron-right',
		        today: 'fa fa-screenshot',
		        clear: 'fa fa-trash',
		        close: 'fa fa-remove'
		    }
		});
		
		
		
		$('#apply').on("click",function() {
					
		console.log("apply클릭");
		
					$.ajax({
						url : "apply.ps",
						type : "post",
						data : {
							
							operApplyAppeal : $("#operApplyAppeal").val(),
							operApplyPrice : $("#operApplyPrice").val(),
							operApplyReg : $("#operApplyReg").val(),
							requestUserNo : ${boardInfo.userNo},
							brdNo : ${boardInfo.brdNo}
						},
						success : function(data) {
							
							
						}
					});	
				});
		

		$('#applysummit').on("click",function() {
		
					$.ajax({
						url : "operok.ps",
						type : "post",
						data : {							
							operApplyAppeal : $("#oApplyAppeal").val(),
							operApplyPrice : $("#oApplyPrice").val(),
							operApplyReg : Date($("#oApplyReg").val()),
							brdNo : ${boardInfo.brdNo},
							operUserNo : $("#oUserNo").val(),
							operApplyNo : $("#operApplyNo").val()
						}, 
						success : function(data) {
							
							
						}
					});	
				});
		
		
		
		$('.applyModal').on("click",function() {
			var operApplyNo=$(this).attr("operApplyNo");
			var applyid=$(this).children()[0].innerText;
			console.log("applyid : "+applyid);
			var operApplyPrice=$(this).children()[1].innerText;
			console.log("operApplyPrice : "+operApplyPrice);
			var operApplyReg=$(this).children()[2].innerText;
			console.log("operApplyReg : "+operApplyReg);
			var operUserNo=$(this).attr("operUserNo");
			console.log("operUserNo : "+operUserNo);
			var operApplyAppeal=$(this).attr("operApplyAppeal");
			console.log("operApplyAppeal : "+operApplyAppeal);
			
			$('#oUserNo').val(operUserNo);
			$('#applyid').val(applyid);
			$('#oApplyPrice').val(operApplyPrice);
			$('#oApplyReg').val(operApplyReg);
			$('#oApplyAppeal').val(operApplyAppeal);
			$('#operApplyNo').val(operApplyNo);
			
			
			
			
		});
		
		
		
		
		
		
	});
</script>



<div class="page-header header-filter" data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
			<div class="row" style="border-width: 1px">
				<div class="col-md-12 ml-auto mr-auto">
					<h3>${boardInfo.brdTitle}</h3>
					<p>
						<font>${boardInfo.brdContent}</font>
					</p>





				</div>
			</div>

		</div>

	</div>


	<div id="reviews" style="text-align: center;">
		<h4 style="margin-bottom: 20px;">
			<b>리뷰</b>
		</h4>
		<hr style="margin-top: 5px; margin-bottom: 5px;">
		<div class="review">
			<c:forEach var="review" items="${comment}" varStatus="status">
				

					${commuserid[status.index]} : ${review.cmtContent} 
					
					<hr style="margin-top: 5px; margin-bottom: 5px;">

			</c:forEach>
		</div>
		<textarea rows="2" maxlength="45" placeholder="리뷰를 입력해주세요(최대 45자)"
			id="reviewcontent"></textarea>
		<button id="addreviewbutton" class="btn">
			<font><b>리뷰 쓰기</b></font>
		</button>
	</div>


	<table class="table">
		<thead>
			<tr>
				<th class="text-center">작업신청자</th>
				<th class="text-center">금액</th>
				<th class="text-center">마감 날짜</th>
			</tr>
		</thead>
		<tbody>


			<c:choose>
				<c:when test="${boardInfo.userNo eq user.userNo}">
					<div class="apply">
						<c:forEach var="apply" items="${applylist}" varStatus="status">

							<tr class="applyModal" style="cursor:pointer;" data-toggle="modal" data-target="#operModal" operApplyNo="${apply.operApplyNo}" operUserNo="${apply.operUserNo}" operApplyAppeal="${apply.operApplyAppeal}">
								<td class="text-center">${applyid[status.index]}</td>
								<td class="text-center">${apply.operApplyPrice}</td>
								<td class="text-center">${apply.operApplyReg}</td>
								<%-- ${applyid[status.index]} : ${apply.operApplyAppeal} 
					${apply.operApplyPrice}
					${apply.operApplyReg}
					${apply.operUserNo} 
					<input type="button" value="수락" operUserNo="${apply.operUserNo}" > --%>
							</tr>


						</c:forEach>
					</div>
				</c:when>
				<c:otherwise>
					<button type="button" class="btn btn-default btn-sm"
						data-toggle="modal" data-target="#exampleModal">신청하기</button>
				</c:otherwise>
			</c:choose>

		</tbody>
	</table>



</div>







<!-- 신청Modal -->
<div class="modal fade" id="exampleModal" tabindex="1" role="dialog"
	aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">참여신청 페이지</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<div class="form-group">
					<label for="exampleInput1" class="bmd-label-floating">판매금액</label>
					<input type="text" class="form-control" id="operApplyPrice"
						name="operApplyPrice">
				</div>
				<div class="form-group">
					<label class="label-control">희망 완료 날짜</label> <input type="text"
						class="form-control datetimepicker" id="operApplyReg"
						name="operApplyReg" />
				</div>
				<div class="form-group">
					<label for="exampleFormControlTextarea1">간단한 소개글</label>
					<textarea class="form-control" id="operApplyAppeal"
						name="operApplyAppeal" rows="3"></textarea>
				</div>

			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="apply"
					data-dismiss="modal">신청</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
			</div>

		</div>
	</div>
</div>

<!-- 신청자 상세  Modal Core -->
<div class="modal fade" id="operModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      	<h5 class="modal-title" id="myModalLabel">신청자 상제보기</h5>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <div class="modal-body">
      	
      	<form>
		  <fieldset disabled>
		  <input type="text" style="display: none;" id="oUserNo" name="operUserNo" class="form-control">
		  <input type="text" style="display: none;" id="operApplyNo" name="operApplyNo" class="form-control">
		    <div class="form-group">													 
		      <label for="disabledTextInput">신청자</label>
		      <input type="text" id="applyid" class="form-control">
		    </div>
		    <div class="form-group">
		      <label for="disabledTextInput">판매가격</label>
		      <input type="text" id="oApplyPrice" name="operApplyPrice"  class="form-control">
		    </div>
		    <div class="form-group">
		      <label for="disabledTextInput">완료 예정일</label>
		      <input type="text" id="oApplyReg" name="operApplyReg"  class="form-control">
		    </div>
		    <div class="form-group">
		      <label for="disabledTextInput">참고사항</label>
		      <input type="text" id="oApplyAppeal" name="operApplyAppeal"  class="form-control">
		    </div>
		    
		  </fieldset>
		  <button type="button" class="btn btn-primary" id="applysummit"
					data-dismiss="modal">수락</button>
		</form>
      	
      </div>
     
    </div>
  </div>
</div>

