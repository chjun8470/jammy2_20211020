<%@page import="org.apache.ibatis.binding.MapperMethod.ParamMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	String deth1 = "6";
	String deth2 = "3";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("PmsLoginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("PmsLoginVO");
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
%>
<div class="skin_list">
	<div>
		<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="reURl" id="reURl" value="<%=myPage%>" />

			<div class="bbs-top">
			<br/>
				<div class="total">
					[전체 <span><%=staticVO.getTotalCount() %></span>건, <span><%=staticVO.getNowPage() %></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				</div>
				<br/>
			</div>
		</form>

		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 12%;" />
				<col style="width: 40%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">글쓴이</th>
					<th scope="col">파일</th>
					<th scope="col">작성일</th>
				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<tr>
					<td>
						<%=cont%>
					</td>
					<td class="subject">
						<a href="./<%=myPage %>?mode=view&amp;manageIdx=<%=util.getStr(rs.get("MANAGE_IDX"))%>" ><%=util.getStr(rs.get("SUBJECT"))%>&nbsp;(<%=util.getStr(rs.get("COMMENTCNT")) %>)</a>
					</td>
					<td><%=util.getStr(rs.get("REG_ID"))%></td>
					<td>
					<%if( !"".equals(util.getStr(rs.get("FILE_EXT"))) ){%>
						<img src="/imgs/board/ico_file.gif" alt="첨부파일" style="padding-top:2px"/>
						<%} %>
					</td>
					<td><%=util.getStr(rs.get("REG_DT")).split(" ")[0]%></td>
				</tr>
			<%
			cont--;
			} %>

			</tbody>
		</table>
		<div class="btn_box">
			&nbsp;
			<div class="btn_right_box">
				<a href="#" ><input type="button" class="btn_inp_b_01" value="등록" onclick="goWrite()"/></a>
		</div>
	</div>
</div>
</div>

<%=util.getPaging(staticVO, nowPage) %>
<script type="text/javascript">
//<![CDATA[
	function goWrite(){
		$('#mode').val('write');
		$('#searchForm').submit();
	}
//]]>	
</script>
