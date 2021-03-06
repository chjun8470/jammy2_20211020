<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.IncludeDocument.Include"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String diary = util.getStr(paramMap.get("diary"));
	String reportType = util.getStr(paramMap.get("reportType"));

	SimpleDateFormat df= new SimpleDateFormat("yyyyMMdd");

	Date date = new Date();
	String today = df.format(date);

	String fileGrp = "";
	String fileSubGrp = "";
	String fileFullGrp ="";
	

%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<div class="clear_wrap">

<form id = "fview" name = "fview" method="post" action="/mjeinet/sub.do">
	<input type="hidden" id="mode" 			name="mode" 		value="<%=mode%>"/>
	<input type="hidden" id="m" 			name="m" 		value="<%=m%>"/>
	<input type="hidden" id="orderState" 	name="orderState"	value="<%=util.getStr(paramMap.get("orderState"))%>"/>
	<input type="hidden" id="searchType" 	name="searchType"	value="<%=util.getStr(paramMap.get("searchType"))%>"/>
	<input type="hidden" id="searchStDt" 	name="searchStDt"	value="<%=util.getStr(paramMap.get("searchStDt"))%>"/>
	<input type="hidden" id="searchEdDt" 	name="searchEdDt"	value="<%=util.getStr(paramMap.get("searchEdDt"))%>"/>
	<input type="hidden" id="searchWord" 	name="searchWord"	value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
	<input type="hidden" id="reUrl"  		name="reUrl" 		value="/mjeinet/sub.do?m=110" />
	<input type="hidden" id="reject"  		name="reject" 		value="" />
	<input type="hidden" id="equOrderIdx"	 name="equOrderIdx" value="<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>
	<input type="hidden" name="reportType"	value="<%if(util.getStr(paramMap.get("orderState")).equals("4")) { out.print(util.getStr(paramMap.get("reportType"))); } %>"/>
