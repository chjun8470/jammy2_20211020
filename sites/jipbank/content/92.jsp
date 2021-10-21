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
	String nowPage = util.getStr(request.getParameter("nowPage"),"0");//추가적으로 파라미터 를 추가해준다
	String avg = util.getStr(request.getParameter("avg"));
	if(avg.equals("")){
		avg = "기관별";
	}
%>

	<jsp:include page="/web/avgJipPower.do" flush="true">
		<jsp:param name="mode" value="<%=mode%>"/>
		<jsp:param name="m" value="92"/>
		<jsp:param name="nowPage" value="<%=nowPage%>"/>
		<jsp:param name="avg" value="<%=avg%>"/>
	</jsp:include>