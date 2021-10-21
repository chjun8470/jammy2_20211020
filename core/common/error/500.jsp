<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
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
	<title><spring:message code="error.500"/></title>
	<link rel="stylesheet" type="text/css" href="/core/css/error.css">   
</head>
<body>
	<div id="wrap">
		<div id="header">
		</div>
		<% if ("ko".equals(locale.toString().toLowerCase())) { %>
		<div id="container">
			<h2 class="title500">죄송합니다. 내부 서버 오류가 발생하였습니다.</h2>
			<p>서버에 오류가 발생하여 요청을 완료할 수 없습니다.</p>
			<p><strong>에러 타입</strong> : <%= exception.getClass().getName() %><br /><strong>에러 메시지</strong> : <%= exception.getMessage() %></p>
			<p>문제가 계속되면  고객센터를 통해 문의해 주시기 바랍니다.</p>
			<p>감사합니다.</p>
		</div>
		<% } else {%>
		<div id="container">
			<h2 class="title500">Internal Server Error</h2>
			<p>The server encountered an internal error or misconfiguration and was unable to emplete your request</p>
			<p><strong>Error Type</strong> : <%= exception.getClass().getName() %><br /><strong>Error Message</strong> : <%= exception.getMessage() %></p>
			<p>Please contact the server's administrator if this problem persists.</p>
		</div>		
		<% } %>
		<div id="footer">copyright 2016 jammy cms all rights reserved.</div>
	</div>
</body>
</html>