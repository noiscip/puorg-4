<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script>
    
   $(document).ready(function() {
        	var loginUserNo = $('#loginUserNo').val();
        	var tot = ${total};
        	var userPoint = ${user.point}
            var widget = $('.tabs-underline');
            var tabs = widget.find('ul a'),
                content = widget.find('.tabs-content-placeholder > div');

            tabs.on('click', function (e) {

                e.preventDefault();

                // Get the data-index attribute, and show the matching content div

                var index = $(this).data('index');

                tabs.removeClass('tab-active');
                content.removeClass('tab-content-active');

                $(this).addClass('tab-active');
                content.eq(index).addClass('tab-content-active');

            });
            
            var nocart2 ='<li class="divider" id="nonecart"><a>장바구니가 비었습니다</a></li>';
          //장바구니 사진 삭제
        	$(document).on('click', '#deleteItem', function(){
        		var tr = $(this).parent().parent();
        		var picNo = $(this).attr("value");
        		var price = $(this).attr("price");
        		var userpoint = $('#change').attr('value');
        		
        		console.log($('#change'));
        		   $.ajax({
        			url:"/picsion/purchase/deleteItem.ps",
        			data:{userNo:loginUserNo,
        				  picNo:picNo},
        			success:function(data){
        				console.log($('#total2'));
        				if(data.result==1){ //물품이 있을때 항목 삭제
            			tot-=price;
            			userpoint *= 1;
            			price *= 1;
            			userpoint+=price;
            			$('#total1')["0"].childNodes["0"].data=tot;
            			$('#total2')["0"].childNodes["0"].data=tot;
        				$(tr).remove();
        				$("#cartNo"+picNo).remove();
        				$('#change')["0"].childNodes["0"].data=userpoint;
        				$('#changehidden').val(userPoint);
        				alert("항목 삭제 완료");
        				
        				if(data.again==0){
        					$('#cartnav')["0"].childNodes[3].data--;
        					$('#addcartnav').empty();
							$('#addcartnav').append(nocart2);
        				}else{
        					$('#cartnav')["0"].childNodes[3].data--;
    						$('#'+picNo+'tt').parent().parent().remove();
        				}
        				
        				}else{
        					alert("항목 삭제 실패");
        				}
        			}
        		})
        	})
        	
        	
        	var IMP = window.IMP
    		IMP.init('imp27054314')
    		
    		$('#pointCharge').click(function(){
    			IMP.request_pay({
    			    pg : 'inicis', // version 1.1.0부터 지원.
    			    pay_method : 'card',
    			    merchant_uid : 'merchant_' + new Date().getTime(),
    			    name : '주문명:포인트 충전',
    			    amount : $('#chargePrice').val(),
    			    buyer_name : $('#userName').val(),
    			    m_redirect_url : 'http://localhost:8090/user/updateinfo.ps'
    		}, function(rsp) {
    			if ( rsp.success ) {
    				var msg = '결제가 완료되었습니다.'
    				msg += '결제 금액 : ' + rsp.paid_amount
    				msg += '카드 승인번호 : ' + rsp.apply_num
    				
    				$.ajax({
    					url:"/picsion/user/charge.ps",
    					data: {point:rsp.paid_amount},
    					success: function(data){
    						if(data.result == 0){
    							msg = '결제 완료 BUT 업데이트 실패'
    						}else{
    							console.log(data.point)
    							$('#point').val(data.point)
    						}
    						
    					}
    				})
    			
    				$('#chargePrice').val("")
    			} else {
    			    var msg = '결제에 실패하였습니다.'
    			    msg += '에러내용 : ' + rsp.error_msg
    			}
    			alert(msg)
    		});
    			
    		})	
        	
        	
   });

    </script>
<div id="changemain" class="page-header header-filter" data-parallax="true">
</div>

