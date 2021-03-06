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
	types.put("type0", "????????????");
	types.put("type1", "1????????? ?????? ~ 3????????? ??????");
	types.put("type2", "3????????? ?????? ~ 1?????? ??????");
	types.put("type3", "1?????? ?????? ~ 5?????? ??????");
	types.put("type4", "5?????? ??????");

	int[] chartCnts = new int[27];

	int cnt = 0;
	for(HashMap data : dataListAll){
		if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){
			chartCnts[cnt] = util.getInt(data.get("yearCntTotal"));
			chartCnts[cnt+1] = util.getInt(data.get("yearCntCenterGov")) + util.getInt(data.get("yearCntCenterEtc")) + util.getInt(data.get("yearCntOther"));
			chartCnts[cnt+2] = util.getInt(data.get("yearCntCenterOut"));
		}else{
			chartCnts[cnt+3] = util.getInt(data.get("yearCntTotal"));
			chartCnts[cnt+7] = util.getInt(data.get("yearCntCenterGov")) + util.getInt(data.get("yearCntCenterEtc")) + util.getInt(data.get("yearCntOther"));
			chartCnts[cnt+11] = util.getInt(data.get("yearCntCenterGov"));
			chartCnts[cnt+15] = util.getInt(data.get("yearCntCenterEtc"));
			chartCnts[cnt+19] = util.getInt(data.get("yearCntOther"));
			chartCnts[cnt+23] = util.getInt(data.get("yearCntCenterOut"));
			cnt++;
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
			<li <%if(util.getStr(paramMap.get("useState")).equals("1") || util.getStr(paramMap.get("useState")).equals("")) { %> class="on" <% } %> ><a href="#" onclick="useTab('1')">????????????</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("2")) { %> class="on" <% } %> ><a href="#" onclick="useTab('2')">????????????????????? ??????</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("3")) { %> class="on" <% } %> ><a href="#" onclick="useTab('3')">??????????????? ?????? ??????</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("4")) { %> class="on" <% } %> ><a href="#" onclick="useTab('4')">??????????????? ??????</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("5")) { %> class="on" <% } %> ><a href="#" onclick="useTab('5')">???????????? ??????</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("6")) { %> class="on" <% } %> ><a href="#" onclick="useTab('6')">????????? ?????? ??????</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("7")) { %> class="on" <% } %> ><a href="#" onclick="useTab('7')">??????????????? ??????</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("8")) { %> class="on" <% } %> ><a href="#" onclick="useTab('8')">???????????? ??????</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("9")) { %> class="on" <% } %> ><a href="#" onclick="useTab('9')">????????? ??????</a></li>
			<li <%if(util.getStr(paramMap.get("useState")).equals("10")) { %> class="on" <% } %> ><a href="#" onclick="useTab('10')">???????????? ??????</a></li>
		</ul>
	</div>
	<form id = "searchForm" name = "searchForm" method="post" action="./<%=myPage%>">
		<input type="hidden" name = "nowPage" id = "nowPage" value="<%=util.getStr(paramMap.get("nowPage"))%>"/>
		<input type="hidden" name = "mode" id = "mode" value="<%=util.getStr(paramMap.get("mode"))%>"/>
		<input type="hidden" name = "useState" id = "useState" value="<%=util.getStr(paramMap.get("useState"))%>"/>
		<input type="hidden" name = "orgGrpCd" id = "orgGrpCd" value="<%=util.getStr(paramMap.get("orgGrpCd"))%>"/>
		<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<label for="search_year">??????</label>
						<select name="jointYear" id="jointYear" class="select" >
							<option value="" >??????</option>
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
					<label for="orgGrpNm">??????</label>
						<input type="text" class="inp_txt" name="orgGrpNm" id="orgGrpNm" value="<%=util.getStr(paramMap.get("orgGrpNm")) %>" readonly="readonly" />
						<%if("99".equals(util.getStr(loginVO.getAuthLv()))){ %>
							<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="btn_inp_b_01" style="display: inline-block;" onclick="popupOrgWindow('orgList','2')" />
						<%} %>
					<!-- ???????????? -->
					<button type="button" class="btn_inp_g_01" onclick="pageSearchGo()" style="float: right;">??????</button>
				</div>
				<!-- board-search -->
			 </div>
		</div>
		<!-- bbs-top e -->
	</form>

	<div id="chartContainer" style="min-width: 360px; height: 600px; margin: 30px auto"></div>

	<div class="total" style="margin-top: 10px;">
		<span style="float: right; margin-bottom: 5px;">
		<button type="button" id="excelDownload" class="btn_inp_b_01"  onclick="excelDown()">??????????????????</button>
		</span>
	</div>
	<div>
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
					<th scope="col" rowspan="3" colspan="2" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">??????</th>
					<th scope="col" colspan="5" style = "border-right: solid 1px #e0e0e0;">???????????? ??????</th>
					<th scope="col" rowspan="3" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">???????????????<br/>(???, VAT??????)</th>
				</tr>
				<tr>
					<th scope="col" rowspan="2" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">??????</th>
					<th scope="col" colspan="3" style = "border-right: solid 1px #e0e0e0;">????????????</th>
					<th scope="col" rowspan="2" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">????????????</th>
				</tr>
				<tr>
					<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">R&D</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;">????????????</th>
					<th scope="col" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">???????????????</th>
				</tr>
			</thead>
			<tbody>
			<%for(HashMap data : dataListAll){%>
				<tr>
					<%if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
					<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">??????<br/>??????</th>
					<%}%>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntTotal")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterGov")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterEtc")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntOther")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterOut")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("yearPrice"))) %></p></td>
				</tr>
			<%} %>
			<%for(HashMap data : dataListJeinet){%>
				<tr>
					<%if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
					<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">JEINET</th>
					<%}%>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntTotal")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterGov")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterEtc")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntOther")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterOut")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("yearPrice"))) %></p></td>
				</tr>
			<%} %>
			<%for(HashMap data : dataListZeus){%>
				<tr>
					<%if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
					<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">ZEUS</th>
					<%}%>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntTotal")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterGov")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterEtc")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntOther")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterOut")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("yearPrice"))) %></p></td>
				</tr>
			<%} %>
			<%for(HashMap data : dataListEtube){%>
				<tr>
					<%if("type0".equals(util.getStr(data.get("eqInfoPriceType")))){ %>
					<th scope="col" rowspan="5" style = "border-right: solid 1px #e0e0e0; border-left: solid 1px #e0e0e0;">E-Tube</th>
					<%}%>
					<th scope="col" style = "border-right: solid 1px #e0e0e0;"><%=types.get(util.getStr(data.get("eqInfoPriceType")))%></th>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntTotal")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterGov")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterEtc")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntOther")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getStr(data.get("yearCntCenterOut")) %></p></td>
					<td scope="col" style = "border-right: solid 1px #e0e0e0;"><p class="scope111"><%=util.getComma(util.getStr(data.get("yearPrice"))) %></p></td>
				</tr>
			<%} %>

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
		nextText : '?????? ???',
		prevText : '?????? ???',
		currentText : '?????? ??????',
		closeText : '??????',
		dateFormat : "yy-mm-dd",
		dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		dayNamesMin : ['???','???','???','???','???','???','???'],
		monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
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
	$('#useState').val(10);
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

	//???????????? ??????
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

