<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

   <div class="page-header header-filter" data-parallax="true" style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
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
        </tr>
    </thead>
    <tbody>
    	<c:forEach items="${list}" var="n">
        <tr>
			<td class="text-center">${n.brdNo}</td>
			<td class="text-center"><a href="boardInfo.ps?brdNo=${n.brdNo}">${n.brdTitle}</a></td>
			<td class="text-center">${n.brdNo}</td>
			<td class="text-center">${n.brdReg}</td>							
		</tr>
		</c:forEach>
    </tbody>
    <tfoot>
     <tr>
		<td class="text-center">
			<!-- 처음 이전 링크 -->
			<c:if test="${pg>block}">  <!-- 5>10 : false / 15>10 : true -->
				[<a href="board.ps?pg=1" style="cursor:pointer;">◀◀</a>]
				[<a href="board.ps?pg=${fromPage-1}" style="cursor:pointer;">◀</a>]		
			</c:if>
			<c:if test="${pg<=block}"> <!-- 5<=10 :true / 15<=10:false -->
				[<span style="color:gray">◀◀</span>]	
				[<span style="color:gray">◀</span>]
			</c:if>
			
			<!-- 블록 범위 찍기 -->
			<c:forEach begin="${fromPage}" end="${toPage}" var="i">
				<c:if test="${i==pg}">[${i}]</c:if>
				<c:if test="${i!=pg}">
					[<a href="board.ps?pg=${i}">${i}</a>]
				</c:if>
			</c:forEach>
			
			<!-- 다음, 이후 -->
			<c:if test="${toPage<allPage}"> <!-- 20<21 : true -->
					[<a href="board.ps?pg=${toPage+1}" style="cursor:pointer;">▶</a>]
					[<a href="board.ps?pg=${allPage}" style="cursor:pointer;">▶▶</a>]
			
			</c:if>	
			<c:if test="${toPage>=allPage}"> <!-- 21>=21 :true -->
					[<span style="color:gray">▶</span>]
					[<span style="color:gray">▶▶</span>]
			
			</c:if>			
			
		</td>
	</tr>
    
    </tfoot>
</table>

 <a href="<%=request.getContextPath()%>/writeboard.ps" style="cursor:pointer;">글 쓰기</a>
 </div>
</div>

</div>
</div>
</div>


