<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:choose>
	<c:when test="${sessionScope.user eq null }">
		 <div class="section section-signup page-header" style="background-image: url('<%=request.getContextPath()%>/assets/img/bg3.jpg');">
	      <div class="container">
	        <div class="row">
	          <div class="col-md-4 ml-auto mr-auto">
	            <div class="card card-signup">
	              <form class="form" method="post" action="">
	                <div class="card-header card-header-primary text-center">
	                  <h4>Sign Up</h4>
	                  <div class="social-line">
	                    <a href="#pablo" class="btn btn-link btn-just-icon">
	                      <i class="fa fa-facebook-square"></i>
	                    </a>
	                    <a href="#pablo" class="btn btn-link btn-just-icon">
	                      <i class="fa fa-twitter"></i>
	                    </a>
	                    <a id="naver_id_login"></a>
	                  </div>
	                </div>
	                <p class="text-divider">Or Be Classical</p>
	                <div class="card-body">
	                  	<span class="bmd-form-group"><div class="input-group">
		                    <div class="input-group-prepend">
		                      <span class="input-group-text">
		                        <i class="material-icons">face</i>
		                      </span>
		                    </div>
		                    <input type="text" class="form-control" name="userId" placeholder="아이디...">
	                  		</div>
	                  	</span>
						<span class="bmd-form-group">
		                  	<div class="input-group">
		                    	<div class="input-group-prepend">
			                      	<span class="input-group-text">
		                        		<i class="material-icons">lock_outline</i>
			                      	</span>
	                    		</div>
		                    	<input type="password" class="form-control" name="pwd" placeholder="비밀번호...">
		                  	</div>
						</span>
	
		                <div class="form-check">
		                    <label class="form-check-label">
		                        <input class="form-check-input" type="checkbox" value="">
		                        		아이디 기억하기
		                        <span class="form-check-sign">
		                            <span class="check"></span>
		                        </span>
		                    </label>
		                </div>
	                </div>
	                <div class="card-footer justify-content-center">
	                  <button type="submit" class="btn btn-link btn-primary btn-lg">Start</button>
	                </div>
	              </form>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	    <input type="hidden" value="${sessionScope.result}" id="result">
	</c:when>
	<c:otherwise>
		<a id="naver_id_login"></a>
	</c:otherwise>
</c:choose>
<script type="text/javascript">
	var callBackUrl = "http://127.0.0.1:8090/picsion/naver/insert.ps"
	var loginUserNo = $('#loginUserNo').val()
	
	if(loginUserNo == ""){ 
		callBackUrl = "http://127.0.0.1:8090/picsion/naver/login.ps"
	} 
	
	console.log(callBackUrl)
  	var naver_id_login = new naver_id_login("AavwsVovOeUd6Ijvt3W0", callBackUrl);
  	var state = naver_id_login.getUniqState();
    naver_id_login.response_type="code"; 
  	naver_id_login.setDomain("http://127.0.0.1:8090/picsion/naver/login.ps"); 
  	naver_id_login.setState(state);
  	naver_id_login.setButton("white",1,40);
  	naver_id_login.init_naver_id_login();
  	
  	console.log(1)
  	if(loginUserNo != ""){
		console.log("여기는 로그인 된 사람만 보여야행")
		console.log($('#naver_id_login'))
		naver_id_login_anchor.click()
		console.log('dfs')
  	}
  	
  	var result = $('#result').val()
  	setTimeout(function() {
  		if(result =="F"){
  			alert('연동된 계정이 없습니다')
  			var y = confirm("연동 하시겠나이까")
  			console.log(y)
  		  	<%session.removeAttribute("result");%>
  		}
	}, 1000);
  	

</script>