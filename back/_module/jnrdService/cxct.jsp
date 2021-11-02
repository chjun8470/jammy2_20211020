<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	
	ArrayList<HashMap<String, String>> yearData = request.getAttribute("yearData") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("yearData");
	
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	
	System.out.println("page-path : /jnrdService/infoeq.jsp");
	
%>
<!-- div class="basic_grid">
	<div class="search_box" style="padding:10px">
		<div class="board-search">
			<h3 class="list_tit">기준연도</h3>
			<select name="searchType" id="searchType" class="sel01 select">
				<option value="">년도선택</option>
				<option value="2018">2018</option>
				<option value="2019">2019</option>
				<option value="2020">2020</option>
			</select>
			<input type="button" value="조회" class="btn01 btn_inp_g_01" style="float:right;">
		</div>
	</div>
</div-->

<table width="100%" class="tbl00">
		<caption>전남R&D통계정보 기획과제통계</caption>
		<tbody>
			<tr>
				<th>년도</th>
				<th>구분</th>
				<th>합계</th>
				<th>국비</th>
				<th>지방비</th>
				<th>기타</th>
				<th>사업수</th>		
			</tr>
<% 

	
	for(HashMap rs:yearData) {
		
		int totCont = 0;
		ArrayList<HashMap<String, String>> yearxxx = (ArrayList<HashMap<String, String>>)request.getAttribute("year_"+rs.get("CX_YEAR"));
		int x = 0;
		for(HashMap ms:yearxxx){
			
%>
			<tr>
				<%if(x == 0){ %>
				<th rowspan="4"><%=rs.get("CX_YEAR")%></th>
				<% } %>
				<th><%=ms.get("CX_TYPE1")%></th>
				<td><%=ms.get("cd6")%></td>
				<td><%=ms.get("cd1")%></td>
				<td><%=ms.get("cd3")%></td>
				<td><%=ms.get("cd5")%></td>
				<td><%=ms.get("tot")%></td>
			</tr>

	
	 
	
	
<% 
	//totCont++;
		x++;	
	}
	
}%>
	
		</tbody>
	</table>
	<script>
		$(function(){
			$(document).attr("title","홈-전남R&D통계정보-전남R&D통계정보-기획과제통계"); 
		});
	</script>


