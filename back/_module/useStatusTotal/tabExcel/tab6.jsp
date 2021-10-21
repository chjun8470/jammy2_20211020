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
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");

	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "분류별장비현황_"+to_day;
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
			<th scope="col" colspan="2" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">구분</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">합계</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">BT</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">ET</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">IT</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">NT</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">ST</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">CT</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">기타</th>
		</tr>
	</thead>
	<tbody>
	<%int cnt=0;
		String[] titles = {"전체<br>장비", "JEINET", "ZEUS", "E-Tube"};
		for(HashMap data : dataList){%>
		<tr>
			<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;" rowspan="2"><%=titles[cnt]%></th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">장비수(점)</th>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getStr(data.get("cnt1")) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getStr(data.get("cnt2")) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getStr(data.get("cnt3")) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getStr(data.get("cnt4")) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getStr(data.get("cnt5")) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getStr(data.get("cnt6")) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getStr(data.get("cnt7")) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getStr(data.get("cnt8")) %></p>
			</td>
		</tr>
		<tr>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">장비구축비(원)</th>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getComma(util.getStr(data.get("price1"))) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getComma(util.getStr(data.get("price2"))) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getComma(util.getStr(data.get("price3"))) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getComma(util.getStr(data.get("price4"))) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getComma(util.getStr(data.get("price5"))) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getComma(util.getStr(data.get("price6"))) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getComma(util.getStr(data.get("price7"))) %></p>
			</td>
			<td scope="col" style = "border-right: solid 1px #e0e0e0;">
				<p class="scope111"><%=util.getComma(util.getStr(data.get("price8"))) %></p>
			</td>
		</tr>
	<%cnt++;
		}%>
	</tbody>
</table>