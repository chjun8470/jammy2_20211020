<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="vStartP" value="7000000" />

<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, Object> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, Object>(): (HashMap<String, Object>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, Object>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, Object>>(): (ArrayList<HashMap<String, Object>>)request.getAttribute("dataList");
// 	HashMap<String, Object> excelMap = request.getAttribute("excelMap") == null ? new HashMap<String, Object>(): (HashMap<String, Object>)request.getAttribute("excelMap");
// 	HashMap<String, Object> fileMap1 = request.getAttribute("fileMap1") == null ? new HashMap<String, Object>(): (HashMap<String, Object>)request.getAttribute("fileMap1");
// 	HashMap<String, Object> fileMap2 = request.getAttribute("fileMap2") == null ? new HashMap<String, Object>(): (HashMap<String, Object>)request.getAttribute("fileMap2");
// 	HashMap<String, Object> fileMap3 = request.getAttribute("fileMap3") == null ? new HashMap<String, Object>(): (HashMap<String, Object>)request.getAttribute("fileMap3");
// 	HashMap<String, Object> fileMap4 = request.getAttribute("fileMap4") == null ? new HashMap<String, Object>(): (HashMap<String, Object>)request.getAttribute("fileMap4");
// 	HashMap<String, Object> fileMap5 = request.getAttribute("fileMap5") == null ? new HashMap<String, Object>(): (HashMap<String, Object>)request.getAttribute("fileMap5");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

//     String imgEtc = "/img/back/comm/ico_file.png";
//     String imgExcel = "/img/back/comm/excel.png";
//     String imgHw = "/img/back/comm/hw.jpg";

	int stYear = 2010;
	int nowYear = Calendar.getInstance().get(Calendar.YEAR);
	int edYear = nowYear + 3;
%>

<style type="text/css">
.bu_tit {padding-left:22px !important; margin:21px 0 14px 0 !important; background:url("<c:url value='/images/bl_circle.gif' />") no-repeat left 50% !important; font-size:15px !important; color:#393939 !important;}
.conts .cont02 .list_box .list_table {width: 100%;border-collapse: collapse;margin-top: 8px;}
.conts .cont02 .list_box .list_table th,td{padding: 8px 0;border: 1px solid #ddd; text-align:center}
.conts .cont02 .list_box .list_table th{background-color: #f5f5f5;}
.conts span.title-left{border-left: 5px solid #0198ce;padding-left: 5px;}
 </style>
<div class="tabBox_pub">
	<ul>
		<li><a href="#" onclick="setRefresh('excel')">????????????</a></li>
		<%if("99".equals(loginVO.getAuthLv())){ %>
		<li><a href="#" onclick="setRefresh('excelEdit')">????????????</a></li>
		<%} %>
		<li class="on"><a href="#" onclick="setRefresh('list')">?????????</a></li>
	</ul>
</div>

<form action="/sys/sys_use_status_write.do" id="submitForm">
	<input type="hidden" name="mode" id="submitMode" value=""/>
	<input type="hidden" name="useYear" id="submitUseYear" value="<%=util.getStr(paramMap.get("userYear"))%>"/>
	<input type="hidden" name="orgGrpCd" id="submitOrgGrpCd" value="<%=util.getStr(paramMap.get("orgGrpCd"))%>"/>
	<input type="hidden" name="orgGrpNm" id="submitOrgGrpNm" value="<%=util.getStr(paramMap.get("orgGrpNm"))%>"/>
</form>


<div class="basic_grid">
	<form method="get" action="./<%=myPage%>" id="searchForm" name="searchForm">
		<input type="hidden" name = "mode" id = "mode" value="<%=mode%>"/>
		<input type="hidden" name = "nowPage" id = "nowPage" />
		<div class="search_box" style="padding:10px">
			<div class="board-search">
				<label for="search_year">??????</label>
				<select class="select" id="searchYear" name="searchYear">
					<option value="" >??????</option>
					<%String selected2="";
						for(int i=stYear ; i<edYear ; i++){
					%>
						<option value="<%=i%>" <%if(util.getStr(paramMap.get("searchYear")).equals(String.valueOf(i))) { %> selected="selected" <% } %>><%=i%></option>
					<%}%>
				</select>
				<label for="orgGrpNm">??????</label>
				<input type="text" class="inp_txt" name="orgGrpNm" id="orgGrpNm" value="<%=util.getStr(paramMap.get("orgGrpNm"))%>" />
				<input type="hidden" name="useState" value="2" />
				<%if("99".equals(loginVO.getAuthLv())){ %>
				<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm1" class="btn_inp_b_01" style="display: inline-block;" onclick="popupWindow('orgList','2')">
				<%} %>
				<input type="button" class="btn_inp_g_01" value="??????" style="float: right;" onclick="excelList()">
			</div>
		</div><br/>
		<div class="conts">
			<div class="cont02">
				[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=staticVO.getTotalPage()%> page]
				<div class="list_box">
					<table class="list_table">
						<colgroup>
							<col width="5%"/><col width="8%"/><col width="15%"/><col width="18%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="5%"/>
						</colgroup>
						<tr>
							<th rowspan="2">??????</th><th rowspan="2">????????????</th><th rowspan="2">????????????</th><th rowspan="2">?????????</th><th colspan="3">????????????????????????</th><th colspan="2">????????????????????????</th><th rowspan="2">????????????<br>????????????<br>?????????</th><th rowspan="2">????????????<br>???????????????<br>?????????</th><th rowspan="2">??????<br>??????</th>
						</tr>
						<tr><th>?????? ??????</th><th>?????????</th><th>????????????</th><th>????????????</th><th>????????????</th></tr>
						<%
						if(dataList.size()>0){
							int cnt = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
							for(HashMap rs : dataList){
						%>
						<tr>
							<td><%=cnt%></td>
							<td><%=util.getStr(rs.get("useYear"))%></td>
							<td><%=util.getStr(rs.get("useStDt"))%>~<%=util.getStr(rs.get("useEdDt"))%></td>
							<%if("99".equals(loginVO.getAuthLv())){ %>
							<td style="cursor:pointer;" onclick="editExcel('<%=util.getStr(rs.get("useYear"))%>','<%=util.getStr(rs.get("orgGrpCd"))%>','<%=util.getStr(rs.get("orgGrpNm"))%>')"><%=util.getStr(rs.get("orgGrpNm"))%></td>
							<%} else {%>
							<td><%=util.getStr(rs.get("orgGrpNm"))%></td>
							<%} %>
							<td>
								<%if(util.getStr(rs.get("fileDataIdx1")).equals("") || util.getStr(rs.get("fileDataIdx1")) == null){ %>?????????<%} else { %>??????<%} %>
							</td>
							<td>
								<%if(util.getStr(rs.get("fileDataIdx2")).equals("") || util.getStr(rs.get("fileDataIdx2")) == null){ %>?????????<%} else { %>??????<%} %>
							</td>
							<td>
								<%if(util.getStr(rs.get("fileDataIdx3")).equals("") || util.getStr(rs.get("fileDataIdx3")) == null){ %>?????????<%} else { %>??????<%} %>
							</td>
							<td>
								<%if(util.getStr(rs.get("fileDataIdx4")).equals("") || util.getStr(rs.get("fileDataIdx4")) == null){ %>?????????<%} else { %>??????<%} %>
							</td>
							<td>
								<%if(util.getStr(rs.get("fileDataIdx5")).equals("") || util.getStr(rs.get("fileDataIdx5")) == null){ %>?????????<%} else { %>??????<%} %>
							</td>
							<td>
								<%if(util.getStr(rs.get("fileDataIdx6")).equals("") || util.getStr(rs.get("fileDataIdx6")) == null){ %>?????????<%} else { %>??????<%} %>
							</td>
							<td>
								<%if(util.getStr(rs.get("fileDataIdx7")).equals("") || util.getStr(rs.get("fileDataIdx7")) == null){ %>?????????<%} else { %>??????<%} %>
							</td>
							<td>
								<%if(util.getStr(rs.get("jointType")).equals("") || util.getStr(rs.get("jointType")) == null  || util.getStr(rs.get("jointType")).equals("2")){ %>?????????<%} else { %>??????<%} %>
							</td>
						</tr>
						<%
							cnt--;
							}
						}else{%>
							<tr>
								<td colspan="12" style="text-align:center">???????????? ????????????.</td>
							</tr>
						<%}%>
					</table>
					<%=util.getPaging(staticVO, nowPage) %>
				</div>
			</div>
		</div>
	</form>
</div>

 <script type="text/javascript">
	$(document).ready(function(){
		$("#useStDt, #useEdDt").datepicker({
			showMonthAfterYear : true,
			showButtonPanel : true,
			changeMonth : true,
			changeYear : true,
			nextText : '?????? ???',
			prevText : '?????? ???',
			currentText : '?????? ??????',
			closeText : '??????',
			dateFormat : "yy-mm-dd",
			dayNames : [ '?????????', '?????????', '?????????', '?????????', '?????????', '?????????', '?????????' ],
			dayNamesMin : [ '???', '???', '???', '???', '???', '???', '???' ],
			monthNames : [ '1???', '2???', '3???', '4???', '5???', '6???', '7???', '8???', '9???', '10???', '11???', '12???' ],
			monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
		});
		// ????????? ?????? ?????? ????????? ?????? ??? ??????
	    $('#useStDt').datepicker("option", "maxDate", $("#useEdDt").val());
	    $('#useStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#useEdDt").datepicker( "option", "minDate", selectedDate );
	    });
		// ????????? ?????? ?????? ????????? ?????? ??? ??????
	    $('#useEdDt').datepicker("option", "minDate", $("#useStDt").val());
	    $('#useEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#useStDt").datepicker( "option", "maxDate", selectedDate );
		});
	})

//???????????? ??????
function popupWindow(listMode,userTp){
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
	var orgGrpCd = orgGrpCd;
	var orgGrpNm;
	var result = "";
	var params = {
			"orgGrpCd": orgGrpCd
	};
	$.post("/sys/getOrgInfo.do",$.param(params),
	function(data){
		if(cnt != 'cnt'){$("#deptNm").val("");$("#positionNm").val("");}
		orgGrpNm = data.dataMap.ORG_GRP_NM;
		$("#orgGrpNm").val(orgGrpNm);
		if($("input[type=radio][name='userTp']:checked").val() == '2'){
    		$('#blngOrgNm').show();
    		$("#deptNm").removeAttr("readonly");
		}else if($("input[type=radio][name='userTp']:checked").val() == '3'){
    		$('#deptTh').show();
    		$('#deptTd').show();
    	}
	});
}

function excelList(){
	$("#searchForm").submit();
}

function setRefresh(mode){
	$("#submitMode").val(mode);
	$("#submitForm").submit();
}

function editExcel(useYear,orgGrpCd,orgGrpNm){
	$("#submitUseYear").val(useYear);
	$("#submitOrgGrpCd").val(orgGrpCd);
	$("#submitOrgGrpNm").val(orgGrpNm);
	$("#submitMode").val('excelEdit');
	$("#submitForm").submit();
}
 </script>