</form>


	<!-- ????????????(???????????? ????????????, ?????? ????????? ??????) -->
	<div class="box_in">
		<h2>???????????? ?????? ????????????</h2>
		<table id="step1"  class="skin_basic_write">
			<colgroup>
				<col width="30%">
				<col width="70%">
			</colgroup>
			<tbody>
				<tr>
					<th scope="col">JEINET ????????????</th>
					<td scope="col">
					J-<%=util.getStr(paramMap.get("equOrderIdx"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">????????????</th>
					<td colspan="3">
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_1.png"> <% } %>
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_2.png"> <% } %>
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %>
					<img alt="????????????" src="/img/back/comm/order_state_img_3.png"> <br /> ???????????? :&nbsp;<%=util.getStr(dataMap.get("REJECT"))%> <% } %>
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_4.png"> <% } %>
					<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> <img alt="????????????" src="/img/back/comm/order_state_img_5.png"> <% } %>
					</td>  
				</tr>
				<tr>
					<th scope="col">????????????</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("ORDER_DEPT_NM"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">?????????</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("ORDER_OPERATOR"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">????????????</th>
					<td scope="col">
						<%=util.getStr(dataMap.get("ORDER_OPERATOR_DT"))%>
					</td>
				</tr>
				<tr>
					<th scope="col"><!-- ???????????? ?????? --></th>
					<td scope="col">
					<%-- <button class="btn_inp_y_01" onclick="printPop('<%=dataMap.get("RND_EQU_IDX")%>','<%=dataMap.get("USER_IDX")%>','<%=util.getStr(paramMap.get("equOrderIdx"))%>')">????????????</button> --%>
					<%-- <button class="btn_inp_y_01" onclick="goPrint('<%=dataMap.get("RND_EQU_IDX")%>','<%=dataMap.get("USER_IDX")%>','<%=util.getStr(paramMap.get("equOrderIdx"))%>')">????????????</button> --%>
					</td>
				</tr>
			</tbody>
		</table>
	</div>


	<div class="box_in" id="equUserDiv">
		<h3>?????? ????????? ??????</h3>
		<!-- ????????? ?????? -->
		<table class="skin_basic_write">
			<colgroup>
			<col style="width: 30%;" />
			<col style="width: 70%;" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="col"> ????????????</th>
					<td><%=util.getStr(userMap.get("PSN_NM"))%></td>
				</tr>
				<tr>
					<th scope="col"> ???????????????</th>
					<td><%=util.getStr(userMap.get("ORG_GRP_NM"))%></td>
				</tr>
				<tr>
					<th scope="col"> ????????????/??????</th>
					<td><%=util.getStr(dataMap.get("DEPT_NM"))%></td>
				</tr>
				<tr>
					<th scope="col"> ????????? ??????</th>
					<td><%=util.getStr(userMap.get("POSITION_NM"))%></td>
				</tr>
				<tr>
					<th scope="col"> ?????????</th>
					<td><%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER"))%></td>
				</tr>
				<tr>
					<th scope="col"> ?????????</th>
					<td><%=util.getStr(userMap.get("EMAIL"))%>
					<br /><%=util.getStr(userMap.get("PHONE"))%></td>
				</tr>
				<tr>
					<th scope="col"> ??????</th>
					<td><%=util.getStr(userMap.get("ADDR1"))%>
					<br/><%=util.getStr(userMap.get("ADDR2"))%></td>
				</tr>
			</tbody>
		</table>
	</div>

	<div class="box_in" id="equResDiv">
		<h3>???????????? ????????????</h3>
		<table class="skin_basic_write">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 25%;" />
				<col style="width: 26.6%;" />
				<col style="width: 26.6%;" />
				<col style="width: 26.6%;" />
			</colgroup>
			<!-- colgroup e -->
			<tr>
				<th scope="col">???????????????</th>
       			<td scope="col" colspan="3"><%=util.getStr(dataMap.get("ORDER_DT"))%></td>
           	</tr>
           	<tr>
				<th scope="col">?????????</th>
				<td scope="col" colspan="3">
					<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
				</td>
			</tr> 
			<tr>
				<th scope="col" rowspan="4">????????????</th>
			</tr>
			<tr>
				<td scope="col" colspan="3">
					JEINET ???????????? : <%=util.getStr(dataMap.get("RND_EQU_IDX"))%>
				</td>
			</tr>
			<tr>
				<td scope="col" colspan="3">
					Zeus ???????????? : <%if(!util.getStr(dataMap.get("NTIS_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("NTIS_EQUIP_INFO")));}else {out.print("Zeus ????????? ??????");}%>
				</td>
			</tr>
			<tr>		
				<td scope="col" colspan="3">
					i-Tube ???????????? : <%if(!util.getStr(dataMap.get("ETUBE_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("ETUBE_EQUIP_INFO")));}else {out.print("i-Tube ????????? ??????");}%>
				</td>
			</tr>
			<tr>
				<th scope="col">????????????</th>
				<td scope="col" colspan="3">
					<%=util.getStr(dataMap.get("OWN_ORG_NM"))%>(<%=util.getStr(dataMap.get("OWN_ORG_SUB_NM"))%>)
				</td>
			</tr>
			<tr>
				<th scope="col"> ??????????????????</th>
				<td scope="col" colspan="3">
		 			<%=util.getStr(dataMap.get("USE_ST_DT"))%> ~ <%=util.getStr(dataMap.get("USE_ED_DT"))%>
				</td>
			</tr>
			<tr>
				<th scope="col"> ????????????</th>
				<td scope="col" colspan="3">
					<%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")) { %> ??????????????? <% } %>
                				<%if(util.getStr(dataMap.get("USE_MEAN")).equals("2")) { %> ???????????? <% } %>
                				<%if(util.getStr(dataMap.get("USE_MEAN")).equals("3")) { %> ????????????????????? <% } %>
				</td>
			</tr>
			<tr>
				<th scope="col"> ????????????</th>
				<td scope="col" colspan="3">
					<%=util.getStr(dataMap.get("USE_PURPOSE"))%>
				</td>
			</tr>
			<tr>
				<th scope="col"> ???????????????</th>
				<td scope="col" colspan="3">
					<%=util.getStr(dataMap.get("REAL_USE_ST_DT"))%> ~ <%=util.getStr(dataMap.get("REAL_USE_ED_DT"))%>
				</td>
			</tr>
			<tr>
				<th scope="col"> ??????????????????</th>
				<td colspan="3">
					<%
	                				String sampleNm = util.getStr(dataMap.get("SAMPLE_NM"));
                					String sampleNo = util.getStr(dataMap.get("SAMPLE_NO"));
                					String sampleNmArr[] = sampleNm.split("\\|\\|");
                					String sampleNoArr[] = sampleNo.split("\\|\\|");
                					for(int i = 1 ; i < sampleNmArr.length ; i++ ){
                						if( i != 1 ){
                							//out.println(", ");
                						}
                						out.println(i+". ?????? : " + sampleNmArr[i]);
                						out.println("(");
                						out.println(sampleNoArr[i]);
                						out.println(")");
                						out.println("<br />");
                					}
	                			%>
				</td>
			</tr>
			<tr>
				<th>????????????????????? </th>
				<td colspan="3">
					<div style="clear:both;">
						<%if(fileList.size() > 0){%>

							<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
								<%
									int fileCnt = 1;
									for(HashMap rs:fileList){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
								%>
									<li class="text"> ???????????? <%=fileCnt%> :
										<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
										<%--<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px; padding:10px; vertical-align:middle "/></a>--%>
										<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
										<%--<%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)--%>
									</li>
								<% fileCnt++; }%>
							</ul>
						<%} %>
					</div>
				</td>
			</tr>
			<tr>
				<th scope="col">????????????</th>
				<td colspan="3">
					<%=util.getStr(dataMap.get("SAMPLE_MATTER")).replace("\n", "<br/>")%>
				</td>
			</tr>
			<tr>
				<th scope="col">???????????????</th>
       			<td scope="col" colspan="3"><%=util.getStr(dataMap.get("USE_ED_DT"))%></td>
			</tr>
		</table>
	</div>
	<div class="btn_box" >
		<div class="btn_left_box" >
              		<!-- ???????????? ??????,???????????????,????????? -->
              		<% if(util.loginCheck()) {%>
	              		<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %>  <!-- ??????????????????????????? -->
		            		<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('2')">????????????</button>

<!-- 	            			<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay()">???????????? ??????</button> -->
		            	<% } else if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <!-- ??????????????????????????? -->
		            		<%-- <%if(util.getStr(dataMap.get("USE_ED_DT")) > util.getStr(today)) { %> <!-- ???????????? ??????????????? -->
		            			<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('4')">?????? ??????</button>
		            		<% } %> --%>
		            			<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('5')">???????????? ??????</button>

						<% } %>
	            	<% } %>
              	</div>

		<div class="btn_right_box" >
		<% if(util.loginCheck()) {%>
			<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">????????????</button>
			<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ) {%>
				<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">????????????</button>
			<% } %>
		<% } %>
		<button class="btn_inp_w_01" type="button" onclick="pageListGo()">??????</button>
		</div>

	</div>
	<div class="btn_box" style="margin-top:10px;">
		<div class="btn_left_box">
		<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 70) { %> <!-- ??????????????? ?????? -->
			<% if(util.getStr(paramMap.get("mode")).equals("view")){ %>
				<% if(!util.getStr(dataMap.get("DIARY_YN")).equals("Y")) { %>
					<button class="btn_inp_b_01" id="diaryWriteBtn" type="button" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1") || (util.getStr(paramMap.get("reportType")).equals("diary") && util.getStr(paramMap.get("diary")).equals("view"))){ %>style="display:none;"<%} %> onclick="resveReport()">???????????? ??????</button>
				<% }else { %>
					<button class="btn_inp_b_01" id="diaryEditBtn" type="button" onclick="diaryEditView()">???????????? ??????</button>
				<% } %>
				<% if(!util.getStr(dataMap.get("INNER_YN")).equals("Y")) { %>
<%-- 					<button class="btn_inp_b_01" id="innerWriteBtn" type="button" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1") || (util.getStr(paramMap.get("reportType")).equals("inner") && util.getStr(paramMap.get("diary")).equals("view"))){ %>style="display:none;"<%} %> onclick="innerResveReport()">???????????? ??????</button> --%>
				<% }else { %>
<!-- 					<button class="btn_inp_b_01" id="innerEditBtn" type="button" onclick="innerEditView()">???????????? ??????</button> -->
				<% } %>
				<% if(!util.getStr(dataMap.get("LEGAL_YN")).equals("Y")) { %>
					<%-- <button class="btn_inp_b_01" id="legalWriteBtn" type="button" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1") || (util.getStr(paramMap.get("reportType")).equals("legal") && util.getStr(paramMap.get("diary")).equals("view"))){ %>style="display:none;"<%} %> onclick="legalResveReport()">???????????? ??????</button> --%>
				<% }else { %>
					<!-- <button class="btn_inp_b_01" id="legalEditBtn" type="button" onclick="legalEditView()">???????????? ??????</button> -->
				<% } %>
			<% } %>
		<% } %>
		</div>
	</div>

<%-- <%if(reportType.equals("") || reportType.equals("diary") || util.getStr(dataMap.get("DIARY_YN")).equals("Y")){ %> --%>
<%if(util.getStr(paramMap.get("mode")).equals("view")){ %>
	<%@include file="diary.jsp" %>
<%-- <%}if(reportType.equals("") || reportType.equals("inner") || util.getStr(dataMap.get("INNER_YN")).equals("Y")){ %> --%>
<%-- 	<%@include file="inner.jsp" %> --%>
	<%-- <%@include file="legal.jsp" %> --%>
<%} %>
<%--
	<div class="btn_box" >
		<div class="btn_left_box" >
		<!-- ???????????? ??????,???????????????,????????? -->
		<% if(util.loginCheck()) {%>
			<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %>  <!-- ??????????????????????????? -->
				<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('2')">????????????</button>
				<!--<button class="btn_inp_b_01" type="button" onclick="resveReturnDisplay()">???????????? ??????</button> -->
			<% } else if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <!-- ??????????????????????????? -->
				<%if(util.getStr(dataMap.get("USE_ED_DT")) > util.getStr(today)) { %> <!-- ???????????? ??????????????? -->
					<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('4')">?????? ??????</button>
            		<% } %>
					<button class="btn_inp_b_01" type="button" onclick="resveConsentGo('5')">???????????? ??????</button>
			<% } else if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> <!-- ??????????????????????????? -->
				<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 70) { %> <!-- ??????????????? ?????? -->
					<% if(!util.getStr(dataMap.get("DIARY_YN")).equals("Y")) { %> <!-- ??????????????? ?????? -->
						<button class="btn_inp_b_01" type="button" onclick="resveReport(<%=util.getStr(paramMap.get("equOrderIdx"))%>)resveReport()">???????????? ??????</button>
					<% } %>
				<% } %>
			<% } %>
		<% } %>
		</div>

		<div class="btn_right_box" >
		<% if(util.loginCheck()) {%>
			<button class="btn_inp_b_01" type="button" onclick="pageEditGo()">??????</button>
			<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ) {%>
				<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">??????</button>
			<% } %>
		<% } %>
		<button class="btn_inp_w_01" type="button" onclick="pageListGo()">??????</button>
		</div>
	</div> --%>
	<br/>
	<div id="rejectDisplayDiv" style="display:none; " class="skin_bbs_write">
		<table class="skin_basic_write 444">
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: *%;" />
				<col style="width: 5%;" />
			</colgroup>
			<tbody>
				<tr>
					<th>????????????</th>
					<td><textarea rows="4" cols="100" id="rejectTxt" name="rejectTxt" class="inp_txt" style="width:100%; overflow: auto; resize:none;"></textarea></td>
					<td><button class="btn_inp_b_01" type="button" onclick="resveConsentGo('3')">????????????</button></td>
				</tr>
			</tbody>
		</table>
	</div>


