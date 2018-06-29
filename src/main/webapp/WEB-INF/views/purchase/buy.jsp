<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

        });

    </script>
<div class="page-header header-filter" data-parallax="true" filter-color="rose" style="background-image: url('<%=request.getContextPath()%>/assets/img/faces/giphy.gif');">
    
    </div>
    
   <div class="section section-gray"> 
        <div class="container">
            <div class="main main-raised main-product">
               
                 <div class="tabs-underline">

        <ul>
            <li>
                <a class="tab-active" data-index="0" href="#">Make a payment</a>
            </li>
            <li>
                <a data-index="1" href="#">My Cart</a>
            </li>
        </ul>

        <div class="tabs-content-placeholder">

            <div class="tab-content-active payment-form">
             <form>
          <div class="products">
            <h3 class="title">Checkout</h3>  
            <div class="item">
              <span class="price">$200</span>
              <p class="item-name">Product 1</p>
              <p class="item-description">Lorem ipsum dolor sit amet</p>
            </div>
            <div class="item">
              <span class="price">$120</span>
              <p class="item-name">Product 2</p>
              <p class="item-description">Lorem ipsum dolor sit amet</p>
            </div>
            <div class="total">Total<span class="price">$320</span></div>
               <br>
               <hr>
            <div class="form-group col-sm-12">
            <button type="button" class="btn btn-primary btn-block">Proceed<div class="ripple-container"></div></button>
            </div>
          </div>
        </form>
            </div>

            <div>
               
               	<section class="shopping-cart dark">
	 		<div class="container">
		  
		        <div class="content">
	 				<div class="row">
	 					<div class="col-md-12 col-lg-8">
	 						<div class="items">
				 				<div class="product">
				 					<div class="row">
					 					<div class="col-md-3">
					 						<img class="img-fluid mx-auto d-block image" src="image.jpg">
					 					</div>
					 					<div class="col-md-8">
					 						<div class="info">
						 						<div class="row">
							 						<div class="col-md-5 product-name">
							 							<div class="product-name">
								 							<a href="#">Lorem Ipsum dolor</a>
								 							<div class="product-info">
									 							<div>Display: <span class="value">5 inch</span></div>
									 							<div>RAM: <span class="value">4GB</span></div>
									 							<div>Memory: <span class="value">32GB</span></div>
									 						</div>
									 					</div>
							 						</div>
							 						<div class="col-md-4 quantity">
							 							<label for="quantity">Quantity:</label>
							 							<input id="quantity" type="number" value ="1" class="form-control quantity-input">
							 						</div>
							 						<div class="col-md-3 price">
							 							<span>$120</span>
							 						</div>
							 					</div>
							 				</div>
					 					</div>
					 				</div>
				 				</div>
				 				<div class="product">
				 					<div class="row">
					 					<div class="col-md-3">
					 						<img class="img-fluid mx-auto d-block image" src="image.jpg">
					 					</div>
					 					<div class="col-md-8">
					 						<div class="info">
						 						<div class="row">
							 						<div class="col-md-5 product-name">
							 							<div class="product-name">
								 							<a href="#">Lorem Ipsum dolor</a>
								 							<div class="product-info">
									 							<div>Display: <span class="value">5 inch</span></div>
									 							<div>RAM: <span class="value">4GB</span></div>
									 							<div>Memory: <span class="value">32GB</span></div>
									 						</div>
									 					</div>
							 						</div>
							 						<div class="col-md-4 quantity">
							 							<label for="quantity">Quantity:</label>
							 							<input id="quantity" type="number" value ="1" class="form-control quantity-input">
							 						</div>
							 						<div class="col-md-3 price">
							 							<span>$120</span>
							 						</div>
							 					</div>
							 				</div>
					 					</div>
					 				</div>
				 				</div>
				 				<div class="product">
				 					<div class="row">
					 					<div class="col-md-3">
					 						<img class="img-fluid mx-auto d-block image" src="image.jpg">
					 					</div>
					 					<div class="col-md-8">
					 						<div class="info">
						 						<div class="row">
							 						<div class="col-md-5 product-name">
							 							<div class="product-name">
								 							<a href="#">Lorem Ipsum dolor</a>
								 							<div class="product-info">
									 							<div>Display: <span class="value">5 inch</span></div>
									 							<div>RAM: <span class="value">4GB</span></div>
									 							<div>Memory: <span class="value">32GB</span></div>
									 						</div>
									 					</div>
							 						</div>
							 						<div class="col-md-4 quantity">
							 							<label for="quantity">Quantity:</label>
							 							<input id="quantity" type="number" value ="1" class="form-control quantity-input">
							 						</div>
							 						<div class="col-md-3 price">
							 							<span>$120</span>
							 						</div>
							 					</div>
							 				</div>
					 					</div>
					 				</div>
				 				</div>
				 			</div>
			 			</div>
			 			<div class="col-md-12 col-lg-4">
			 				<div class="summary">
			 					<h3>Summary</h3>
			 					<div class="summary-item"><span class="text">Subtotal</span><span class="price">$360</span></div>
			 					<div class="summary-item"><span class="text">Discount</span><span class="price">$0</span></div>
			 					<div class="summary-item"><span class="text">Shipping</span><span class="price">$0</span></div>
			 					<div class="summary-item"><span class="text">Total</span><span class="price">$360</span></div>
			 					<button type="button" class="btn btn-primary btn-lg btn-block">Checkout</button>
				 			</div>
			 			</div>
		 			</div> 
		 		</div>
	 		</div>
		</section>
               
               
		 		</div>
                   </div>

        </div>

    </div>
                    
                
            </div>
            <div class="features text-center">
                <div class="row">
                    <div class="col-md-4">
                        <div class="info">
                            <div class="icon icon-info">
                                <i class="material-icons">local_shipping</i>
                            </div>
                            <h4 class="info-title">2 Days Delivery </h4>
                            <p>Divide details about your product or agency work into parts. Write a few lines about each one. A paragraph describing a feature will be enough.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info">
                            <div class="icon icon-success">
                                <i class="material-icons">verified_user</i>
                            </div>
                            <h4 class="info-title">Refundable Policy</h4>
                            <p>Divide details about your product or agency work into parts. Write a few lines about each one. A paragraph describing a feature will be enough.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="info">
                            <div class="icon icon-rose">
                                <i class="material-icons">favorite</i>
                            </div>
                            <h4 class="info-title">Popular Item</h4>
                            <p>Divide details about your product or agency work into parts. Write a few lines about each one. A paragraph describing a feature will be enough.</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="related-products">
                <h3 class="title text-center">You may also be interested in:</h3>
                <div class="row">
                    <div class="col-sm-6 col-md-3">  
                        <div class="card card-product">
                            <div class="card-header card-header-image">
                                <a href="#pablo">
                                    <img class="img" src="../assets/img/examples/card-product1.jpg">
                                </a>
                            <div class="colored-shadow" style="background-image: url(&quot;../assets/img/examples/card-product1.jpg&quot;); opacity: 1;"></div></div>
                            <div class="card-body">
                                <h6 class="card-category text-rose">Trending</h6>
                                <h4 class="card-title">
                                    <a href="#pablo">Dolce &amp; Gabbana</a>
                                </h4>
                                <div class="card-description">
                                    Dolce &amp; Gabbana's 'Greta' tote has been crafted in Italy from hard-wearing red textured-leather.
                                </div>
                            </div>
                            <div class="card-footer justify-content-between">
                                <div class="price">
                                    <h4>$1,459</h4>
                                </div>
                                <div class="stats">
                                    <button type="button" rel="tooltip" title="" class="btn btn-just-icon btn-link btn-rose" data-original-title="Saved to Wishlist">
                                        <i class="material-icons">favorite</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-3">
                        <div class="card card-product">
                            <div class="card-header card-header-image">
                                <a href="#pablo">
                                    <img class="img" src="../assets/img/examples/card-product3.jpg">
                                </a>
                            <div class="colored-shadow" style="background-image: url(&quot;../assets/img/examples/card-product3.jpg&quot;); opacity: 1;"></div></div>
                            <div class="card-body">
                                <h6 class="card-category text-muted">Popular</h6>
                                <h4 class="card-title">
                                    <a href="#pablo">Balmain</a>
                                </h4>
                                <div class="card-description">
                                    Balmain's mid-rise skinny jeans are cut with stretch to ensure they retain their second-skin fit but move comfortably.
                                </div>
                            </div>
                            <div class="card-footer justify-content-between">
                                <div class="price">
                                    <h4>$459</h4>
                                </div>
                                <div class="stats">
                                    <button type="button" rel="tooltip" title="" class="btn btn-just-icon btn-link" data-original-title="Save to Wishlist">
                                        <i class="material-icons">favorite</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-3">
                        <div class="card card-product">
                            <div class="card-header card-header-image">
                                <a href="#pablo">
                                    <img class="img" src="../assets/img/examples/card-product4.jpg">
                                </a>
                            <div class="colored-shadow" style="background-image: url(&quot;../assets/img/examples/card-product4.jpg&quot;); opacity: 1;"></div></div>
                            <div class="card-body">
                                <h6 class="card-category text-muted">Popular</h6>
                                <h4 class="card-title">
                                    <a href="#pablo">Balenciaga</a>
                                </h4>
                                <div class="card-description">
                                    Balenciaga's black textured-leather wallet is finished with the label's iconic 'Giant' studs. This is where you can...
                                </div>
                            </div>
                            <div class="card-footer justify-content-between">
                                <div class="price">
                                    <h4>$590</h4>
                                </div>
                                <div class="stats">
                                    <button type="button" rel="tooltip" title="" class="btn btn-just-icon btn-link btn-rose" data-original-title="Saved to Wishlist">
                                        <i class="material-icons">favorite</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6 col-md-3">
                        <div class="card card-product">
                            <div class="card-header card-header-image">
                                <a href="#pablo">
                                    <img class="img" src="../assets/img/examples/card-product2.jpg">
                                </a>
                            <div class="colored-shadow" style="background-image: url(&quot;../assets/img/examples/card-product2.jpg&quot;); opacity: 1;"></div></div>
                            <div class="card-body">
                                <h6 class="card-category text-rose">Trending</h6>
                                <h4 class="card-title">
                                    <a href="#pablo">Dolce &amp; Gabbana</a>
                                </h4>
                                <div class="card-description">
                                    Dolce &amp; Gabbana's 'Greta' tote has been crafted in Italy from hard-wearing red textured-leather.
                                </div>
                            </div>
                            <div class="card-footer justify-content-between">
                                <div class="price">
                                    <h4>$1,459</h4>
                                </div>
                                <div class="stats">
                                    <button type="button" rel="tooltip" title="" class="btn btn-just-icon btn-link btn-default" data-original-title="Save to Wishlist">
                                        <i class="material-icons">favorite</i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>