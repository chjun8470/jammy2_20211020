<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page language="java" import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.util.*,java.net.URL.*,java.net.URLEncoder" %>
<%@ page import="com.solbitech.common.web.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ManagerLogin</title>
<link rel="stylesheet" type="text/css" href="jsStyle/managerWeb.css"/>
<script src="jsStyle/placeholders.min.js"></script>
<script src="jsStyle/jquery-1.11.3.min.js"></script>
<script src="jsStyle/managerWeb.js"></script>
</head>
<body onload="document.manager.managerId.focus();">
<%
try {
	WebLoginSession webSession = new WebLoginSession(request, response, pageContext, session);
	webSession.setLoginView(out);
} catch (Exception e) {
	System.err.println("#manager exception...");
} finally { }
%>
</body>
</html>