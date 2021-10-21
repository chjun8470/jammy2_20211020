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
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String tap = util.getStr(paramMap.get("tap"));
	
	if(tap == null || tap.equals("null")){
		tap = "1" ;
	}
	int i=0;
	for(HashMap rs:dataList) {
		i++;
%>

<div style="text-align:left;">
	<input type="button" class="btn_inp_w_01" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'" style="float:left;width:194px;height:35px;" value="<%=util.getStr(rs.get("ORG_GRP_NM"))%>" onclick="avgShow('<%=util.getStr(rs.get("ORG_GRP_CD"))%>')"/>
</div>
<%
	}
%>