</div>

<script type="text/javascript">

$(document).on("keyup",".numberOnly",function(){
	if (!(event.keyCode >=37 && event.keyCode<=40)) {
        var inputVal = $(this).val();
        $(this).val(inputVal.replace(/[^0-9;]/gi,''));
    }
});

$("input:text[numberOnlyDot]").on("keyup", function() {
    $(this).val($(this).val().replace(/^[^0-9]|[^0-9\\.]|[\.]+[^0-9]|[0-9].[0-9]+[\D]/g,""));
});

//????????????
function checkSpace(id){
	var str = $('#'+id).val();
	if(str.search(/\s/) != -1){
		$('#'+id).val(str.trim());
		//$('#'+id).val(str.replace(/ /g, ""));
	}
	return $('#'+id).val();
}

//????????????(??????, ??????, ??????) ??????
function pageListGo(){
	$('#mode').val('list');
	//$('#fview').find('input[name=reportType]').val();
	$('#fview').submit();
}
function pageDelGo(){
	var stateResult = "";
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> stateResult = "????????????"; <% } %>
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> stateResult = "????????????"; <% } %>
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %> stateResult = "????????????"; <% } %>
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> stateResult = "????????????"; <% } %>
	<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> stateResult = "????????????"; <% } %>
	if(confirm("'"+stateResult+"' ????????? ??????????????????. ?????????????????????????")){
		$('#mode').val('del');
		$('#fview').submit();
	}
}
function pageEditGo(){
	$('#mode').val('edit');
	$('#fview').submit();
}
function resveConsentGo(orderState){
	var rejectTxt = document.getElementById('rejectTxt').value;

	if(orderState == '2'){ //????????????
		if(confirm("?????? ?????? ???????????????????")){
			$('#mode').val('stateEdit');
			document.fview.action = "/web/sysEqReservation.do"
			$('#orderState').val(orderState);
			//alert("?????? ???????????????.");
			$('#fview').submit();
		} else {
			return false;
		}
	}

	if(orderState == '3'){ //????????????
		if(confirm("?????? ???????????? ???????????????????")){
			$('#mode').val('stateEdit');
			document.fview.action = "/web/sysEqReservation.do"
			$('#orderState').val(orderState);
			$('#reject').val(rejectTxt);
			alert("?????? ???????????????.");
			$('#fview').submit();
		} else {
			return false;
		}
	}

	if(orderState == '5'){ //????????????
		if(confirm("?????? ?????? ?????? ?????? ???????????????????")){
			$('#mode').val('stateEdit');
			document.fview.action = "/web/sysEqReservation.do"
			$('#orderState').val(orderState);
			//alert("?????? ???????????????.");
			$('#fview').submit();
		} else {
			return false;
		}
	}
}
function resveReturnGo(){
	var rejectTxt = document.getElementById('rejectTxt').value;
	if(confirm("?????? ???????????? ???????????????????")){
		$('#mode').val('stateEdit');
		document.fview.action = "./eqReservationProc.do"
		$('#orderState').val('3');
		$('#reject').val(rejectTxt);
		alert("?????? ???????????????.");
		$('#fview').submit();
	} else {
		return false;
	}

}


