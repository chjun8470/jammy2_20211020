<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>

<%@include file="/front/_item/main/i_header.jsp" %>
<div id="wrap">
	<%@include file="/front/_item/main/i_top.jsp" %>
	<div id="container">
		<div class="contents">
		<%if("sub".equals(display)) {%>
			<div class="lnb">
				<div class="title_box">
					<div class="title_sub_txt">COMPANY</div>
					<div class="title_txt">회사소개</div>
				</div>
				<div class="lnb_menu">
					<%@include file="/front/_item/main/i_left.jsp" %>
				</div>
			</div>
		<%} %>