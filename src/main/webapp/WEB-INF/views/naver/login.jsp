<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
	<div class="section section-signup page-header" style="background-image: url('<%=request.getContextPath()%>/assets/img/bg3.jpg');">
		<div style="margin: 30%">
			<div id="naver_id_login"></div>
		</div>
	</div>
	
<script type="text/javascript">
  	var naver_id_login = new naver_id_login("AavwsVovOeUd6Ijvt3W0", "http://127.0.0.1:8090/picsion/naver/login.ps");
  	var state = naver_id_login.getUniqState();
    naver_id_login.response_type="code"; 
  	naver_id_login.setButton("white", 3, 40);
  	naver_id_login.setDomain("http://127.0.0.1:8090/picsion/naverlogin.ps"); 
  	naver_id_login.setState(state);
  	naver_id_login.init_naver_id_login();
</script>