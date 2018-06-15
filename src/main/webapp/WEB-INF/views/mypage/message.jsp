<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
/* 뿌려주는 이미지의 크기 */
.img-size {
	height: 300px;
}

/* 사용자의 프로필 사진의 크기 */
.user-img {
	width: 50px;
	height: 50px;
}

/* 마이페이지 상단 메뉴 위,아래 여백 */
.my-ul {
	padding-top: 30px;
	padding-bottom: 30px;
}

/* 팔로잉 회원 프로필 사진 크기 이미지 */
.following-pr{
	width:180px;
	height:180px;
}

/* body, html  { height: 100%; }
html, body, div, span, applet, object, iframe,
h1, h2, h3, h4, h5, h6, p, blockquote, pre,
a, abbr, acronym, address, big, cite, code,
del, dfn, em, font, img, ins, kbd, q, s, samp,
small, strike, strong, sub, sup, tt, var,
b, u, i, center,
dl, dt, dd, ol, ul, li,
fieldset, form, label, legend,
table, caption, tbody, tfoot, thead, tr, th, td {
	margin: 0;
	padding: 0;
	border: 0;
	outline: 0;
	font-size: 100%;
	vertical-align: baseline;
	background: transparent;
}
body { line-height: 1; }
ol, ul { list-style: none; }
blockquote, q { quotes: none; }
blockquote:before, blockquote:after, q:before, q:after { content: ''; content: none; }
:focus { outline: 0; }
del { text-decoration: line-through; }
table {border-spacing: 0; } /* IMPORTANT, I REMOVED border-collapse: collapse; FROM THIS LINE IN ORDER TO MAKE THE OUTER BORDER RADIUS WORK */
 */
/*------------------------------------------------------------------ */

/*This is not important*/
/* body{
	font-family: Arial, Helvetica, sans-serif;
	background: url(background.jpg);
	margin: 0 auto;
	width: 520px;
}
a:link {
	color: #666;
	font-weight: bold;
	text-decoration: none;
}
a:visited {
	color: #666;
	font-weight: bold;
	text-decoration: none;
}
a:active,
a:hover {
	color: #bd5a35;
	text-decoration: underline;
} */


