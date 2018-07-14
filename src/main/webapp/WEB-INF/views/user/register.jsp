<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

	<div id="changemain" class="page-header header">
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
                
                  <form class="form" method="post" action="<%=request.getContextPath()%>/register.ps">
                    <div class="form-group">
                      <div class="input-group">
                        <div class="input-group-prepend">
                          <span class="input-group-text">
                            <i class="material-icons">face</i>
                          </span>
                        </div>
                        <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디..." autocomplete="off">
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
                        <input type="text" class="form-control" name="userName" placeholder="이름..." autocomplete="off">
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
                        <input class="form-check-input" name="agreecheck" type="checkbox" value="">
                        <span class="form-check-sign">
                          <span class="check"></span>
                        </span>
                        	나는 
                        <a data-toggle="modal" data-target="#agreeModal" href="">이용 약관</a>
                        	에 동의합니다.
                      </label>
                    </div>
                    <div class="text-center">
                      <input type="button" class="btn btn-primary" id="userRegister" value="가입하기">
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
  
  
  <!-- 이용 약관 모달 -->
<div class="modal fade" id="agreeModal" tabindex="-1" role="dialog" aria-labelledby="agreeModalTitle" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="agreeModalTitle">회원가입</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
   <div class="row">
                    <div class="col-md-12">
                   
          <!--이용약관 테이블 시작-->
                      <table style="width:100%">
                        <tr>
                          <td>
                            <div>
                             <font color="#f67001" size=4>01</font> <font size=3>이용 약관</font>
                            </div>
                         </td>
                       </tr>
                       <tr>
                         <td>
                         <textarea style="width:100%;text-align:left;overflow:visible;text-overflow:ellipsis;" rows=10 readonly="readonly">
제 1조  사이트 이용                         
1.이용약관은 본 서비스의 이용에 관한 규약을 정한 것입니다. 
본 서비스를 방문하거나 이용하는 모든 분(회원등록을 한 사람에 한하지 않습니다. 이하 “사용자”라 함)에게 이용약관이 적용됩니다.
2. 사진의 서비스의 콘텐츠는 일체 당사 또는 해당 콘텐츠의 권리자에 귀속되며, 저작권법을 포함한 지적 재산권에 관한 법에 따라 보호되고 있습니다. 적절한 라이선스를 취득하지 않고 이를 무단으로 사용하는 것은 법으로 금지되어 있습니다. 포인트사이트 내 콘텐츠는 전부 저작권법을 포함한 지적재산권에 관한 법에 따라 보호 되여 있으며 무단사용 및 전재를 금지되어 있습니다.
3.사용자는 당사와의 콘텐츠 사용허락 계약 체결하지 않는 한, 당사의 콘텐츠를 다운로드하여 복제 혹은 그 외 사용할 수 없습니다. 그러나 무료 콘텐츠 및 샘플 데이터 등 별도 콘텐츠에 대하여 사용 허가 조건이 명시되어 있을 경우에는 그 것에 따릅니다.
4.본 서비스에서 제공하는 샘플 데이터는 워터마크의 유무를 따지지 않고 레이아웃이나 구성의 확인 등 콘텐츠 사용에 앞서 시안 등을 준비하는 목적으로만 사용 가능합니다. 샘플 데이터에 들어간 워터마크는 당사의 허락 없이 삭제할 수 없습니다. 또한, 샘플 데이터를 콘텐츠 사용에 앞서 준비하는 목적을 넘어서 사용한 경우, 이용약관 위반 및 저작권 침해로 처리되어 사용 금지, 위약금 또는 손해배상 청구 등의 대상이 됩니다.
5.본 서비스의 상표, 명칭, 로고 등의 권리는 당사에 귀속됩니다. 해당 로고 등의 사용에 있어서는 PICSION 로고 사용 룰 이 적용됩니다.

