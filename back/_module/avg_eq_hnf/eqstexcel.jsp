<%@ page language="java" contentType="application/vnd.ms-excel; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<%@page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="org.springframework.ui.Model"%>
<%@page import="org.apache.ibatis.binding.MapperMethod.ParamMap"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>

<%@ page import = "java.util.Calendar" %>
<%

	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dayList = request.getAttribute("dayList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dayList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String selectValue = paramMap.get("selectValue");
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "AvgEqst_"+to_day;
	response.setHeader("Content-Disposition", "attachment; filename="+new String((excelName).getBytes("KSC5601"),"8859_1")+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");

%>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<style type="text/css">
		td { mso-number-format:\@; }
		br{mso-data-placement:same-cell;}
	    table {
	        width: 200px;
	        border-collapse: collapse;
	        text-align: center;
	        font-family: 'Trebuchet MS';
	    }
	    td, th {
	        font-size: 10pt;
	        border: 1px solid #98bf21;
	        height: 30px;
	    }
	    th {
	        background-color:#A7C942;
	        color:#ffffff;
	        font-family: Georgia;
	    }
	    tr.alt td {
	        color:#000000;
	        background-color:#EAF2D3;
	    }
	</style>
</head>
<body>
	<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 12%;" />
				<col style="width: 15%;" />
				<col style="width: 14%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 14%;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col"><%=selectValue %></th>
					<th scope="col">장비 명</th>
					<th scope="col">건 수</th>


				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dayList) {%>
				<tr>
					<td><%=util.getStr(rs.get("DAY"))%></td>
					<td><%=util.getStr(rs.get("KOR_NM"))%></td>
					<td><%=util.getStr(rs.get("CNT"))%></td>
				</tr>
			<%
				}
			%>

			</tbody>
		</table>
</body>