<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<script>
    
   $(document).ready(function() {
        	var loginUserNo = $('#loginUserNo').val();
        	var tot = $('#hiddentotal').val();
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
        		var picNo = $(this).attr("value"); //선택 항목 사진 번호
        		var price = $(this).attr("price"); //선택 항목 가격
        		tot-=price; //장바구니 토탈  - 항목 가격
        		console.log(tot);
        		var userpoint = $('.changeit').attr('value');
        		
        		console.log($('.changeit'));
        		   $.ajax({
        			url:"/picsion/purchase/deleteItem.ps",
        			data:{userNo:loginUserNo,
        				  picNo:picNo},
        			success:function(data){
        				console.log($('#total2'));
        				if(data.result==1){ //물품이 있을때 항목 삭제
            			userpoint *= 1;
            			price *= 1;
            			userpoint+=price;
            			$('#total1')["0"].childNodes["0"].data=tot;
            			$('#total2')["0"].childNodes["0"].data=tot;
        				$(tr).remove();
        				$("#cartNo"+picNo).remove();
       					$('.changeit')["0"].childNodes["0"].data=userpoint;
       					$('.changeit')["0"].childNodes["0"].data=userpoint;
           				$('.changehidden').val(userPoint);
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
   });

</script>
<style>
	.awhite-font-color{
		color:#fff;	
	}
	.awhite-font-color:hover,
	.awhite-font-color:focus{
		color:#fff;	
	}
</style>

<div id="changemain" class="page-header header-filter" data-parallax="true">
</div>

<div class="section">
	<div class="container">
		<div class="main main-raised main-product">
                  <input id="hiddentotal" type="hidden" value="${total}">
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
									 <c:choose>
											<c:when test="${user.point-total >= 0}">
											<div id="plusprice" class="total">
												구매 후 잔액<span value="${user.point-total}" class="price changeit"><fmt:formatNumber value="${user.point-total}" pattern="#,###"/><small>원</small></span>
												<input class="changehidden" name="point" value="${user.point-total}" type="hidden">
											</div>
											<br>
											<br>
											  <button type="submit" class="btn btn-primary btn-block">
                                                    Proceed
                                                </button>
											</c:when>
											<c:otherwise>
											<div id="minusprice" class="total">
												금액 부족<span value="${user.point-total}" class="price text-danger changeit"><fmt:formatNumber value="${user.point-total}" pattern="#,###"/><small>원</small></span>
												<input class="changehidden" name="point" value="${user.point-total}" type="hidden">
											</div>
											</c:otherwise>
									</c:choose>
									
								<br>
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
