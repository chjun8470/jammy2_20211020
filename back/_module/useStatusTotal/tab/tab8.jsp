<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

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

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	HashMap<String, String> types= new HashMap<String, String>();
	types.put("type0", "전체장비");
	types.put("type1", "1천만원 이상 ~ 3천만원 미만");
	types.put("type2", "3천만원 이상 ~ 1억원 미만");
	types.put("type3", "1억원 이상 ~ 5억원 미만");
	types.put("type4", "5억원 이상");

	long[] chartSums = new long[21];
	int[] chartCnts = new int[21];

	for(int i=0 ; i<2 ; i++){
		int cnt = 0;
		for(HashMap data : dataListAll){
			if(i==0){
				if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){
					chartCnts[cnt++] = util.getInt(data.get("cnt0"));
				}else{
					chartCnts[cnt] = util.getInt(data.get("cnt0"));
					chartCnts[cnt+4] = util.getInt(data.get("cnt1"));
					chartCnts[cnt+8] = util.getInt(data.get("cnt2"));
					chartCnts[cnt+12] = util.getInt(data.get("cnt3"));
					chartCnts[(cnt++)+16] = util.getInt(data.get("cnt4"));
				}
			}else{
				if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){
					chartSums[cnt++] = Long.parseLong(data.get("sum0").toString());
				}else{
					chartSums[cnt] = Long.parseLong(data.get("sum0").toString());
					chartSums[cnt+4] = Long.parseLong(data.get("sum1").toString());
					chartSums[cnt+8] = Long.parseLong(data.get("sum2").toString());
					chartSums[cnt+12] = Long.parseLong(data.get("sum3").toString());
					chartSums[(cnt++)+16] = Long.parseLong(data.get("sum4").toString());
				}
			}
		}
	}
