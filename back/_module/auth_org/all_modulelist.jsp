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
	List<HashMap<String, String>> dataAuthList = request.getAttribute("dataAuthList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataAuthList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	int i = 0;
	for(HashMap rs:dataList) {
		i++;

		%>
		<div class="menuRows_1"  style="position:relative;">
			<input type="button" value="&lt;" class="btn_y_01" onclick="orgModuleAdd('<%=util.getStr(rs.get("MODULE_INFO_IDX"))%>')" style="position:absolute;top:20px;right:10px;width:30px;min-width:30px;z-index:8;"/>
			&nbsp;
			<label style="display:inline-block;width:100%;padding-left:5px;" >
			0<%=i %>. <%=util.getStr(rs.get("MB_NM"))%> <br/>(<%=util.getStr(rs.get("MODULE_INFO_IDX"))%>)
			</label>
		</div>
<%
	}


	if(i == 0	){
		%>
		<div style="border:1px solid #cccccc;margin:5px 0px;padding:0px 5px;">
			지정된 모듈 정보가 없습니다.
		</div>
		<%
	}
%>
