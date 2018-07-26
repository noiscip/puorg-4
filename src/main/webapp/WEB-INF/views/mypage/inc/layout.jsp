<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<tiles:insertAttribute name="script"/>
</head>

<body oncontextmenu="return false" ondragstart="return false" onselectstart="return false" class="profile-page sidebar-collapse">
	<!-- header -->
	<tiles:insertAttribute name="header" />

	<!-- content -->
	<tiles:insertAttribute name="content" />

	<!-- footer -->
	<tiles:insertAttribute name="footer" />

</body>
</html>