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

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

	String list_mode = util.getStr(paramMap.get("list_mode"));
	ArrayList<HashMap<String, String>> dataList = new ArrayList();
	ArrayList<HashMap<String, String>> imgfileList = new ArrayList();
	StaticVO staticVO = new StaticVO();

	if(list_mode.equals("utility")){
		dataList = request.getAttribute("utilityList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("utilityList");
		staticVO = request.getAttribute("utilityStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("utilityStaticVO");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}
	if(list_mode.equals("design")){
		dataList = request.getAttribute("designList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("designList");
		staticVO = request.getAttribute("designStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("designStaticVO");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}
	if(list_mode.equals("brand")){
		dataList = request.getAttribute("brandList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("brandList");
		staticVO = request.getAttribute("brandStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("brandStaticVO");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}
	if(list_mode.equals("program")){
		dataList = request.getAttribute("programList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("programList");
		staticVO = request.getAttribute("programStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("programStaticVO");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}
	if(list_mode.equals("knowhow")){
		dataList = request.getAttribute("knowHowList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("knowHowList");
		staticVO = request.getAttribute("knowHowStaticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("knowHowStaticVO");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
	}

	ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String fileGrp = "registration";
	String fileImgGrp = "registartion_img";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String fileFullImgGrp = fileImgGrp+fileSubGrp;

	int scCnt = 0;

	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "";
	if(list_mode.equals("utility")){
		excelName = "????????????????????????"+to_day;
	}else if(list_mode.equals("design")){
		excelName = "???????????????"+to_day;
	}else if(list_mode.equals("brand")){
		excelName = "????????????"+to_day;
	}else if(list_mode.equals("program")){
		excelName = "??????????????????"+to_day;
	}else {
		excelName = "???????????????"+to_day;
	}

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
	<table class="skin_basic_list" summary="?????????????????? ???????????? ????????????..">
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
	<% if(list_mode.equals("utility")){ %>
				<tr>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">???????????????(??????)</th>
					<th scope="col">???????????????(??????)</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">ICP??????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????(?????????)</th>
					<th scope="col">????????????(?????????)</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????????????????</th>
					<th scope="col">????????????????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
				</tr>
			<% }else if(list_mode.equals("design")) {%>
				<tr>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????????????????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????????????????</th>
					<th scope="col">????????????(?????????)</th>
					<th scope="col">????????????(?????????)</th>
					<th scope="col">????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
				</tr>
			<% }else if(list_mode.equals("brand")) {%>
				<tr>
					<th scope="col">??????(????????????)??????</th>
					<th scope="col">??????(????????????)??????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????(?????????)</th>
					<th scope="col">????????????(?????????)</th>
					<th scope="col">????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
				</tr>
			<% }else if(list_mode.equals("program")) {%>
				<tr>
					<th scope="col">????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????????????????</th>
					<th scope="col">?????????????????????</th>
					<th scope="col">????????????(?????????)</th>
					<th scope="col">????????????(?????????)</th>
					<th scope="col">??????????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????????????????</th>
				</tr>
			<% }else{ %>
				<tr>
					<th scope="col">???????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">??????(??????)???</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
				</tr>
			<% } %>
	</thead>
	<!-- thead s -->

	<!-- tbody s -->
	<tbody>
	<%
		int cont = 1;
			if(list_mode.equals("utility")){
				for(HashMap rs:dataList) {
	%>
				<tr>
					<td><%=util.getStr(rs.get("APLC_NO")) %></td>
					<td><%=util.getStr(rs.get("APLC_NATION")) %></td>
					<td><%=util.getStr(rs.get("NATION_NM")) %></td>
					<td><%=util.getStr(rs.get("APLC_DT")) %></td>
					<td><%=util.getStr(rs.get("APLC_USER")) %></td>
					<td><%=util.getStr(rs.get("INVENTION_KOR_NM")) %></td>
					<td><%=util.getStr(rs.get("INVENTION_ENG_NM")) %></td>
					<td><%=util.getStr(rs.get("INVENTOR")) %></td>
					<td><%=util.getStr(rs.get("AGENT")) %></td>
					<td><%=util.getStr(rs.get("ICP_CL")) %></td>
					<td><%=util.getStr(rs.get("RIGHT_SE")) %></td>
					<td><%=util.getStr(rs.get("RIGHT_STATUS")) %></td>
					<td><%=util.getStr(rs.get("REG_NO")) %></td>
					<td><%=util.getStr(rs.get("REG_DT")) %></td>
					<td><%=util.getStr(rs.get("PUBLIC_NO")) %></td>
					<td><%=util.getStr(rs.get("PUBLIC_DT")) %></td>
					<td><%=util.getStr(rs.get("BEFORE_INFO")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGYY_GRADE")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_M_CL")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_S_CL")) %></td>
					<td><%=util.getStr(rs.get("TECHNOLOGY_DC")) %></td>
					<td><%=util.getStr(rs.get("FIRST_PAYMENT_DT")) %></td>
					<td><%=util.getStr(rs.get("YEAR_PAYMENT_DT")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_SUB_NM")) %></td>
					<td><%=util.getStr(rs.get("PSN_NM")) %></td>
					<td><%=util.getStr(rs.get("AREA_SIGUNGU")) %></td>
					<td><%=util.getStr(rs.get("REPRSNT")) %></td>
					<td><%=util.getStr(rs.get("DETAILED_STATEMENT")) %></td>
					<td><%=util.getStr(rs.get("REFERENCE_DATA")) %></td>
				</tr>
		<%
				cont++;
			}
			}else if(list_mode.equals("design")){
				for(HashMap rs:dataList) {
		%>
				<tr>
					<td><%=util.getStr(rs.get("APLC_NO")) %></td>
					<td><%=util.getStr(rs.get("APLC_DT")) %></td>
					<td><%=util.getStr(rs.get("APLC_USER")) %></td>
					<td><%=util.getStr(rs.get("RIGHT_STATUS")) %></td>
					<td><%=util.getStr(rs.get("DESIGN_NO")) %></td>
					<td><%=util.getStr(rs.get("USE_NM")) %></td>
					<td><%=util.getStr(rs.get("KOREA_CL")) %></td>
					<td><%=util.getStr(rs.get("INTRL_CL")) %></td>
					<td><%=util.getStr(rs.get("CREATION_USER")) %></td>
					<td><%=util.getStr(rs.get("AGENT")) %></td>
					<td><%=util.getStr(rs.get("REG_NO")) %></td>
					<td><%=util.getStr(rs.get("REG_DT")) %></td>
					<td><%=util.getStr(rs.get("PUBLIC_NO")) %></td>
					<td><%=util.getStr(rs.get("PUBLIC_DT")) %></td>
					<td><%=util.getStr(rs.get("BEFORE_INFO")) %></td>
					<td><%=util.getStr(rs.get("YEAR_PAYMENT_DT")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_M_CL")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_S_CL")) %></td>
					<td><%=util.getStr(rs.get("TECHNOLOGY_DC")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_SUB_NM")) %></td>
					<td><%=util.getStr(rs.get("PSN_NM")) %></td>
					<td><%=util.getStr(rs.get("AREA_SIGUNGU")) %></td>
					<td><%=util.getStr(rs.get("REPRSNT")) %></td>
					<td><%=util.getStr(rs.get("DETAILED_STATEMENT")) %></td>
					<td><%=util.getStr(rs.get("INTRCN_DATA")) %></td>
				</tr>
		<%
				cont++;
				}
			}else if(list_mode.equals("brand")){
				for(HashMap rs:dataList) {
		%>
				<tr>
					<td><%=util.getStr(rs.get("INTRL_APLC_NO")) %></td>
					<td><%=util.getStr(rs.get("INTRL_APLC_DT")) %></td>
					<td><%=util.getStr(rs.get("APLC_USER")) %></td>
					<td><%=util.getStr(rs.get("AGENT")) %></td>
					<td><%=util.getStr(rs.get("USE_NM")) %></td>
					<td><%=util.getStr(rs.get("GOODS_CL")) %></td>
					<td><%=util.getStr(rs.get("FIGURE_CODE")) %></td>
					<td><%=util.getStr(rs.get("REG_NO")) %></td>
					<td><%=util.getStr(rs.get("REG_DT")) %></td>
					<td><%=util.getStr(rs.get("PBLANC_NO")) %></td>
					<td><%=util.getStr(rs.get("PBLANC_DT")) %></td>
					<td><%=util.getStr(rs.get("RIGHT_STATUS")) %></td>
					<td><%=util.getStr(rs.get("BEFORE_INFO")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_M_CL")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_S_CL")) %></td>
					<td><%=util.getStr(rs.get("TECHNOLOGY_DC")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_SUB_NM")) %></td>
					<td><%=util.getStr(rs.get("PSN_NM")) %></td>
					<td><%=util.getStr(rs.get("AREA_SIGUNGU")) %></td>
					<td><%=util.getStr(rs.get("YEAR_PAYMENT_DT")) %></td>
					<td><%=util.getStr(rs.get("REPRSNT")) %></td>
					<td><%=util.getStr(rs.get("DETAILED_STATEMENT")) %></td>
					<td><%=util.getStr(rs.get("REFERENCE_DATA")) %></td>
				</tr>
		<%
				cont++;
				}
			}else if(list_mode.equals("program")){
				for(HashMap rs:dataList) {
		%>
				<tr>
					<td><%=util.getStr(rs.get("REG_NO")) %></td>
					<td><%=util.getStr(rs.get("REG_DE")) %></td>
					<td><%=util.getStr(rs.get("CRT_WORK_DE")) %></td>
					<td><%=util.getStr(rs.get("PUBLICT_DE")) %></td>
					<td><%=util.getStr(rs.get("USE_NM")) %></td>
					<td><%=util.getStr(rs.get("BEFORE_INFO")) %></td>
					<td><%=util.getStr(rs.get("PGM_AUTHOR")) %></td>
					<td><%=util.getStr(rs.get("CRT_PARTICIPANT")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_M_CL")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_S_CL")) %></td>
					<td><%=util.getStr(rs.get("PGM_DC")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_SUB_NM")) %></td>
					<td><%=util.getStr(rs.get("PSN_NM")) %></td>
					<td><%=util.getStr(rs.get("AREA_SIGUNGU")) %></td>
					<td><%=util.getStr(rs.get("REPRSNT")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_INTRCN_DATA")) %></td>
				</tr>
		<%
			cont++;
				}
			}else{
				for(HashMap rs:dataList) {
		%>
				<tr>
					<td><%=util.getStr(rs.get("KNOW_HOW_NO")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_NM")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM")) %></td>
					<td><%=util.getStr(rs.get("ORG_GRP_SUB_NM")) %></td>
					<td><%=util.getStr(rs.get("PSN_NM")) %></td>
					<td><%=util.getStr(rs.get("AREA_SIGUNGU")) %></td>
					<td><%=util.getStr(rs.get("BEFORE_INFO")) %></td>
					<td><%=util.getStr(rs.get("TECHNOLOGY_DC")) %></td>
					<td><%=util.getStr(rs.get("REPRSNT")) %></td>
					<td><%=util.getStr(rs.get("TCHNLGY_INTRCN_DATA")) %></td>
					<td><%=util.getStr(rs.get("RSPNBER_USER_NM")) %></td>
					<td><%=util.getStr(rs.get("RSPNBER_OFC_POSITION")) %></td>
					<td><%=util.getStr(rs.get("RSPNBER_TEL_NO")) %></td>
					<td><%=util.getStr(rs.get("RSPNBER_EMAIL")) %></td>
					<td><%=util.getStr(rs.get("RSPNBER_MOBILE_PHONE")) %></td>
				</tr>
		<%
			cont++;
				}
			}
		%>


	</tbody>
	</table>
<br/>

