<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%-- <%@page import="info.elsys.cms.front.vo.StaticVO"%> --%>
<%-- <%@include file="/back/_temple/basic/t_top.jsp" %> --%>
<%@include file="/back/_item/basic/i_header.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
 	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
 	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("dataMap");
	String listMode = paramMap.get("listMode");
	String nowPage = paramMap.get("nowPage");
	String mode = "/web/popup/"+listMode+".do";
	
%>

	<jsp:include page="<%=mode%>" flush="true">
	  	<jsp:param name="listMode" value="<%=listMode%>"/>
	</jsp:include>


