<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>


   <div class="page-header header-filter" data-parallax="true" style="background-image: url('assets/img/city-profile.jpg');"></div>
  <div class="main main-raised">
    <div class="profile-content">
      <div class="container">
        
        
        <div class="row">
          <div class="col-md-6 ml-auto mr-auto">
            <div class="profile-tabs">
              <ul class="nav nav-pills nav-pills-icons justify-content-center" role="tablist">
                
                <li class="nav-item">
                  <a class="nav-link" href="home.ps">
                    <i class="material-icons">keyboard_backspace</i> 돌아가기
                  </a>
                </li>
               
              </ul>
            </div>
          </div>
        </div>
        <div class="tab-content tab-space">
          <div class="tab-pane active text-center gallery" id="studio">
         
            <div class="row">
              <c:forEach items="${popularlist}" var="popular">
              <div class="col-md-4 ml-auto mr-auto">
              
					<img src="${popular }" class="rounded">
					
              </div> 
             
             </c:forEach>
            </div>
             
          </div>
        </div>
      </div>
    </div>
  </div>

