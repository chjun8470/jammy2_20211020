<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>


<%if("1".equals(deth1)) {%>
		<ul>
			<li <%if("1".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_01_01.do" >인사말</a></li>
			<li <%if("2".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_01_02.do" >회사개요</a></li>
			<li <%if("3".equals(deth2)) {%>class='on'<%}%>><a href="/p/sub_01_03.do"  >경영이념</a></li>
			<li <%if("4".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_01_04.do" >연혁 및 실적</a></li>
			<li <%if("5".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_01_05.do" >조직도</a></li>
			<li <%if("6".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_01_06.do" >오시는길</a></li>
		</ul>
<%} else if("2".equals(deth1)) {%>
		<ul>
			<li <%if("1".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_02_01.do" >사업소개</a></li>
			<li <%if("2".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_02_02.do" >브랜드</a></li>
		</ul>
<%} else if("3".equals(deth1)) {%>
		<ul>
			<li <%if("1".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_03_01.do" >제품소개</a></li>
		</ul>
<%} else if("4".equals(deth1)) {%>
		<ul>
			<li <%if("1".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_04_01.do"  >생산시설</a></li>
			<li <%if("2".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_04_02.do" >가공라인</a></li>
		</ul>
<%} else if("5".equals(deth1)) {%>
		<ul>
			<li <%if("1".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_05_01.do" >특허 및 인증</a></li>
			<!-- <li <%if("2".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_05_02.do" >홍보영상</a></li> -->
		</ul>
<%} else if("6".equals(deth1)) {%>
		<ul>
			<li <%if("1".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_06_01.do" >공지사항</a></li>
			<li <%if("2".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_06_02.do"  >Q&amp;A</a></li>
			<li <%if("4".equals(deth2)) {%>class='on'<%}%> ><a href="/p/sub_06_04.do" >일정관리</a></li>
		</ul>
<%} else if("7".equals(deth1)) {%>
		<ul>
			<li <%if("1".equals(deth2)) {%>class='on'<%}%> ><a href="/p/login.do" >로그인</a></li>
		</ul>
<%} %>
