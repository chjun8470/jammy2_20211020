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
	ArrayList<HashMap<String, String>> rndNationExcelDataList = request.getAttribute("rndNationExcelDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("rndNationExcelDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));
	
	

	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "NATION_RND_"+util.getStr(paramMap.get("rndYear"));
	response.setHeader("Content-Disposition", "attachment; filename="+new String((excelName).getBytes("KSC5601"),"8859_1")+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");
%>
	<script>
		return false;
	</script>
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
			
			<thead>
				<tr>
					<th colspan="5" scope="col"></th>
					<th colspan="2" scope="col">????????????</th>
					<th colspan="2" scope="col"></th>
					<th colspan="4" scope="col">??????</th>
					<th colspan="4" scope="col">?????????</th>
					<th colspan="2" scope="col">????????????</th>
					<th colspan="5" scope="col"></th>			
				</tr>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">??????URL</th>
					<th scope="col">????????????</th>
					<th scope="col">??????</th>
					<th scope="col">??????/??????</th>
					<th scope="col">??????</th>
					<th scope="col">??????/??????</th>
					<th scope="col">??????</th>
					<th scope="col">??????/??????</th>
					<th scope="col">??????</th>
					<th scope="col">??????/??????</th>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">????????? ????????????</th>
					<th scope="col">???????????? ????????????</th>
					<th scope="col">???????????? ????????? ??????</th>
					<th scope="col">??????????????????</th>
					<th scope="col">??????????????????????????????</th>	
				</tr>
			</thead>
			<tbody>
			<%
			int cont = rndNationExcelDataList.size();

			if(rndNationExcelDataList.size()>0){
				for(HashMap rs:rndNationExcelDataList) {%>
				<tr>
					<td><%=util.getStr(rs.get("EX_1"))%></td>
					<td><%=util.getStr(rs.get("EX_2"))%></td>
					<td><%=util.getStr(rs.get("EX_3"))%></td>
					<td><%=util.getStr(rs.get("EX_4"))%></td>
					<td><%=util.getStr(rs.get("EX_5"))%></td>
					<td><%=util.getStr(rs.get("EX_6"))%></td>
					<td><%=util.getStr(rs.get("EX_7"))%></td>
					<td><%=util.getStr(rs.get("EX_8"))%></td>
					<td><%=util.getStr(rs.get("EX_9"))%></td>
					<td><%=util.getStr(rs.get("EX_10"))%></td>
					<td><%=util.getStr(rs.get("EX_11"))%></td>
					<td><%=util.getStr(rs.get("EX_12"))%></td>
					<td><%=util.getStr(rs.get("EX_13"))%></td>
					<td><%=util.getStr(rs.get("EX_14"))%></td>
					<td><%=util.getStr(rs.get("EX_15"))%></td>
					<td><%=util.getStr(rs.get("EX_16"))%></td>
					<td><%=util.getStr(rs.get("EX_17"))%></td>
					<td><%=util.getStr(rs.get("EX_18"))%></td>
					<td><%=util.getStr(rs.get("EX_19"))%></td>
					<td><%=util.getStr(rs.get("EX_20"))%></td>
					<td><%=util.getStr(rs.get("EX_21"))%></td>
					<td><%=util.getStr(rs.get("EX_22"))%></td>
					<td><%=util.getStr(rs.get("EX_23"))%></td>
					<td><%=util.getStr(rs.get("EX_24"))%></td>
				</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='24'>????????? ????????? ????????????.</td></tr>");}
			%>
			</tbody>
		</table>