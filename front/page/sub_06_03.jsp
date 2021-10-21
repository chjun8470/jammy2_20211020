<%@page import="egovframework.com.cmm.LoginVO"%>
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
	String deth2 = "3";
	
	ComUtil util = new ComUtil();
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String allData = util.getStr(paramMap.get("allData"));
	String manageIdx = util.getStr(paramMap.get("manageIdx"));

	if(!util.loginCheck()){
		response.sendRedirect("/sys/login.do");
	}
%>
<%@include file="/front/_temple/basic/t_top.jsp" %>

<div class="content_center">
	<div class="location">
		HOME > 회사소개 > 유지보수
	</div>
	<div class="conts_title">
		유지보수
	</div>
	<div class="conts">
		<jsp:include page="/m/manageList.do" flush="true">
		  	<jsp:param name="mode" value="<%=mode%>"/>
		  	<jsp:param name="nowPage" value="<%=nowPage %>"/>
		  	<jsp:param name="allData" value="<%=allData%>"/>
		  	<jsp:param name="manageIdx" value="<%=manageIdx%>"/>
		</jsp:include>
	</div>
</div>

<%@include file="/front/_temple/basic/t_footer.jsp" %>