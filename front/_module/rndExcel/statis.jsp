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
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> rndExcelDataList = request.getAttribute("rndExcelDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndExcelDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	
	String searchType = util.getStr(request.getParameter("searchType"));
	
	ArrayList<HashMap<String, Object>> rndSumTeamList = request.getAttribute("rndSumTeamList") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("rndSumTeamList");
	ArrayList<HashMap<String, Object>> rndSumTeamList_x1 = request.getAttribute("rndSumTeamList_x1") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("rndSumTeamList_x1");
	
	
	
	String category = "[";
	String data = "[";
	int k = 0;
	String eq = ",";
	
	data += "{";
	data += "name:'test',";
	data += "colorByPoint:true,";
	data += "data:[";
	
	for(HashMap rs:rndSumTeamList) {
		
		if(k != 0){
			category += eq;
			data += eq;
		}
		data += "{";
		data += "name:'"+util.getStr(rs.get("LAB_TYPE"))+"',";
		data += "y:"+util.getStr(rs.get("TNUM"))+"";
		data += "}";
		
		category += " '"+util.getStr(rs.get("LAB_TYPE"))+"'";
		
		k++;
	}	
	category += "]";
	data += "]";
	data += "}]";
	
	int total = 0;
	for(HashMap rs:rndSumTeamList_x1) {
		total += util.getInt(rs.get("TNUM"));
	}
	
	
%>





<script src="http://code.highcharts.com/maps/modules/drilldown.js"></script>

<span style="display:block; text-align:right;">자료기준일 : <%=util.getStr(paramMap.get("setDate"))%></span>
<div class="map">
	
	<div class="map_img" style="float:left; width:60%;">
		
		<script src="/js/chart_web.js"></script>
		<script type="text/javascript">
		var highMap = new highMaps('<%=util.getStr(paramMap.get("searchType"))%>');
		highMap.init('<%=util.getStr(paramMap.get("searchType"))%>');
		</script>
		<div id="map" style="width:95%;height:500px;"></div>
    </div>
    <div class="map_txt" style="float:left; width:40%;">
        <div id="chart_container"></div>
    </div>
</div>

<br style="display:block; visibility:hidden; clear:both; content:'';" />

<div class="con10">
	<div class="sh_box">
		<ul>
			<li>
				<form method="post" name="searchform" id="searchform">
                    <label>연구소구분</label>
					<select name="searchType" id="searchType" class="select_box">
						<option <%if(searchType.equals("연구소")) { %> selected="selected" <% } %>>연구소</option>
						<option <%if(searchType.equals("전담부서")) { %> selected="selected" <% } %>>전담부서</option>
					</select>
					<input type="submit" class="btn_bl" value="검색">
				</form>
			</li>
		</ul>
	</div>



	<div class="scroll">
        <table class="tbl_01">
            <thead>
            <thead>
				<tr>
				<%
				int x = 0;
				for(HashMap rs:rndSumTeamList_x1){
					if(x==0){
						out.print("<th>지역</th>");
						out.print("<th>총계</th>");
					}
				%>
					<th><%=rs.get("LAB_TYPE")%></th>
				<%
		        	x++;
				}//for end
		        %>
		        </tr>
			</thead>
            </thead>
            <tbody>
                <tr>
                <%
	            int xx = 0;
				for(HashMap rs:rndSumTeamList_x1){
					if(xx==0){
						out.print("<td>전라남도</td>");
						out.print("<td>"+total+"</td>");
					}
					//int totPrice = rs.get("TOTAL_PRICE")/100;
				%>
					<td><%=util.getComma(rs.get("TNUM"))%></td>
				<%
		        	xx++;
				}//for end
		        %>
                </tr>
            </tbody>
        </table>
    </div>
</div>

<script>
Highcharts.chart('chart_container', {
    chart: {
    	plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
    },
    title: {
        text: '<%=searchType%>'
    },
    subtitle: {
        text: ''
    },
    accessibility: {
    	point: {
            valueSuffix: '%'
        }
    },
    legend:{
    	enabled:true
    },
    credits: {
        enabled: false
    },
    tooltip: {
    	pointFormat: '{series.name}: <b>{point.y}개</b>'
    },
    plotOptions: {
    	pie: {
    		allowPointSelect: true,
    		cursor: 'pointer',
    		dataLabels: {
   	        	enabled: true,
   	        	format: '{point.name}<br>{point.y}개'
   	      	},
            showInLegend: true
   	    }
    },
    series: <%=data%>
});
</script>

