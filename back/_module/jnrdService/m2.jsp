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
	
	String[] m2Type = {"국비사업","매칭사업","자체사업"};
	
	System.out.println("page-path : /jnrdService/m2.jsp");
	
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
		<caption>전남R&D통계정보 성과통계</caption>
		<tbody>
			<tr>
				<th>년도</th>
				<th>구분</th>
				<th>논문</th>
				<th>지적재산</th>
				<th>기술이전</th>
				<th>사업화<br>고용/매출</th>
				<th>신품종</th>
				<th>사업수/성과수</th>		
			</tr>
<% 

	
	for(HashMap rs:yearData) {
		
		
		//out.println(rs.get("RE_YEAR"));
		out.println("<tr>");
		out.println("<th rowspan='"+m2Type.length+"'>"+rs.get("RE_YEAR")+"</th>");
		
		for(int k=0; k<m2Type.length; k++){
			
			ArrayList<HashMap<String, String>> yearxxx = (ArrayList<HashMap<String, String>>)request.getAttribute("year_"+rs.get("RE_YEAR")+"_"+k);
		
			out.println("<th>"+m2Type[k]+"</th>");
			out.println("<td>"+yearxxx.get(0).get("tot")+"</td>");
			out.println("<td>"+yearxxx.get(1).get("tot")+"</td>");
			out.println("<td>"+yearxxx.get(2).get("tot")+"</td>");
			out.println("<td>"+yearxxx.get(3).get("tot")+"</td>");
			out.println("<td style='border-right:1px solid #ddd'>"+yearxxx.get(4).get("tot")+"</td>");
			
			if(k == 0){
				out.println("<td rowspan='"+m2Type.length+"'>"+yearxxx.get(0).get("num")+"</td>");
			}
			
			
			out.println("</tr>");
		
		}
	
		
		
	}
%>

		</tbody>
	</table>
	<script>
		$(function(){
			$(document).attr("title","홈-전남R&D통계정보-전남R&D통계정보-성과통계"); 
		});
	</script>


