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
	ArrayList<HashMap<String, String>> dataListAll = request.getAttribute("dataListAll") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataListAll");
	ArrayList<HashMap<String, String>> dataListJeinet = request.getAttribute("dataListJeinet") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataListJeinet");
	ArrayList<HashMap<String, String>> dataListZeus = request.getAttribute("dataListZeus") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataListZeus");
	ArrayList<HashMap<String, String>> dataListEtube = request.getAttribute("dataListEtube") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataListEtube");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	HashMap<String, String> types= new HashMap<String, String>();
	types.put("type0", "????????????");
	types.put("type1", "1????????? ?????? ~ 3????????? ??????");
	types.put("type2", "3????????? ?????? ~ 1?????? ??????");
	types.put("type3", "1?????? ?????? ~ 5?????? ??????");
	types.put("type4", "5?????? ??????");

	SimpleDateFormat df = new SimpleDateFormat("yyyyMMdd");
	Calendar cal = new GregorianCalendar(Locale.KOREA);
	String to_day = df.format(cal.getTime());
	String excelName = "??????????????????_"+to_day;
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
<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
	<colgroup>
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
			<th scope="col" colspan="3" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">??????</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">??????</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">?????????</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">????????????</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0;">????????????</th>
			<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">????????????</th>
		</tr>
	</thead>
	<tbody>
	<%
	for(int i=0 ; i<2 ; i++){
		for(HashMap data : dataListAll){%>
			<tr>
				<%
				if(i==0){
					if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
						<th scope="col" rowspan="10" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">??????<br/>??????</th>
						<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">?????????<br/>(???)</th>
					<%}%>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt0")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt1")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt2")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt3")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt4")) %></p></td>
				<%}else{
					if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){%>
					<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">???????????????<br/>(???)</th>
					<%}%>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum0")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum1")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum2")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum3")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum4")) %></p></td>
				<%}
		}
	} %>
	<%
	for(int i=0 ; i<2 ; i++){
		for(HashMap data : dataListJeinet){%>
			<tr>
				<%if(i==0){
				if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
					<th scope="col" rowspan="10" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">JEINET</th>
					<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">?????????<br/>(???)</th>
				<%}%>
				<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt0")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt1")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt2")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt3")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt4")) %></p></td>
				<%}else{
				if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
				<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">???????????????<br/>(???)</th>
				<%}%>
				<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum0")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum1")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum2")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum3")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum4")) %></p></td>
				<%}
		}
	} %>			<%
	for(int i=0 ; i<2 ; i++){
		for(HashMap data : dataListZeus){%>
			<tr>
				<%if(i==0){
				if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
					<th scope="col" rowspan="10" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">ZEUS</th>
					<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">?????????<br/>(???)</th>
				<%}%>
				<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt0")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt1")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt2")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt3")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt4")) %></p></td>
				<%}else{
				if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
				<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">???????????????<br/>(???)</th>
				<%}%>
				<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum0")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum1")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum2")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum3")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum4")) %></p></td>
				<%}
		}
	} %>			<%
	for(int i=0 ; i<2 ; i++){
		for(HashMap data : dataListEtube){%>
			<tr>
				<%if(i==0){
				if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
					<th scope="col" rowspan="10" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">E-Tube</th>
					<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">?????????<br/>(???)</th>
				<%}%>
				<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt0")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt1")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt2")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt3")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt4")) %></p></td>
				<%}else{
				if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
				<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">???????????????<br/>(???)</th>
				<%}%>
				<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum0")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum1")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum2")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum3")) %></p></td>
				<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("sum4")) %></p></td>
				<%}
		}
	} %>
	</tbody>
</table>