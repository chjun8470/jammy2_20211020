<%@page language="java" contentType="text/html; charset=UTF-8" 	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page	import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	request.setCharacterEncoding("UTF-8");
	ComUtil util = new ComUtil();
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

	List<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	List<HashMap<String, String>> dataSubList = request.getAttribute("dataSubList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataSubList");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");

	int i=0;
	for(HashMap rs:dataList) {
		i++;
	%>
	<div class="menuRows" >
		<div class="menuRows_1" onmouseover="menuOver(1,this)" onmouseout="menuOut(1,this)" onclick="authModuelShow('<%=util.getStr(rs.get("ORG_GRP_CD"))%>','<%=util.getStr(rs.get("ORG_GRP_NM"))%>')">
			<input type="hidden" id="orgNm_<%=i%>" value="<%=util.getStr(rs.get("ORG_GRP_NM"))%>" />
			<%=i%> . <%=util.getStr(rs.get("ORG_GRP_NM"))%>
		</div>

	</div>
	<%
		}
	%>