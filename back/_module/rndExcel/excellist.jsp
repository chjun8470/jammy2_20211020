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
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> rndExcelDataList = request.getAttribute("rndExcelDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndExcelDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));


	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "RND_"+to_day;
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
		<table class="skin_basic_list">
			<caption>R&D과제 리스트.</caption>
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 5%;" />
				<col/>
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">년도</th>
					<th scope="col">사업명</th>
					<th scope="col">부처명</th>
					<th scope="col">지역</th>
					<th scope="col">과학기술표준분류(대)</th>
					<th scope="col">중점과학기술분류(대)</th>
					<th scope="col">6T관련기술(대)</th>
					<th scope="col">사업비</th>					
				</tr>
			</thead>
			<tbody>
			<%
			int cont = rndExcelDataList.size();

			if(rndExcelDataList.size()>0){
				for(HashMap rs:rndExcelDataList) {%>
				<tr onclick="delThisRow('<%=util.getInt(rs.get("IDX"))%>')">
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("YEAR"))%></td>
					<td><%=util.getStr(rs.get("COM_NM"))%></td>
					<td><%=util.getStr(rs.get("COM_TEAM"))%></td>
					<td><%=util.getStr(rs.get("AR_NM"))%></td>
					<td><%=util.getStr(rs.get("S_TYPE_A1"))%></td>
					<td><%=util.getStr(rs.get("SIC_TYPE1"))%></td>
					<td><%=util.getStr(rs.get("T6_TYPE1"))%></td>
					<td><%=util.getComma(String.valueOf(rs.get("SUM_PRICE")))%></td>
				</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='7'>조회된 결과가 없습니다.</td></tr>");}
			%>
			</tbody>
		</table>