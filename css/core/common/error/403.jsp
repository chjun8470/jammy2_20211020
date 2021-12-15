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
	<title><spring:message code="error.403"/></title>
	<link rel="stylesheet" type="text/css" href="/core/css/error.css">   
</head>
<body>
	<div id="wrap">
		<div id="header">
		</div>
		<% if ("ko".equals(locale.toString().toLowerCase())) { %>
		<div id="container">
			<h2 class="title403">죄송합니다. 요청하신 페이지 접근이 거부되었습니다.</h2>
			<p>페이지를 사용할 수 없거나, <span class="newline">페이지를 열 수 있는 권한을 가지고 있지 않습니다.</span></p>
			<p>필요한 자격 정보는 관리자에게 문의 하십시요.</p>
			<p>감사합니다.</p>
		</div>
		<% } else {%>
		<div id="container">
			<h2 class="title404">Access denied</h2>
			<p>The page may not be available or you might not have permission to open the page.</p>
			<p>Please contact your administrator for the required credentials.</p>
		</div>		
		<% } %>
		<div id="footer">copyright 2016 jammy cms all rights reserved.</div>
	</div>
</body>
</html>