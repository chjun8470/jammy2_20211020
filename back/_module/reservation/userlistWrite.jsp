<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page
	import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>

	<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_tpl.css" />
	<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css" />
	<link rel="stylesheet" type="text/css" href="/css/cms/back/board_3.css" />
	<link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />

	<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="/js/board.js"></script>

	<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
	<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js" type="text/javascript"></script>

<%
	String display = "sub";
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));

	//email S
	String email = util.getStr(dataMap.get("EMAIL"));
	String emailId = "";
	String emailDomain = "";
	int e = email.indexOf("@");
	if(e>1){
		emailId = email.substring(0, e);
		emailDomain = email.substring(e+1);
	}
	//email E
	//tel S
	String telNo = util.getStr(dataMap.get("TEL_NO"));
	String telNo1 = "";
	String telNo2 = "";
	String telNo3 = "";
	if(!telNo.equals("") && !telNo.equals(null)){
		telNo = util.autoTel(telNo);
		int t1 = telNo.indexOf("-");
		int t2 = telNo.indexOf("-",t1+1);
		telNo1 = telNo.substring(0, t1);
		telNo2 = telNo.substring(t1+1, t2);
		telNo3 = telNo.substring(t2+1);
	}
	//tel E
	//cp S
	String cpNo = util.getStr(dataMap.get("CP_NO"));
	String cpNo1 = "";
	String cpNo2 = "";
	String cpNo3 = "";
	
	if(!cpNo.equals("") && !cpNo.equals(null)){
		
		//cpNo = util.autoTel(cpNo);
				
		int c1 = cpNo.indexOf("-");
		int c2 = cpNo.indexOf("-",c1+1);
		
		cpNo1 = cpNo.substring(0, c1);
		cpNo2 = cpNo.substring(c1+1, c2);
		cpNo3 = cpNo.substring(c2+1);
	}
	//cp E
	//corpNo S
	String corpNo = util.getStr(dataMap.get("CORP_NO"));
	String corpNo1 = "";
	String corpNo2 = "";
	String corpNo3 = "";
	if(!corpNo.equals("") && !corpNo.equals(null)){
		int co1 = corpNo.indexOf("-");
		int co2 = corpNo.indexOf("-", co1+1);
		corpNo1 = corpNo.substring(0, co1);
		corpNo2 = corpNo.substring(co1+1, co2);
		corpNo3 = corpNo.substring(co2+1);
	}
	//corpNo E

