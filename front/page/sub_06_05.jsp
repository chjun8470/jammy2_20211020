<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	String deth1 = "6";
	String deth2 = "5";

	ComUtil util = new ComUtil();
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String allData = util.getStr(paramMap.get("allData"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));

	System.out.println("sub_06_05 : "+mode);
%>
<%@include file="/front/_temple/basic/t_top.jsp" %>

<div class="content_center">
<!-- 	<div class="location">
		HOME > 회사소개 > 인사말
	</div>
	<div class="conts_title">
		인사말
	</div>
	<div class="conts"> -->

		<jsp:include page="/m/surveyPage.do" flush="true">
		  	<jsp:param name="mode" value="<%=mode%>"/>
		  	<jsp:param name="nowPage" value="<%=nowPage %>"/>
		  	<jsp:param name="searchType" value="<%=searchType %>"/>
		  	<jsp:param name="searchWord" value="<%=searchWord %>"/>
		  	<jsp:param name="allData" value="<%=allData%>"/>
		  	<jsp:param name="boardIdx" value="<%=boardIdx%>"/>
		</jsp:include>

	</div>
</div>

<%@include file="/front/_temple/basic/t_footer.jsp" %>
