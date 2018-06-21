<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>





<div class="page-header header-filter" data-parallax="true"
	style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
<div class="main main-raised">
	<div class="profile-content">
		<div class="container">
			<div class="row">
				<div class="col-md-12 ml-auto mr-auto">

					<table class="table">
						<thead>
							<tr>
								<th class="text-center">#</th>
								<th class="text-center">제목</th>
								<th class="text-center">작성자</th>
								<th class="text-center">작성일</th>
								<th class="text-center">작업상태</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="n" varStatus="status">
								<tr>
									<td class="text-center">${n.brdNo}</td>
									<td class="text-center"><a
										href="<%=request.getContextPath()%>/board/boardInfo.ps?brdNo=${n.brdNo}">${n.brdTitle}</a></td>
									<td class="text-center">${n.userName}</td>
									<td class="text-center">${n.brdReg}</td>
									<td class="text-center">${n.operState}</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
							<tr>


								<td class="text-center" colspan="5">
									<nav aria-label="Page navigation example">
										<ul class="pagination justify-content-center">

											<!-- 처음 이전 링크 -->
											<c:if test="${pg>block}">
												<!-- 5>10 : false / 15>10 : true -->
												<li class="page-item"><a href="<%=request.getContextPath()%>/board/board.ps?pg=1"
													class="page-link">◀◀</a></li>
												<li class="page-item"><a
													href="<%=request.getContextPath()%>/board/board.ps?pg=${fromPage-1}" class="page-link">◀</a></li>
											</c:if>
											<c:if test="${pg<=block}">
												<!-- 5<=10 :true / 15<=10:false -->
												<li class="page-item"><span style="color: gray">◀◀</span></li>
												<li class="page-item"><span style="color: gray">◀</span></li>
											</c:if>

											<!-- 블록 범위 찍기 -->
											<c:forEach begin="${fromPage}" end="${toPage}" var="i">
												<c:if test="${i==pg}">
													<li class="page-item active"><span class="page-link">
															${i} <span class="sr-only">(current)</span>
													</span></li>
												</c:if>
												<c:if test="${i!=pg}">
													<li class="page-item"><a href="<%=request.getContextPath()%>/board/board.ps?pg=${i}"
														class="page-link">${i}</a></li>
												</c:if>
											</c:forEach>

											<!-- 다음, 이후 -->
											<c:if test="${toPage<allPage}">
												<!-- 20<21 : true -->
												<li class="page-item"><a href="<%=request.getContextPath()%>/board/board.ps?pg=${toPage+1}"
													class="page-link">▶</a></li>
												<li class="page-item"><a href="<%=request.getContextPath()%>/board/board.ps?pg=${allPage}"
													class="page-link">▶▶</a></li>

											</c:if>
											<c:if test="${toPage>=allPage}">
												<!-- 21>=21 :true -->
												<li class="page-item"><span style="color: gray">▶</span></li>
												<li class="page-item"><span style="color: gray">▶▶</span></li>

											</c:if>
										</ul>

									</nav>
							<tr>


								<td class="text-right" colspan="5" style="border-top-width: 0px">

									<a href="<%=request.getContextPath()%>/board/writeboard.ps"
									style="cursor: pointer;">
										<button class="btn btn-primary btn-round" style="top: -78px">
											<i class="material-icons">edit</i> 글 쓰기
										</button>
								</a>
								</td>

							</tr>

						</tfoot>
					</table>



				</div>
			</div>

		</div>
	</div>
</div>


