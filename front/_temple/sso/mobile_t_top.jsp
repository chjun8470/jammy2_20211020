<%@page import="info.elsys.jnsp.util.CriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>


<%@include file="/front/_item/sso/i_header.jsp" %>
<!--Wrap S-->
<div class="MyPageWrap">
	
		<!--MPTop s-->
	<div class="MPTop">
	<%if("mjeinet".equals(siteId) || "221".equals(siteId)){ %>
		<%@include file="/front/_item/sso/i_top_m.jsp" %>
	<% }else{ %>
		<%@include file="/front/_item/sso/i_top.jsp" %>
	<% } %>
	</div>
	<!--MPTop e-->

		<%if(!"login".equals(pageMode) && !"join".equals(pageMode) && !"idpwd".equals(pageMode)) {%>
			<!--MPLNB s-->
			<div class="MPLNB">
					<%@include file="/front/_item/sso/i_left.jsp" %>
			</div>
			<!--MPLNB e-->
		<%} %>

		<%if("login".equals(pageMode)) {%>
			<!--loginWrap S-->
			<div class="MyPageWrap_login">
			<div class="popWrap">
		<%}else if("idpwd".equals(pageMode) ) {%>
			<!--loginWrap S-->
			<div class="MyPageWrap_login">
			<div class="popWrap">
		<%}else if("join".equals(pageMode) ) {%>
			<!--agreeWrap S-->
			<div class="agreeWrap">
		<%} else{%>
			<!--MPCont 전체 화면 되야함s-->
			<div class="MPCont">
		<%} %>


