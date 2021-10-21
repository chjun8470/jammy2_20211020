<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>

<!DOCTYPE html>
<html lang="ko" >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>전남과학기술정보시스템</title>
	<%
	String useragent = request.getHeader("User-Agent");
	String signCheck = request.getParameter("mode") != null ? request.getParameter("mode"):"";
	System.out.println(signCheck);
	if(signCheck.equals("sign")){%>
			<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_tpl.css" />
			<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css" />
			<link href="/css/cms/jntptotal/layer.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/jntptotal/common.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/jntptotal/layout.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/jntptotal/contents.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/jntptotal/table-style.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/jntptotal/button.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/back/cont.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/back/main.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/back/base.css" rel="stylesheet" type="text/css"/>
	<%}else{ %>
			<link href="/css/cms/back/cont.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/back/main.css" rel="stylesheet" type="text/css"/>
			<link href="/css/cms/back/base.css" rel="stylesheet" type="text/css"/>

			<link rel="stylesheet" type="text/css" href="/css/cms/back/cms_sys.css" />
			<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
			<script type="text/javascript" src="/js/cms/back/func_sys.js"></script>
			<script type="text/javascript" src="/js/board.js"></script>
	<%} %>
		</head>
	<body>