

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
	String excelName = "edu_reserve_list_"+to_day;
	response.setHeader("Content-Disposition", "attachment; filename="+new String((excelName).getBytes("KSC5601"),"8859_1")+".xls");
	response.setHeader("Content-Description", "JSP Generated Data");
	response.setContentType("application/vnd.ms-excel");
%>
		<table class="skin_basic_list">
			<caption>등록되어있는 교육 신청정보 리스트표입니다.</caption>
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 5%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 5%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">관리번호</th>
					<th scope="col">교육명(과정명)</th>
					<th scope="col">신청자<br/>(아이디)</th>
					<th scope="col">성별</th>
					<th scope="col">소속</th>
					<th scope="col">직책</th>
					<th scope="col">전화번호</th>
					<th scope="col">휴대전화</th>
					<th scope="col">이메일</th>
					<th scope="col">상태</th>
					<th scope="col">신청일</th>
				</tr>
			</thead>
			<tbody>

			<%
			int cont = dataList.size();

			if(dataList.size()>0){
				for(HashMap rs:dataList) {%>
					<tr id="resvTr<%=rs.get("EDU_RESV_ID")%>">
						<td><%=cont%></td>
						<td>
						<%=util.getStr(rs.get("EDU_RESV_ID"))%>
						</td>
						<td ><%=util.getStr(rs.get("EDU_NM"))%>(<%=util.getStr(rs.get("EDU_CUR"))%>)</td>
						<td ><%=util.getStr(rs.get("PSN_NM"))%>(<%=util.getStr(rs.get("USER_ID"))%>)</td>
						<td ><%=util.getStr(rs.get("GENDER_TYPE"))%></td>
						<td ><%=util.getStr(rs.get("ORG_GRP_NM"))%></td>
						<td ><%=util.getStr(rs.get("POSITION_NM"))%></td>
						<td ><%=util.getStr(rs.get("TEL_NO"))%></td>
						<td ><%=util.getStr(rs.get("CP_NO"))%></td>
						<td ><%=util.getStr(rs.get("USER_EMAIL"))%></td>
						<td >
						<%=util.getStr(rs.get("RESV_STATE")).equals("10")?"신청":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("20")?"승인":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("30")?"반려":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("40")?"신청취소":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("50")?"수료":"" %>
						<%=util.getStr(rs.get("RESV_STATE")).equals("60")?"미수료":"" %>
						</td>
						<td ><%=util.getStr(rs.get("REG_DATE"))%></td>
					</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='13'>조회된 결과가 없습니다.</td></tr>");}
			%>
			</tbody>
		</table>