제 2조 서비스 이용
1.본 서비스에서 사용자는 회원 등록을 함으로써, 본 서비스에서 제공하는 사진 사용 권한을 구입할 수 있습니다.
2.본 서비스에서 회원 등록을 한 사용자 (이하 '회원'이라 함)는 네이버 및 구글 계정 연동을 함으로써, 저작권 등의 권리를 보유한 콘텐츠를 업로드하고 해당 콘텐츠의 사용권을 판매할 수 있습니다.
3.당사는 콘텐츠의 판매 방법 (판매처, 가격, 이용허가 내용을 포함), 판매 보수의 계산 방법 및 보수 금액 등을 고객의 선택 가격과 당사의 재량으로 결정할 수 있습니다.
4.당사는 당사가 합리적으로 필요하다고 판단한 경우에 사용자에 대한 아무런 책임 없이 본 서비스의 내용을 변경, 휴지, 폐지할 수 있습니다.
5.당사는 당사가 합리적으로 필요하다고 판단한 경우에 사용자에게 사전 통지, 허가를 요하지 않고 또한 사용자에 대한 아무런 책임을 지지 않고 사용자가 제공한 콘텐츠 및 이에 수반하는 정보를 삭제, 변경할 수 있습니다.
6.당사는 당사가 합리적으로 필요하다고 판단한 경우에 이용약관, 콘텐츠 사용허락 계약, 콘텐츠 제공 계약(이하 '이용약관 등'이라 총칭)의 내용을 변경할 수 있습니다. 사용자가 본 서비스 이용시, 최신 이용약관에 동의한 것으로 간주합니다.
7.회원을 포함한 사용자는 본 서비스를 이용함에 있어 발생하는, 휴대전화를 포함한 정보통신기기 등에 의한 이메일 송수신 및 사이트 열람 기타 필요한 통신 비용 일체에 대해서 사용자 자신이 이를 부담합니다.
8.당사는 본 서비스 상의 콘텐츠, 이에 수반하는 태그 표기, 타이틀 또는 정보 (콘텐츠에 관한 저작권, 초상권, 퍼블리시티권 기타 재산권 표시를 포함함)의 정확성과 완전성을 보장할 수 없습니다. 본 서비스에 콘텐츠 및 정보를 제공하는 경우, 본 서비스 상의 콘텐츠를 구입하여 사용하는 경우, 사용자, 회원 및 크리에이터 회원은 모두 본 이용약관을 준수하고 본인의 책임으로 실시하는 것으로 합니다.

제 3조 서비스 이용시 금지 사항
1.본 서비스를 이용함에 있어서 모든 사용자는 다음의 행위를 해서는 안 됩니다. 
2.당사 또는 모든 제3자의 저작권 등 지적 재산권, 초상권, 프라이버시 권리, 명예 등의 기타 권리 또는 이익을 침해하는 행위 (본 서비스상의 콘텐츠 무단 사용, 타인이 권리를 보유하는 콘텐츠의 제공 등을 포함함)
3.본 서비스에 허위 또는 오류가 있는 정보를 입력하는 것
4.컴퓨터 바이러스, 리버스 엔지니어링 등 인터넷을 통한 위법행위 또는 폐를 끼치는 행위로 의해 본 서비스의 운영을 방해하는 것
5.회원 가입시 또는 로그인시에 허위의 정보를 입력하고, 권한없이 타인을 사칭하여 본 서비스를 이용하는 것
6.비방, 괴롭힘, 희롱, 협박 등의 행위를 당사 및 모든 제3자에게 하는 것
7.본 서비스에서 제공하는 상품 또는 서비스의 범위를 넘어서 다른 회원 등에게 광고, 권유, 영업, 기타 연락을 행하는 것
8.공서양속에 반하는 행위, 범죄 행위, 불법 행위
9.기타 당사가 부당하다고 판단하는 행위
                             </textarea>
                          </td>
                        </tr>
                       <tr>
			              <td>
			                <br><br>
			              </td>
			            </tr>
                            <tr>
                          <td>
                            <div>
                             <font color="#f67001" size=4>02</font> <font size=3>개인정보 수집 및 이용에 대한 안내</font>
                            </div>
                         </td>
                       </tr>
                       <tr>
                         <td>
                           <textarea style="width:100%;text-align:left; overflow:visible;text-overflow:ellipsis;" rows=10 readonly="readonly">
