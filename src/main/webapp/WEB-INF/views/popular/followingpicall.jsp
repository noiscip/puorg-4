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
       <c:forEach items="${imagelistall}" var="f" varStatus="i">
			<c:forEach  items="${f.value}" var="u" varStatus="j">
				${u.picNo }<br>
			</c:forEach>
			<br>
			
        </c:forEach> 
        
        
            <%--  <c:forEach items="${imagelistall}" var="followinglistall" varStatus="i">
            <div class="item" data-w="640" data-h="426" style="width: 255px; height: 300px; display: block;">
                <a href="">
                    <img class="rounded img-size" src="<%=request.getContextPath()%>/${followinglistall.picPath}" alt="">
                    
                </a>
                <div>
                    <div class="counts hide-xs hide-sm ">
                        <em data-href="" class="ajax"><i class="icon icon_like material-icons">favorite_border</i></em>
                        <em data-href="" class="ajax"><i class="icon icon_favorite material-icons">bookmark_border</i></em>
                    </div>
                    <a href="">${followinglistall[${i.index}].Users.userName}</a>
                </div>
            </div>
             </c:forEach>  --%>
          </div>
        </div>
      </div>
    </div>
  </div>
