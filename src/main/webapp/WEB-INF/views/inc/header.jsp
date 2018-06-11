<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<nav class="navbar navbar-transparent navbar-color-on-scroll fixed-top navbar-expand-lg" color-on-scroll="100" id="sectionsNav">
    <div class="container">
      <div class="navbar-translate">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/home.ps">picsion</a>
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
                    <a href="board.ps" class="dropdown-item">
                        <i class="material-icons">list</i> 요청 게시판
                    </a>
                    <a href="" class="dropdown-item">
                        <i class="material-icons">content_paste</i> 넣고싶은 거 넣으셈
                    </a>
                    <a href="" class="dropdown-item">
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
						 
							<a class="nav-link" href="#" onclick="scrollToDownload()"> 
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
  
 