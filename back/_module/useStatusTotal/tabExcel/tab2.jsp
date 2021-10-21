<%@page import="org.apache.ibatis.binding.MapperMethod.ParamMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.util.Calendar" %>
<%@ page contentType="application/vnd.ms-excel;charset=utf-8" %>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> totalDataMap = request.getAttribute("totalDataMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("totalDataMap");
	HashMap<String, String> jeinetDataMap = request.getAttribute("jeinetDataMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("jeinetDataMap");
	HashMap<String, String> zeusDataMap = request.getAttribute("zeusDataMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("zeusDataMap");
	HashMap<String, String> etubeDataMap = request.getAttribute("etubeDataMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("etubeDataMap");
	HashMap<String, String> nJeinetDataMap = request.getAttribute("nJeinetDataMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("nJeinetDataMap");

	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "장비정보시스템등록_"+to_day;
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
<!-- skin_basic_list s -->
<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
	<colgroup>
		<col style="">
		<col style="">
		<col style="">
		<col style="">
		<col style="">
		<col style="">
		<col style="">
		<col style="">
		<col style="">
		<col style="">

	</colgroup>

	<thead>
		<tr>
			<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">구분</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">전체보유 장비</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">JEINET<br>등록장비</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">ZEUS<br>등록장비</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">E-Tube<br>등록장비</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">JEINET<br>미등록장비</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th scope="col">등록기관수</th>
			<td scope="col"><%if(totalDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(totalDataMap.get("TOTAL1"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(jeinetDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(jeinetDataMap.get("TOTAL1"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(zeusDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(zeusDataMap.get("TOTAL1"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(etubeDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(etubeDataMap.get("TOTAL1"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(nJeinetDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(nJeinetDataMap.get("TOTAL1"))))%><%}else{%>0<%}%></td>
		</tr>
		<tr>
			<th scope="col">등록대수(점)</th>
			<td scope="col"><%if(totalDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(totalDataMap.get("TOTAL2"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(jeinetDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(jeinetDataMap.get("TOTAL2"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(zeusDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(zeusDataMap.get("TOTAL2"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(etubeDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(etubeDataMap.get("TOTAL2"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(nJeinetDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(nJeinetDataMap.get("TOTAL2"))))%><%}else{%>0<%}%></td>
		</tr>
		<tr>
			<th scope="col">등록금액(원)</th>
			<td scope="col"><%if(totalDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(totalDataMap.get("TOTAL3"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(jeinetDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(jeinetDataMap.get("TOTAL3"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(zeusDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(zeusDataMap.get("TOTAL3"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(etubeDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(etubeDataMap.get("TOTAL3"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(nJeinetDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(nJeinetDataMap.get("TOTAL3"))))%><%}else{%>0<%}%></td>
		</tr>
		<tr>
			<th scope="col">내구연한<br>경과장비수<br>(점)</th>
			<td scope="col"><%if(totalDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(totalDataMap.get("TOTAL4"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(jeinetDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(jeinetDataMap.get("TOTAL4"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(zeusDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(zeusDataMap.get("TOTAL4"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(etubeDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(etubeDataMap.get("TOTAL4"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(nJeinetDataMap.size() > 0){%><%=Math.round(Double.parseDouble(String.valueOf(nJeinetDataMap.get("TOTAL4"))))%><%}else{%>0<%}%></td>
		</tr>
		<tr>
			<th scope="col">내구연한<br>경과장비<br>구축비(원)</th>
			<td scope="col"><%if(totalDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(totalDataMap.get("TOTAL5"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(jeinetDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(jeinetDataMap.get("TOTAL5"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(zeusDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(zeusDataMap.get("TOTAL5"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(etubeDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(etubeDataMap.get("TOTAL5"))))%><%}else{%>0<%}%></td>
			<td scope="col"><%if(nJeinetDataMap.size() > 0){%><%=util.getComma(Double.parseDouble(String.valueOf(nJeinetDataMap.get("TOTAL5"))))%><%}else{%>0<%}%></td>
		</tr>
	</tbody>
</table>