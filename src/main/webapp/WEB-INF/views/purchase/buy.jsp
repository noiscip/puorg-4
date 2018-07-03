<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<style>
 a {
	color: #007bff;
	text-decoration: none;
	background-color: transparent;
	-webkit-text-decoration-skip: objects;
}
</style>


<script>
    
   $(document).ready(function() {
        	var loginUserNo = $('#loginUserNo').val();
        	var tot = ${total};
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
            
            
            
          //장바구니 사진 삭제
        	$(document).on('click', '#deleteItem', function(){
        		var tr = $(this).parent().parent();
        		var picNo = $(this).attr("value");
        		var price = $(this).attr("price")
        		   $.ajax({
        			url:"/picsion/purchase/deleteItem.ps",
        			data:{userNo:loginUserNo,
        				  picNo:picNo},
        			success:function(data){
        				console.log($('#total2'));
        				if(data.result==1){
            			tot-=price;
            			$('#total1')["0"].childNodes["0"].data=tot;
            			$('#total2')["0"].childNodes["0"].data=tot;
        				$(tr).remove();
        				$("#cartNo"+picNo).remove();
        				
        				alert("항목 삭제 완료");
        				}else{
        					alert("항목 삭제 실패");
        				}
        			}
        		})
        	})
   });

    </script>
<div class="page-header header-filter" data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/faces/giphy.gif');">


<div class="section section-gray">
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
									<span class="price">${cart.picPrice} 원</span>
									<p class="item-name">${cart.picTitle}</p>
									<p class="item-description">${cart.picContent}</p>
									<input name="purchases[${status.index}].picNo" value="${cart.picNo}" type="hidden">
									<input name="purchases[${status.index}].purchaseUserNo" value="${sessionScope.user.userNo}" type="hidden">
									<input name="purchases[${status.index}].saleUserNo" value="${photographerName[status.index].userNo}" type="hidden">
									</div>
								</c:forEach>
								<div class="total">
									Total<span id="total1"class="price">${total}<small>원</small></span>
								</div>
								<div class="total">
									내 금액<span id="total1"class="price">${total}<small>원</small></span>
								</div> 
								<br>
								<div class="form-group col-sm-12">
									<button type="submit" class="btn btn-primary btn-block">
										Proceed
									</button>
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
											<th class="text-center">날짜</th>
											<th class="text-center">가격</th>
											<th></th>
										</tr>
									</thead>
									<tbody>
									<c:forEach var="cart" items="${myCartList}" varStatus="status">
									<tr>
										<td>
											<div class="img-container">
												<img src="${cart.picPath}"
													alt="No Image">
											</div>
										</td>
										<td class="td-name"><a href="<%=request.getContextPath()%>/picture/picinfo.ps?picNo=${cart.picNo}">${cart.picTitle}</a>
											<br> <small>by ${photographerName[status.index].userName}</small></td>
										<td class="text-center">${cart.resolution}</td>
										<td class="td-number text-center">${cart.photoDate}</td>
										<td class="td-number text-center">${cart.picPrice}<small>원</small></td>
										<td class="td-actions">
											<a id="deleteItem" class="btn btn-link" value="${cart.picNo}" price="${cart.picPrice}" style="padding: 15px 5px 5px"><i class="material-icons">close</i></a>
										</td>
									</tr>
									
									</c:forEach>
																			
										<tr>
											<td colspan="2"></td>
											<td colspan="1"></td>
											<td class="td-total">Total</td>
											<td id="total2" class="td-price text-center">${total}<small>원</small></td>
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
</div>
