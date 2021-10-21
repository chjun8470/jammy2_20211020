<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.util.CriptUtil"%>
<%
	request.setCharacterEncoding("UTF-8");
	ComUtil util = new ComUtil();
	CriptUtil ctuil = new CriptUtil();
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(request.getParameter("mode"));
	String m = util.getStr(request.getParameter("m"));
	String nowPage = util.getStr(request.getParameter("nowPage"),"0");//추가적으로 파라미터 를 추가해준다
%>
	<jsp:include page="/web/manageEvent.do" flush="true">
	<jsp:param name="mode" value="<%=mode%>"/>
	<jsp:param name="m" value="32"/>
	<jsp:param name="nowPage" value="<%=nowPage%>"/>
</jsp:include>