%>
<style type="text/css">
.layer {display:none; position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:10;}
.layer .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
.layer .pop-layer {display:block;}
.pop-layer {display:none; position: absolute; top: 50%; left: 50%; width: 50%;   background-color:#fff; border: 1px solid black; z-index: 5; padding: 10px;}
.pop-layer .pop-container {padding: 20px 25px;}
.pop-layer p.ctxt {color: #666; line-height: 25px;}
.pop-layer .btn-r {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}
a.cbtn {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:#3f5a9d; font-size:13px; color:#fff; line-height:25px;}
a.cbtn:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;}
.layer2 {display:none; position:fixed; _position:absolute; top:0; left:0; width:100%; height:100%; z-index:10;}
.layer2 .bg2 {position:absolute; top:0; left:0; width:100%; height:100%; background:#000; opacity:.5; filter:alpha(opacity=50);}
.layer2 .pop-layer2 {display:block;}
.pop-layer2 {display:none; position: absolute; top: 50%; left: 50%; width: 50%;   background-color:#fff; border: 1px solid black; z-index: 5; padding: 10px;}
.pop-layer2 .pop-container2 {padding: 20px 25px;}
.pop-layer2 p.ctxt2 {color: #666; line-height: 25px;}
.pop-layer2 .btn-r2 {width: 100%; margin:10px 0 20px; padding-top: 10px; border-top: 1px solid #DDD; text-align:right;}
a.cbtn2 {display:inline-block; height:25px; padding:0 14px 0; border:1px solid #304a8a; background-color:#3f5a9d; font-size:13px; color:#fff; line-height:25px;}
a.cbtn2:hover {border: 1px solid #091940; background-color:#1f326a; color:#fff;}
</style>



<div class="skin_list">
	<div class="tabBox_pub">
		<ul>
			<li <%if(util.getStr(paramMap.get("useState")).equals("1") || util.getStr(paramMap.get("useState")).equals("")) { %> class="on" <% } %> ><a href="#" onclick="useTab('1')">장비상태</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("2")) { %> class="on" <% } %> ><a href="#" onclick="useTab('2')">장비정보시스템 등록</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("3")) { %> class="on" <% } %> ><a href="#" onclick="useTab('3')">장비구축비 출저 현황</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("4")) { %> class="on" <% } %> ><a href="#" onclick="useTab('4')">장비분류별 현황</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("5")) { %> class="on" <% } %> ><a href="#" onclick="useTab('5')">활용범위 현황</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("6")) { %> class="on" <% } %> ><a href="#" onclick="useTab('6')">분류별 장비 현황</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("7")) { %> class="on" <% } %> ><a href="#" onclick="useTab('7')">장비활용률 현황</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("8")) { %> class="on" <% } %> ><a href="#" onclick="useTab('8')">구축비별 현황</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("9")) { %> class="on" <% } %> ><a href="#" onclick="useTab('9')">가동률 현황</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("10")) { %> class="on" <% } %> ><a href="#" onclick="useTab('10')">장비활용 현황</a></li>
		</ul>
	</div>
	<form id = "searchForm" name = "searchForm" method="post" action="./<%=myPage%>">
		<input type="hidden" name = "nowPage" id = "nowPage" value="<%=util.getStr(paramMap.get("nowPage"))%>"/>
		<input type="hidden" name = "mode" id = "mode" value="<%=util.getStr(paramMap.get("mode"))%>"/>
		<input type="hidden" name = "useState" id = "useState" value="<%=util.getStr(paramMap.get("useState"))%>"/>
		<input type="hidden" name = "orgGrpCd" id = "orgGrpCd" value="<%=request.getParameter("orgGrpCd")%>"/>
		<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<label for="search_year">기간</label>
						<select name="jointYear" id="jointYear" class="select" >
							<option value="" >전체</option>
							<%
								int stYear = 2010;
								int nowYear = Calendar.getInstance().get(Calendar.YEAR);
								int edYear = nowYear + 3;
								String selected2="";
								for(int i=stYear ; i<=edYear ; i++){
							%>
							<option value="<%=i%>" <%if(util.getStr(paramMap.get("jointYear")).equals(String.valueOf(i))) { %> selected="selected" <% } %>><%=i%></option>
							<%}%>
						</select>
					&nbsp;&nbsp;
					<label for="orgGrpNm">기관</label>
						<input type="text" class="inp_txt" name="orgGrpNm" id="orgGrpNm" value="<%=util.getStr(paramMap.get("orgGrpNm")) %>" readonly="readonly" />
						<%if("99".equals(util.getStr(loginVO.getAuthLv()))){ %>
							<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="btn_inp_b_01" style="display: inline-block;" onclick="popupOrgWindow('orgList','2')" />
						<%} %>
					<!-- 검색버튼 -->
					<button type="button" class="btn_inp_g_01" onclick="pageSearchGo()" style="float: right;">검색</button>
				</div>
				<!-- board-search -->
			 </div>
		</div>
		<!-- bbs-top e -->
	</form>
	<div class="tabBox_pub">
		<ul>
			<li id="cntTab" class="on2"><a href="#" onclick="getChart('cnt')">구축수 차트</a></li>
			<li id="sumTab" class="off"><a href="#" onclick="getChart('sum')">구축비 차트</a></li>
		</ul>
	</div>
	<div id="chartContainer" style="min-width: 360px; height: 600px; margin: 30px auto"></div>
	<div class="total" style="margin-top: 10px;">
		<span style="float: right; margin-bottom: 5px;">
		<button type="button" id="excelDownload" class="btn_inp_b_01" onclick="excelDown()">엑셀다운로드</button>
		</span>
	</div>
	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
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
					<th scope="col" colspan="3" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">구분</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">합계</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">주장비</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">부대장비</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">보조장비</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">기타장비</th>
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
								<th scope="col" rowspan="10" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">전체<br/>장비</th>
								<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">장비수<br/>(점)</th>
							<%}%>
							<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt0")) %></p></td>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt1")) %></p></td>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt2")) %></p></td>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt3")) %></p></td>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt4")) %></p></td>
						<%}else{
							if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){%>
							<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">장비구축비<br/>(원)</th>
							<%}%>
							<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum0"))) %></p></td>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum1"))) %></p></td>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum2"))) %></p></td>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum3"))) %></p></td>
							<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum4"))) %></p></td>
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
							<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">장비수<br/>(점)</th>
						<%}%>
						<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt0")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt1")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt2")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt3")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt4")) %></p></td>
						<%}else{
						if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
						<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">장비구축비<br/>(원)</th>
						<%}%>
						<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum0"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum1"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum2"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum3"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum4"))) %></p></td>
						<%}
				}
			} %>			<%
			for(int i=0 ; i<2 ; i++){
				for(HashMap data : dataListZeus){%>
					<tr>
						<%if(i==0){
						if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
							<th scope="col" rowspan="10" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">ZEUS</th>
							<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">장비수<br/>(점)</th>
						<%}%>
						<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt0")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt1")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt2")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt3")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt4")) %></p></td>
						<%}else{
						if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
						<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">장비구축비<br/>(원)</th>
						<%}%>
						<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum0"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum1"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum2"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum3"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum4"))) %></p></td>
						<%}
				}
			} %>			<%
			for(int i=0 ; i<2 ; i++){
				for(HashMap data : dataListEtube){%>
					<tr>
						<%if(i==0){
						if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
							<th scope="col" rowspan="10" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">E-Tube</th>
							<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">장비수<br/>(점)</th>
						<%}%>
						<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt0")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt1")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt2")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt3")) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("cnt4")) %></p></td>
						<%}else{
						if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
						<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">장비구축비<br/>(원)</th>
						<%}%>
						<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum0"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum1"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum2"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum3"))) %></p></td>
						<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("sum4"))) %></p></td>
						<%}
				}
			} %>
			</tbody>
		</table>
	</div>
