<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style type="text/css">

/* 마이페이지 상단 메뉴 위,아래 여백 */
.my-ul {
	padding-top: 30px;
	padding-bottom: 30px;
}

/* 위에 여백 */
.update-pad-top{
	padding-top: 50px !important;
}

/* 아래 여백 */
.update-pad-bottom{
	padding-bottom: 50px;
}

/* div row 여백  */
.row-pad-tb{
	padding-top: 60px;
	padding-bottom: 160px;
}

</style>

<div id="changemain" class="page-header header-filter" data-parallax="true"></div>
<div class="main">
	<div class="profile-content">
		<div class="container">
		<ul class="nav nav-pills justify-content-center my-ul">
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/upload.ps">업로드</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/user/bookmarklist.ps">즐겨찾기</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/message/receivemessage.ps">메시지함</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/purchase/history.ps">거래 내역</a></li>
			<li class="nav-item"><a class="nav-link" href="<%=request.getContextPath()%>/operation/operequest.ps">요청/작업</a></li>
			<li class="nav-item"><a class="nav-link active" href="<%=request.getContextPath()%>/user/updatebefore.ps">정보 수정</a></li>
		</ul>
		
				<div class="row row-pad-tb">
					<div class="col-md-4 ml-auto mr-auto">
		            <div class="card card-signup">
					<form class="form" method="post" action="<%=request.getContextPath()%>/user/updatebefore.ps">
		                <div class="card-body update-pad-top">
							<span class="bmd-form-group">
			                  	<div class="input-group my-ul">
			                    	<div class="input-group-prepend">
				                      	<span class="input-group-text">
			                        		<i class="material-icons">lock_outline</i>
				                      	</span>
		                    		</div>
			                    	<input type="password" class="form-control" name="pwd" placeholder="비밀번호 확인">
			                  	</div>
							</span>
		
		                </div>
		                <div align="center" class="update-pad-bottom">
		                  	<button type="submit" class="btn btn-default update-btn-save">확인</button>
		                 </div>
		              </form>
		            </div>
		          </div>
				</div>
        		
		</div>
	</div>
</div>

