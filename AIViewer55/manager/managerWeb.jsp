<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.util.*,java.net.URL,javax.servlet.http.*"%>
<%@ page import="com.solbitech.common.web.*"%>
<%@ page import="com.activeintra.manager.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.apache.log4j.PropertyConfigurator"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>AIReport Manager</title>
<link rel="stylesheet" type="text/css" href="jsStyle/managerWeb.css"/>
<script src="jsStyle/jquery-1.11.3.min.js"></script>
</head>
<body>
<%
try{
	AIScriptManager aiscript = new AIScriptManager(request, response, pageContext, out, null, null);
	WebManager manager = new WebManager(request, response, aiscript, pageContext, session);
	manager.getDrowWeb(out);
} catch(Exception e) {
	System.err.println("#manager exception...");
}
%>
<script src="jsStyle/managerWeb.js"></script>
</body>
</html>