</div>

<script src="http://blacklabel.github.io/grouped_categories/grouped-categories.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$("#jointUseStDt, #jointUseEdDt").datepicker({
		showMonthAfterYear : true,
		changeMonth : true,
		changeYear : true,
		nextText : '다음 달',
		prevText : '이전 달',
		currentText : '오늘 날짜',
		closeText : '닫기',
		dateFormat : "yy-mm-dd",
		dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
		dayNamesMin : ['월','화','수','목','금','토','일'],
		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
	});

	$('#jointUseStDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#jointUseEdDt").datepicker( "option", "minDate", selectedDate );
    });

	$('#jointUseEdDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#jointUseStDt").datepicker( "option", "maxDate", selectedDate );
    });

	$("#jointUseStDt, #jointUseEdDt").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;\-]/gi,''));
        }
    });

	$('#userPhone').change(function(){
		var value = $('#userPhone').val();
		var pattern = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
		var match = pattern.exec(value);

		if(match == null){
			alert("전화번호 형식으로 입력해야 합니다.");
			$('#userPhone').val('').focus();
			return false;
		};
	});


	getChart('cnt');
});
function excelDown(){
	$('#searchForm').attr('target','_blank');
	$("#searchForm").attr("action", "/sys/useStatusTotalExcelDown.do");
	$("#searchForm").submit();
	$('#searchForm').attr('target','');
	$("#searchForm").attr("action", "./<%=myPage%>");
}

function pageSearchGo(){
	$('#useState').val(8);
	$('#searchForm').submit();
}

function showRejectArea() {
	$("#rejectArea").show();
}

function hideRejectArea() {
	$("#reject").val("");
	$("#rejectArea").hide();
}

function popupWindow(){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
	var popUrl="/sys/useEquipStatus.do?mode=equPop";
	var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
	window.open(popUrl,"",popOption);
}

function setPopup(obj){
	$("#jeinetEquNo").val(obj['equ_idx']);
	$("#ntisEquNo").val(obj['ntis_no']);
}

	//기관검색 팝업
function popupOrgWindow(listMode,userTp){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

	if(listMode == 'orgList'){
		var popUrl="/sys/popup/"+listMode+".do?userTp="+userTp;
	}else if(listMode == 'orgSubList'){
		var popUrl="/sys/popup/"+listMode+".do?orgGrpCd="+$('#orgGrpCd').val();
	}
	var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
	window.open(popUrl,"",popOption);
}

//기관정보
function orgInfo(orgGrpCd, cnt){
	var result = "";
	var params = {
			"orgGrpCd": orgGrpCd
	};
	$.post("/sys/getOrgInfo.do",$.param(params),
	function(data){
		if(cnt != 'cnt'){$("#deptNm").val("");$("#positionNm").val("");}
		$("#orgGrpNm").val(data.dataMap.ORG_GRP_NM);
		if($("input[type=radio][name='userTp']:checked").val() == '2'){
    		$('#blngOrgNm').show();
    		$("#deptNm").removeAttr("readonly");
		}else if($("input[type=radio][name='userTp']:checked").val() == '3'){
    		$('#deptTh').show();
    		$('#deptTd').show();
    	}
	});
}

