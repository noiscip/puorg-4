<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="page-header header-filter" data-parallax="true"
	filter-color="rose"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/bg7.jpg');">
	<div class="container">
		<div class="row title-row">
			<div class="col-md-4 ml-auto">
				<button class="btn btn-white float-right">
					<i class="material-icons">shopping_cart</i> 0 Items
				</button>
			</div>
		</div>
	</div>
</div>


<div class="section section-gray">
	<div class="container">
		<div class="main main-raised main-product">
			<div class="row">
				<div class="col-md-6 col-sm-6">
					<div class="card card-blog">
                        <div class="card-header card-header-image">
                            <a href="#pablo">
                                <img class="img" src="<%=request.getContextPath()%>/${picture.picPath}">
                                <div class="card-title">
                                    <i class="material-icons">favorite</i> 2.4K ·
                                    <i class="material-icons">bookmark</i> 45
                                </div>
                            </a>
                         <div class="colored-shadow colored-shadow-big" style="background-image: url(&quot;<%=request.getContextPath()%>/${picture.picPath}?auto=format&amp;fit=crop&amp;w=750&amp;q=80&amp;ixid=dW5zcGxhc2guY29tOzs7Ozs%3D&quot;); opacity: 1;"></div></div>
                        <div class="card-body">
                        </div>
					 </div> 
					<div class="team">
						<div class="col-md-12">
							<div class="card card-profile card-plain">
								<div class="row">
									<div class="col-md-5">
										<div class="card-header card-header-image">
											<a href="#pablo"> <img class="img"
												src="<%=request.getContextPath()%>/${userInfo.prPicture}">
											</a>
											<div class="colored-shadow"
												style="background-image: url(&quot;<%=request.getContextPath()%>/${userInfo.prPicture}&quot;); opacity: 1;"></div>
										</div>
									</div>
									<div class="col-md-7">
										<div class="card-body">
											<h4 class="card-title">${userInfo.userName}</h4>
											<h6 class="category text-muted">photographer</h6>
											<p class="card-description">${userInfo.prContent}</p>
										</div>
										<div class="card-footer justify-content-center">
											<button type="button" class="btn btn-default btn-sm"
												data-toggle="modal" data-target="#exampleModal">메시지</button>
											<button class="btn btn-primary btn-sm" id="follow">
												<i class="material-icons" id="follow-icon">favorite</i> 팔로우 취소
											</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
				</div>
				<div class="col-md-6 col-sm-6">
					<h2 class="title">${picture.picTitle}</h2>
					<!-- <h3 class="main-price">$335</h3> -->
					<div id="accordion" role="tablist">
						<div class="card card-collapse">
							<div class="card-header" role="tab" id="headingOne">
								<h5 class="mb-0">
									<a>Content</a>
								</h5>
							</div>
							<div id="collapseOne" class="collapse show" role="tabpanel"
								aria-labelledby="headingOne" data-parent="#accordion" style="">
								<div class="card-body">
									<p>${picture.picContent}</p>
								</div>
							</div>
						</div>
						<div class="card card-collapse">
							<div class="card-header" role="tab" id="headingTwo">
								<h5 class="mb-0">
									<a>Tag</a>
								</h5>
							</div>
							<div id="collapseTwo" class="collapse show" role="tabpanel"
								aria-labelledby="headingTwo" data-parent="#accordion" style="">
								<div class="card-body">#Tag #Tag #Tag #Tag #Tag #Tag #Tag #Tag</div>
							</div>
						</div>
						<div class="card card-collapse">
							<div class="card-header" role="tab" id="headingThree">
								<h5 class="mb-0">
									<a>Comment</a>
								</h5>
							</div>
							<div id="collapseThree" class="collapse show" role="tabpanel"
								aria-labelledby="headingThree" data-parent="#accordion"
								style="height: 250px; overflow-x: hidden; overflow-y: inherit;">
								<div class="card-body">
									<div class="media">
										<a class="float-left" href="#pablo">
											<div class="avatar">
												<img class="media-object"
													src="../assets/img/faces/card-profile4-square.jpg"
													alt="...">
											</div>
										</a>
										<div class="media-body">
											<h4 class="media-heading">
												Tina Andrew <small>· 7 minutes ago</small>
											</h4>
											<p>사진 멋있어요</p>
											<a href="#pablo" class="btn btn-primary btn-link float-right"
												rel="tooltip" title="" data-original-title="보내버리기"> <i
												class="material-icons">reply</i> 신고
											</a>
										</div>
									</div>
									<div class="media">
										<a class="float-left" href="#pablo">
											<div class="avatar">
												<img class="media-object" alt="Tim Picture"
													src="../assets/img/faces/card-profile1-square.jpg">
											</div>
										</a>
										<div class="media-body">
											<h4 class="media-heading">
												John Camber <small>· Yesterday</small>
											</h4>
											<p>감사용~</p>
											<div class="media-footer">
												<a href="#pablo"
													class="btn btn-primary btn-link float-right" rel="tooltip"
													title="" data-original-title="보내버리기"> <i
													class="material-icons">reply</i> 신고
												</a>
											</div>
										</div>
									</div>
									<div class="media">
										<a class="float-left" href="#pablo">
											<div class="avatar">
												<img class="media-object" alt="Tim Picture"
													src="../assets/img/faces/card-profile1-square.jpg">
											</div>
										</a>
										<div class="media-body">
											<h4 class="media-heading">
												John Camber <small>· Yesterday</small>
											</h4>
											<p>사진 많아용~</p>
											<div class="media-footer">
												<a href="#pablo"
													class="btn btn-primary btn-link float-right" rel="tooltip"
													title="" data-original-title="보내버리기"> <i
													class="material-icons">reply</i> 신고
												</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="card card-collapse">
							<div class="card-header" role="tab" id="headingTwo">
								<h5 class="mb-0">
									<a>Input Comment</a>
								</h5>
							</div>
							<div id="collapseTwo" class="collapse show" role="tabpanel"
								aria-labelledby="headingTwo" data-parent="#accordion" style="">
								<div class="media media-post">
                            <a class="author float-left" href="#pablo">
                                <div class="avatar">
                                    <img class="media-object" alt="64x64" src="../assets/img/faces/card-profile6-square.jpg">
                                </div>
                            </a>
                            <div class="media-body">
                                <div class="form-group label-floating bmd-form-group">
                                    <label class="form-control-label bmd-label-floating" for="exampleBlogPost"> 댓글을 달아보세요...</label>
                                    <textarea class="form-control" rows="5" id="exampleBlogPost"></textarea>
                                </div>
                                <div class="media-footer">
                                    <a href="#pablo" class="btn btn-primary btn-round btn-wd float-right">Post Comment</a>
                                </div>
                            </div>
                        </div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-12 col-sm-12">
				<div align="center">
				  	
								<h1 class="card-title">
									<small>$</small>199
								</h1>
								 <button class="btn btn-rose btn-round card-title">
									Buy &nbsp;<i class="material-icons">shopping_cart</i>
								</button>
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
						<h4 class="info-title">2 Days Delivery</h4>
						<p>Divide details about your product or agency work into
							parts. Write a few lines about each one. A paragraph describing a
							feature will be enough.</p>
					</div>
				</div>
				<div class="col-md-4">
					<div class="info">
						<div class="icon icon-success">
							<i class="material-icons">verified_user</i>
						</div>
						<h4 class="info-title">Refundable Policy</h4>
						<p>Divide details about your product or agency work into
							parts. Write a few lines about each one. A paragraph describing a
							feature will be enough.</p>
					</div>
				</div>
				<div class="col-md-4">
					<div class="info">
						<div class="icon icon-rose">
							<i class="material-icons">favorite</i>
						</div>
						<h4 class="info-title">Popular Item</h4>
						<p>Divide details about your product or agency work into
							parts. Write a few lines about each one. A paragraph describing a
							feature will be enough.</p>
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
							<a href="#pablo"> <img class="img"
								src="<%=request.getContextPath()%>/assets/img/examples/studio-1.jpg">
							</a>
							<div class="colored-shadow"
								style="background-image: url(&quot;<%=request.getContextPath()%>/assets/img/examples/studio-1.jpg&quot;); opacity: 1;"></div>
						</div>
						<div class="card-body">
							<h6 class="card-category text-rose">Trending</h6>
							<h4 class="card-title">
								<a href="#pablo">Dolce &amp; Gabbana</a>
							</h4>
							<div class="card-description">Dolce &amp; Gabbana's 'Greta'
								tote has been crafted in Italy from hard-wearing red
								textured-leather.</div>
						</div>
						<div class="card-footer justify-content-between">
							<div class="price">
								<h4>$1,459</h4>
							</div>
							<div class="stats">
								<button type="button" rel="tooltip" title=""
									class="btn btn-just-icon btn-link btn-rose"
									data-original-title="Saved to Wishlist">
									<i class="material-icons">favorite</i>
								</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-md-3">
					<div class="card card-product">
						<div class="card-header card-header-image">
							<a href="#pablo"> <img class="img"
								src="<%=request.getContextPath()%>/assets/img/examples/studio-3.jpg">
							</a>
							<div class="colored-shadow"
								style="background-image: url(&quot;<%=request.getContextPath()%>/assets/img/examples/studio-3.jpg&quot;); opacity: 1;"></div>
						</div>
						<div class="card-body">
							<h6 class="card-category text-muted">Popular</h6>
							<h4 class="card-title">
								<a href="#pablo">Balmain</a>
							</h4>
							<div class="card-description">Balmain's mid-rise skinny
								jeans are cut with stretch to ensure they retain their
								second-skin fit but move comfortably.</div>
						</div>
						<div class="card-footer justify-content-between">
							<div class="price">
								<h4>$459</h4>
							</div>
							<div class="stats">
								<button type="button" rel="tooltip" title=""
									class="btn btn-just-icon btn-link"
									data-original-title="Save to Wishlist">
									<i class="material-icons">favorite</i>
								</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-md-3">
					<div class="card card-product">
						<div class="card-header card-header-image">
							<a href="#pablo"> <img class="img"
								src="<%=request.getContextPath()%>/assets/img/examples/studio-4.jpg">
							</a>
							<div class="colored-shadow"
								style="background-image: url(&quot;<%=request.getContextPath()%>/assets/img/examples/studio-4.jpg&quot;); opacity: 1;"></div>
						</div>
						<div class="card-body">
							<h6 class="card-category text-muted">Popular</h6>
							<h4 class="card-title">
								<a href="#pablo">Balenciaga</a>
							</h4>
							<div class="card-description">Balenciaga's black
								textured-leather wallet is finished with the label's iconic
								'Giant' studs. This is where you can...</div>
						</div>
						<div class="card-footer justify-content-between">
							<div class="price">
								<h4>$590</h4>
							</div>
							<div class="stats">
								<button type="button" rel="tooltip" title=""
									class="btn btn-just-icon btn-link btn-rose"
									data-original-title="Saved to Wishlist">
									<i class="material-icons">favorite</i>
								</button>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-6 col-md-3">
					<div class="card card-product">
						<div class="card-header card-header-image">
							<a href="#pablo"> <img class="img"
								src="<%=request.getContextPath()%>/assets/img/examples/studio-2.jpg">
							</a>
							<div class="colored-shadow"
								style="background-image: url(&quot;<%=request.getContextPath()%>/assets/img/examples/studio-2.jpg&quot;); opacity: 1;"></div>
						</div>
						<div class="card-body">
							<h6 class="card-category text-rose">Trending</h6>
							<h4 class="card-title">
								<a href="#pablo">Dolce &amp; Gabbana</a>
							</h4>
							<div class="card-description">Dolce &amp; Gabbana's 'Greta'
								tote has been crafted in Italy from hard-wearing red
								textured-leather.</div>
						</div>
						<div class="card-footer justify-content-between">
							<div class="price">
								<h4>$1,459</h4>
							</div>
							<div class="stats">
								<button type="button" rel="tooltip" title=""
									class="btn btn-just-icon btn-link btn-default"
									data-original-title="Save to Wishlist">
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