%>
<div style="margin: 10px;">
	<form name="fwrite" id="fwrite" action="/sys/eqReservationUser.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name = "searchType" id = "searchType" value="NAME"/>
		<input type="hidden" name = "searchWord" id = "searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
		<input type="hidden" name = "order" id = "order" value = "<%=util.getStr(paramMap.get("order"))%>" />
		<input type="hidden" name = "userIdx" id = "userIdx" value = "<%=util.getStr(paramMap.get("userIdx"))%>" />
		<input type="hidden" name = "oriEmail" id = "oriEmail" value = "<%=util.getStr(dataMap.get("EMAIL"))%>" />
		<input type="hidden" name = "oriCpNo" id = "oriCpNo" value = "<%=util.getStr(dataMap.get("CP_NO"))%>" />

		<div class="skin_bbs_write">
		<div style="margin:10px">
			<h3>
				<%if(mode.equals("write")){ %>
					<b>OFFLINE ????????? ?????? ??????</b>
				<%}else if(mode.equals("edit")){ %>
					<b>OFFLINE ????????? ?????? ??????</b>
				<%} %>
			</h3>
		</div>

			<table class="skin_basic_write">
				<caption>OFFLINE ????????? ??????</caption>
				<colgroup>
					<col style="width: 20%">
					<col style="width: 30%">
					<col style="width: 20%">
					<col style="width: 30%">
				</colgroup>
				<tbody>
					<tr>
						<th>
							<span style="color: red; font-size: 10pt;">*</span>??? ???
						</th>
						<td colspan="3">
							<input type="text" name="psnNm" maxlength="24" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" id="psnNm" class="inp_txt" title="??????" style="width:50%;">
						</td>
					</tr>
					<tr>
						<th>
							<span style="color: red; font-size: 10pt;">*</span>????????????
						</th>
						<td>
							<input type="radio" name="genderTypeCd" value="M" id="genderTypeCdMale" style="width:20px;" <%=util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("M") || util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("") ? "checked='checked'" : "" %>><label for="genderTypeCdMale">??????</label>
							<input type="radio" name="genderTypeCd" value="F" id="genderTypeCdFemale" style="width:20px;" <%=util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("F")? "checked='checked'" : "" %>><label for="genderTypeCdFemale">??????</label>
						</td>
						<th style="align: center; valign: middle">
							<span style="color: red; font-size: 10pt;">*</span> ???????????????
						</th>
						<td>
							<input type="radio" name="frgnYn" value="N" id="frgnYnY" style="width:20px;" title="?????????" <%=util.getStr(dataMap.get("FRGN_YN")).equals("N") || util.getStr(dataMap.get("FRGN_YN")).equals("") ?  "checked='checked'" : "" %>><label for="frgnYnY">?????????</label>
							<input type="radio" name="frgnYn" value="Y" id="frgnYnN" style="margin-left: 20px; width:20px" title="?????????" <%=util.getStr(dataMap.get("FRGN_YN")).equals("Y")?  "checked='checked'" : "" %> disabled="disabled"><label for="frgnYnN">?????????</label>
						</td>
					</tr>
					<tr>
						<th>
							<span style="color: red; font-size: 10pt;">*</span>????????????
						</th>
						<td>
							<input type="hidden" name="telNo" value="" id="telNo">
							<select name="telNo1" id="telNo1" class="select_box" style="width: 60px;" title="????????????????????? ??????">
								<option value="02" <%if(telNo1.equals("02")) { %> selected="selected" <% } %>>02</option>
								<option value="031" <%if(telNo1.equals("031")) { %> selected="selected" <% } %>>031</option>
								<option value="032" <%if(telNo1.equals("032")) { %> selected="selected" <% } %>>032</option>
								<option value="033" <%if(telNo1.equals("033")) { %> selected="selected" <% } %>>033</option>
								<option value="041" <%if(telNo1.equals("041")) { %> selected="selected" <% } %>>041</option>
								<option value="042" <%if(telNo1.equals("042")) { %> selected="selected" <% } %>>042</option>
								<option value="043" <%if(telNo1.equals("043")) { %> selected="selected" <% } %>>043</option>
								<option value="044" <%if(telNo1.equals("044")) { %> selected="selected" <% } %>>044</option>
								<option value="051" <%if(telNo1.equals("051")) { %> selected="selected" <% } %>>051</option>
								<option value="052" <%if(telNo1.equals("052")) { %> selected="selected" <% } %>>052</option>
								<option value="053" <%if(telNo1.equals("053")) { %> selected="selected" <% } %>>053</option>
								<option value="054" <%if(telNo1.equals("054")) { %> selected="selected" <% } %>>054</option>
								<option value="055" <%if(telNo1.equals("055")) { %> selected="selected" <% } %>>055</option>
								<option value="061" <%if(telNo1.equals("061")) { %> selected="selected" <% } %>>061</option>
								<option value="062" <%if(telNo1.equals("062")) { %> selected="selected" <% } %>>062</option>
								<option value="063" <%if(telNo1.equals("063")) { %> selected="selected" <% } %>>063</option>
								<option value="064" <%if(telNo1.equals("064")) { %> selected="selected" <% } %>>064</option>
								<option value="070" <%if(telNo1.equals("070")) { %> selected="selected" <% } %>>070</option>
							</select>
							<span>-</span>
							<input type="text" name="telNo2" style="width: 50px" maxlength="4" value="<%=telNo2%>" id="telNo2" class="inp_txt" title="??????????????? ?????????">
							<span>-</span>
							<input type="text" name="telNo3" style="width: 50px" maxlength="4" value="<%=telNo3%>" id="telNo3" class="inp_txt" title="??????????????? ?????????">
						</td>
						<th>
							???????????????
						</th>
						<td>
							<input type="hidden" name="cpNo" value="" id="cpNo">
							<select name="cpNo1" id="cpNo1" class="select_box" style="width: 60px;" title="????????? ??????">
								<option value="010" <%if(cpNo1.equals("010")) { %> selected="selected" <% } %>>010</option>
								<option value="011" <%if(cpNo1.equals("011")) { %> selected="selected" <% } %>>011</option>
								<option value="016" <%if(cpNo1.equals("016")) { %> selected="selected" <% } %>>016</option>
								<option value="017" <%if(cpNo1.equals("017")) { %> selected="selected" <% } %>>017</option>
								<option value="018" <%if(cpNo1.equals("018")) { %> selected="selected" <% } %>>018</option>
								<option value="019" <%if(cpNo1.equals("019")) { %> selected="selected" <% } %>>019</option>
							</select>
							<span>-</span>
							<input type="text" name="cpNo2" style="width: 50px" maxlength="4" value="<%=cpNo2%>" id="cpNo2" class="inp_txt" title="????????? ?????????">
							<span>-</span>
							<input type="text" name="cpNo3" style="width: 50px" maxlength="4" value="<%=cpNo3%>" id="cpNo3" class="inp_txt" title="????????? ?????????">
						</td>
					</tr>
					<tr>
						<th>
							<span style="color: red; font-size: 10pt;">*</span>?????????
						</th>
						<td colspan="3">
							<input type="hidden" name="email" value="" id="email">
							<input type="text" name="emailId" maxlength="20" value="<%=emailId %>" id="emailId" class="inp_txt" title="??????????????????">
							<span>@</span>
							<input type="text" name="emailDomain" maxlength="50" value="<%=emailDomain%>" id="emailDomain" class="inp_txt" title="??????????????????">
							<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="??????????????????????????????">
								<option value="" selected="selected">????????????</option>
								<option value="naver.com">naver.com</option>
								<option value="hanmail.net">hanmail.net</option>
								<option value="gmail.com">gmail.com</option>
								<option value="korea.kr">korea.kr</option>
								<option value="jntp.or.kr">jntp.or.kr</option>
							</select>
							<span id="userCheckMsg"></span>
						</td>
					</tr>
					<tr>
						<th>
							<span style="color: red; font-size: 10pt;">*</span> ??????
						</th>
						<td colspan="3">
							<input type="text" class="inp_txt" id="zipcode" name="zipcode" maxlength="10" readonly="readonly" style="width:50px;" value="<%=util.getStr(dataMap.get("ZIPCD")) %>">
							<input type="text" class="inp_txt" id="addr1" name="addr1" maxlength="50" readonly="readonly" style="width:75%;margin-left:5px;" value="<%=util.getStr(dataMap.get("ADDR1")) %>"/>
							<input type="button" id = "orgPostButton" value="????????????" class="btn_inp_g_01" onclick="orgPost()" />
						</td>
					</tr>
					<tr>
						<th scope="col">
							<span style="color: red; font-size: 10pt;">*</span> ????????????
						</th>
						<td colspan="3">
							<input type="text" class="inp_txt" id="addr2" name="addr2" maxlength="50" size="50" style="width:100%;" value="<%=util.getStr(dataMap.get("ADDR2")) %>"/>
						</td>
					</tr>
					<tr>
						<th id="thNm">
							??????/?????????
						</th>
						<td colspan="3">
							<select name="orgGrpType" id="orgGrpType" class="select_box" title="??????/?????? ????????????" style="width:104px;">
								<option value="" selected="selected">??????</option>
								<option value="????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("????????????")) { %> selected="selected" <% } %>>????????????</option>
								<option value="????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("????????????")) { %> selected="selected" <% } %>>????????????</option>
								<option value="????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("????????????")) { %> selected="selected" <% } %>>????????????</option>
								<option value="????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("????????????")) { %> selected="selected" <% } %>>????????????</option>
								<option value="????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("????????????")) { %> selected="selected" <% } %>>????????????</option>
								<option value="??????????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("??????????????????")) { %> selected="selected" <% } %>>??????????????????</option>
								<option value="????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("????????????")) { %> selected="selected" <% } %>>????????????</option>
								<option value="????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("????????????")) { %> selected="selected" <% } %>>????????????</option>
								<option value="????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("????????????")) { %> selected="selected" <% } %>>????????????</option>
								<option value="????????????" <%if(util.getStr(dataMap.get("ORG_GRP_TYPE")).equals("????????????")) { %> selected="selected" <% } %>>????????????</option>
							</select>
							<input type="text" id="orgGrpNm" name="orgGrpNm" class="inp_txt" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>" title="??????/?????????" style="width: 80%;margin-left:5px;">
						</td>
					</tr>
					<tr>
						<th>
							????????????
						</th>
						<td id="deptNmTd" colspan="3">
							<input type="text" class="inp_txt" name="ownerNm" id="ownerNm" title="????????????" maxlength="10" style="width:100%;" value="<%=util.getStr(dataMap.get("OWNER_NM")) %>"/>
						</td>
					</tr>
					<tr>
						<th>
							?????????????????????
						</th>
						<td colspan="3">
							<span>
								<input type="hidden" name="corpNo" value="" id="corpNo">
								<input type="text" name="corpNo1" style="width: 50px" maxlength="3" value="<%=corpNo1 %>" id="corpNo1" class="inp_txt" title="?????????????????????">
								 -
								<input type="text" name="corpNo2" style="width: 50px" maxlength="2" value="<%=corpNo2 %>" id="corpNo2" class="inp_txt" title="?????????????????????">
								 -
								<input type="text" name="corpNo3" style="width: 50px" maxlength="5" value="<%=corpNo3 %>" id="corpNo3" class="inp_txt" title="?????????????????????">
							</span>
						</td>
					</tr>
					<tr>
						<th id="deptNmTh">
							????????????/??????
						</th>
						<td colspan="3">
							<input type="text" class="inp_txt" name="deptNm" id="deptNm" title="????????????/??????" maxlength="10" style="width:100%;" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" />
						</td>
					</tr>
					<tr>
						<th>
							??????
						</th>
						<td colspan="3">
							<input type="text" name="positionNm" id="positionNm" class="inp_txt" title="??????" maxlength="10" style="width:100%;" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" />
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="btn_box">
			<div class="btn_right_box">
				<%if(mode.equals("write")){ %>
					<input type="button" onclick="submitGo()" value="??????" class="btn_inp_b_01" />
				<%}else if(mode.equals("edit")){ %>
					<input type="button" onclick="submitGo()" value="??????" class="btn_inp_b_01" />
				<%} %>
				<input type="button" onclick="goList()" class="btn_inp_w_01" value="??????" />
			</div>
		</div>

	</form>