<div class="section">
	<div class="container">
		<div class="main main-raised main-product">

			<div class="tabs-underline">

				<ul>
					<li><a class="tab-active" data-index="0" href="#">Make a payment</a></li>
					<li><a data-index="1" href="#">My Cart</a></li>
				</ul>

				<div class="tabs-content-placeholder">

					<div class="tab-content-active">
					<div class="payment-form">
						<form:form action="/picsion/purchase/picturePurchase.ps" modelAttribute="PurchList">
							<div class="products">
								<h3 class="title">Checkout</h3>
								<c:forEach var="cart" items="${myCartList}" varStatus="status">
									<div id="cartNo${cart.picNo}" class="item">
									<span class="price">
									<fmt:formatNumber value="${cart.picPrice}" pattern="#,###"/>원</span>
									<p class="item-name">${cart.picTitle}</p>
									<p class="item-description">${cart.picContent}</p>
									<input name="purchases[${status.index}].picNo" value="${cart.picNo}" type="hidden">
									<input name="purchases[${status.index}].purchaseUserNo" value="${sessionScope.user.userNo}" type="hidden">
									<input name="purchases[${status.index}].saleUserNo" value="${photographerName[status.index].userNo}" type="hidden">
									<input name="purchases[${status.index}].picPrice" value="${cart.picPrice}" type="hidden">
									</div>
								</c:forEach>
								<div class="total">
									Total<span id="total1"class="price"><fmt:formatNumber value="${total}" pattern="#,###"/><small>원</small></span>
								</div>
								<div class="total">
									 <c:choose>
											<c:when test="${user.point-total >= 0}">
												구매 후 잔액<span id="change" value="${user.point-total}" class="price"><fmt:formatNumber value="${user.point-total}" pattern="#,###"/><small>원</small></span>
												<input id="changehidden" name="point" value="${user.point-total}" type="hidden">
											</c:when>
											<c:otherwise>
												<span>잔액(<fmt:formatNumber value="${user.point}" pattern="#,###"/><small>원</small>)부족으로 인한 구매 불가</span>
											</c:otherwise>
									</c:choose>
									
								</div> 
								<br>
								<div class="form-group col-sm-12">
								<c:choose>
											<c:when test="${user.point-total >= 0}">
												<button type="submit" class="btn btn-primary btn-block">
													Proceed
												</button>
											</c:when>
											<c:otherwise>												
													<button type="button" class="btn btn-default update-margin" data-toggle="modal" data-target="#exampleModal">충전하기</button>									
											</c:otherwise>
									</c:choose>								
									
								</div>
							</div>
						</form:form>
						</div>
						
					</div>

					<div>

						<div id="tables">
							<div class="table-responsive">
								<table class="table table-shopping">
									<thead>
										<tr>
											<th class="text-center"></th>
											<th>사진</th>
											<th class="text-center">해상도</th>
											<th class="text-center">촬영 날짜</th>
											<th class="text-center">가격</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="cart" items="${myCartList}" varStatus="status">
									<tr>
										<td>
											<div class="img-container">
												<img src="${cart.picWater}"
													alt="No Image">
											</div>
										</td>
										<td class="td-name"><a href="<%=request.getContextPath()%>/picture/picinfo.ps?picNo=${cart.picNo}">${cart.picTitle}</a>
											<br> <small>by ${photographerName[status.index].userName}</small></td>
										<td class="text-center">${cart.resolutionW} x ${cart.resolutionH}</td>
										<td class="td-number text-center"><fmt:formatDate pattern="yyyy-MM-dd" value="${cart.photoDate}" /></td>
										<td class="td-number text-center"><fmt:formatNumber value="${cart.picPrice}" pattern="#,###"/><small>원</small></td>
										<td class="td-actions">
											<a id="deleteItem" class="btn btn-link" value="${cart.picNo}" price="${cart.picPrice}" style="padding: 15px 5px 5px"><i class="material-icons">close</i></a>
										</td>
									</tr>
									
									</c:forEach>
																			
										<tr>
											<td colspan="2"></td>
											<td colspan="1"></td>
											<td class="td-total">Total</td>
											<td id="total2" class="td-price text-center"><fmt:formatNumber value="${total}" pattern="#,###"/><small>원</small></td>
											<td colspan="1"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>

			</div>

		</div>


	</div>
	
	

</div>

<!-- 충전하기 Modal -->
	<div class="modal fade" id="exampleModal" tabindex="1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">충전하기</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      
	      <div class="modal-body">
		    <div class="form-group bmd-form-group">
					<label for="exampleInput1" class="bmd-label-floating">충전금액</label>
					<input type="text" class="form-control" id="chargePrice">
			</div>
	      </div>
	      <div class="modal-footer">
	      	<button type="button" class="btn btn-primary" id="pointCharge" data-dismiss="modal">충전하기</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	      
	    </div>
	  </div>
	</div>
