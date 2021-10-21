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
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	int i = 0;
	for(HashMap rs:dataList) {
		i++;

		String sellist = ""; 	String seledit = ""; 	String seldel = ""; String selwrite = "";
		String selcmt = ""; 	String selreplay = "";
		String delValue = "";
		for(HashMap authRs:dataAuthList) {
			//System.out.println( util.getStr(authRs.get("MODULE_INFO_IDX")) );
			//System.out.println( util.getStr(rs.get("MODULE_INFO_IDX")) );
			if(util.getStr(authRs.get("MODULE_INFO_IDX")).equals(util.getStr(rs.get("MODULE_INFO_IDX")))){
				if(util.getStr(authRs.get("AUTH_LIST"),"N").equals("Y")) sellist = " checked='checked' ";
				if(util.getStr(authRs.get("AUTH_WRITE"),"N").equals("Y")) selwrite = " checked='checked' ";
				if(util.getStr(authRs.get("AUTH_EDIT"),"N").equals("Y")) seledit = " checked='checked' ";
				delValue = util.getStr(authRs.get("AUTH_DEL"),"N");
				if(util.getStr(authRs.get("AUTH_DEL"),"N").equals("Y")) seldel = " checked='checked' ";
				if(util.getStr(authRs.get("AUTH_CMT"),"N").equals("Y")) selcmt = " checked='checked' ";
				if(util.getStr(authRs.get("AUTH_REPLY"),"N").equals("Y")) selreplay = " checked='checked' ";
			}
		}

		%>
		<div style="border:1px solid #cccccc;margin:5px 0px;">
			<div style="border-bottom:1px solid #cccccc;padding:0px 5px;">
			<%=i %>. <%=util.getStr(rs.get("MB_NM"))%> (<%=util.getStr(rs.get("MODULE_INFO_IDX"))%>)
			</div>
			<div style="padding:0px 5px;">
				<input type="hidden" name="auth_md_info_idx" value="<%=util.getStr(rs.get("MODULE_INFO_IDX"))%>" />
				<input type="checkbox" value="Y" class="all_check_box" name="auth_md_list" id="auth_md_list_<%=i %>" <%=sellist %> />&nbsp;<label for="auth_md_list_<%=i %>">목록</label>&nbsp;&nbsp;&nbsp;
				<input type="checkbox" value="Y" class="all_check_box" name="auth_md_write" id="auth_md_write_<%=i %>" <%=selwrite %> />&nbsp;<label for="auth_md_write_<%=i %>">등록</label>&nbsp;&nbsp;&nbsp;
				<input type="checkbox" value="Y" class="all_check_box" name="auth_md_edit" id="auth_md_edit_<%=i %>" <%=seledit %> />&nbsp;<label for="auth_md_edit_<%=i %>">수정</label>&nbsp;&nbsp;&nbsp;
				<% if( loginVO.getAuthLv() == "99"){ %>
					<input type="checkbox" value="Y" class="all_check_box" name="auth_md_del" id="auth_md_del_<%=i %>" <%=seldel %> />&nbsp;<label for="auth_md_del_<%=i %>">삭제</label>
				<% }else{ %>
					<input type="hidden" value="<%=delValue%>" name="auth_md_del" id="auth_md_del_<%=i %>" />
				<% } %>
			</div>
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
