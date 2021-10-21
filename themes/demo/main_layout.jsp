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

	<script type="text/javascript" src="<c:out value='/js/jquery.bxslider.js'/>"></script>

	<script type="text/javascript">
	//<![CDATA[
	$(document).ready(function(){
		/*
		$('.visual_roll').bxSlider({
			auto: true,
			mode: 'fade',
			autoControls: true,
			speed:1000,
		});
		*/
		$('.PopupList').bxSlider({
			auto: true,
			mode: 'fade',
			autoControls: true,
			captions:true,
			speed:1000,
		});
		/*
		$('.news_roll').bxSlider({
			auto:false,
			autoControls:true,
			minSlides: 3,
			maxSlides: 3,
			moveSlides: 3,
			slideMargin: 17,
			pager:false
		});
		$('.banner_roll').bxSlider({
			auto:true,
			autoControls:true,
			slideWidth: 170,
			minSlides: 5,
			maxSlides: 5,
			moveSlides: 1,
			slideMargin: 10,
			pager:false
		});
		*/
	});
//]]>
	</script>
</head>
<body>
<div id="wrap">
	<div id="header">
		<%@include file="include/header.jsp"%>
	</div>
	<div id="body">
		<c:import url="${contentFile}" />
	</div>
	<div id="footer">
		<%@include file="include/footer.jsp"%>
	</div>
</div>
</body>
</html>