function popupWindow(mode, order){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
	var popUrl="/sys/eqReservation.do?mode="+mode+"&order="+order;
	var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
	window.open(popUrl,"popup"+order,popOption);
}

function setPopup(obj, mode){
	$("#"+obj['order']+"fwrite").find('input[name=equUserOrg]').val(obj['org_grp_nm']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserDept]').val(obj['dept_nm']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserName]').val(obj['user_nm']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserPosition]').val(obj['position_nm']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserPhone]').val(obj['cp_no']);
	$("#"+obj['order']+"fwrite").find('input[name=equUserEmail]').val(obj['email']);
}

function move(id) {
	var offset = $("#"+id).offset();
    $('html, body').animate({scrollTop : offset.top}, 400);
}

/* ?????? ?????? */
function goPrint(rndEquIdx, userIdx, equOrderIdx){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
	var popUrl='/back/page/print_popup.jsp?rndEquIdx='+rndEquIdx+'&userIdx='+userIdx+'&equOrderIdx='+equOrderIdx;
	var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
	window.open(popUrl,"print_popup",popOption);
};

function bytecheck(obj, maxByte){
	 var str = obj.value;
	 var str_len = str.length;

	 var rbyte = 0;
	 var rlen = 0;
	 var one_char = "";
	 var str2 = "";

	 for(var i=0; i<str_len; i++){
	 one_char = str.charAt(i);
	 if(escape(one_char).length > 4){
	     rbyte += 2;                                         //??????2Byte
	 }else{
	     rbyte++;                                            //?????? ??? ????????? 1Byte
	 }

	 if(rbyte <= maxByte){
	     rlen = i+1;                                          //return??? ????????? ??????
	 }
	 }

	 if(rbyte > maxByte){
	     alert("?????? "+(maxByte/2)+"??? / ?????? "+maxByte+"?????? ?????? ????????? ??? ????????????.");
	     str2 = str.substr(0,rlen);                                  //????????? ?????????
	     obj.value = str2;
	     bytecheck(obj, maxByte);
	 }else{
	     document.getElementById('byteInfo').innerText = rbyte;
	 }
};


$(document).ready(function() {
	$(function() {
	    $("input:text").keydown(function(evt) {
	        if (evt.keyCode == 13)
	            return false;
	    });
	});

	$("#diaryStartDate, #diaryEndDate, #innerStartDate, #innerEndDate").datepicker({
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
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
		maxDate:'+0d'
	});

	$('#startTime').datepicker("option", "onClose", function ( selectedDate ) {
        $("#endTime").datepicker( "option", "minDate", selectedDate );
    });

	$('#endTime').datepicker("option", "onClose", function ( selectedDate ) {
        $("#startTime").datepicker( "option", "maxDate", selectedDate );
    });

	$("#diaryRentalFee, #legalRentalFee").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
        }
    });
	<%if(util.getStr(paramMap.get("reportType")).equals("diary")) { %> $("#diaryWriteBtn").hide(); <% } %>
<%-- 	<%if(util.getStr(paramMap.get("reportType")).equals("inner")) { %> $("#innerWriteBtn").hide(); <% } %> --%>
	<%-- <%if(util.getStr(paramMap.get("reportType")).equals("legal")) { %> $("#legalWriteBtn").hide(); <% } %> --%>
});



</script>
