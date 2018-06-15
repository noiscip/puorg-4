<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-transparent navbar-color-on-scroll fixed-top navbar-expand-lg" color-on-scroll="100" id="sectionsNav">
    <div class="container">
      <div class="navbar-translate">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/home.ps"><img src="<%=request.getContextPath()%>/assets/img/picsion-logo.png" style="width: 100px; height: 30px;"></a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
          <span class="navbar-toggler-icon"></span>
          <span class="navbar-toggler-icon"></span>
        </button>
      </div>
      <div class="collapse navbar-collapse">
      	<form class="form-inline">
                 <div class="form-group has-default bmd-form-group">
                            <input type="text" class="form-control" placeholder="Search">
                 </div>
                 <button type="submit" class="btn btn-white btn-raised btn-fab btn-fab-mini btn-round">
                    <i class="material-icons">search</i>
                </button>
           </form>
        <ul class="navbar-nav ml-auto">
         <li class="dropdown nav-item">
                  <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                      <i class="material-icons">apps</i> Components
                  </a>
                  <div class="dropdown-menu dropdown-with-icons">
                    <a href="<%=request.getContextPath()%>/board.ps" class="dropdown-item">
                        <i class="material-icons">list</i> 요청 게시판
                    </a>
                    <a href="<%=request.getContextPath()%>/upload.ps" class="dropdown-item">
                        <i class="material-icons">add_circle_outline</i>업로드
                    </a>
                    <a href="<%=request.getContextPath()%>/user/bookmarklist.ps" class="dropdown-item">
                        <i class="material-icons">bookmark</i>즐겨찾기
                    </a>
                    <a href="<%=request.getContextPath()%>/user/followinglist.ps" class="dropdown-item">
                        <i class="material-icons">favorite</i>팔로잉
                    </a>
                    <a href="<%=request.getContextPath()%>/message/receivemessage.ps" class="dropdown-item">
                        <i class="material-icons">mail</i>메시지함
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="material-icons">shop_two</i>거래내역
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="material-icons">description</i>요청/작업
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="material-icons">settings</i>정보 수정
                    </a>
                    <a href="#" class="dropdown-item">
                        <i class="material-icons">content_paste</i> 넣고싶은 거 넣으셈
                    </a>
                  </div>
                </li>
        
        
        
        
          <c:choose>
					<c:when test="${sessionScope.user eq null}">
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/user/register.ps" onclick="scrollToDownload()"> 
								<i class="material-icons">accessibility_new</i> 회원가입
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/user/login.ps" onclick="scrollToDownload()"> 
								<i class="material-icons">camera_front</i>로그인
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item">
							<a id="userProfile" class="nav-link" href="<%=request.getContextPath()%>/picture/mystudio.ps?userNo=${sessionScope.user.userNo}"> 
								  <img style ="width: 30px;" alt="Circle Image" class="rounded-circle" src="<%=request.getContextPath()%>${sessionScope.user.prPicture}">
								  ${sessionScope.user.userName}
							</a>
						</li>
						<li class="nav-item">
							<a class="nav-link" href="<%=request.getContextPath()%>/user/logout.ps" onclick="scrollToDownload()"> 
								<i class="material-icons">highlight_off</i> 로그아웃
							</a>
						</li>
					</c:otherwise>
				</c:choose>
        </ul>
      </div>
    </div>
  </nav>
  
 