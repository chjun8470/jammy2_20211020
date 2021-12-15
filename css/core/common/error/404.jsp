<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="java.util.*" %>
<%@ page import="org.springframework.web.servlet.i18n.SessionLocaleResolver" %>
<%
	Locale locale = (Locale)request.getSession().getAttribute(SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title><spring:message code="error.404"/></title>
	<link rel="stylesheet" type="text/css" href="/core/css/error.css">   
</head>
<body>
	<div id="wrap">
		<div id="header">
		</div>
		<% if ("ko".equals(locale.toString().toLowerCase())) { %>
		<div id="container">
			<h2 class="title404">죄송합니다. 현재 찾을 수 없는 페이지를 요청하셨습니다.</h2>
			<p>존재하지 않는 주소를 입력하셨거나, <span class="newline">요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.</span></p>
			<p>궁금한 점 있으시다면 언제나 고객센터를 통해 문의해 주시기 바랍니다.</p>
			<p>감사합니다.</p>
		</div>
		<% } else {%>
		<div id="container">
			<h2 class="title404">404 Not Found</h2>
			<p>The Web server cannot find the file or script you asked for.<br />Please check the URL to ensure that the path is correct.</p>
			<p>Please contact the server's administrator if this problem persists.</p>
		</div>		
		<% } %>
		<div id="footer">copyright 2016 jammy cms all rights reserved.</div>
	</div>
</body>
</html>