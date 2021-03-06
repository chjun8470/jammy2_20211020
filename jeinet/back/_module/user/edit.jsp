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
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
// 	String fileGrp = "jntptotal";
// 	String fileSubGrp = "";
// 	String fileFullGrp =fileGrp+fileSubGrp;
	String mode = util.getStr(paramMap.get("mode"));
	String userAppState = util.getStr(dataMap.get("USER_APP_STATE"));
	String orgGrpCd = util.getStr(dataMap.get("ORG_GRP_CD"));
	String deptNmOption = util.getStr(dataMap.get("DEPT_NM"));
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
	telNo = util.autoTel(telNo);
		int t1 = telNo.indexOf("-");
		int t2 = telNo.indexOf("-",t1+1);
		String	telNo1 = telNo.substring(0, t1);
		String	telNo2 = telNo.substring(t1+1, t2);
		String	telNo3 = telNo.substring(t2+1);
	//tel E
	//cp S
	String cpNo = util.getStr(dataMap.get("CP_NO"));
	cpNo = util.autoTel(cpNo);
		int c1 = cpNo.indexOf("-");
		int c2 = cpNo.indexOf("-",c1+1);
		String cpNo1 = cpNo.substring(0, c1);
		String cpNo2 = cpNo.substring(c1+1, c2);
		String cpNo3 = cpNo.substring(c2+1);
	//tel E
