<%@page import="info.elsys.jnsp.util.CriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%
request.setCharacterEncoding("UTF-8");

ComUtil util = new ComUtil();
CriptUtil ctuil = new CriptUtil();
LoginVO loginVO = util.getLoginInfo(request); //세션정보 가져오기

String menuPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

HashMap menuMap = new HashMap();
// menuMap.put("web_jnsptotal.do", "deth=|1||1|");
// menuMap.put("web_jnsptotalReg.do", "deth=|1||2|");
// menuMap.put("web_jnsptotalRscReg.do", "deth=|1||3|");
// menuMap.put("web_useredit.do", "deth=|2||1|");

menuMap.put("web_myPage.do", "deth=|1||1|");
menuMap.put("web changeOrg.do", "deth=|1||2|");

HashMap dethMap = util.getDeth(menuMap,menuPage);
String menu1 = util.getStr(dethMap.get("deth1"));
String menu2 = util.getStr(dethMap.get("deth2"));

%>
<%@include file="/front/_item/basic/i_header.jsp" %>

<div id="wrap">

	<div id="header">
		<%@include file="/front/_item/basic/i_top.jsp" %>
	</div>
	<div id="container">

		<%@include file="/front/_item/basic/i_left.jsp" %>

		<div class="contents">
			<%@include file="/front/_item/basic/i_localbar.jsp" %>
			<div class="contents_box">
