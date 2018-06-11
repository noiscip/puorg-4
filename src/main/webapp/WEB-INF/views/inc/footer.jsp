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
				$('#sendBtn').click(function() { send(); });
				connect();
				
			});
			
		  	var wsocket;
		  
			function connect(){
			 	wsocket = new WebSocket("ws://localhost:8090/picsion/message.ps");
			 	wsocket.onmessage = onMessage;
			}
		  	function onOpen(evt) {
				console.log("여기는 오픈 이벤트")
			}
		  	function onMessage(evt){
				var data = evt.data;
				console.log("-------")
				console.log(evt);
				console.log("-------")
				console.log(data);
				console.log("하하하하하하하하하")
		 	}
		  	function onClose(evt) {
			  console.log("여기는 클로즈 이벤트")
			}
		  
		  function send() {
		        var nickname = "닉네임?"
		        var msg = "메시지이?";
		        wsocket.send("msg:"+nickname+":"+msg);
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
	<input type="hidden" value="${sessionScope.user}">
	<button class="btn btn-primary btn-round" id="sendBtn">sendBtn</button>
		<footer class="text-center">
			<form action="amazontest.ps" enctype="multipart/form-data" method="post">
				
				<input type="file" name="filePath">
				
				<input type="submit" class="btn btn-primary btn-round" value="보내기">
			</form>
		  <a title="Go to top" onclick="topFunction()">
		   <i class="fas fa-angle-up fa-2x"></i>
		  </a><br><br>
		  <p>CSS ⓒ DB</p> 
		</footer>
	</body>
</html>