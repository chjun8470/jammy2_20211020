<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@include file="/back/_temple/basic/t_top.jsp" %>
<%

	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String nowPage = util.getStr(paramMap.get("nowPage"),"0");
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
%>
<div class="content_center">

		<jsp:include page="/sys/comBoard.do" flush="true">
		  	<jsp:param name="mode" value="<%=mode%>"/>
		  	<jsp:param name="nowPage" value="<%=nowPage %>"/>
		  	<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
		  	<jsp:param name="boardComIdx" value="00026"/>
		  	<jsp:param name="listMode" value="<%=listMode%>"/>
		</jsp:include>

</div>

<%@include file="/back/_temple/basic/t_footer.jsp" %>
