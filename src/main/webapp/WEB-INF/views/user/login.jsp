<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		 <div id="changemain" class="section section-signup page-header">
	      <div class="container">
	        <div class="row">
	          <div class="col-md-4 ml-auto mr-auto">
	            <div class="card card-signup">
	              <form class="form" method="post" action="/picsion/login.ps">
	                <div class="card-header card-header-primary text-center">
	                  <h4>Sign Up</h4>
	                  <div class="social-line">
	                    <a href="<%=request.getContextPath()%>/google/login.ps" class="btn btn-link btn-just-icon">
	                       <img alt="구글 로그인" src="<%=request.getContextPath()%>/assets/img/portalsite/google_icon.png" style="width: 40px">
	                    </a>
	                    <a href="<%=request.getContextPath()%>/naver/login.ps" class="btn btn-link btn-just-icon">
	                      <img alt="네이버 로그인" src="<%=request.getContextPath()%>/assets/img/portalsite/naver_icon.png" style="width: 40px">
	                    </a>
	                  </div> 
	                </div>
	                <p class="text-divider">회원 로그인</p>
	                <div class="card-body">
	                  	<span class="bmd-form-group"><div class="input-group">
		                    <div class="input-group-prepend">
		                      <span class="input-group-text">
		                        <i class="material-icons">face</i>
		                      </span>
		                    </div>
		                    <input type="text" class="form-control" name="userId" placeholder="아이디..." autocomplete="off">
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
<script type="text/javascript">
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