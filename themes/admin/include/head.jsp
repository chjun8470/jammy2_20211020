<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js" lang="ko">
<head>
	<title><c:out value='${title}' /></title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	
	<link href="<c:out value='${LAYOUT_PATH}/css/styles.css' />" rel="stylesheet" type="text/css" id="theme"/>
	<!--[if lt IE 10]><link rel="stylesheet" type="text/css" href="<c:out value='${LAYOUT_PATH}/css/ie.css' />"/><![endif]-->
	
	<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/jquery/jquery.min.js' />"></script>
	<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/jquery/jquery-ui.min.js' />"></script>
	<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/bootstrap/bootstrap.min.js' />"></script>
	<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js' />"></script>
	
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery-validation/jquery.validate.min.js' />"></script>
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery-validation/localization/messages_ko.min.js' />"></script>
		
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/sys.js' />"></script>
	
	<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/actions.js' />"></script>        
</head>