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

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));

// 	String msg = util.getStr(paramMap.get("msg"));
	String reUrl = util.getStr(paramMap.get("reUrl"));

	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String rndEquIdx = util.getStr(paramMap.get("rndEquIdx"));
	String equGoodsIdx = util.getIntStr(paramMap.get("equGoodsIdx"));
	String equipCd = util.getIntStr(paramMap.get("equipCd"));
	String state = util.getStr(paramMap.get("state"));
	String reject = util.getStr(paramMap.get("reject"));
	String authLv = util.getStr(paramMap.get("authLv"));
	
	String msg = util.getStr(paramMap.get("msg"),"정상적으로 처리되었습니다.");
	if("popCloseReload".equals(util.getStr(paramMap.get("reUrl")))){
%>
<script type="text/javascript">
	<%if(!"no".equals(msg)){%>
		alert(	'<%=msg%>');
	<%}%>
	try{
		opener.location.reload();
	}catch(e){
	}
	window.close();
</script>
<%
	}else{
%>
<script type="text/javascript">
	<%if(!"no".equals(msg)){%>
		alert(	'<%=msg%>');
	<%}%>
	<%if("6".equals(paramMap.get("searchState"))){%>
		location.href='<%=util.getStr(paramMap.get("reUrl"))%>?searchState=<%=util.getStr(paramMap.get("searchState"))%>';
	<%}else{%>
		<% if(util.getStr(paramMap.get("xt")).equals("1")){ %>	
		location.href='<%=util.getStr(paramMap.get("reUrl"))%>?mode=view&userIdx=<%=util.getStr(paramMap.get("userIdx"))%>';
		<% }else{ %>
		location.href='<%=util.getStr(paramMap.get("reUrl"))%>';
		<% } %>
	<%}%>
</script>
<%}%>