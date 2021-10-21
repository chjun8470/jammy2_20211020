<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
		String agree1 = util.getStr(paramMap.get("agree1"));
		String agree2 = util.getStr(paramMap.get("agree2"));
		String userTp = util.getStr(paramMap.get("userTp"));
		String certiState = util.getStr(paramMap.get("certiState"));
%>

	<%if(("Y".equals(agree1) && "Y".equals(agree2)) || (certiState.equals("Y"))) {%>
		<%@include file="/front/_module/sso/mobile/join_step2.jsp" %>
	<%}else {%>
		<%@include file="/front/_module/sso/mobile/join_step1.jsp" %>
	<%}%>