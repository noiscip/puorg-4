<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<div class="page-header header" style="background-image: url('<%=request.getContextPath()%>/assets/img/bg7.jpg')">
    <div class="container">
      <div class="row">
        <div class="col-md-10 ml-auto mr-auto">
          <div class="card card-signup">
            <h2 class="card-title text-center">Register</h2>
            <div class="card-body">
              <div class="row">
                <div class="col-md-5 ml-auto">
                  <div class="info info-horizontal">
                    <div class="icon icon-rose">
                      <i class="material-icons">search</i>
                    </div>
                    <div class="description">
                      <h4 class="info-title">Search</h4>
                      <p class="description">
                        		다양한 종류의 사진을 검색할 수 있습니다.
                      </p>
                    </div>
                  </div>
                  <div class="info info-horizontal">
                    <div class="icon icon-primary">
                      <i class="material-icons">group</i>
                    </div>
                    <div class="description">
                      <h4 class="info-title">Trade</h4>
                      <p class="description">
                       	자신만의 사진을 판매, 구매 할 수 있습니다.
                      </p>
                    </div>
                  </div>
                  <div class="info info-horizontal">
                    <div class="icon icon-info">
                      <i class="material-icons">visibility</i>
                    </div>
                    <div class="description">
                      <h4 class="info-title">Vision</h4>
                      <p class="description">
                        	API를 이용한 사진분류
                      </p>
                    </div>
                  </div>
                </div>
                <div class="col-md-5 mr-auto">
                
                  <form class="form" method="post" action="<%=request.getContextPath()%>/user/register.ps">
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="material-icons">face</i>
                          </span>
                        </div>
                        <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디...">
                        <input type="button" class="btn btn-primary btn-sm" id="userIdCheck" value="중복체크">
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="material-icons">text_format</i>
                          </span>
                        </div>
                        <input type="text" class="form-control" name="userName" placeholder="이름...">
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="material-icons">lock_outline</i>
                          </span>
                        </div>
                        <input type="password" placeholder="비밀번호..." id="pwd" name="pwd" class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="material-icons">check_circle_outline</i>
                          </span>
                        </div>
                        <input type="password" placeholder="비밀번호 확인..." id="pwCheck" class="form-control" />
                      </div>
                    </div>
                    <div class="form-check">
                      <label class="form-check-label">
                        <input class="form-check-input" type="checkbox" value="" checked>
                        <span class="form-check-sign">
                          <span class="check"></span>
                        </span>
                        	나는 
                        <a href="#something">이용 약관</a>
                        	에 동의합니다.
                      </label>
                    </div>
                    <div class="text-center">
                      <input type="button" class="btn btn-primary btn-round" id="userRegister" value="가입">
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <script>
  	$(function(){
  		var regUserId = /^[a-z]+[a-z0-9]{5,19}$/ //첫글자 영문 + 영문 숫자 혼용 6~20글자
  		var regPwd = /^[a-zA-Z0-9!@#$%^&*()?_~]{4,15}$/  //영문 숫자 특수문자 혼용해서 4~15글자
  		var idCheck = false
  		var pwCheck = false

  		$('#userIdCheck').click(function(){
  			if(!regUserId.test($("#userId").val())) {
  	          	alert('아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.')
  	          	return
  	      	}

  			$.ajax({
  				url : "/picsion/user/adminUserSearch.ps",
  				data : {userId : $('#userId').val()},
  				success : function (data) {
					if(data.searchUser == null){
						alert('사용 가능한 아이디 입니다')
						idCheck = true;
					}else{
						alert('중복된 아이디 입니다')
					}
				}
  			})
  		})
  		
  		$('#userId').keyup(function(){
  			idCheck = false;
  		})
  		
  		$('#pwd').focusout(function(){
  			pwCheck = false
  			var reg = '사용 가능 합니다!!'
  			if( !regPwd.test($('#pwd').val()) ){
  				alert('비밀번호는 영문 숫자 특수문자 혼용하여 4~15글자 입니다')
  				reg = '사용 불가능 합니다!!'
  			}
  			$('#pwd').closest('.form-group')[0].childNodes[2].remove()
  			$('#pwd')[0].parentElement.after(reg)
  		})
  		
  		$('#pwCheck').keyup(function(){
  			var isPwCheck = '사용 불가능 합니다!!'
  			if( $('#pwd').val() == $('#pwCheck').val() ){
  				isPwCheck = '사용 가능 합니다!!'
	  			pwCheck = true
  			}else{
  				pwCheck = false
  			}
  			$('#pwCheck').closest('.form-group')[0].childNodes[2].remove()
  			$('#pwCheck')[0].parentElement.after(isPwCheck)
  		})
  		
  		$('#userRegister').click(function(){
  			if(!idCheck){
  				alert('아이디 중복 체크가 필요합니다')
  				$('#userId').focus()
  			}else if(!pwCheck){
  				alert('비밀번호를 다시 확인 해주세요')
  				$('#pwd').focus()
  			}else if(idCheck && pwCheck){
	  			$('form').submit()
  			}
  		})
  		
  	})
  </script>