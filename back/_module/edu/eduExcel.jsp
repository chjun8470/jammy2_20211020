

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

	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");

	String mode = util.getStr(paramMap.get("mode"));
	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "edu_list_"+to_day;
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
			<caption>?????????????????? ???????????? ?????????????????????.</caption>
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">?????????(?????????)</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????<br/>(??????/??????)</th>
					<th scope="col">????????????</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = dataList.size();

			if(dataList.size()>0){
				for(HashMap rs:dataList) {%>
					<tr>
						<td><%=cont%></td>
						<td><%=util.getStr(rs.get("EDU_NM"))%>(<%=util.getStr(rs.get("EDU_CUR"))%>)</td>
						<td><%=util.getStr(rs.get("EDU_ORD_ST_DT"))%> ~ <%=util.getStr(rs.get("EDU_ORD_ED_DT"))%></td>
						<td><%=util.getStr(rs.get("EDU_ST_DT"))%> ~ <%=util.getStr(rs.get("EDU_ED_DT"))%></td>
						<td><%=util.getIntStr(rs.get("EDU_TOTAL_TIME"))%>??????</td>
						
						<td><%=util.getIntStr(rs.get("EDU_ORD_PEOPLE"))%>/<%=util.getIntStr(rs.get("EDU_PEOPLE"))%></td>
						<td>
						<% if("?????????".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
								?????????
						<% }else if("????????????".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
								????????????
						<% }else if("????????????".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
								????????????
						<% }else if("?????????".equals(util.getStr(rs.get("EDU_ORD_STATE")))){ %>
								?????????
						<% }else{%>
								????????????
						<% } %>
						</td>

					</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='7'>????????? ????????? ????????????.</td></tr>");}
			%>
			</tbody>
		</table>