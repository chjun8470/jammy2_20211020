<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	
	
%>

<% if(util.getStr(paramMap.get("mode")).equals("rssParser")){ %>
<script>
alert("<%=util.getStr(paramMap.get("dt"))%>일은 이미 등록한 일자입니다.");
location.href="./sys_rss_parser.do";
</script>
<% }else if(util.getStr(paramMap.get("mode")).equals("rssDel")){ %>
<script>
alert("삭제되었습니다.");
location.href="/sys/sys_rss_parser.do";
</script>
<% }else if(util.getStr(paramMap.get("mode")).equals("rssParserOk")){ %>
<script>
alert("등록되었습니다.");
location.href="/sys/sys_rss_parser.do";
</script>
<% }else{ %>
<script>
alert("등록되었습니다.");
location.href="./sys_rnd_team.do";
</script>
<% } %>