수집하는 개인정보의 항목
회사는 회원가입, 상담, 서비스 신청 및 제공 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.
- 이름, 이메일, 핸드폰 번호, 아이디, 비밀번호, 홈페이지 주소 또한 서비스 이용과정이나 사업
 처리 과정에서 아래와 같은 정보들이 생성되어 수집될 수 있습니다.
- 서비스 이용기록, 접속 로그, 쿠키, 접속 IP 정보, 방문일시, 브라우저종류 및 os, 검색어, 결제기록, 이용정지 기록

개인정보의 수집 및 이용목적

회사는 수집한 개인정보를 다음의 목적을 위해 활용합니다.
가. 서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산
콘텐츠 제공, 물품배송 또는 청구서 등 발송, 금융거래 본인 인증 및 금융 서비스, 구매 및 요금 결재, 요금추심

나. 회원 관리
회원제 서비스 이용에 따른 본인확인, 개인식별, 불량회원의 부정 이용 방지와 비인가 사용 방지, 가입 의사 확인, 가입 및 
가입횟수 제한, 만14세 미만 아동 개인정보 수집 시 법정 대리인 동의여부 확인, 추후 법정 대리인 본인확인, 분쟁 조정을 위한
 기록보존, 불만처리 등 민원처리, 고지사항 전달

개인정보의 보유/이용기간

이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기합니다.
단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.
가. 회사 내부 방침에 의한 정보보유 사유
- 부정이용기록
  보존 이유 : 부정 이용 방지
  보존 기간 : 1년

나. 관련법령에 의한 정보보유 사유
상법, 전자상거래 등에서의 소비자보호에 관한 법률 등 관계법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 관계법령에서 정한 일정한 기간 동안 회원정보를 보관합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.

- 계약 또는 청약철회 등에 관한 기록
  보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률
  보존 기간 : 5년
- 대금결제 및 재화 등의 공급에 관한 기록
  보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률
  보존 기간 : 5년
- 소비자의 불만 또는 분쟁처리에 관한 기록
  보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률
  보존 기간 : 3년
- 본인확인에 관한 기록
  보존 이유 : 정보통신 이용촉진 및 정보보호 등에 관한 법률
  보존 기간 : 6개월
- 방문에 관한 기록
  보존 이유 : 통신비밀보호법
  보존 기간 : 3개월

개인정보취급 위탁관련 / 개인정보제공 거부

가. 개인정보취급 위탁관련

- 개인정보취급위탁을 받는 자 : PICSION
- 개인정보취급위탁을 하는 업무의 내용 : 회원관리 회원제 서비스 이용에 따른 회원정보 관리 및 웹사이트 시스템 관리

나. 개인정보제공 거부에 관한 사항
- 귀하께서는 본 동의 안내 문구를 숙지하였으며, 안내문구에 대해 거절하실 수 있습니다. 단, 거절하신 경우에는 서비스 이용에 제한을 받을 수 있습니다.
                            </textarea>
                          </td>
                        </tr>
                      </table>
                    </div>
                </div>
      </div>
      <div class="modal-footer">
        <button type="button" id="iagree" class="btn btn-success btn-link" data-dismiss="modal">동의하기</button>
        <button type="button" class="btn btn-danger btn-link" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
  
  <script>
  	$(function(){
  		$('#agreeModal').modal();
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
  				success : function(data) {
  					console.log(data)
  					console.log(data.searchUser)
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
  			console.log($('#pwd').closest('.form-group'))
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
  			}else if(!$('input[name=agreecheck]').prop("checked")){
  				alert('이용약관에 동의해 주세요')
  				
  			}else if(idCheck && pwCheck && $('input[name=agreecheck]').prop("checked")){
	  			$('form').submit()
  			}
  		})
  		$(document).on('click','#iagree',function(){
  			$('input[name=agreecheck]').prop('checked',true);
		}) 
  		
  	})
  </script>