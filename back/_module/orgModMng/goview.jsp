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
	List<HashMap<String, String>> userGoList = request.getAttribute("userGoList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("userGoList");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
%>
	<input type="hidden" id="authUserGoIdx" value="<%=util.getStr(paramMap.get("reqUserIdx"))%>" />
	<input type="hidden" id="authUserGoOrgCd" value="<%=util.getStr(paramMap.get("orgGrpCd"))%>" />
	<input type="hidden" id="authUserGoOrgSubCd" value="<%=util.getStr(paramMap.get("orgGrpSubCd"))%>" />

	<%if(userGoList.size() == 0){%>
	<div style="border:1px solid #cccccc;margin:5px 0px;padding:0px 5px;">
		권한이 미부여된 회원 정보가 없습니다.
	</div>
	<%}else{%>

	<select class="select" name="searchAuthUserGo" id="searchAuthUserGo" style="width:193px; height:24px;">
		<%for(HashMap rs:userGoList) {%>
		<option value="<%=util.getStr(rs.get("USER_IDX"))%>"><%=util.getStr(rs.get("PSN_NM"))%>(<%=util.getStr(rs.get("USER_ID"))%>)</option>
		<%}%>
	</select>
	<input type="button" class="btn_inp_b_01" value="이관" onclick="authUserGo()">
	<%}%>
