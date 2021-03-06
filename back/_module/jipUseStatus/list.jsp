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
	ArrayList<HashMap<String, String>> dataMap = request.getAttribute("dataMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String fileGrp = "jipUseStatus";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

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

<script type="text/javascript">
$(document).ready(function() {
	$("#transferStDt, #transferEdDt, #transferDate").datepicker({
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

	$('#transferStDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#transferEdDt").datepicker( "option", "minDate", selectedDate );
    });

	$('#transferEdDt').datepicker("option", "onClose", function ( selectedDate ) {
        $("#transferStDt").datepicker( "option", "maxDate", selectedDate );
    });

	$("#transferDate, #transferStDt, #transferEdDt").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;\-]/gi,''));
        }
    });

	$("#transferPhone1, #transferPhone2").keyup(function(event) {
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;\-]/gi,''));
        }
	});

	$("#flatSumSkillFee").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
        }
    });
});
</script>

<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post" action="./<%=myPage%>">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<label for="stateType" class="hide">??????</label>
							<select name="stateType" id="stateType" class="select" style="height: 24px;">
								<option value="">??????</option>
								<option value="1" <%if(util.getStr(paramMap.get("stateType")).equals("1")) { %> selected="selected" <% } %>>??????</option>
								<option value="2" <%if(util.getStr(paramMap.get("stateType")).equals("2")) { %> selected="selected" <% } %>>??????</option>
								<option value="3" <%if(util.getStr(paramMap.get("stateType")).equals("3")) { %> selected="selected" <% } %>>??????</option>
							</select>

							<label for="seType">????????????</label>
							<select name="seType" id="seType" class="select" style="height: 24px;">
								<option value="">??????</option>
								<option value="1" <%if(util.getStr(paramMap.get("seType")).equals("1")) { %> selected="selected" <% } %>>??????</option>
								<option value="2" <%if(util.getStr(paramMap.get("seType")).equals("2")) { %> selected="selected" <% } %>>????????????</option>
								<option value="3" <%if(util.getStr(paramMap.get("seType")).equals("3")) { %> selected="selected" <% } %>>?????????</option>
								<option value="4" <%if(util.getStr(paramMap.get("seType")).equals("4")) { %> selected="selected" <% } %>>??????</option>
								<option value="5" <%if(util.getStr(paramMap.get("seType")).equals("5")) { %> selected="selected" <% } %>>????????????</option>
								<option value="6" <%if(util.getStr(paramMap.get("seType")).equals("6")) { %> selected="selected" <% } %>>?????????</option>
							</select>

							<label for="tfSe">????????????</label>
							<select name="tfSe" id="tfSe" class="select" style="height: 24px">
								<option value="">??????</option>
								<option value="01" <%if(util.getStr(paramMap.get("tfSe")).equals("01")) { %> selected="selected" <% } %>>??????</option>
								<option value="02" <%if(util.getStr(paramMap.get("tfSe")).equals("02")) { %> selected="selected" <% } %>>????????????</option>
								<option value="03" <%if(util.getStr(paramMap.get("tfSe")).equals("03")) { %> selected="selected" <% } %>>????????? ????????????</option>
								<option value="04" <%if(util.getStr(paramMap.get("tfSe")).equals("04")) { %> selected="selected" <% } %>>????????????</option>
								<option value="05" <%if(util.getStr(paramMap.get("tfSe")).equals("05")) { %> selected="selected" <% } %>>???????????????</option>
								<option value="06" <%if(util.getStr(paramMap.get("tfSe")).equals("06")) { %> selected="selected" <% } %>>??????</option>
							</select>&nbsp;

							<label for="searchType" class="hide">????????????</label>
							<select name="searchType" id="searchType" class="select" style="height: 24px;">
								<option value="">??????</option>
								<option value="name" <%if(util.getStr(paramMap.get("searchType")).equals("name")) { %> selected="selected" <% } %>>???????????????</option>
								<option value="code" <%if(util.getStr(paramMap.get("searchType")).equals("code")) { %> selected="selected" <% } %>>????????????</option>
							</select>
							<!-- ????????? -->
							 <label for="searchWord" class="hide">?????????</label>
							<input type="text" name="searchWord" id="searchWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
							<!-- ???????????? -->
						<button type="button" class="btn_inp_g_01" onclick="pageSearchGo()" style="float: right;">??????</button>
						</div>
						<!-- board-search -->
					 </div>
				</div>
			<!-- bbs-top e -->