//????????????
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
	var chartData; var subtitle;var min; var max;
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
		subtitle = "????????????";
		min = 0; max = 500;
	}
	var chart = new Highcharts.Chart({
		  chart: {
		    renderTo: "chartContainer",
		    type: "bar"
		  },
		  title: {
			    text: "???????????? ??????(???)"
			  },
		  series: [
		    {
		      name: "??????(???)",
		      data:chartData
		    }
		  ],
		  yAxis: {
			  min: min,
			  max: max,
			  title : null
		  },
		  xAxis: {
		    categories: [
		      {
		        name : "???????????? "+subtitle+" ??????(???)",
		        categories: [{
		          name : "???????????? "+ subtitle + " ??????(???)",
		          categories: ["????????????  " +subtitle+ " ??????(???)"]
		        }]
		      },
		      {
		        name: "?????? "+subtitle+"(???)",
		        categories: [{
		          name : "?????? "+subtitle+"(???)",
		         categories: ["?????? "+subtitle+ "(???)"]
		        }]
		      },
		      {
	    	  	name: "?????? "+subtitle+"(???)",
		        categories: [{
		          name : "?????? "+subtitle+"(???)",
		         categories: ["?????? "+subtitle+"(???)"]
		        }]
		      },
		      {
	    	 	name: "?????? ???????????? " + subtitle + "<br>(???)",
		        categories: [{
		          name : "?????? ???????????? "+subtitle +"<br>(???)",
		          categories: ["1??????????????? ~ 3???????????????", "3??????????????? ~ 1????????????", "1???????????? ~ 5????????????", "5?????? ??????"]
		        }]
		      },
		      {
		        name: "??????"+subtitle+"(???)",
		        categories: [
		          {
		          name : "??????"+subtitle+"??????(???)",
		          categories: ["1??????????????? ~ 3???????????????", "3??????????????? ~ 1????????????", "1???????????? ~ 5????????????", "5?????? ??????"]
		          },
		          {
		          name : "R&D",
		          categories: ["1??????????????? ~ 3???????????????", "3??????????????? ~ 1????????????", "1???????????? ~ 5????????????", "5?????? ??????"]
		          },
		          {
		          name : "????????????",
		          categories: ["1??????????????? ~ 3???????????????", "3??????????????? ~ 1????????????", "1???????????? ~ 5????????????", "5?????? ??????"]
		          },
		          {
		          name : "???????????????",
		          categories: ["1??????????????? ~ 3???????????????", "3??????????????? ~ 1????????????", "1???????????? ~ 5????????????", "5?????? ??????"]
		          }
		        ]
		      },
		      {
		        name: "??????"+subtitle+"(???)",
		        categories: [{
		          name : "??????"+subtitle+"(???)",
		          categories: ["1??????????????? ~ 3???????????????", "3??????????????? ~ 1????????????", "1???????????? ~ 5????????????", "5?????? ??????"]
		        }]
		      }
		    ]
		    , labels: {
		        rotation: 0,
		        x: -8,
		        style: {
		        fontSize: '13px',
		        align: 'Right'
		      }
		},
		  }
		});

}

</script>