</div>
<script type="text/javascript">
	var idPattern = /[^a-zA-Z0-9]/;
	var korPattern = /[^???-???]/;
	var engPattern = /[^a-zA-Z- ]/;
	var numPattern = /[^\d]/;
	var imgPattern = new Array("bmp", "gif", "jpg", "jpeg", "png");
	var emailIdChk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*$/i;
	var emailDomainChk = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

	$(document).ready(function(){
		$("#emailDomainChoise").change(function() {
			if (this.value == "") {
				$("#emailDomain").css("background-color", "");
				$("#emailDomain").removeAttr("readonly");
				$("#emailDomain").val("");

				$("#userCheckMsg").html("");
			} else {
				$("#emailDomain").val(this.value);
				$("#emailDomain").css("background-color", "#EEEEEE");
				$("#emailDomain").attr("readonly", true);

				if($('#emailId').val() != "" && $('#emailId').val() != null){
					$('#email').val($("#emailId").val() + "@" + $("#emailDomain").val());
					if($('#email').val() != $('#oriEmail').val()){
						userCheck('email');
					}
				}else{
					$('#emailId').focus();
				}
			}
		});

		$("#emailId").blur(function(){
			if($("#emailId").val() != "" && $("#emailId").val() != null){
				if(!emailIdChk.test($("#emailId").val())){
					alert("????????? ID : ????????? ID ???????????? ??????????????????.");
					setTimeout(function(){
						$("#emailId").focus();
					}, 10)
					return false;
				}

				if($('#emailDomain').val() != "" && $('#emailDomain').val() != null){
					$('#email').val($("#emailId").val() + "@" + $("#emailDomain").val());
					if($('#email').val() != $('#oriEmail').val()){
						userCheck('email');
					}
				}else{
					setTimeout(function(){
						$('#emailDomain').focus();
					}, 10)
				}
			}
		});

		$("#emailDomain").blur(function(){
			if($("#emailDomain").val() != "" && $("#emailDomain").val() != null){
				if(!emailDomainChk.test($("#emailDomain").val()) && $("#emailDomain").val() != ""){
					alert("????????? DOMAIN : ????????? ????????? ???????????? ??????????????????.");
					setTimeout(function(){
						$("#emailDomain").focus();
					}, 10)
					return false;
				}
				if($('#emailId').val() != "" && $('#emailId').val() != null){
					$('#email').val($("#emailId").val() + "@" + $("#emailDomain").val());
					if($('#email').val() != $('#oriEmail').val()){
						userCheck('email');
					}
				}else{
					setTimeout(function(){
						$("#emailId").focus();
					}, 10)
				}
			}
		});
	});

	function goList(){
		$("#mode").val("userPop");
		$('#fwrite').attr("action","/sys/eqReservation.do");
		$('#fwrite').submit();
	}

	function orgPost(){
		new daum.Postcode({
			oncomplete: function(data) {
				document.getElementById('zipcode').value = data.zonecode;

				if (data.userSelectedType === 'R') {
					// ????????? ?????? ?????????
					var adrs = data.roadAddress;
					if (data.buildingName != undefined && data.buildingName.length > 0) {
						adrs += ' (' + data.buildingName + ')';
					}
					document.getElementById('addr1').value = adrs;
				} else {
					// ?????? ?????? ?????????
					document.getElementById('addr1').value = data.jibunAddress;
				}
				document.getElementById('addr2').focus();
			}
		}).open();
	}

	function userCheck(mode){
		var params;
		if(mode == 'email'){
			params = {
					"email": $('#email').val()
			};
		}else if(mode == 'cp'){
			params = {
					"cpNo": $('#cpNo').val()
			};
		}

		$.post("/sys/getUserCheck.do",$.param(params),
		function(data){
			$("#userCheckMsg").html(data.userCheckMsg);
			$("#userCheck").val(data.userCheck);
			if(data.userCheck > 0){
				$("#userCheckMsg").attr("style","color:red;");
			}
			if(data.userCheck < 1){
				$("#userCheckMsg").attr("style","color:gray;");
			}
	    });
	}

	function submitGo() {

		if ($("#psnNm").val() == null || $("#psnNm").val() == "") {
			alert("?????? : ????????????????????????.");
			$("#psnNm").focus();
			return false;
		} else {
			if (korPattern.test($("#psnNm").val())) {
				alert("?????? : ????????? ??????????????????.");
				$("#psnNm").focus();
				return false;
			}
		}

		if (!$("input[name='genderTypeCd']").is(":checked")) {
			alert("???????????? : ????????????????????????.");
			$("#genderTypeCdMale").focus();
			return false;
		}
		if (!$("input[name='frgnYn']").is(":checked")) {
			alert("??????????????? : ????????????????????????.");
			$("#frgnYnY").focus();
			return false;
		}

		if ($("#telNo1 > option:selected").val() == null || $("#telNo1 > option:selected").val() == "") {
			alert("???????????? : ????????????????????????.");
			$("#telNo1").focus();
			return false;
		}

		if ($("#telNo2").val() == null || $("#telNo2").val() == "") {
			alert("???????????? : ????????????????????????.");
			$("#telNo2").focus();
			return false;
		} else if (isNaN($("#telNo2").val())) {
			alert("???????????? : ????????? ??????????????????.");
			$("#telNo2").focus();
			return false;
		}

		if ($("#telNo3").val() == null || $("#telNo3").val() == "") {
			alert("???????????? : ????????????????????????.");
			$("#telNo3").focus();
			return false;
		} else if (isNaN($("#telNo3").val())) {
			alert("???????????? : ????????? ??????????????????.");
			$("#telNo3").focus();
			return false;
		}

		var telNo = $("#telNo1").val() + "-" + $("#telNo2").val() + "-" + $("#telNo3").val();
		$("#telNo").val(telNo);
		
		/*
		if ($("#cpNo1 > option:selected").val() == null || $("#cpNo1 > option:selected").val() == "") {
			alert("??????????????? : ????????????????????????.");
			$("#cpNo1").focus();
			return false;
		} else if (isNaN($("#cpNo1").val())) {
			alert("??????????????? : ????????? ??????????????????.");
			$("#cpNo1").focus();
			return false;
		}
		if ($("#cpNo2").val() == null || $("#cpNo2").val() == "") {
			alert("???????????????: ????????????????????????.");
			$("#cpNo2").focus();
			return false;
		} else if (isNaN($("#cpNo2").val())) {
			alert("??????????????? : ????????? ??????????????????.");
			$("#cpNo2").focus();
			return false;
		}

		if ($("#cpNo3").val() == null || $("#cpNo3").val() == "") {
			alert("???????????????: ????????????????????????.");
			$("#cpNo3").focus();
			return false;
		} else if (isNaN($("#cpNo3").val())) {
			alert("??????????????? : ????????? ??????????????????.");
			$("#cpNo3").focus();
			return false;
		}
		*/
		var cpNo = "";
		if($("#cpNo2").val() != "" && $("#cpNo3").val() != ""){
			cpNo = $("#cpNo1").val() + "-" + $("#cpNo2").val() + "-" + $("#cpNo3").val();
		}
		$("#cpNo").val(cpNo);

		if ($("#emailId").val() == null || $("#emailId").val() == "") {
			alert("????????? ID : ????????????????????????.");
			$("#emailId").focus();
			return false;
		}else if(!emailIdChk.test($("#emailId").val())){
			alert("????????? ID : ????????? ID ???????????? ??????????????????.");
			$("#emailId").focus();
			return false;
		}

		if ($("#emailDomain").val() == null || $("#emailDomain").val() == "") {
			alert("????????? DOMAIN : ????????????????????????.");
			$("#emailDomain").focus();
			return false;
		}else if(!emailDomainChk.test($("#emailDomain").val())){
			alert("????????? DOMAIN : ????????? ????????? ???????????? ??????????????????.");
			$("#emailDomain").focus();
			return false;
		}
		var email = $("#emailId").val() + "@" + $("#emailDomain").val();
		$("#email").val(email);

		if($("#zipcode").val() == null || $("#zipcode").val() == "") {
			alert("???????????? : ????????????????????????.");
			$("#zipcode").focus();
			return false;
		}

		if($("#addr1").val() == null || $("#addr1").val() == "") {
			alert("?????? : ????????????????????????.");
			$("#addr1").focus();
			return false;
		}
		
		if($("#addr2").val() == null || $("#addr2").val() == "") {
			alert("???????????? : ????????????????????????.");
			$("#addr2").focus();
			return false;
		}
		
		/*
		if($("#orgGrpType").val() == null || $("#orgGrpType").val() == "") {
			alert("??????/?????? ?????? : ????????????????????????.");
			$("#orgGrpType").focus();
			return false;
		}

		if($("#orgGrpNm").val() == null || $("#orgGrpNm").val() == "") {
			alert("??????/????????? : ????????????????????????.");
			$("#orgGrpNm").focus();
			return false;
		}

		if($("#ownerNm").val() == null || $("#ownerNm").val() == "") {
			alert("???????????? : ????????????????????????.");
			$("#ownerNm").focus();
			return false;
		}

		if($("#corpNo1").val() == null || $("#corpNo1").val() == "") {
			alert("????????????????????? : ????????????????????????.");
			$("#corpNo1").focus();
			return false;
		}else if(isNaN($("#corpNo1").val())){
			alert("????????????????????? : ????????? ????????? ?????????.");
			$("#corpNo1").focus();
		}

		if($("#corpNo2").val() == null || $("#corpNo2").val() == "") {
			alert("????????????????????? : ????????????????????????.");
			$("#corpNo2").focus();
			return false;
		}else if(isNaN($("#corpNo2").val())){
			alert("????????????????????? : ????????? ????????? ?????????.");
			$("#corpNo2").focus();
		}

		if($("#corpNo3").val() == null || $("#corpNo3").val() == "") {
			alert("????????????????????? : ????????????????????????.");
			$("#corpNo3").focus();
			return false;
		}else if(isNaN($("#corpNo3").val())){
			alert("????????????????????? : ????????? ????????? ?????????.");
			$("#corpNo3").focus();
		}
		*/
		var corpNo = "";
		if($("#corpNo1").val() != "" && $("#corpNo2").val() != "" && $("#corpNo3").val() != ""){
			corpNo = $("#corpNo1").val() + "-" + $("#corpNo2").val() + "-" + $("#corpNo3").val();
		}
		$("#corpNo").val(corpNo);
		
		/*
		if($("#deptNm").val() == null || $("#deptNm").val() == "") {
			alert("????????????/?????? : ????????????????????????.");
			$("#deptNm").focus();
			return false;
		}

		if($("#positionNm").val() == null || $("#positionNm").val() == "") {
			alert("?????? : ????????????????????????.");
			$("#positionNm").focus();
			return false;
		}
		*/

		if($("#mode").val() == 'write'){
			$("#mode").val("writeProc");
		}else if($("#mode").val() == 'edit'){
			$("#mode").val("editProc");
		}

		$('#fwrite').submit();
	}
</script>