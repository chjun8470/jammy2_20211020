<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.util.*,java.net.URL,javax.servlet.http.*"%>
<%@ page import="com.solbitech.common.web.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="jsStyle/managerWeb.css" />
<script src="jsStyle/jquery-1.11.3.min.js"></script>
<script src="jsStyle/managerWeb.js"></script>
</head>
<body style="background: #2f2e2c;">
<%
try {
	WebManager manager = new WebManager(request, pageContext, session);
	manager.getServerIn(out);
} catch (Exception e) {
	System.err.println("#manager exception...");
} finally { }
%>
</body>
</html>