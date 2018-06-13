<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style type="text/css">
		.img-size{
			height: 300px;
		
		}
</style>

   <div class="page-header header-filter" data-parallax="true" style="background-image: url('<%=request.getContextPath()%>/assets/img/city-profile.jpg');"></div>
  <div class="main main-raised">
    <div class="profile-content">
      <div class="container">
        
        
        <div class="row">
          <div class="col-md-6 ml-auto mr-auto">
            <div class="profile-tabs">
              <ul class="nav nav-pills nav-pills-icons justify-content-center" role="tablist">
                
                <li class="nav-item">
                  <a class="nav-link" href="<%=request.getContextPath()%>/home.ps">
                    <i class="material-icons">keyboard_backspace</i> 돌아가기
                  </a>
                </li>
               
              </ul>
            </div>
          </div>
        </div>
        <div id="gallery">
          <div class="flex_grid credits">
            <div class="row">
            <c:forEach items="${imagelistall}" var="followinglistall">
            <div class="item" data-w="640" data-h="426" style="width: 314px; height: 209px; display: block;">
                <a href="/ko/%EB%A1%A4-%EC%A1%B0%EC%8B%9D-%EC%83%8C%EB%93%9C%EC%9C%84%EC%B9%98-%EC%95%84%EC%B9%A8-%EC%8B%9D%EC%82%AC-%EC%9D%8C%EC%8B%9D-%EB%B0%94%EC%82%AD-%EC%8B%9D%EC%82%AC-%EC%9E%90%EA%B7%B9%ED%95%98%EB%8B%A4-3467243/">
                    <img src="<%=request.getContextPath()%>/${followinglistall.picPath}" alt="">
                    
                </a>
                <div>
                    <div class="counts hide-xs hide-sm ">
                        <em data-href="/ko/photos/like/3467243/" class="ajax"><i class="icon icon_like material-icons">favorite_border</i></em>
                        <em data-href="/ko/accounts/favorite/photo/3467243/" class="ajax"><i class="icon icon_favorite material-icons">bookmark_border</i></em>
                    </div>
                    <a href="/ko/users/manfredrichter-4055600/">manfredrichter</a>
                </div>
            </div>
             </c:forEach>
            </div>
             
          </div>
        </div>
      </div>
    </div>
  </div>
