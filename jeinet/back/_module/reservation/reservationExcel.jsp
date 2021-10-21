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
	String excelName = "JEINET 장비이용내역"+to_day;
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

	<!-- thead s -->
	<thead>
				<tr>
					<th>시설장비분류</th>
					<th>장비명</th>
					<th>취득방법</th>
					<th>취득금액</th>
					<th>예약자 기관명</th>
					<th>예약자 기관주소</th>
					<th>예약자명</th>
					<th>성별</th>
					<th>사업자구분</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>사용구분</th>
					<th>기타</th>
					<th>주소</th>
					<th>상세주소</th>
					<th>소속부서/센터</th>
					<th>신청자 직위</th>
					<th>책임자</th>
					<th>이용희망시작일</th>
					<th>이용희망종료일</th>
					<th>접수일</th>
					<th>이용목적</th>
					<th>시료명</th>
					<th>시료수</th>
					<th>특이사항</th>
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
					<td><%=cont%></td>
					<td>
						<%if(util.getStr(rs.get("EQUIP_CD")).equals("1")) { %> 연구장비 <% } %>
                		<%if(util.getStr(rs.get("EQUIP_CD")).equals("2")) { %> 연구시설 <% } %>
                	</td>
					<td><%=util.getStr(rs.get("KOR_NM"))%>(<%=util.getStr(rs.get("ENG_NM"))%>)</td>
					<td>
						<%if(util.getStr(rs.get("TAKE_CD")).equals("1")) { %> 구매 <% } %>
                		<%if(util.getStr(rs.get("TAKE_CD")).equals("2")) { %> 개발 <% } %>
					</td>
					<td><%=util.getStr(rs.get("TAKE_PRC"))%></td>
					<td><%=util.getStr(rs.get("CORP_NM"))%></td>
					<td><%=util.getStr(rs.get("BLNG_ORG_ADDR_DTL"))%></td>
					<td><%=util.getStr(rs.get("PSN_NM"))%></td>
					<td>
						<%if(util.getStr(rs.get("GENDER_TYPE_CD")).equals("M")) { %> 남자 <% } %>
                		<%if(util.getStr(rs.get("GENDER_TYPE_CD")).equals("F")) { %> 여자 <% } %>
					</td>
					<td>
						<%if(util.getStr(rs.get("USER_TYPE")).equals("A")) {
							out.println("사업자");
						} else {
							out.println("비사업자");
						} %>
					</td>
					<td><%=util.getStr(rs.get("EMAIL"))%></td>
                	<td><%=util.getStr(rs.get("CP_NO"))%></td>
					<td>
						<%if(util.getStr(rs.get("USE_MEAN")).equals("1")) {
							out.println("서비스의뢰");
						} else if(util.getStr(rs.get("USE_MEAN")).equals("2")) {
							out.println("직접사용");
						} else {
							out.println("야간및휴일사용");
						} %>
					</td>
					<td><%=util.getStr(rs.get("ADDR1"))%></td>
					<td><%=util.getStr(rs.get("ADDR2"))%></td>
					<td><%=util.getStr(rs.get("DEPT_NM"))%></td>
					<td><%=util.getStr(rs.get("CORP_POSITION"))%></td>
					<td><%=util.getStr(rs.get("CORP_RESPONSIBLE_USER"))%></td>
					<td><%=util.getStr(rs.get("USE_ST_DT"))%></td>
					<td><%=util.getStr(rs.get("USE_ED_DT"))%></td>
					<td><%=util.getStr(rs.get("ORDER_DT"))%></td>
					<td><%=util.getStr(rs.get("USE_PURPOSE"))%></td>
					<td><%=util.getStr(rs.get("SAMPLE_NM"))%></td>
					<td><%=util.getStr(rs.get("SAMPLE_NO"))%></td>
					<td><%=util.getStr(rs.get("SAMPLE_MATTER"))%></td>
				</tr>
		<%
				cont++;
			}
		%>

	</tbody>
	</table>
<br/>

