<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ include file="/back/_temple/basic/t_top.jsp" %>
<%
	String searchMain = util.getStr(paramMap.get("searchMain"));
	String searchSub = util.getStr(paramMap.get("searchSub"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
%>
<div class="content_center">

		<jsp:include page="/sys/smbRndTeamExcel.do" flush="true">
		  	<jsp:param name="searchMain" value="<%=searchMain %>"/>
		  	<jsp:param name="searchSub" value="<%=searchSub %>"/>
		  	<jsp:param name="searchType" value="<%=searchType %>"/>
		  	<jsp:param name="searchWord" value="<%=searchWord %>"/>
		</jsp:include>

</div>

<%@include file="/back/_temple/basic/t_footer.jsp" %>