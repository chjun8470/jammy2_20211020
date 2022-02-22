<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataInfo") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataInfo");
	
	
%>

<style>
td em{float:right; margin-right:20px; color:#999;}
</style>


<h2 class="tit">공고기본정보</h2>
<table class="skin_basic_write">
	<caption>공고기본정보</caption>
	<colgroup>
		<col style="width: 16.6%;">
		<col style="width: 16.6%">
		<col style="width: 16.6%;">
		<col style="width: 16.6%">
		<col style="width: 16.6%">
	</colgroup>
	<thead></thead>
	<tbody>
		<tr>
			<th>공고명</th>
			<td colspan="5"><%=util.getStr(dataMap.get("TITLE")) %></td>
		</tr>
		<tr>
			<th>공고기관</th>
			<td colspan="2"><%=util.getStr(dataMap.get("AUTHOR")) %></td>
			<th>부처명</th>
			<td colspan="2"><%=util.getStr(dataMap.get("CATEGORY")) %></td>
		</tr>
		<tr>
			<th>공고일</th>
			<td><%=util.getStr(dataMap.get("PUBDATE")) %></td>
			<th>접수시작일</th>
			<td><%=util.getStr(dataMap.get("APPBEGIN")) %></td>
			<th>접수마감일</th>
			<td><%=util.getStr(dataMap.get("APPDUE")) %></td>
		</tr>
		<tr>
			<th>공고URL</th>
			<td colspan="5"><%=util.getStr(dataMap.get("LINK")) %></td>
		</tr>
		<tr>
			<th>공고내용</th>
			<td colspan="5"><%=dataMap.get("DESCRIPTION")%></td>
		</tr>
	</tbody>
</table>

<div style="text-align:right;">
<span class="delBtn" id="delBtn" data-idx="<%=util.getStr(paramMap.get("idx"))%>">삭제</span>
</div>


<script>
$("#delBtn").on("click",function(){
	if(confirm("해당내용을 삭제하시겠습니까?") !== false){
		var idx = $(this).data("idx");
		location.href="/sys/sys_rss_parser.do?mode=del&idx="+idx;
	}
})
</script>



