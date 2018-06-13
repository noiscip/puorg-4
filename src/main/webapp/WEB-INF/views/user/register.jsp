<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<div class="page-header header-filter" filter-color="purple" style="background-image: url('<%=request.getContextPath()%>/assets/img/bg7.jpg')">
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
                        	인공지능 기술을 한 사진분류
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
                        <input type="password" placeholder="비밀번호..." name="pwd" class="form-control" />
                      </div>
                    </div>
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="material-icons">check_circle_outline</i>
                          </span>
                        </div>
                        <input type="password" placeholder="비밀번호 확인..." class="form-control" />
                      </div>
                    </div>
                     <div class="social text-center">
                    <button class="btn btn-just-icon btn-round btn-google">
                      <i class="fa fa-google"></i>
                    </button>
                    <button class="btn btn-just-icon btn-round btn-facebook">
                      <i class="fa fa-Naver">N</i>
                    </button>
                    <h4> 계정 연동 </h4>
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
                      <button type="submit" class="btn btn-primary btn-round">가입</button>
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