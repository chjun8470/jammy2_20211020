<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>

<%
	String btn_bg_1 = "";
	String btn_bg_2 = "";

	if(tmenu.equals("2")){
		btn_bg_1 = "";
		btn_bg_2 = "menuOn";
	}else{
		btn_bg_1 = "menuOn";
		btn_bg_2 = "";
	}
%>


	<!-- Logo  -->
    <div class="header_rfsh">
	<div class="top_logo" >
		<a href="/sys/main.do">
			<img src="/img/common/logo_main.png" alt="전남과학기술센터" />
		</a>
	</div>


	<!-- Tap  -->
	<div class="top_menu">
	<%if(util.getInt(loginVO.getAuthLv()) == 99){%>
        <div class="menu_lft" style="float:left;display:block;height:48px;line-height:48px; text-align:center;">
        	<a href="/cms/admin/login.do" style="font-size:20px;">CMS</a>
        </div>
	<%} %>
	<%if(util.getInt(loginVO.getAuthLv()) >= 80){%>
		<div class="menu <%=btn_bg_1 %>" style="float:left;display:block;height:48px;line-height:48px; text-align:center; ">
        	<a href="/sys/main.do?tmenu=1" style="font-size:20px;">통합 PMS</a>
        </div>
	<%} %>
	<%if(util.getInt(loginVO.getAuthLv()) >= 70){%>
        <div class="menu_rgt <%=btn_bg_2 %>" style="float:left;display:block;height:48px;line-height:48px; text-align:center;">
        	<a href="/sys/main.do?tmenu=2" style="font-size:20px;">기관 PMS</a>
        </div>
	<%} %>
    </div>


</div>
