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
	
	
	
	ArrayList<HashMap<String, Object>> rndSumPriceList2 = request.getAttribute("rndSumPriceList2") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("rndSumPriceList2");
	//ArrayList<HashMap<String, Object>> rndSumPriceList2 = request.getAttribute("rndSumPriceList2") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("rndSumPriceList2");
	//ArrayList<HashMap<String, Object>> rndSumPriceList3 = request.getAttribute("rndSumPriceList3") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("rndSumPriceList3");
	
	String category = "[";
	String data = "[";
	int k = 0;
	String eq = ",";
	
	data += "{";
	data += "name:'test',";
	data += "colorByPoint:true,";
	data += "data:[";
	
	for(HashMap rs:rndSumPriceList2) {
		
		if(k != 0){
			category += eq;
			data += eq;
		}
		data += "{";
		data += "name:'"+util.getStr(rs.get("SIC_TYPE1"))+"',";
		data += "y:"+util.getStr(rs.get("TOTAL_PRICE"))+"";
		data += "}";
		
		category += " '"+util.getStr(rs.get("SIC_TYPE1"))+"'";
		
		k++;
	}	
	category += "]";
	data += "]";
	data += "}]";
	
	//out.println(category);
	
%>



<div id="high_container">
	<div style="text-align:center; border:1px solid #ddd; color:#999; padding:50px; margin-bottom:50px;">일치하는 데이터가 없습니다.</div>
</div>

<script>
Highcharts.chart('high_container', {
    chart: {
        type: 'column'
    },
    title: {
        text: '사업비'
    },
    subtitle: {
        text: ''
    },
    accessibility: {
      announceNewData: {
        enabled: true
      }
    },
    xAxis: {
        type:'category'
    },
    yAxis: {
        min: 0,
        title: {
            text: '단위 (만원)'
        }
    },
    legend:{
    	enabled:false
    },
    credits: {
        enabled: false
    },
    tooltip: {
        headerFormat: '<span style="font-size:10px"></span><table>',
        pointFormat: '<tr><td style="color:{point.color};padding:0">{point.name}: </td>' +
            '<td style="padding:0"><b>{point.y} 만원</b></td></tr>',
        footerFormat: '</table>',
        shared: true,
        useHTML: true
    },
    plotOptions: {
    	series: {
   	      borderWidth: 0,
   	      dataLabels: {
   	        enabled: true,
   	        format: '{point.y:.1f}만원'
   	      }
   	    }
    },
    series: <%=data%>
});
</script>