<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>전남연구장비정보망</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=Edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0"/>
<meta http-equiv="imagetoolbar" content="no"/>
<meta name="keywords" content=""/>
<meta name="description" content=""/>

<link href="/css/cms/front/board.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/board_3.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/base.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/my_page.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/media_960.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/media_480.css" media="all" rel="stylesheet" type="text/css" />
<link href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" media="all" rel="stylesheet" type="text/css" />
<!-- <link href="/css/cms/front/base.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/my_page.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/my_page2.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/media_960.css" media="all" rel="stylesheet" type="text/css" />
<link href="/css/cms/front/media_480.css" media="all" rel="stylesheet" type="text/css" /> -->

		<script type="text/javascript" src="/js/cms/front/jquery-1.11.1.min.js"></script>
		<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
		<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>

		<script type="text/javascript" src="/js/cms/front/func_web.js"></script>
		<script type="text/javascript" src="/js/board.js"></script>
		<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js"></script>
		<script type="text/javascript" src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
		<!-- 날짜 선택 위젯 jQuery datepicker S -->
		<!-- jQuery UI CSS파일 -->
		<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
		<!-- jQuery UI 라이브러리 js파일 -->
		<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>
		<!-- 날짜 선택 위젯 jQuery datepicker E -->


		<link rel="stylesheet" type="text/css" href="/css/cms/front/sso_grid.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />


		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js" type="text/javascript"></script>
		
		
		<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=775c36174af77a7878a91ef218173921&amp;libraries=services" type="text/javascript"></script>
		
		<link href="/css/cms/front/login.css" media="all" rel="stylesheet" type="text/css" />
</head>
<body>