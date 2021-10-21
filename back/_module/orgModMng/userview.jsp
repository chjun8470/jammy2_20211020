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
	int i = 0;
	for(HashMap rs:dataList) {
		i++;
		%>
			<div class="menuRows_1"  onmouseover="menuOver(1,this)" onmouseout="menuOut(1,this)" style="position:relative;">
				<input type="button" value="&gt;" class="btn_y_01" onclick="authOrgDel('<%=util.getStr(rs.get("USER_IDX"))%>')" style="position:absolute;top:20px;right:10px;width:30px;min-width:30px;z-index:8;" />
				&nbsp;
				<label style="position:relative;display:inline-block;width:100%;left:5px;" onclick="subOrgAuthShow('user','<%=util.getStr(rs.get("USER_IDX"))%>' ,'<%=util.getStr(rs.get("PSN_NM"))%>','<%=util.getStr(rs.get("USER_ID"))%>',
				'<%=util.getStr(rs.get("POSITION_NM")) %>', '<%=util.getStr(rs.get("DEPT_NM")) %>', '<%=util.getStr(rs.get("TEL_NO")) %>', '<%=util.getStr(rs.get("EMAIL")) %>')">
					<%=util.getStr(rs.get("PSN_NM"))%>
					<br/>
					(<%=util.getStr(rs.get("USER_ID"))%>)
				</label>
			</div>
		<%
	}


	if(i == 0	){
		%>
		<div class="menuRows_1" style="text-align:center;">
			정보가 없습니다.
		</div>
		<%
	}
%>
