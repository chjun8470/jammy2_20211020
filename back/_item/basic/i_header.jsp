<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>

<!DOCTYPE html>
<html lang="ko" >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>전남과학기술정보시스템</title>

		<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_tpl.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board_3.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />


		<!-- <link rel="stylesheet" type="text/css" href="/css/cms/back/contents.css" /> -->

		<!-- <link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board_2.css" /> -->
		<link href="/css/cms/sub.css" media="all" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="/js/cms/back/func_sys.js"></script>

		<script type="text/javascript" src="/js/cms/back/html2canvas.js"></script>

		<script type="text/javascript" src="/js/board.js"></script>
		<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js"></script>

		<!--그래프  -->
		<script src="http://code.highcharts.com/maps/highmaps.js"></script>
		<script src="https://code.highcharts.com/highcharts-3d.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>
		<script src="https://code.highcharts.com/modules/export-data.js"></script>

		<script src="https://cdn.jsdelivr.net/gh/egeriis/zipcelx/lib/standalone.js"></script>

		<!-- 날짜 선택 위젯 jQuery datepicker S -->
		<!-- jQuery UI CSS파일 -->
		<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
		<!-- jQuery UI 라이브러리 js파일 -->
		<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>
		<script type="text/javascript" src="/js/cms/jquery.mtz.monthpicker.js"></script>
		<!-- 날짜 선택 위젯 jQuery datepicker E -->

		<script src="/js/amcharts/amcharts.js" type="text/javascript"></script>
        <script src="/js/amcharts/serial.js" type="text/javascript"></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<% 
			String daumKey = "775c36174af77a7878a91ef218173921";//실서버 운영키
			if( request.getRequestURL().indexOf("221.144.12.3:12345") > 0 ){
				daumKey = "1950e0038e121d1163985ed2bae5c660";//localhost:8080 테스트키		
			}
		%>
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=daumKey %>&libraries=services" type="text/javascript"></script>
	</head>
<body>