/*
Table Style - This is what you want
------------------------------------------------------------------ */
table a:link {
	color: #666;
	font-weight: bold;
	text-decoration: none;
}
table a:visited {
	color: #999999;
	font-weight: bold;
	text-decoration: none;
}
table a:active,
table a:hover {
	color: #bd5a35;
	text-decoration: underline;
}
table {
	font-family: Arial, Helvetica, sans-serif;
	color: #666;
	font-size: 12px;
	text-shadow: 1px 1px 0px #fff;
	background: #eaebec;
	margin: 20px;
	border: #ccc 1px solid;

	-webkit-border-radius: 3px;
	border-radius: 3px;

	-webkit-box-shadow: 0 1px 2px #d1d1d1;
	box-shadow: 0 1px 2px #d1d1d1;
}
table > thead th {
	padding: 21px 25px 22px 25px;
	border-top: 1px solid #fafafa;
	border-bottom: 1px solid #e0e0e0;

	background: #ededed; /* Old browsers */
	background: -moz-linear-gradient(top,  #ededed 0%, #ebebeb 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#ededed), color-stop(100%,#ebebeb)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #ededed 0%,#ebebeb 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #ededed 0%,#ebebeb 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #ededed 0%,#ebebeb 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #ededed 0%,#ebebeb 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ededed', endColorstr='#ebebeb',GradientType=0 ); /* IE6-9 */
}
table > thead th:first-child{
	text-align: left;
	padding-left: 20px;
}
table > thead > tr:first-child > th:first-child {
	-webkit-border-top-left-radius: 3px;
	border-top-left-radius: 3px;
}
table > thead > tr:first-child > th:last-child {
	-webkit-border-top-right-radius: 3px;
	border-top-right-radius: 3px;
}
table > tbody > tr {
	text-align: center;
	padding-left: 20px;
}
table > tbody > tr > td:first-child {
	text-align: left;
	padding-left: 20px;
	border-left: 0;
}
table > tbody > tr > td {
	padding:18px;
	border-top: 1px solid #ffffff;
	border-bottom: 1px solid #e0e0e0;
	border-left: 1px solid #e0e0e0;

	background: #fbfbfb; /* Old browsers */
	background: -moz-linear-gradient(top,  #fbfbfb 0%, #fafafa 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#fbfbfb), color-stop(100%,#fafafa)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #fbfbfb 0%,#fafafa 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #fbfbfb 0%,#fafafa 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #fbfbfb 0%,#fafafa 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #fbfbfb 0%,#fafafa 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#fbfbfb', endColorstr='#fafafa',GradientType=0 ); /* IE6-9 */
}
table > tbody > tr:nth-child(even) > td{
	background: #f8f8f8; /* Old browsers */
	background: -moz-linear-gradient(top,  #f8f8f8 0%, #f6f6f6 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f8f8f8), color-stop(100%,#f6f6f6)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #f8f8f8 0%,#f6f6f6 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #f8f8f8 0%,#f6f6f6 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #f8f8f8 0%,#f6f6f6 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #f8f8f8 0%,#f6f6f6 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f8f8f8', endColorstr='#f6f6f6',GradientType=0 ); /* IE6-9 */
}
table > tbody > tr:last-child > td{
	border-bottom: 0;
}
table > tbody > tr:last-child > td:first-child {
	-webkit-border-bottom-left-radius: 3px;
	border-bottom-left-radius: 3px;
}
table > tbody > tr:last-child > td:last-child {
	-webkit-border-bottom-right-radius: 3px;
	border-bottom-right-radius: 3px;
}
table > tbody > tr:hover > td {
	background: #f2f2f2; /* Old browsers */
	background: -moz-linear-gradient(top,  #f2f2f2 0%, #f0f0f0 100%); /* FF3.6+ */
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#f2f2f2), color-stop(100%,#f0f0f0)); /* Chrome,Safari4+ */
	background: -webkit-linear-gradient(top,  #f2f2f2 0%,#f0f0f0 100%); /* Chrome10+,Safari5.1+ */
	background: -o-linear-gradient(top,  #f2f2f2 0%,#f0f0f0 100%); /* Opera 11.10+ */
	background: -ms-linear-gradient(top,  #f2f2f2 0%,#f0f0f0 100%); /* IE10+ */
	background: linear-gradient(to bottom,  #f2f2f2 0%,#f0f0f0 100%); /* W3C */
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#f2f2f2', endColorstr='#f0f0f0',GradientType=0 ); /* IE6-9 */
}
</style>

<div class="page-header header-filter" data-parallax="true"<%-- style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');" --%>></div>
<div class="main main-raised">
	<div class="profile-content">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="#">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/followinglist.ps">팔로잉</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="#">거래/내역</a></li>
			<li class="nav-item"><a class="nav-link" href="#">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link" href="#">정보 수정</a></li>
		</ul>
		
		<div class="container">
			<div class="gallery text-center">
				<div class="row">
					<div class="col-md-12" align="center">
						<table cellspacing='0' style="width:100%; border:#ccc 2px solid"> <!-- cellspacing='0' is important, must stay -->
							<thead>
								<tr align="center">
									<th>번호</th>
									<th>보낸이</th>
									<th>내용</th>
									<th>보낸 날짜</th>
									<th>상태</th>
								</tr>
							</thead>
						
							
							<tbody>
							
								<c:forEach items="${receiveList}" var="receiveMessage" varStatus="status">
									<tr class="url-tr" data-url="" data-toggle="modal" data-target="#myModal">
									
										<td>${receiveMessage.msgNo}</td>
										<td>${receiveInfo[status.index].userName}</td>
										<!-- 상세 페이지? 상세 메시지 내용을 보여주는 Modal? -->
										<td>${receiveMessage.msgContent}</td>
										<td>${receiveMessage.msgReg}</td>
										<td>
											<c:choose>
												<c:when test="${receiveMessage.msgState eq 'F'}">
													안읽음
												</c:when>
												<c:otherwise>
													읽음
												</c:otherwise>
											</c:choose>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal Core -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      	<h4 class="modal-title" id="myModalLabel">메시지</h4>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
      </div>
      <div class="modal-body">
      	<c:forEach items="${receiveList}" var="receiveMessage" varStatus="status">
      		${receiveInfo[status.index].userName}<br>
      		${receiveMessage.msgContent}
      	</c:forEach>
      </div>
      <div class="modal-footer">
      	<!-- <button type="button" class="btn btn-info btn-simple">Save</button> -->
        <button type="button" class="btn btn-default btn-simple" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
