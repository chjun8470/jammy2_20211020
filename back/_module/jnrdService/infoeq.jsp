<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
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
	
	//String typea = util.getStr(paramMap.get("typea"));

	
	//System.out.println(yearList);
	
	

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
		<caption>전남R&D통계정보 사업통계</caption>
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
			<tr>
				<th rowspan="2">2021</th>
				<th>일반R&amp;D</th>
				<td>462,101</td>
				<td>264,401</td>
				<td>173,569</td>
				<td>24,131</td>
				<td>95</td>			
			</tr>
			<tr>
				<th>순도비R&amp;D</th>
				<td>40,541</td>
				<td>0</td>
				<td>37,879</td>
				<td>2,662</td>
				<td>139</td>			
			</tr>
			<tr>
				<th rowspan="2">2020</th>	
				<th>일반R&amp;D</th>
				<td>336,891</td>
				<td>176,867</td>
				<td>131,703</td>
				<td>28,321</td>
				<td>94</td>
			</tr>
			<tr>
				<th>순도비R&amp;D</th>
				<td>37,063</td>
				<td>0</td>
				<td>35,270</td>
				<td>1,793</td>
				<td>136</td>
			</tr>
			<tr>
				<th rowspan="2">2019</th>
				<th>일반R&amp;D</th>
				<td>250,590</td>
				<td>136,127</td>
				<td>84,031</td>
				<td>30,432</td>
				<td>88</td>			
			</tr>
			<tr>
				<th>순도비R&amp;D</th>
				<td>25,582</td>
				<td>0</td>
				<td>24,759</td>
				<td>823</td>
				<td>130</td>			
			</tr>
			<tr>
				<th rowspan="2">2018</th>
				<th>일반R&amp;D</th>
				<td>194,470</td>
				<td>109,240</td>
				<td>63,756</td>
				<td>21,474</td>
				<td>68</td>			
			</tr>
			<tr>
				<th>순도비R&amp;D</th>
				<td>22,610</td>
				<td>0</td>
				<td>20,158</td>
				<td>2,452</td>
				<td>114</td>			
			</tr>
	</tbody>
<!--<% 

	
	for(HashMap rs:yearData) {
		
		int totCont = 0;
		ArrayList<HashMap<String, String>> yearxxx = (ArrayList<HashMap<String, String>>)request.getAttribute("year_"+rs.get("BIS_YEAR"));
		int x = 0;
		for(HashMap ms:yearxxx){
			System.out.println(ms);
			
			
%>
	
			<tr>
				<%if(x == 0){ %>
				<th rowspan="3"><%=rs.get("BIS_YEAR")%></th>
				<% } %>
				<th><%=ms.get("TYPE_A")%></th>
				<td><%=ms.get("bp4") %></td>
				<td><%=ms.get("bp1")%></td>
				<td><%=ms.get("bp2")%></td>
				<td><%=ms.get("bp3")%></td>
				<td><%=ms.get("tot")%></td>			
			</tr>

	
	 
	
	
<% 
	//totCont++;
	x++;	
	}
	
}%>-->
	
		</tbody>
	</table>
		<script>
		$(function(){
			$(document).attr("title","홈-전남R&D통계정보-전남R&D통계정보-사업통계"); 
		});
	</script>