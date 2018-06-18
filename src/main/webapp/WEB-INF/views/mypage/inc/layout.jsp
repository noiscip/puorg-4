<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
​
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
​
<html>
<head>
	<link href="<%=request.getContextPath()%>/images/picsionlogo.png" rel="icon" type="image/png">
	
	<meta charset="utf-8">
	<meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
	<title>PICSION</title>
	
	<!--   Fonts and icons   -->
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css">
  <!-- CSS Files -->
  <link href="<%=request.getContextPath()%>/assets/css/material-kit.min.css?v=2.0.3" rel="stylesheet" />
  <link href="<%=request.getContextPath()%>/assets/demo/vertical-nav.css" rel="stylesheet" />
  <!-- Js -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<!--  Core JS Files  -->
	<script src="<%=request.getContextPath()%>/assets/js/core/jquery.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/assets/js/core/popper.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/assets/js/core/bootstrap-material-design.min.js" type="text/javascript"></script>
	<!-- Plugin for Date Time Picker and Full Calendar Plugin -->
	<script src="<%=request.getContextPath()%>/assets/js/plugins/moment.min.js"></script>
	<!--	Plugin for the Datepicker, full documentation here: https://github.com/Eonasdan/bootstrap-datetimepicker -->
	<script src="<%=request.getContextPath()%>/assets/js/plugins/bootstrap-datetimepicker.js" type="text/javascript"></script>
	<!-- Plugin for the Sliders, full documentation here: http://refreshless.com/nouislider/ -->
	<script src="<%=request.getContextPath()%>/assets/js/plugins/nouislider.min.js" type="text/javascript"></script>
	<!-- Control Center for Now Ui Kit: parallax effects, scripts for the example pages etc -->
	<script src="<%=request.getContextPath()%>/assets/js/material-kit.js?v=2.0.1" type="text/javascript"></script>
	 <!--	Plugin for Select, full documentation here: https://silviomoreto.github.io/bootstrap-select -->
  <script src="<%=request.getContextPath()%>/assets/js/plugins/bootstrap-selectpicker.js"></script>
  <!--	Plugin for Tags, full documentation here: https://xoxco.com/projects/code/tagsinput/ -->
  <script src="<%=request.getContextPath()%>/assets/js/plugins/bootstrap-tagsinput.js"></script>
    <!--	Plugin for Small Gallery in Product Page -->
  <script src="<%=request.getContextPath()%>/assets/js/plugins/jquery.flexisel.js"></script>
  <!-- Plugins for presentation and navigation -->
  <script src="<%=request.getContextPath()%>/assets/demo/js/vertical-nav.js"></script>
  <!-- Fixed Sidebar Nav - js With initialisations -->
  <script src="<%=request.getContextPath()%>/assets/demo/js/material-kit-demo.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
	<!--	Plugin for Fileupload, full documentation here: https://www.jasny.net/bootstrap/javascript/#fileinput -->
  <script src="<%=request.getContextPath()%>/assets/js/plugins/jasny-bootstrap.min.js"></script>
</head>
​
<body class="profile-page sidebar-collapse">
	<!-- header -->
	<tiles:insertAttribute name="header" />
​
	<!-- content -->
	<div id="main">
		<tiles:insertAttribute name="content" />
	</div>
​
	<!-- footer -->
	<tiles:insertAttribute name="footer" />
​
​
</body>
</html>