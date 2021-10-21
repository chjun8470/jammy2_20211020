<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
String deth1 = "1";
String deth2 = "5";
	request.setCharacterEncoding("utf-8");
/*
	TourDtlVO rs = request.getAttribute("dataMap") == null ? new  TourDtlVO() : (TourDtlVO)request.getAttribute("dataMap");
	TourVO tourVO = request.getAttribute("tourVO") == null ? new  TourVO() : (TourVO)request.getAttribute("tourVO");
	HashMap<String,Object> comMap = request.getAttribute("comMap") == null ? null : (HashMap<String,Object>)request.getAttribute("comMap");
	*/
%>
<%@include file="/front/_temple/basic/t_top.jsp" %>

<div class="content_center">
	<div class="location">
		HOME > 회사소개 > 인사말
	</div>
	<div class="conts_title">
		인사말
	</div>
	<div class="conts">
		<img src="/imgs/sub/04.jpg" />
	</div>
</div>

<%@include file="/front/_temple/basic/t_footer.jsp" %>