</form>
			<div class="total" style="margin-top: 10px;">
				[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				<span style="float: right; margin-bottom: 5px;">
				<button type="button" id="excelUp" onclick="excelForm()" class="btn_inp_b_01">???????????????</button>
				<button type="button" class="btn_inp_b_01" onclick="location.href='/sys/jipUseStatusExcel.do'">?????? ????????????</button>
				</span>
			</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
			<colgroup>
				<col width="10%" />
				<col width="10%" />
				<col width="30%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
				<col width="10%" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">???????????????(????????????)</th>
					<th scope="col">????????????</th>
					<th scope="col">???????????????</th>
					<th scope="col">????????????<br/>(?????????)</th>
					<th scope="col">????????????</th>
					<th scope="col">??????</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataMap) {%>
				<tr>
					<td scope="col"><%=util.getStr(rs.get("JIP_USE_IDX")) %></td>
					<td scope="col">
						<%if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("1")) {
						 out.println("??????");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("2")) {
						 out.println("????????????");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("3")) {
						 out.println("?????????");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("4")) {
						 out.println("??????");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("5")) {
						 out.println("????????????");
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("6")) {
						 out.println("?????????");
						} %>
					</td>
					<td scope="col" style="cursor: pointer;" onclick="statusView('<%=util.getStr(rs.get("JIP_USE_IDX")) %>')">
						<%if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("1")) {
							out.println(util.getStr(rs.get("INVENTION_KOR_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("2")) {
							out.println(util.getStr(rs.get("INVENTION_KOR_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("3")) {
							out.println(util.getStr(rs.get("D_USE_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("4")) {
							out.println(util.getStr(rs.get("B_USE_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("5")) {
							out.println(util.getStr(rs.get("P_USE_NM")));
						} else if(util.getStr(String.valueOf(rs.get("RIGHT_SECTION"))).equals("6")) {
							out.println(util.getStr(rs.get("TCHNLGY_NM")));
						} %>
						<%="(" + util.getStr(rs.get("REGIST_INFO")) + ")" %>
					</td>
					<td scope="col">
						<%if(util.getStr(rs.get("TRANSFER_SECTION")).equals("01")) {
							out.println("??????");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("02")) {
							out.println("????????????");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("03")) {
							out.println("????????? ????????????");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("04")) {
							out.println("????????????");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("05")) {
							out.println("????????? ??????");
						} else if(util.getStr(rs.get("TRANSFER_SECTION")).equals("06")) {
							out.println("??????");
						}
						%>
					</td>
					<td scope="col">
						<%=util.getStr(rs.get("ORG_GRP_NM")) %>
					</td>
					<td scope="col"><%=util.getStr(rs.get("TRANSFER_PERSON"))%></td>
					<td scope="col">
						<%if(util.getStr(rs.get("ETERNITY_YN")).equals("Y")) { %>
							??????
						<% } else { %>
							<%=util.getStr(rs.get("TRANSFER_ST_DT")) %><br/>
							<%=util.getStr(rs.get("TRANSFER_ED_DT")) %>
						<% } %>
					</td>
					<td>
						<%if(util.getStr(rs.get("STATE")).equals("1")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_1.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("2")) { %> <img alt="??????" src="/img/back/comm/edu_state_img_07.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("3")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_3.png"> <% } %>
						<%if(util.getStr(rs.get("STATE")).equals("5")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_5.png"> <% } %>
					</td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<div align="right">
			<button type="button" class="btn_inp_b_01" onclick="goWrite()" >??????</button>
		</div>
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<div class="layer2">
	<div class="bg2"></div>
	<div id="viewLayer" class="pop-layer2">
	<input type="hidden" name="viewStatusIdx"	id="viewStatusIdx" />
		<h3>???????????? ?????? ??????</h3>
		<table class="skin_basic_write" id="viewStatus">
			<colgroup>
				<col width="22%">
				<col width="25%">
				<col width="23%">
				<col width="30%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col" colspan="4">??????????????????</th>
				</tr>
				<tr>
					<th scope="col">????????????</th>
					<td scope="col" id="viewRightSection"></td>
					<th scope="col">????????????</th>
					<td scope="col" id="viewRegistInfo"></td>
				</tr>
				<tr>
					<th scope="col">???????????????</th>
					<td colspan="3" id="viewName"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">????????????</th>
				</tr>
				<tr>
					<th scope="col">????????????</th>
					<td scope="col" id="viewTransferSection"></td>
					<th scope="col">?????????</th>
					<td scope="col" id="viewTransferDate"></td>
				</tr>
				<tr>
					<th scope="col">????????????</th>
					<td scope="col" id="viewPossessOrg"></td>
					<th scope="col">????????????</th>
					<td scope="col" id="viewBInstitution"></td>
				</tr>
				<tr>
					<th scope="col">???????????????(???)</th>
					<td scope="col" id="viewFlaSumSkillFee"></td>
					<th scope="col">???????????????</th>
					<td scope="col" id="viewOrdinarySkillFee"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">????????????</th>
				</tr>
				<tr id="eternityLine">
					<td colspan="4" id="eternity"></td>
				</tr>
				<tr id="viewTransferTerm">
					<th scope="col">?????????</th>
					<td scope="col" id="viewTransferStDt"></td>
					<th scope="col">?????????</th>
					<td scope="col" id="viewTransferEdDt"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">????????????</th>
				</tr>
				<tr>
					<th scope="col">?????????(?????????)</th>
					<td scope="col" id="viewTransferPerson"></td>
					<th scope="col">?????????</th>
					<td scope="col" id="viewTransferDelegate"></td>
				</tr>
				<tr>
					<th scope="col">?????????/??????</th>
					<td scope="col" id="viewTransferPosition"></td>
					<th scope="col">????????????</th>
					<td scope="col" id="viewTransferPhone1"></td>
				</tr>
				<tr>
					<th scope="col">????????????</th>
					<td scope="col" id="viewTransferPhone2"></td>
					<th scope="col">?????????</th>
					<td scope="col" id="viewTransferEmail"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">??????</th>
				</tr>
				<tr>
					<td colspan="4" id="viewNote"></td>
				</tr>
				<tr>
					<th scope="col">??????</th>
					<td scope="col" id="viewState"></td>
					<th scope="col" id="rejectCell"></th>
					<td scope="col" id="viewReject"></td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn_inp_w_01" id="vcbtn" style="float: right">??????</button>
		<button type="button" class="btn_inp_b_01" id="dbtn" style="float: right" onclick="delProc()">??????</button>
		<button type="button" class="btn_inp_b_01" style="float: right" onclick="statusEdit()">??????</button>
	<%if(util.getStr(loginVO.getAuthLv()).equals("99")) { %>
		<div align="left">
			<button type="button" class="btn_inp_b_01" id="btnAdmission" onclick="stateAdmission('2')">??????</button>
			<button type="button" class="btn_inp_b_01" id="btnReject" onclick="showRejectArea()">??????</button>
		</div>
		<div id="rejectArea" style="display:none;">
			<label for="reject">????????????</label>
			<input type="text" class="inp_text" name="reject" id="reject">
			<button type="button" class="btn_inp_b_01" id="rejectInput" onclick="stateReject('3')">????????????</button>
			<button type="button" class="btn_inp_b_01" id="rejectCancle" onclick="hideRejectArea()">??????</button>
		</div>
	<% } %>
	</div>
</div>

<div class="layer">
	<div class="bg"></div>
	<div id="layer2" class="pop-layer">
	<form name="editStatus" id="editStatus" method="post" action="">
		<input type="hidden" name="jipUseIdx" id="jipUseIdx" />
		<h3>???????????? ???????????? ??????</h3>
		<table class="skin_basic_write" id="editViewStatus">
			<colgroup>
				<col width="22%">
				<col width="25%">
				<col width="23%">
				<col width="30%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col" colspan="4">??????????????????</th>
				</tr>
				<tr>
					<th scope="col"><label for="rightSection">????????????</label></th>
					<td scope="col">
						<select name="rightSection" id="rightSection" class="inp_text">
							<option value="1">??????</option>
							<option value="2">????????????</option>
							<option value="3">?????????</option>
							<option value="4">??????</option>
							<option value="5">????????????</option>
							<option value="6">?????????</option>
						</select>
					</td>
					<th scope="col"><label for="registInfo">????????????</label></th>
					<td scope="col"><input type="text" name="registInfo" id="registInfo" class="inp_text"/>&nbsp;<button class="btn_inp_w_01" type="button" onclick="popupWindow()">??????</button></td>
				</tr>
				<tr>
					<th scope="col">???????????????</th>
					<td colspan="3" id="name"></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">????????????</th>
				</tr>
				<tr>
					<th scope="col"><label for="transferSection">????????????</label></th>
					<td scope="col">
						<select name="transferSection" id="transferSection" class="inp_text">
							<option value="01">??????</option>
							<option value="02">????????????</option>
							<option value="03">????????? ????????????</option>
							<option value="04">????????????</option>
							<option value="05">???????????????</option>
							<option value="06">??????</option>
						</select>
					</td>
					<th scope="col"><label for="transferDate">?????????</label></th>
					<td scope="col"><input type="text" name="transferDate" id="transferDate" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col">????????????</th>
					<td scope="col" id="possessOrg"></td>
					<th scope="col"><label for="brokerageInstitution">????????????</label></th>
					<td scope="col"><input type="text" name="brokerageInstitution" id="brokerageInstitution" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col"><label for="flatSumSkillFee">???????????????(???)</label></th>
					<td scope="col"><input type="text" name="flatSumSkillFee" id="flatSumSkillFee" class="inp_text"/></td>
					<th scope="col"><label for="ordinarySkillFee">???????????????</label></th>
					<td scope="col"><input type="text" name="ordinarySkillFee" id="ordinarySkillFee" class="inp_text"/></td>
				</tr>
				<tr>
					<th scope="col" colspan="4">???????????? <input type="checkbox" name="eternityYN" id="eternityYN" value="N" /><label for="eternityYN">??????</label></th>
				</tr>
				<tr id="transferTerm">
					<th scope="col"><label for="transferStDt">?????????</label></th>
					<td scope="col"><input type="text" name="transferStDt" id="transferStDt" class="inp_text"/></td>
					<th scope="col"><label for="transferEdDt">?????????</label></th>
					<td scope="col"><input type="text" name="transferEdDt" id="transferEdDt" class="inp_text"/> </td>
				</tr>
				<tr>
					<th scope="col" colspan="4">????????????</th>
				</tr>
				<tr>
					<th scope="col"><label for="transferPerson">?????????(?????????)</label></th>
					<td scope="col"><input type="text" name="transferPerson" id="transferPerson" class="inp_text"/></td>
					<th scope="col"><label for="transferDelegate">?????????</label></th>
					<td scope="col"><input type="text" name="transferDelegate" id="transferDelegate" class="inp_text" /></td>
				</tr>
				<tr>
					<th scope="col"><label for="transferPosition">?????????/??????</label></th>
					<td scope="col"><input type="text" name="transferPosition" id="transferPosition" class="inp_text" /></td>
					<th scope="col"><label for="transferPhone1">????????????</label></th>
					<td scope="col"><input type="text" name="transferPhone1" id="transferPhone1" class="inp_text" /></td>
				</tr>
				<tr>
					<th scope="col"><label for="transferPhone2">????????????</label></th>
					<td scope="col"><input type="text" name="transferPhone2" id="transferPhone2" class="inp_text" /></td>
					<th scope="col"><label for="transferEmail">?????????</label></th>
					<td scope="col"><input type="text" name="transferEmail" id="transferEmail" class="inp_text" /></td>
				</tr>
				<tr>
					<th scope="col" colspan="4"><label for="note">??????</label></th>
				</tr>
				<tr>
					<td colspan="4"><textarea name="note" id="note" rows="" cols="" style="width: 100%;"></textarea></td>
				</tr>
			</tbody>
		</table>
		<button type="button" class="btn_inp_w_01" id="cbtn" style="float: right">??????</button>
		<button type="button" class="btn_inp_b_01" id="pbtn" style="float: right" onclick="editProc()">??????</button>
	</form>
	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#jipUseStatusIdx').val(idx);
		$('#searchForm').submit();
	}
	function excelForm() {
		$("#mode").val("excel");
		$("#searchForm").submit();
	}

	function statusView(idx) {
		$("#viewStatus td").text("");
		$.ajax({
			url : "/sys/jipUseStatus.do",
			type : "POST",
			data : {"mode" : "view", "jipUseIdx" : idx},
			success : function(data) {
				$("#viewStatusIdx").val(idx);
				if(data.dataMap.RIGHT_SECTION == "1") {
					$("#viewRightSection").text("??????");
					$("#viewName").text(data.dataMap.INVENTION_KOR_NM);
				} else if(data.dataMap.RIGHT_SECTION == "2") {
					$("#viewRightSection").text("????????????");
					$("#viewName").text(data.dataMap.INVENTION_KOR_NM);
				} else if(data.dataMap.RIGHT_SECTION == "3") {
					$("#viewRightSection").text("?????????");
					$("#viewName").text(data.dataMap.D_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "4") {
					$("#viewRightSection").text("??????");
					$("#viewName").text(data.dataMap.B_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "5") {
					$("#viewRightSection").text("????????????");
					$("#viewName").text(data.dataMap.P_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "6") {
					$("#viewRightSection").text("?????????");
					$("#viewName").text(data.dataMap.TCHNLGY_NM);
				}
				$("#viewPossessOrg").text(data.dataMap.ORG_GRP_NM);
				$("#viewRegistInfo").text(data.dataMap.REGIST_INFO);
				$("#viewTransferSection").text(data.dataMap.TRANSFER_SECTION);
				$("#viewTransferDate").text(data.dataMap.TRANSFER_DATE);
				if(data.dataMap.ETERNITY_YN == 'Y') {
					$("#eternityLine").show();
					$("#viewTransferTerm").hide();
					$("#eternity").text("??????");
				} else {
					$("#eternityLine").hide();
					$("#viewTransferTerm").show();
					$("#viewTransferStDt").text(data.dataMap.TRANSFER_ST_DT);
					$("#viewTransferEdDt").text(data.dataMap.TRANSFER_ED_DT);
				}
				$("#viewTransferPerson").text(data.dataMap.TRANSFER_PERSON);
				$("#viewBInstitution").text(data.dataMap.BROKERAGE_INSTITUTION);
				$("#viewFlaSumSkillFee").text(data.dataMap.FLAT_SUM_SKILL_FEE);
				$("#viewOrdinarySkillFee").text(data.dataMap.ORDINARY_SKILL_FEE);
				$("#viewTransferDelegate").text(data.dataMap.TRANSFER_DELEGATE);
				$("#viewTransferPosition").text(data.dataMap.TRANSFER_POSITION);
				$("#viewTransferPhone1").text(data.dataMap.TRANSFER_PHONE1);
				$("#viewTransferPhone2").text(data.dataMap.TRANSFER_PHONE2);
				$("#viewTransferEmail").text(data.dataMap.TRANSFER_EMAIL);
				$("#viewNote").text(data.dataMap.NOTE);
				if(data.dataMap.STATE != '1') {
					$("#btnAdmission").hide();
					$("#btnReject").hide();
				}
				if(data.dataMap.STATE == '1') {
					$("#btnAdmission").show();
					$("#btnReject").show();
					$("#viewState").text("????????????");
					$("#rejectCell").text("");
					$("#viewReject").text("");
				}
				if(data.dataMap.STATE == '2') {
					$("#viewState").text("??????");
					$("#rejectCell").text("");
					$("#viewReject").text("");
				}
				if(data.dataMap.STATE == '3') {
					$("#viewState").text("??????");
					$("#rejectCell").text("????????????");
					$("#viewReject").text(data.dataMap.REJECT);
				}


				var temp = $("#viewLayer");
				var bg = temp.prev().hasClass('bg2');	//dimmed ???????????? ???????????? ?????? boolean ??????

				if(bg){
					$('.layer2').fadeIn();	//'bg' ???????????? ???????????? ???????????? ???????????? ????????? dimmed ??????.
				}else{
					temp.fadeIn();
				}

				// ????????? ????????? ???????????? ?????????.
				if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
				else temp.css('top', '0px');
				if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
				else temp.css('left', '0px');

				temp.find('#vcbtn').click(function(e){
					if(bg){
						$('.layer2').fadeOut(); //'bg' ???????????? ???????????? ???????????? ???????????? ??????.
						$("#reject").val("");
						$("#rejectArea").hide();
					}else{
						temp.fadeOut();
					}
					e.preventDefault();
				});

				$('.layer2 .bg2').click(function(e){	//????????? ???????????? ???????????? ???????????? ?????? ????????? ?????????
					$('.layer2').fadeOut();
					$("#reject").val("");
					$("#rejectArea").hide();
					e.preventDefault();
				});


				}
		});
	}

	function stateAdmission(value) {
		var idx = $("#viewStatusIdx").val();
		var reject = $("#reject").val("");
		if(confirm('?????????????????????????')) {
			$.ajax({
				url : "/sys/jipUseStatus.do",
				type : "POST",
				data : {"mode" : "state", "idx" : idx, "state" : value},
				success : function() {
					alert("?????????????????????.");
					location.reload();
				},
				error : function() {
					alert("????????? ??????????????????.");
				}
			});
		}
	}

	function showRejectArea() {
		$("#rejectArea").show();
	}

	function hideRejectArea() {
		$("#reject").val("");
		$("#rejectArea").hide();
	}

	function stateReject(value) {
		var idx = $("#viewStatusIdx").val();
		var reject = $("#reject").val();
		if(confirm('?????????????????????????')) {
			$.ajax({
				url : "/sys/jipUseStatus.do",
				type : "POST",
				data : {"mode" : "state", "idx" : idx, "state" : value, "reject" : reject},
				success : function() {
					alert("?????????????????????.");
					location.reload();
				},
				error : function() {
					alert("????????? ??????????????????.");
				}
			});
		}
	}

	function goWrite() {
		$("#name").text("");
		$("#possessOrg").text("");
		$("#eternityYN").attr("checked", false);
		$("#eternityYN").val("N");
		$("#transferTerm").show();
		$("#editStatus").each(function() {
			this.reset();
		});
		$("#editStatus > h3").text("???????????? ???????????? ??????");
		$("#pbtn").attr("onclick", "writeProc()").text("??????");
		$("#dbtn").hide();

		var temp = $("#layer2");
		var bg = temp.prev().hasClass('bg');

		if(bg){
			$('.layer').fadeIn();
		}else{
			temp.fadeIn();
		}

		// ????????? ????????? ???????????? ?????????.
		if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
		else temp.css('top', '0px');
		if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
		else temp.css('left', '0px');

		temp.find('#cbtn').click(function(e){
			if(bg){
				$('.layer').fadeOut();
			}else{
				temp.fadeOut();
			}
			e.preventDefault();
		});

		$('.layer .bg').click(function(e){
			$('.layer').fadeOut();
			e.preventDefault();
		});
	}

	function statusEdit() {
		$("#name").text("");
		$("#possessOrg").text("");
		$("#editStatus > h3").text("???????????? ???????????? ??????");
		var value = $("#viewStatusIdx").val();
		$.ajax({
			url : "/sys/jipUseStatus.do",
			data : {"mode" : "edit", "jipUseIdx" : value},
			success : function(data) {
				$("#jipUseIdx").val(value);
				$("#rightSection").val(data.dataMap.RIGHT_SECTION).attr("selcted", "selected");
				if(data.dataMap.RIGHT_SECTION == "1") {
					$("#name").text(data.dataMap.INVENTION_KOR_NM);
				} else if(data.dataMap.RIGHT_SECTION == "2") {
					$("#name").text(data.dataMap.INVENTION_KOR_NM);
				} else if(data.dataMap.RIGHT_SECTION == "3") {
					$("#name").text(data.dataMap.D_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "4") {
					$("#name").text(data.dataMap.B_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "5") {
					$("#name").text(data.dataMap.P_USE_NM);
				} else if(data.dataMap.RIGHT_SECTION == "6") {
					$("#name").text(data.dataMap.TCHNLGY_NM);
				}
				$("#possessOrg").text(data.dataMap.ORG_GRP_NM);
				$("#registInfo").val(data.dataMap.REGIST_INFO);
				$("#transferSection").val(data.dataMap.TRANSFER_SECTION).attr("selcted", "selected");
				$("#transferDate").val(data.dataMap.TRANSFER_DATE);
				$("#transferStDt").val(data.dataMap.TRANSFER_ST_DT);
				$("#transferEdDt").val(data.dataMap.TRANSFER_ED_DT);
				$("#transferPerson").val(data.dataMap.TRANSFER_PERSON);
				$("#brokerageInstitution").val(data.dataMap.BROKERAGE_INSTITUTION);
				$("#flatSumSkillFee").val(data.dataMap.FLAT_SUM_SKILL_FEE);
				$("#ordinarySkillFee").val(data.dataMap.ORDINARY_SKILL_FEE);
				$("#transferDelegate").val(data.dataMap.TRANSFER_DELEGATE);
				$("#transferPosition").val(data.dataMap.TRANSFER_POSITION);
				$("#transferPhone1").val(data.dataMap.TRANSFER_PHONE1);
				$("#transferPhone2").val(data.dataMap.TRANSFER_PHONE2);
				$("#transferEmail").val(data.dataMap.TRANSFER_EMAIL);
				if(data.dataMap.ETERNITY_YN == "Y") {
					$("#eternityYN").attr("checked", true);
					$("#eternityYN").val("Y");
					$("#transferTerm").hide();
				} else {
					$("#eternityYN").attr("checked", false);
					$("#eternityYN").val("N");
					$("#transferTerm").show();
				}
				$("#note").val(data.dataMap.NOTE);

				$("#statusForm > h3").text("???????????? ???????????? ??????");
				$("#pbtn").attr("onclick", "editProc()").text("??????");
				$("#dbtn").show();

				var temp = $("#layer2");
				var bg = temp.prev().hasClass('bg');

				if(bg){
					$('.layer').fadeIn();
				}else{
					temp.fadeIn();
				}

				// ????????? ????????? ???????????? ?????????.
				if (temp.outerHeight() < $(document).height() ) temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
				else temp.css('top', '0px');
				if (temp.outerWidth() < $(document).width() ) temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
				else temp.css('left', '0px');

				temp.find('#cbtn').click(function(e){
					if(bg){
						$('.layer').fadeOut();
					}else{
						temp.fadeOut();
					}
					e.preventDefault();
				});

				$('.layer .bg').click(function(e){
					$('.layer').fadeOut();
					e.preventDefault();
				});


			}
		});
	}
	function editProc() {
		if(confirm("?????????????????????????")) {
			if($("#registInfo").val() == "") {
				alert("??????????????? ????????? ?????????.");
				$("#registInfo").focus();
			} else if($("#transferDate").val() == "") {
				alert("???????????? ????????? ?????????");
				$("#transferDate").focus();
			} else if($("#transferPerson").val() == "") {
				alert("??????????????? ????????? ?????????.");
				$("#transferPerson").focus();
			} else if($("#flatSumSkillFee").val() == "") {
				alert("?????????????????? ????????? ?????????.");
				$("#flatSumSkillFee").focus();
			} else {
				var formData = $("#editStatus").serialize();
				$.ajax({
					url : "/sys/jipUseStatusProc.do?mode=edit",
					type : "POST",
					data : formData,
					success : function(){
						alert("??????????????? ?????????????????????.");
						location.reload();
					},
					error : function() {
						alert("????????? ??????????????????.");
					}
				});
			}
		}
	}

	function delProc() {
		if(confirm("?????????????????????????")) {
		var idx = $("#viewStatusIdx").val();
			$.ajax({
				url : "/sys/jipUseStatusProc.do?mode=del",
				type : "POST",
				data : {"jipUseIdx" : idx},
				success : function() {
					alert("?????? ???????????????.");
					location.reload();
				},
				error : function() {
					alert("????????? ??????????????????.");
				}
			})
		}
	}

	function writeProc() {
		if(confirm("?????????????????????????")) {
			if($("#registInfo").val() == "") {
				alert("??????????????? ????????? ?????????.");
				$("#registInfo").focus();
			} else if($("#transferDate").val() == "") {
				alert("???????????? ????????? ?????????");
				$("#transferDate").focus();
			} else if($("#transferPerson").val() == "") {
				alert("??????????????? ????????? ?????????.");
				$("#transferPerson").focus();
			} else if($("#flatSumSkillFee").val() == "") {
				alert("?????????????????? ????????? ?????????.");
				$("#flatSumSkillFee").focus();
			} else {
				var formData = $("#editStatus").serialize();
				$.ajax({
					url : "/sys/jipUseStatusProc.do?mode=write",
					type : "POST",
					data : formData,
					success : function() {
						alert("?????? ???????????????.");
						location.reload();
					},
					error : function() {
						alert("????????? ??????????????????");
					}
				})
			}
		}
	}

	function popupWindow(){
		var listMode = "";
		if($("#rightSection").val() == '3') {
			listMode = "design";
		} else if($("#rightSection").val() == '4') {
			listMode = "brand";
		} else if($("#rightSection").val() == '5') {
			listMode = "program";
		} else if($("#rightSection").val() == '6') {
			listMode = "knowhow";
		} else {
			listMode = "utility";
		}
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/jipUseStatus.do?mode=registPop&listmode="+listMode;
		var popOption="width=800, height=600, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,"",popOption);

	}

	function setPopup(obj){
		$("#registInfo").val(obj['registNo']);
	}

	$("#eternityYN").click(function() {
		if($(this).is(":checked")) {
			$(this).val("Y");
			$("#transferTerm").hide();
			$("#transferStDt").val(null);
			$("#transferEdDt").val(null);
		} else {
			$(this).val("N");
			$("#transferTerm").show();
		}
	});

	$("#rightSection").change(function() {
		$("#registInfo").val(null);
		$("#name").text("");
		$("#possessOrg").text("");
	});
</script>


<!--// bo_btn -->
