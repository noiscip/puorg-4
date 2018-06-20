<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<script type="text/javascript">
$(document).ready(function() {
	$('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
	
	
	$(document).on('click','#commentbtn',function(){
		var tableNo = 2;
		var data= {cmtContent:$("#newComment").val(), 
					userNo:${sessionScope.user.userNo}, 
					picNo:${picture.picNo},
					tableNo : tableNo
				   };
		
		$.ajax({
			  url : "<%=request.getContextPath()%>/insertpiccomment.ps",
			  data: data,
			  success : function(data){
				  var media="";
			      $('#commentstart').empty();
			      console.log("데이터들"+data);
			      $.each(data.newcommentUserList,function(index,element){
						media += "<div class='media'>"+
					    "<a class='float-left' href='#pablo'>"+
						"<div class='avatar'>";
						if(element.prPicture == null){
							 media += "<img class='media-object' alt='64x64' src='<%=request.getContextPath()%>/assets/img/user.png'>";
						}else{
							media += "<img class='media-object' alt='64x64' src='<%=request.getContextPath()%>"+element.prPicture+"'>";
						}
						media += "</div></a><div class='media-body'><h4 class='media-heading'>"+
							element.userName+"<small>· "+moment(data.newcommentlist[index].cmtReg).format('YYYY-MM-DD, H:mm:ss')+"</small>"+
						    "</h4><p>"+data.newcommentlist[index].cmtContent+"</p>"+
						    "<a href='#pablo' class='btn btn-primary btn-link float-right'"+
							"rel='tooltip' title='' data-original-title='보내버리기'> <i "+
							"class='material-icons'>reply</i>신고</a></div></div>";
					})
					$('#commentstart').append(media);
			        $('#collapseThree').scrollTop($('#collapseThree')[0].scrollHeight);
			      	$("#newComment").val("");
			     
			  },
			  error: function(){
			   	  alert("메시지 보내는 도중 오류가 발생했습니다.");
			  }
		});
	})

});

</script>
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
											<a href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${userInfo.userNo}"> <img class="img"
												src="<%=request.getContextPath()%>${userInfo.prPicture}">
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
												data-toggle="modal" data-target="#exampleModal"><i class="material-icons">mail</i> 메시지</button>
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
								<div class="card-body">
									<c:forEach var="tag" items="${tagList}">
										<a href="#pablo">
										#${tag}
										</a>
									</c:forEach>
								</div>
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
								style="max-height: 250px; overflow-x: hidden; overflow-y: inherit;">
								<div id="commentstart" class="card-body">
								<c:choose>
								<c:when test="${empty commentList}">
								<h3 class="category text-muted">아직 댓글이 없습니다.</h3>
								</c:when>
								<c:otherwise>
								<c:forEach var="comm" items="${commentList}" varStatus="status">
								
									<div class="media">
										<a class="float-left" href="#pablo">
											<div class="avatar">
											<c:choose>
											<c:when test="${commentUserList[status.index].prPicture eq null}">
											  <img class="media-object" alt="64x64" src="<%=request.getContextPath()%>/assets/img/user.png">
											</c:when>
											<c:otherwise>
											  <img class="media-object" alt="64x64" src="<%=request.getContextPath()%>${commentUserList[status.index].prPicture}">
											</c:otherwise>
											</c:choose> 
											</div>
										</a>
										<div class="media-body">
											<h4 class="media-heading">
												${commentUserList[status.index].userName} <small>· <fmt:formatDate pattern = "yyyy-MM-dd, HH:mm:ss" value = "${comm.cmtReg}" /></small>
											</h4>
											<p>${comm.cmtContent}</p>
											<a href="#pablo" class="btn btn-primary btn-link float-right"
												rel="tooltip" title="" data-original-title="보내버리기"> <i
												class="material-icons">reply</i> 신고
											</a>
										</div>
									</div>
									</c:forEach>
								</c:otherwise>
								</c:choose>
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
								 <c:choose>
									<c:when test="${sessionScope.user eq null}">
									<h3 class="category text-muted">로그인 후 이용가능합니다.</h3>
									</c:when>
								 	<c:otherwise>
								 	<a class="author float-left" href="#pablo">
										<div class="avatar">
											<c:choose>
												<c:when test="${sessionScope.user.prPicture eq null}">
													<img class="media-object" alt="64x64"
														src="<%=request.getContextPath()%>/assets/img/user.png">
												</c:when>
												<c:otherwise>
													<img class="media-object" alt="64x64"
														src="<%=request.getContextPath()%>${sessionScope.user.prPicture}">
												</c:otherwise>
											</c:choose>
										</div>
									</a>
									<div class="media-body">
										<div class="form-group label-floating bmd-form-group">
											<label class="form-control-label bmd-label-floating"
												for="exampleBlogPost"> 댓글을 달아보세요...</label>
											<textarea id="newComment"class="form-control" rows="5" id="exampleBlogPost"></textarea>
										</div>
										<div class="media-footer">
												<button type="button" id="commentbtn"
												class="btn btn-primary btn-round btn-wd float-right">Post
												Comment</button>
										</div>
									</div>
								 	</c:otherwise>
								  </c:choose>
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





<div class="modal fade" id="exampleModal" tabindex="-1" role="">
    <div class="modal-dialog modal-login" role="document">
        <div class="modal-content">
            <div class="card card-signup card-plain">
                <div class="modal-header">
                    <div class="card-header card-header-primary text-center">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="material-icons">clear</i></button>
                        <h4 class="card-title">Message</h4>
                       
                    </div>
                </div>
                <div class="modal-body">
                    <form class="form" method="" action="">
                        <p class="description text-center">메시지를 전하세요...</p>
                        <div class="card-body">
                            <div class="form-group label-floating bmd-form-group">
                                <label class="form-control-label bmd-label-floating" for="message"> Your message</label>
                                <textarea class="form-control" rows="6" id="message"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer justify-content-center">
                    <a href="#pablo" class="btn btn-primary btn-link btn-wd btn-lg">Send</a>
                </div>
            </div>
        </div>
    </div>
</div>