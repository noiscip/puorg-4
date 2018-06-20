<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Insert title here</title>
		  <style>
		  	  footer {
			  	  background-color:  #e5faf5;
			  }
			  footer a{
			  	  color : #3e9c9d
			  }		
			  footer p{
			  	  color : #3e9c9d;
			  	  margin : 0px 0px 0px 0px;
			  }		
  
		  </style>
		  <script type="text/javascript">
		  //top으로ws
		  
			$(document).ready(function() {

				if($('#loginUserNo').val()!= ""){
					connect() 
					console.log($('#loginUserNo').val())
				}
				
			});
			
		  	var wsocket
		  
			function connect(){
			 	/* wsocket = new WebSocket("ws://13.124.171.244:8080/picsion/message.ps") //ec2등록 용도 */
			 	
			 	wsocket = new WebSocket("ws://192.168.0.21:8090/picsion/message.ps") //테스트 용도 
			 	wsocket.onopen = onOpen
			 	wsocket.onmessage = onMessage
			}
		  	function onOpen(evt) {
				console.log("여기는 오픈 이벤트")
			}
		  	function onMessage(evt){
		  		console.log("onMessage 실행")
				var table = evt.data.split(':')[2]
				var newMessage = '<img id="newNotice" src="https://png.icons8.com/doodle/50/000000/new.png">'
				var url = "";

				if(table == 1){
					console.log("1번, 유저 ")
				}else if (table == 2){
					console.log("2번, 사진")
				}else if(table == 3	){
					console.log("3번, 보드")
					url = "/picsion/notice/noticeComment.ps"
				}else if(table == 4){
					console.log("4번, 댓글")
					url = "/picsion/notice/noticeMsg.ps"
				}else if(table == 5){
					console.log("5번, 메시지")
				}else if(table == 6){
					console.log("6번, 작업 수락")
				}
				
				$.ajax({
					url:url,
					async: false,
					success: function (data) {
						if (data.count > 0 && $('#newNotice').length == 0){
							$('#userProfile').append(newMessage)
						}
					}
				})
				
		 	}
		  	function onClose(evt) {
			  console.log("여기는 클로즈 이벤트")
			}
		  
		  function send(receiveUser,tableNo) {
			  	console.log("send오긴해?")
			  	var loginUser = $('#loginUserNo').val()
			  
		        wsocket.send(loginUser+":"+receiveUser+":4");
		    }
		  
		  //top으로
		  function topFunction() {
			    document.body.scrollTop = 0;
			    document.documentElement.scrollTop = 0;
			}
		  </script>
	</head>
		
	<body>
	<!-- footer -->
	
		<footer class="text-center">
<!-- 			<form action="amazontest.ps" enctype="multipart/form-data" method="post">
				
				<input type="file" name="filePath">
				
				<input type="submit" class="btn btn-primary btn-round" value="보내기">
			</form> -->
		  <a title="Go to top" onclick="topFunction()">
		   <i class="fas fa-angle-up fa-2x"></i>
		  </a><br><br>
		  <p>CSS ⓒ DB</p> 
		</footer>
	</body>
</html>