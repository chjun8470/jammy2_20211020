<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));

	System.out.println("List : "+myPage);
%>
	<div class="skin_list">
	<div>
		<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="surveySearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="allData" id="allData" value="" />
			<input type="hidden" name="surveyIdx" id="surveyIdx" value="" />
			<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />

			<div class="search_box">
				<div class="survey-search">
					<label for="keyword" class="hide">키워드</label>
					<input type="text" class="inp_text" name="searchValue" id="searchValue" value="<%=util.getStr(paramMap.get("searchValue"))%>" />
					<input type="submit" class="input_submit btn_inp_g_01" value="검색" class="vmiddle"/>
				</div>
				<div class="search_row">
					[전체 <span><%=staticVO.getTotalCount() %></span>건, <span><%=staticVO.getNowPage() %></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				</div>
			</div>
		</form>

		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="권한 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 100px" />
				<col style="width: *;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">설문 제목</th>
				</tr>
			</thead>
			<!-- thead e -->

			<!-- tbody s -->
			<tbody>
			<%
				int cnt = staticVO.getTotalCount();
				for(HashMap rs:dataList) {%>
				<tr>
					<td><%=cnt--%></td>
					<td class="name" style="text-indent:10px; text-align:left;">
						<a href="#" onclick="goViwe(<%=util.getStr(rs.get("SURVEY_IDX")) %>)" ><%=util.getStr(rs.get("SUBJECT"))%></a>
					</td>
			<%
				}
			%>
				</tr>
			</tbody>
		</table>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage) %>

<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
	function goViwe(surveyIdx){
		$('#mode').val('view');
		$('#surveyIdx').val(surveyIdx);
		$('#searchForm').submit();
	}
//]]>	
</script>
