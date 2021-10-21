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
		<div class="menuRows_1" onmouseover="menuOver(1,this)" onmouseout="menuOut(1,this)" onclick="orgGrpShow('GRP','<%=util.getStr(rs.get("ORG_GRP_CD"))%>','<%=util.getStr(rs.get("ORG_GRP_CD"))%>','<%=i %>','N')">
			<input type="hidden" id="orgNm_<%=i%>" value="<%=util.getStr(rs.get("ORG_GRP_NM"))%>" />
			<%=i%> .
			<%if(util.getStr(rs.get("ORG_GRP_SUB_NM")).length() <= 12) { %>
				<a href="javascript:void(0)"><%=util.getStr(rs.get("ORG_GRP_NM")) %></a>
			<% } else { %>
				<a href="javascript:void(0)" title="<%=util.getStr(rs.get("ORG_GRP_NM")) %>"><%=util.getStr(rs.get("ORG_GRP_NM")).substring(0, 12) %>...</a>
			<% } %>
			<span style="float:right;">
				<input class="btn_b_01" type="button" style="min-width:40px;width:40px;height:20px;" id="menuInstBtn" value="추가" onclick="subOrgShow(event,'<%=util.getStr(rs.get("ORG_GRP_NM"))%>','<%=util.getStr(rs.get("ORG_GRP_CD"))%>','<%=util.getStr(rs.get("ADDR1"))%>','<%=util.getStr(rs.get("ADDR2"))%>','<%=util.getStr(rs.get("ZIPCODE"))%>')"/>
			</span>
		</div>

		<%
		int j=0;
		for(HashMap rsSub:dataSubList) {
			if(util.getStr(rs.get("ORG_GRP_NM")).equals(util.getStr(rsSub.get("ORG_GRP_NM")))){
				j++;
				%>
				<div class='menuRows_2' onmouseover='menuOver(2,this)' onmouseout='menuOut(2,this)' onclick="orgGrpShow('SUBGRP','<%=util.getStr(rs.get("ORG_GRP_CD"))%>','<%=util.getStr(rsSub.get("ORG_GRP_SUB_CD"))%>','<%=i%>','<%=j%>')">
				&nbsp;&nbsp;&nbsp;&nbsp;<%=i %>_<%=j %> .
				<%if(util.getStr(rsSub.get("ORG_GRP_SUB_NM")).length() <= 10) { %>
					<a href="javascript:void(0)"><%=util.getStr(rsSub.get("ORG_GRP_SUB_NM")) %></a>
				<% } else { %>
					<a href="javascript:void(0)" title="<%=util.getStr(rsSub.get("ORG_GRP_SUB_NM")) %>"><%=util.getStr(rsSub.get("ORG_GRP_SUB_NM")).substring(0, 10) %>...</a>
				<% } %>
				<input type="hidden" id="orgNm_<%=i %>_<%=j %>" value="<%=util.getStr(rsSub.get("ORG_GRP_SUB_NM"))%>" />

				<span style="float:right;">
					<input class="btn_y_01" type="button" style="min-width:40px;width:40px;height:20px;" id="menuInstBtn" value="수정" onclick="subOrgEditShow(event,'<%=util.getStr(rs.get("ORG_GRP_NM"))%>','<%=util.getStr(rs.get("ORG_GRP_CD"))%>','<%=util.getStr(rsSub.get("ORG_GRP_SUB_NM"))%>','<%=util.getStr(rsSub.get("ORG_GRP_SUB_CD"))%>','<%=util.getStr(rsSub.get("ORG_ADDR1"))%>','<%=util.getStr(rsSub.get("ORG_ADDR2"))%>','<%=util.getStr(rsSub.get("ORG_ZIPCODE"))%>','<%=util.getStr(rsSub.get("ORG_PHONE"))%>','<%=util.getStr(rsSub.get("ORG_FAX"))%>','<%=util.getStr(rs.get("ADDR1"))%>','<%=util.getStr(rs.get("ADDR2"))%>','<%=util.getStr(rs.get("ZIPCODE"))%>')"/>
				</span>
				</div>
				<%
			}
		}
		%>

	</div>
	<%
		}
	%>