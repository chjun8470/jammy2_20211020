<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

	<title><c:out value='${title}'/></title>
	<link rel="stylesheet" type="text/css" href="<c:out value='${CORE_PATH}/css/bootstrap.min.css?3.3.5'/>" media="screen" />
	<c:forEach var="css" items="${cssList}">
	<link rel="stylesheet" type="text/css" href="<c:out value='${css}'/>" />
	</c:forEach>
	<!--[if lt IE 9]>
	<script src="<c:out value='${CORE_PATH}/js/html5shiv.js'/>"></script>
	<script src="<c:out value='${CORE_PATH}/js/respond.min.js'/>"></script>
	<![endif]-->	
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery.min.js'/>"></script>
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/jquery-ui.min.js'/>"></script>
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/sys.js'/>"></script>
	<script type="text/javascript" src="<c:out value='${CORE_PATH}/js/bootstrap.min.js?3.3.5'/>"></script>	
	
	<link href="/css/cms/front/base.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/board.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/board_3.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/common.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/sub.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/content.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/media_960.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/media_480.css" media="all" rel="stylesheet" type="text/css" />
	<link href="/css/cms/front/cont.css" media="all" rel="stylesheet" type="text/css" />
	
	<c:forEach var="js" items="${jsList}">
	<script type="text/javascript" src="<c:out value='${js}'/>"></script>
	</c:forEach>
</head>
<body>
<c:import url="${contentFile}" />
</body>
</html>