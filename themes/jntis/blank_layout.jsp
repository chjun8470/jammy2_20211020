<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="include/func.jsp"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title><c:out value='${title}'/></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/bootstrap.min.css'/>" media="screen">
	<link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/font-awesome.min.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/main.css'/>" />
	<c:forEach var="css" items="${cssList}">
	<link rel="stylesheet" type="text/css" href="<c:out value='${css}'/>">
	</c:forEach>
	<!--[if lt IE 9]>
	<script src="<c:out value='${LAYOUT_PATH}/js/html5shiv.js'/>"></script>
	<script src="<c:out value='${LAYOUT_PATH}/js/respond.min.js'/>"></script>
	<![endif]-->	
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery-ui.min.js'/>"></script>
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/sys.js'/>"></script>	
	<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/bootstrap.min.js'/>"></script>
	<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/common.js'/>"></script>
	<c:forEach var="js" items="${jsList}">
	<script type="text/javascript" src="<c:out value='${js}'/>"></script>
	</c:forEach>
</head>
<body>
<c:import url="${contentFile}" />
</body>
</html>
