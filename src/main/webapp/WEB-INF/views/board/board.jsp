<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<script type="text/javascript">
$(document).ready( function () {
    $('#datatable').DataTable( {
        "order": [[ 0, "desc" ]],
    	"bInfo": false,    	
    	"bLengthChange": false
    } );
    var errorCheck = ${errorCheck};
    if(errorCheck == 0){
    	alert("글 작성 오류");
    }
    
    
    
    
} );
</script>
<style>
	.board-top-pad{
		margin-top: -11em;
	}
</style>

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
<div class="main">
	<div class="profile-content board-top-pad">
		<div class="container" id="boardcontainer">
			<div class="row">
				<div class="col-md-12 ml-auto mr-auto">

					<table class="table table-hover" id="datatable">
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
									<td class="text-center"><c:choose>
											<c:when test="${n.operStateNo ne 1}">
												<c:choose>
													<c:when
														test="${operlist[status.index].requesterNo eq sessionScope.user.userNo || operlist[status.index].operatorNo eq sessionScope.user.userNo}">
														<a
															href="<%=request.getContextPath()%>/board/boardInfo.ps?brdNo=${n.brdNo}">${n.brdTitle}</a>
													</c:when>
													<c:otherwise>
													<a data-toggle="popover" data-placement="right" data-trigger="hover" data-content="작업 관계자만 읽기가 가능합니다.">${n.brdTitle}</a>													
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<a
													href="<%=request.getContextPath()%>/board/boardInfo.ps?brdNo=${n.brdNo}">${n.brdTitle}</a>
											</c:otherwise>
										</c:choose></td>
									<td class="text-center">${n.userName}</td>
									<td class="text-center"><small> ·<fmt:formatDate
												pattern="yyyy-MM-dd, HH:mm" value="${n.brdReg}" />
									</small></td>
									<td class="text-center">${n.operState}</td>
								</tr>
							</c:forEach>
						</tbody>
						<tfoot>
							
						</tfoot>
					</table>
					
								<div class="text-right" colspan="5" style="border-top-width: 0px">
									<a href="<%=request.getContextPath()%>/board/writeboard.ps"
									style="cursor: pointer;">
										<button class="btn btn-primary btn-round">
											<i class="material-icons">edit</i> 글 쓰기
										</button>
								</a>
								</div>
								
							
				</div>
			</div>
		</div>
	</div>
</div>