%>
	<form name="fedit" id="fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="userIdx" id="userIdx" value="<%=util.getStr(paramMap.get("userIdx")) %>" />
		<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?mode=view&userIdx=<%=util.getStr(paramMap.get("userIdx")) %>" />
		<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=orgGrpCd %>" onChange="orgInfo()"/>
		<input type="hidden" name="deptNmOption" id="deptNmOption" value="<%=deptNmOption %>"/>
		<input type="hidden" name="idCheck" id="idCheck" />

		<div class="skin_bbs_write" style="margin-top: 30px">
	   		<table class="skin_basic_write" >
	   			<caption>???????????????</caption>
                <colgroup>
                	<col style="width:20%">
					<col style="width:30%">
					<col style="width:20%">
					<col style="width:30%">
               	</colgroup>
				<tbody>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ????????? ID</th>
						<td class="td">
							<input type="text" name="userId" maxlength="20" value="<%=util.getStr(dataMap.get("USER_ID")) %>" id="userId" class="inp_txt" title="?????????ID" readonly="readonly" style="border:0px">
						</td>
						<th class="th"> <span style="color:red; font-size:10pt;">* ??????</span></th>
						<td class="td">
							<select id="authLv" name="authLv">
								<option value="01">????????????</option>
								<option value="10" <%=util.getIntStr(dataMap.get("AUTH_LV")).equals("10")? "selected = 'selected'":"" %>>????????????</option>
								<option value="70" <%=util.getIntStr(dataMap.get("AUTH_LV")).equals("70")? "selected = 'selected'":"" %>>???????????????</option>
								<%-- <option value="80" <%=util.getIntStr(dataMap.get("AUTH_LV")).equals("80")? "selected = 'selected'":"" %>>???????????????</option>
								<option value="99" <%=util.getIntStr(dataMap.get("AUTH_LV")).equals("99")? "selected = 'selected'":"" %>>???????????????</option> --%>
							</select>
						</td>
					</tr>

					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ??? ???</th>
						<td class="td">
							<input type="text" name="psnNm" maxlength="24" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" id="psnNm" class="inp_txt" title="??????">
						</td>
               			<th scope="col">??????</th>
               			<td>
               			<select id="userAppState" name="userAppState">
               				<option value="10" <%=userAppState.equals("??????")? "selected='selected'" : "" %>> ?????? </option>
               				<option value="20" <%=userAppState.equals("??????")? "selected='selected'" : "" %>> ?????? </option>
               				<option value="30" <%=userAppState.equals("??????")? "selected='selected'" : "" %>> ?????? </option>
               			</select>
               			</td>
               		</tr>
				<%-- 	<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ????????????</th>
						<td class="td">
							<input type="password" name="password" maxlength="20" value="<%=util.getStr(dataMap.get("PASSWORD")) %>" id="userId" class="password" title="?????????ID" readOnly style="border:0px">
						</td>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ??????????????????</th>
						<td class="td">
							<input type="password" name="confirmPassword" maxlength="20" value="<%=util.getStr(dataMap.get("PASSWORD")) %>" id="confirmPassword" class="txtbox" title="?????????ID" readOnly style="border:0px">
						</td>
					</tr> --%>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ????????????</th>
						<td class="td">
							<input type="radio" name="genderTypeCd" value="M" id="genderTypeCdMale" style="width:20px;" <%=util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("??????")? "checked='checked'" : "" %>><label for="genderTypeCdMale">??????</label>
							<input type="radio" name="genderTypeCd" value="F" id="genderTypeCdFemale" style="width:20px;" <%=util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("??????")? "checked='checked'" : "" %>><label for="genderTypeCdFemale">??????</label>
						</td>
						<th class="th" style="align:center; valign:middle"> <span style="color:red; font-size:10pt;">*</span> ???????????????</th>
						<td class="td">
							<input type="radio" name="frgnYn" value="N" id="frgnYnY" style="width:20px;" title="?????????" <%=util.getStr(dataMap.get("FRGN_YN")).equals("N")?  "checked='checked'" : "" %>><label for="frgnYnY">?????????</label>
							<input type="radio" name="frgnYn" value="Y" id="frgnYnN" style="margin-left: 20px; width:20px" title="?????????" <%=util.getStr(dataMap.get("FRGN_YN")).equals("Y")?  "checked='checked'" : "" %>><label for="frgnYnN">?????????</label>
						</td>
					</tr>
					 <tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ????????????</th>
						<td class="td">
							<span id="inTel">
								<input type="hidden" name="telNo"  id="telNo">
								<select name="telNo1" id="telNo1" style="width: 60px;" title="????????????????????? ??????"><option value="02">02</option>
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
								</select> -
								<input type="text" name="telNo2" style="width:50px" maxlength="4" value="<%=telNo2%>" id="telNo2" class="inp_txt" title="??????????????? ?????????"> -
								<input type="text" name="telNo3" style="width:50px" maxlength="4" value="<%=telNo3%>" id="telNo3" class="inp_txt" title="??????????????? ?????????">
							</span>
						</td>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ???????????????</th>
						<td class="td">
							<span id="inCp">
								<input type="hidden" name="cpNo"  id="cpNo">
								<select name="cpNo1" id="cpNo1" style="width: 60px;" title="????????? ??????">
									<option value="010" <%if(cpNo1.equals("010")) { %> selected="selected" <% } %>>010</option>
									<option value="011" <%if(cpNo1.equals("011")) { %> selected="selected" <% } %>>011</option>
									<option value="016" <%if(cpNo1.equals("016")) { %> selected="selected" <% } %>>016</option>
									<option value="017" <%if(cpNo1.equals("017")) { %> selected="selected" <% } %>>017</option>
									<option value="018" <%if(cpNo1.equals("018")) { %> selected="selected" <% } %>>018</option>
									<option value="019" <%if(cpNo1.equals("019")) { %> selected="selected" <% } %>>019</option>
								</select> -
								<input type="text" name="cpNo2" style="width:50px" maxlength="4" value="<%=cpNo2%>" id="cpNo2" class="inp_txt" title="????????? ?????????"> -
								<input type="text" name="cpNo3" style="width:50px" maxlength="4" value="<%=cpNo3%>" id="cpNo3" class="inp_txt" title="????????? ?????????">
							</span>
						</td>
					</tr>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ?????????</th>
						<td class="td" colspan="3">
							<input type="hidden" name="email"  id="email">
							<input type="text" name="emailId" maxlength="20" value="<%=emailId %>" id="emailId" class="inp_txt" title="??????????????????"> @
							<input type="text" name="emailDomain" maxlength="50" value="<%=emailDomain%>" id="emailDomain" class="inp_txt" title="??????????????????">
							<select name="emailDomainChoise" id="emailDomainChoise" title="??????????????????????????????" >
								<option  selected="selected">????????????</option>
								<option value="empal.com">?????????</option>
								<option value="naver.com">?????????</option>
								<option value="hanmail.net">??????</option>
								<option value="hotmail.com">?????????</option>
								<option value="yahoo.co.kr">??????</option>
								<option value="nate.com">?????????</option>
							</select>
						</td>

					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ????????????<%= util.getStr(dataMap.get("USER_TP"))%></th>
						<td class="td" colspan="3">
							<input type="radio" name="userTp" value="1" id="userTp1" style="margin-left: 20px;width:20px;" title="??????" <%=util.getStr(dataMap.get("USER_TP")).equals("1")? "checked='checked'" : "" %>><label for="userTp1">????????????</label>
							<input type="radio" name="userTp" value="2" id="userTp2" style="width:20px;" title="??????"  <%=util.getStr(dataMap.get("USER_TP")).equals("2")? "checked='checked'" : "" %>><label for="userTp2">????????????</label>
							<input type="radio" name="userTp" value="3" id="userTp3" style="width:20px;" title="??????"  <%=util.getStr(dataMap.get("USER_TP")).equals("3")? "checked='checked'" : "" %>><label for="userTp3">????????????</label>
							<span id="orgList" style="padding-left: 15px;">
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm1" class="btn_inp_b_01" style="display:none;" onclick="popupWindow('orgList','2')" >
							</span>
							<span id="orgList1" style="padding-left: 15px;">
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm2" class="btn_inp_b_01" style="display:none;" onclick="popupWindow('orgList','1')" >
							</span><br/>
						</td>
					</tr>

					<tr id="orgInfo1">
						<th class="th" id="thNm"> <span style="color:red; font-size:10pt;">*</span> ?????????</th>
						<td class="td" colspan="3">
							<input type="text" id="orgGrpNm" name="orgGrpNm"  class="inp_txt"  title="?????????" style="width:80%;" readonly = "readonly">
						</td>
					</tr>
					<tr id="orgInfo2">
						<th class="th" id="deptNmTh"> <span style="color:red; font-size:10pt;">*</span> ?????????</th>
						<td id="deptNmTd">
	 						<input type="text" id="deptNm" name="deptNm" class="inp_txt" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" title="?????????" style="width:60%;">
	 						<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgSubList')" >
	 					</td>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> ??????</th>
						<td class="td">
							<input type="text" name="positionNm" id="positionNm" class="inp_txt" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" title="??????" maxlength="10"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	<div class="btn_box" >
			<div class="btn_right_box" >
				<input type="button" onclick="submitGo()" value="??????" class="btn_inp_b_01" />
				<input type="button" onclick="goSubmit('list')" class="btn_inp_w_01" value="??????"/>
			</div>
		</div>

