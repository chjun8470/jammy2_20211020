<%@ page language="java" contentType="text/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*,java.io.*,java.lang.*,java.text.*,java.util.*,java.net.URL,javax.servlet.http.*"%>
<%@ page import="com.solbitech.common.web.*"%>
<%@ page import="com.activeintra.manager.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="org.apache.log4j.PropertyConfigurator"%>
<%
try{
	AIScriptManager aiscript = new AIScriptManager(request, response, pageContext, out, null, null);
	WebInfomation information = new WebInfomation(aiscript, request);
	information.getInitJsonMsg(out);
} catch(Exception e) {
	System.err.println("#manager exception...");
} finally { }
%>