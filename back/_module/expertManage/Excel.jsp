<%@page import="org.apache.ibatis.binding.MapperMethod.ParamMap"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import = "java.util.Calendar" %>
<%@ page contentType="application/vnd.ms-excel;charset=utf-8" %>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));
	String userAppState = util.getStr(paramMap.get("userAppState"));
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "expertManager_list_"+to_day;
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
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 7%;" />
				<col style="width: 9%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">기관명</th>
					<th scope="col">부서명</th>
					<th scope="col">이름</th>
					<th scope="col">직위</th>
					<th scope="col">국적</th>
					<th scope="col">성별</th>
					<th scope="col">출생년도</th>
					<th scope="col">최종학교</th>
					<th scope="col">최종학위</th>
					<th scope="col">전공</th>
					<th scope="col">전화번호</th>
					<th scope="col">이메일</th>
					<th scope="col">핸드폰번호</th>
				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
			int cont = staticVO.getTotalCount();
			for(HashMap rs:dataList) {%>
				<tr>
					<td>
						<%=cont%>
					</td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM"))%></td>
					<td><%=util.getStr(rs.get("DEPT_NM"))%></td>
					<td><%=util.getStr(rs.get("PSN_NM"))%></td>
					<td><%=util.getStr(rs.get("POSITION_NM"))%></td>
					<td>
						<%if(util.getStr(rs.get("FRGN_YN")).equals("Y")){%>
							대한민국
						<%}else{%>
							<%=util.getStr(rs.get("PRO_USER_FORG"))%>
						<%}%>
					</td>
					<td><%=util.getStr(rs.get("GENDER_TYPE_CD"))%></td>
					<td><%=util.getStr(rs.get("BIRTH_DATE"))%></td>
					<td><%=util.getStr(rs.get(""))%></td>
					<td><%=util.getStr(rs.get(""))%></td>
					<td><%=util.getStr(rs.get("EX_MAJOR_NAME"))%></td>
					<td><%=util.getStr(rs.get("TEL_NO"))%></td>
					<td><%=util.getStr(rs.get("EMAIL"))%></td>
					<td><%=util.getStr(rs.get("CP_NO"))%></td>
				</tr>
			<%
			cont--;
			} %>

			</tbody>
		</table>




