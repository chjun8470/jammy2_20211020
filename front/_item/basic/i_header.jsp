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
	<title>전남연구장비정보망</title>

		<link rel="stylesheet" type="text/css" href="/css/cms/front/basic_tpl.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/front/basic_grid.css" />

		<!-- <link rel="stylesheet" type="text/css" href="/css/cms/back/contents.css" /> -->

		<!-- <link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board_2.css" /> -->

		<script type="text/javascript" src="/js/cms/front/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="/js/cms/front/func_web.js"></script>
		<script type="text/javascript" src="/js/board.js"></script>
		<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js"></script>


		<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
		<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>


		<script src="/js/amcharts/amcharts.js" type="text/javascript"></script>
        <script src="/js/amcharts/serial.js" type="text/javascript"></script>

		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js" type="text/javascript"></script>
		<script src="//apis.daum.net/maps/maps3.js?apikey=09cdede77b4c4027e119e58c73d4e495&amp;libraries=services" type="text/javascript"></script>
	</head>
<body>