function useTab(useState){
	$('#mode').val('');
	$('#useState').val(useState);
	$('#jointYear').val((new Date).getFullYear());
	$('#searchForm').submit();
}

function getChart(type){
	var chartData; var subtitle;var min; var max; var typeWord; var unitWord;
	if(type == "cnt"){
		chartData =  [ <%
			                int i = 0;
					        for(int val : chartCnts){
					     	   if(i != 0) out.print(",");
					     	   out.print(val);
					     	   i++;
					        }
				        %>
				        ];
		subtitle = "구축수";
		typeWord = '(점)';
		unitWord = '(단위 : 점)';
		$("#sumTab").removeClass("on2");
		$("#sumTab").addClass("off");
		$("#cntTab").removeClass("off");
		$("#cntTab").addClass("on2");
		min = 0; max = 500;
	}else{
		chartData =  [ <%
		                int j = 0;
				        for(long val : chartSums){
				     	   if(j != 0) out.print(",");
				     	   out.print(val);
				     	   j++;
				        }
			        %>
			        ];
		subtitle = "구축비";
		typeWord = '(비)';
		unitWord = '(단위 : 십억원)';
		$("#cntTab").removeClass("on2");
		$("#cntTab").addClass("off");
		$("#sumTab").removeClass("off");
		$("#sumTab").addClass("on2");
		min = 0; max = 50000000000;

		Highcharts.setOptions({
		    lang: {
		        numericSymbols: ['', '', '']
		,		thousandsSep: ','
		    }
		});
	}
	var chart = new Highcharts.Chart({
		  chart: {
		    renderTo: "chartContainer",
		    type: "bar"
		  },
		  title: {
			    text: '장비'+subtitle+typeWord
			  },
		  series: [
		    {
		      name: subtitle+typeWord,
		      data:chartData
		    }
		  ],
		  yAxis: {
			  min: min,
			  max: max,
			  title: {
		            enabled: true,
		            text: unitWord,
		            style: {
		                fontWeight: 'normal'
		            }
		        }
		  },
		  xAxis: {
		    categories: [
		      {
		        name : "장비 "+subtitle+" 합계"+ typeWord,
		        categories: [{
		          name : "장비 "+subtitle+" 합계"+ typeWord ,
		          categories: ["장비 "+subtitle+" 합계"+ typeWord]
		        }]
		      },
		      {
		        name: "전체 장비 "+subtitle+" 현황" + typeWord,
		        categories: [{
		          name : "전체 장비 "+subtitle+" 현황" + typeWord,
		         categories: ["1천만원이상 ~ 3천만원미만", "3천만원이상 ~ 1억원미만", "1억원이상 ~ 5억원미만", "5억원 이상"]
		        }]
		      },
		      {
		        name: "장비 유형별 "+subtitle+" 현황" + typeWord,
		        categories: [
		          {
		          name : "주장비" + typeWord,
		          categories: ["1천만원이상 ~ 3천만원미만", "3천만원이상 ~ 1억원미만", "1억원이상 ~ 5억원미만", "5억원 이상"]
		          },
		          {
		          name : "부대장비" + typeWord,
		          categories: ["1천만원이상 ~ 3천만원미만", "3천만원이상 ~ 1억원미만", "1억원이상 ~ 5억원미만", "5억원 이상"]
		          },
		          {
		          name : "보조장비" + typeWord,
		          categories: ["1천만원이상 ~ 3천만원미만", "3천만원이상 ~ 1억원미만", "1억원이상 ~ 5억원미만", "5억원 이상"]
		          },
		          {
		          name : "기타장비" + typeWord,
		          categories: ["1천만원이상 ~ 3천만원미만", "3천만원이상 ~ 1억원미만", "1억원이상 ~ 5억원미만", "5억원 이상"]
		          }
		        ]
		      }
		    ]
		    , labels: {
		        rotation: 0,
		        x: -8,
		        style: {
		        fontSize: '13px',
		        align: 'Right'
		      }
			}
		  }
		});

}

</script>
