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
	String display = "sub";
	String deth1 = "3";
	String deth2 = "2";
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");



	String mode = util.getStr(paramMap.get("mode"));
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String receipt_sys_idx = util.getStr(paramMap.get("receipt_sys_idx"));
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "JEINET 장비활용실적"+to_day;
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
	<table class="skin_basic_list" summary="호스팅목록을 나타내는 표입니다..">
	<!-- colgroup s -->
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
		<col style="">
		<col style="">
		<col style="">
		<col style="">
		<col style="">
		<col style="">
		<col style="">
	</colgroup>
	<!-- colgroup e -->

	<!-- thead s -->
	<thead>
				<tr>
					<th scope="col">순번</th>
					<th scope="col">JEINET 장비등록번호</th>
					<th scope="col">NTIS 장비등록번호</th>
					<th scope="col">기관명</th>
					<th scope="col">한글장비명</th>
					<th scope="col">취득일</th>
					<th scope="col">공동활용대상 구분</th>
					<th scope="col">공동활용기관/기관명</th>
					<th scope="col">부서명</th>
					<th scope="col">사용자명</th>
					<th scope="col">전화번호</th>
					<th scope="col">이메일</th>
					<th scope="col">공동활용 시작일</th>
					<th scope="col">공동활용 종료일</th>
					<th scope="col">이용시간</th>
					<th scope="col">수익금(원)</th>
					<th scope="col">시료수/지원건수</th>
				</tr>
	</thead>
	<!-- thead s -->

	<!-- tbody s -->
	<tbody>
	<%
		int cont = 1;
				for(HashMap rs:dataList) {
					String[] branch = util.getStr(rs.get("BRANCH_NM")).split(">");
	%>
				<tr>
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("JEINET_EQU_NO")) %></td>
					<td><%=util.getStr(rs.get("NTIS_EQU_NO")) %></td>
					<td><%=util.getStr(rs.get("OWN_ORG_NM")) %></td>
					<td><%=util.getStr(rs.get("KOR_NM")) %></td>
					<td><%=util.getStr(rs.get("TAKE_SDT")) %></td>
					<td><%=util.getStr(rs.get("JOINT_USE_SECTION")) %></td>
					<td><%=util.getStr(rs.get("JOINT_USE_INSTITUTION")) %></td>
					<td><%=util.getStr(rs.get("DEPARTMENT")) %></td>
					<td><%=util.getStr(rs.get("USER_NAME")) %></td>
					<td><%=util.getStr(rs.get("USER_PHONE")) %></td>
					<td><%=util.getStr(rs.get("USER_EMAIL")) %></td>
					<td><%=util.getStr(rs.get("JOINT_USE_ST_DT")) %></td>
					<td><%=util.getStr(rs.get("JOINT_USE_ED_DT")) %></td>
					<td><%=util.getStr(rs.get("USE_TIME")) %></td>
					<td><%=util.getStr(rs.get("EARNINGS")) %></td>
					<td><%=util.getStr(rs.get("SAMPLE_COUNT")) %></td>
				</tr>
		<%
				cont++;
			}
		%>

	</tbody>
	</table>
<br/>