</form>

<script type="text/javascript">
	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fedit').submit();
	}
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



var idPattern = /[^a-zA-Z0-9]/;
var korPattern = /[^???-???]/;
var engPattern = /[^a-zA-Z- ]/;
var numPattern = /[^\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");

$(document).ready(function(){
	orgGrpCd = $("#orgGrpCd").val();

	if(orgGrpCd == "" || orgGrpCd == null){
		$('#blngOrgNm').hide();
		$('#orgInfo1').hide();
		$('#orgInfo2').hide();
	}else{
		$("#blngOrgNm").show();
		var orgGrpCd = $("#orgGrpCd").val();
		orgInfo(orgGrpCd, 'cnt');
	}
	if($("input[type=radio][name='userTp']:checked").val() == '2'){
		$('#blngOrgNm2').show();
		$('#blngOrgNm1').hide();
		$('#deptNmTh').show();
	    $('#deptNmTd').show();
	    $('#blngOrgNm').show();
	}else if($("input[type=radio][name='userTp']:checked").val() == '3'){
		$('#blngOrgNm1').show();
		$('#blngOrgNm2').hide();
		$('#deptNmTh').show();
	    $('#deptNmTd').show();
	    $('#blngOrgNm').show();

	}

	$('input[name="userTp"]').change(function(){
	    if($(this).val()=='1'){
	    	$('#orgInfo1').hide();
			$('#orgInfo2').hide();
	    	$("#orgGrpCd").val("");
	    	$("#positionNm").val("");
	    	$('#orgGrpNm').val("");
	    	$('#userAppState').val("");
	    	$('#deptNm').val("");
	    	$('#blngOrgNm1').hide();
	    	$('#blngOrgNm2').hide();
	    }else if($(this).val()=='2'){
	    	$('#thNm').html( "");
	    	$('#thNm').html(" <span style='color:red; font-size:10pt;'>*</span> ?????????");
	    	$("#orgGrpCd").val("");
	    	$("#positionNm").val("");
	    	$('#orgGrpNm').val("");
	    	$('#userAppState').val("");
	    	$('#deptNm').val("");
	    	$('#blngOrgNm2').show();
	    	$('#orgInfo1').show();
	    	$('#orgInfo2').show();
	    	$('#userTpTr').show();
	    	$('#blngOrgNm1').hide();
	    	$('#blngOrgNm').show();
	    	$('#deptNmTh').show();
	    	$('#deptNmTd').show();
	    	$("#deptNm").removeAttr("readonly");
	    }else if($(this).val()=='3'){
	    	$('#thNm').html( "");
	    	$('#thNm').html(" <span style='color:red; font-size:10pt;'>*</span> ?????????");
	    	$("#orgGrpCd").val("");
	    	$("#positionNm").val("");
	    	$('#orgGrpNm').val("");
	    	$('#userAppState').val("20");
	    	$('#deptNm').val("");
	    	$('#blngOrgNm1').show();
	    	$('#orgInfo1').show();
	    	$('#orgInfo2').show();
	    	$('#userTpTr').show();
	    	$('#blngOrgNm2').hide();
	    	$('#blngOrgNm').show();
	    	$('#deptNmTh').show();
	    	$('#deptNmTd').show();
	    }
	});

	$("#emailDomainChoise").change(function() {
		if(this.value==""){
			$("#emailDomain").css("background-color","");
			$("#emailDomain").removeAttr("readonly");
			$("#emailDomain").val("");
		}else{
			$("#emailDomain").val(this.value);
			$("#emailDomain").css("background-color", "#EEEEEE");
			$("#emailDomain").attr("readonly", true);
		}
	});
});


function submitGo(){

	var userId = $("#userId").val();
	var err = 0;
	if($("#psnNm").val()==null||$("#psnNm").val()==""){
		alert("?????? : ????????????????????????.");
		$("#psnNm").focus();
		return false;
	}else{

		if(korPattern.test($("#psnNm").val())){
			alert("?????? : ????????? ??????????????????.");
			$("#psnNm").focus();
			return false;
			}
		}

	if(!$("input[name='genderTypeCd']").is(":checked")){
		alert("???????????? : ????????????????????????.");
		$("#genderTypeCdMale").focus();
		return false;
	}
	if(!$("input[name='frgnYn']").is(":checked")){
		alert("??????????????? : ????????????????????????.");
		$("#frgnYnY").focus();
		return false;
	}
	if($("#telNo1 > option:selected").val()==null || $("#telNo1 > option:selected").val()==""){
		alert("???????????? : ????????????????????????.");
		$("#telNo1").focus();
		return false;
	}

	if($("#telNo2").val()==null||$("#telNo2").val()==""){
		alert("???????????? : ????????????????????????.");
		$("#telNo2").focus();
		return false;
	}else if(isNaN($("#telNo2").val())){
		alert("???????????? : ????????? ??????????????????.");
		$("#telNo2").focus();
		return false;
	}

	if($("#telNo3").val()==null||$("#telNo3").val()==""){
		alert("???????????? : ????????????????????????.");
		$("#telNo3").focus();
		return false;
	}else if(isNaN($("#telNo3").val())){
		alert("???????????? : ????????? ??????????????????.");
		$("#telNo3").focus();
		return false;
	}

	var telNo = $("#telNo1").val()+"-"+$("#telNo2").val()+"-"+$("#telNo3").val();
	$("#telNo").val(telNo);

	if($("#cpNo1 > option:selected").val()==null || $("#cpNo1 > option:selected").val()==""){
		alert("??????????????? : ????????????????????????.");
		$("#cpNo1").focus();
		return false;
	}else if(isNaN($("#cpNo1").val())){
		alert("??????????????? : ????????? ??????????????????.");
		$("#cpNo1").focus();
		return false;
	}
	if($("#cpNo2").val()==null||$("#cpNo2").val()==""){
		alert("???????????????: ????????????????????????.");
		$("#cpNo2").focus();
		return false;
	}else if(isNaN($("#cpNo2").val())){
		alert("??????????????? : ????????? ??????????????????.");
		$("#cpNo2").focus();
		return false;
	}

	if($("#cpNo3").val()==null||$("#cpNo3").val()==""){
		alert("???????????????: ????????????????????????.");
		$("#cpNo3").focus();
		return false;
	}else if(isNaN($("#cpNo3").val())){
		alert("??????????????? : ????????? ??????????????????.");
		$("#cpNo3").focus();
		return false;
	}
	var cpNo = $("#cpNo1").val()+"-"+$("#cpNo2").val()+"-"+$("#cpNo3").val();
	$("#cpNo").val(cpNo);

	if($("#emailId").val()==null||$("#emailId").val()==""){
		alert("????????? : ????????????????????????.");
		$("#emailId").focus();
		return false;
	}

	if($("#emailDomain").val()==null||$("#emailDomain").val()==""){
		alert("????????? : ????????????????????????.");
		$("#emailDomain").focus();
		return false;
	}
	var email = $("#emailId").val()+"@"+$("#emailDomain").val();
	$("#email").val(email);


	if(!$("input[name='userTp']").is(":checked")){
		alert("???????????? : ????????????????????????.");
		$("#userTp1").focus();
		return false;
	}else if($("input[type=radio][name='userTp']:checked").val()!=1){
		if($("#blngOrgNm").val()==null||$("#blngOrgNm").val()==""){
			alert("???????????? : ????????????????????????.");
			$("#userTp1").focus();
			return false;
		}
	}
	if($("input[type=radio][name='userTp']:checked").val() ==3 || $("input[type=radio][name='userTp']:checked").val() ==4){
	if(confirm("????????? ????????? ?????????????????????????")){
		if(confirm("????????? ????????? ?????????.")){
			$("#mode").val("editProc");
			$('#fedit').submit();
		}
		return false
	}
	}else{
		$("#mode").val("editProc");
		$('#fedit').submit();
	}
	return false

}

</script>