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
	String excelName = "JIPBANK 이전현황"+to_day;
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
	</colgroup>
	<!-- colgroup e -->

	<!-- thead s -->
	<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">권리구분</th>
					<th scope="col">등록정보</th>
					<th scope="col">지식재산명칭</th>
					<th scope="col">보유기관</th>
					<th scope="col">이전구분</th>
					<th scope="col">이전일</th>
					<th scope="col">영구 여부</th>
					<th scope="col">실시시작일</th>
					<th scope="col">실시종료일</th>
					<th scope="col">중개기관</th>
					<th scope="col">정액기술료(원)</th>
					<th scope="col">경상기술료</th>
					<th scope="col">비고</th>
					<th scope="col">실시권자(양수자)</th>
					<th scope="col">대표자</th>
					<th scope="col">담당자/직위</th>
					<th scope="col">전화번호</th>
					<th scope="col">휴대전화</th>
					<th scope="col">이메일</th>
				</tr>
	</thead>
	<!-- thead s -->

	<!-- tbody s -->
	<tbody>
	<%
		int cont = 1;
				for(HashMap rs:dataList) {
	%>
				<tr>
					<td scope="col"><%=util.getStr(rs.get("JIP_USE_IDX")) %></td>
					<td scope="col">
						<%if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("1")) {
						 out.println("특허");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("2")) {
						 out.println("실용신안");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("3")) {
						 out.println("디자인");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("4")) {
						 out.println("상표");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("5")) {
						 out.println("프로그램");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("6")) {
						 out.println("노하우");
						} %>
					</td>
					<td scope="col"><%=util.getStr(rs.get("REGIST_INFO")) %></td>
					<td scope="col">
						<%if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("1")) {
							out.println(util.getStr(rs.get("INVENTION_KOR_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("2")) {
							out.println(util.getStr(rs.get("INVENTION_KOR_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("3")) {
							out.println(util.getStr(rs.get("D_USE_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("4")) {
							out.println(util.getStr(rs.get("B_USE_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("5")) {
							out.println(util.getStr(rs.get("P_USE_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("6")) {
							out.println(util.getStr(rs.get("TCHNLGY_NM")));
						} %>
					</td>
					<td scope="col"><%=util.getStr(rs.get("ORG_GRP_NM")) %></td>
					<td scope="col">
						<%if(util.getStr(rs.get("TRANSFER_SECTION")).equals("01")) {
							out.println("양도");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("02")) {
							out.println("전용실시");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("03")) {
							out.println("독점적 통상실시");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("04")) {
							out.println("통상실시");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("05")) {
							out.println("노하우 이전");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("06")) {
							out.println("기타");
						}
						%>
					</td>
					<td><%=util.getStr(rs.get("TRANSFER_DATE")) %></td>
					<%if(util.getStr(rs.get("ETERNITY_YN")).equals("Y")) { %>
					<td><%=util.getStr(rs.get("ETERNITY_YN"))%></td>
					<td></td>
					<td></td>
					<% } else { %>
					<td></td>
					<td><%=util.getStr(rs.get("TRANSFER_ST_DT")) %></td>
					<td><%=util.getStr(rs.get("TRANSFER_ED_DT")) %></td>
					<% } %>
					<td><%=util.getStr(rs.get("BROKERAGE_INSTITUTION")) %></td>
					<td><%=util.getStr(rs.get("FLAT_SUM_SKILL_FEE")) %></td>
					<td><%=util.getStr(rs.get("ORDINARY_SKILL_FEE")) %></td>
					<td><%=util.getStr(rs.get("NOTE")) %></td>
					<td><%=util.getStr(rs.get("TRANSFER_PERSON")) %></td>
					<td><%=util.getStr(rs.get("TRANSFER_DELEGATE")) %></td>
					<td><%=util.getStr(rs.get("TRANSFER_POSITION")) %></td>
					<td><%=util.getStr(rs.get("TRANSFER_PHONE1")) %></td>
					<td><%=util.getStr(rs.get("TRANSFER_PHONE2")) %></td>
					<td><%=util.getStr(rs.get("TRANSFER_EMAIL")) %></td>
				</tr>
		<%
				cont++;
			}
		%>

	</tbody>
	</table>
<br/>

