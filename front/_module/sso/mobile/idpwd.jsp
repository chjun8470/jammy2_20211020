<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>

<%

//ComUtil util = new ComUtil();
//String reUrl = "";

String send = util.getStr(paramMap.get("send"));
String view = util.getStr(paramMap.get("view"));
String enc = util.getStr(paramMap.get("enc"));

%>



			<jsp:include page="/sso/find.do" flush="true">
		  		<jsp:param name="mode" value="<%=mode%>"/>
		  		<jsp:param name="send" value="<%=send%>"/>		  		
			</jsp:include>
