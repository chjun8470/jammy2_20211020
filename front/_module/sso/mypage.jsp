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
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
// 	String fileGrp = "jntptotal";
// 	String fileSubGrp = "";
// 	String fileFullGrp =fileGrp+fileSubGrp;
	String fileGrp = "orgMngUsr";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
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

	<div class="MPTit">????????????</div>
	
	<form name="fedit" id="fedit" action="./editProc.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="reUrl" id="reUrl" value="" />
		<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=orgGrpCd %>" onChange="orgInfo()"/>
		<input type="hidden" name="deptNmOption" id="deptNmOption" value="<%=deptNmOption %>"/>
		<input type="hidden" name="idCheck" id="idCheck" />

		<div class="basic_writeWrap">
	   		<table class="skin_write01 " summary="???????????????  ??????, ??????, ????????????, ???????????????(??????)??? ???????????????.">
	   			<caption>???????????????</caption>
                <colgroup>
                	<col style="width:30%" />
					<col style="width:70%" />
               	</colgroup>
				<tbody>
					<tr>
						<th class="th">????????? ID <span class="red">*</span></th>
						<td class="td r_line_none">
							<input type="text" name="userId" maxlength="20" value="<%=util.getStr(dataMap.get("USER_ID")) %>" id="userId" class="txtbox" title="?????????ID" readOnly/>
						</td>
					</tr>
<%-- <%if(userAppState.equals("")||userAppState.equals(null)){%> --%>
<%if(util.getStr(dataMap.get("USER_APP_STATE")).equals("") || util.getStr(dataMap.get("USER_APP_STATE")).equals(null)){ %>
					<tr>
						<th class="th">??? ??? <span class="red">*</span></th>
						<td class="td r_line_none">
							<input type="text" name="psnNm" maxlength="24" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" id="psnNm" class="txtbox" title="??????"/>
						</td>
					</tr>
<%}else{ %>
					<tr>
						<th class="th">??? ??? <span class="red">*</span></th>
						<td class="td r_line_none">
							<input type="text" name="psnNm" maxlength="24" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" id="psnNm" class="txtbox" title="??????"/>
						</td>
               			<th scope="col" class="r_line_none"><label for="state">??????</label></th>
               			<td>
               				<%=util.getStr(dataMap.get("USER_APP_STATE")) %>
               			</td>
               		</tr>
<% }%>
				<%-- 	<tr>
						<th class="th"> * ????????????</th>
						<td class="td">
							<input type="password" name="password" maxlength="20" value="<%=util.getStr(dataMap.get("PASSWORD")) %>" id="userId" class="password" title="?????????ID" readOnly style="border:0px"/>
						</td>
						<th class="th"> * ??????????????????</th>
						<td class="td">
							<input type="password" name="confirmPassword" maxlength="20" value="<%=util.getStr(dataMap.get("PASSWORD")) %>" id="confirmPassword" class="txtbox" title="?????????ID" readOnly style="border:0px"/>
						</td>
					</tr> --%>
					<tr>
						<th class="th">????????????<span class="red">*</span></th>
						<td class="td r_line_none">
							<input type="radio" name="genderTypeCd" value="M" id="genderTypeCdMale" <%=util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("M")? " checked='checked'" : "" %>/><label class="radio" for="genderTypeCdMale">??????</label>
							<input type="radio" name="genderTypeCd" value="F" id="genderTypeCdFemale" <%=util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("F")? "checked='checked'" : "" %> class="MAL10"/><label class="radio" for="genderTypeCdFemale">??????</label>
						</td>
					</tr>
					<tr>
						<th class="th" align="center" valign="middle">???????????????<span class="red">*</span></th>
						<td class="td r_line_none">
							<input type="radio" name="frgnYn" value="N" id="frgnYnY" style="width:20px;" title="?????????" <%=util.getStr(dataMap.get("FRGN_YN")).equals("N")? "checked='checked'" : "" %> /><label class="radio" for="frgnYnY">?????????</label>
							<input type="radio" name="frgnYn" value="Y" id="frgnYnN" style="margin-left: 20px; width:20px" title="?????????" <%=util.getStr(dataMap.get("FRGN_YN")).equals("Y")? "checked='checked'" : "" %> class="MAL10"/><label class="radio" for="frgnYnN">?????????</label>
						</td>
					</tr>
					 <tr>
						<th class="th">????????????<span class="red">*</span></th>
						<td class="td r_line_none">
							<span id="inTel">
								<input type="hidden" name="telNo" value="" id="telNo"/>
								<select name="telNo1" id="telNo1" title="????????????????????? ??????" class="w30">
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
								<input class="txt003" type="text" name="telNo2" maxlength="4" value="<%=telNo2%>" id="telNo2" title="??????????????? ?????????"/> -
								<input class="txt003" type="text" name="telNo3" maxlength="4" value="<%=telNo3%>" id="telNo3" class="txtbox" title="??????????????? ?????????"/>
							</span>
						</td>
					</tr>
					<tr>
						<th class="th">???????????????<span class="red">*</span></th>
						<td class="td r_line_none">
							<span id="inCp">
								<input type="hidden" name="cpNo" value="" id="cpNo"/>
								<select name="cpNo1" id="cpNo1" class="w30" title="????????? ??????">
									<option value="010" <%if(cpNo1.equals("010")) { %> selected="selected" <% } %>>010</option>
									<option value="011" <%if(cpNo1.equals("011")) { %> selected="selected" <% } %>>011</option>
									<option value="016" <%if(cpNo1.equals("016")) { %> selected="selected" <% } %>>016</option>
									<option value="017" <%if(cpNo1.equals("017")) { %> selected="selected" <% } %>>017</option>
									<option value="018" <%if(cpNo1.equals("018")) { %> selected="selected" <% } %>>018</option>
									<option value="019" <%if(cpNo1.equals("019")) { %> selected="selected" <% } %>>019</option>
								</select> -
								<input type="text" name="cpNo2" class="txt003" maxlength="4" value="<%=cpNo2%>" id="cpNo2" title="????????? ?????????"/> -
								<input type="text" name="cpNo3" class="txt003" maxlength="4" value="<%=cpNo3%>" id="cpNo3" title="????????? ?????????"/>
							</span>
						</td>
					</tr>
					<tr>
						<th class="th">?????????</th>
						<td class="td r_line_none">
							<%=email %>
						</td>

					<%-- <tr id="userTpTr">
						<th class="th"> * ????????????</th>
						<td class="td" colspan="3">
							<label><input type="radio" name="userTp" value="1"id="userTp1" style="margin-left: 20px;  display: inline-block; width:20px;" title="??????" <%=util.getStr(dataMap.get("USER_TP")).equals("1")? "checked='checked'" : "disabled='disabled'" %>/>??????</label>
							<label><input type="radio" name="userTp" value="2"id="userTp2" style="width:20px;" title="??????"  <%=util.getStr(dataMap.get("USER_TP")).equals("2")? "checked='checked'" : "disabled='disabled'" %>/>??????</label>
							<label><input type="radio" name="userTp" value="3"id="userTp3" style="width:20px;" title="??????"  <%=util.getStr(dataMap.get("USER_TP")).equals("3")? "checked='checked'" : "disabled='disabled'" %>/>??????</label>
							<% if (dataMap.get("USER_TP").equals("3")){%>
							<span id="orgList" style="padding-left: 15px;" >
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgList','2')" />
							</span>
							<%} else if(dataMap.get("USER_TP").equals("2")){%>
							<span id="orgList" style="padding-left: 15px;" >
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgList','1')" />
							</span>
							<%} %>
							<br/>
							<span style="color:#F00; "> *  ?????? ???????????? ?????? JEINET ???????????? ????????? ??????????????? ????????? ??? ????????????.</span>
						</td>
					</tr> --%>
					<% if (util.getStr(dataMap.get("USER_TP")).equals("2")||util.getStr(dataMap.get("USER_TP")).equals("3")){%>
					<tr id="orgInfo1">
						<th class="th"><% if (util.getStr(dataMap.get("USER_TP")).equals("3")){%>?????????<%}else{ %>?????????<%}%></th>
						<td class="td r_line_none">
							<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>
							<%-- <input type="text" id="orgGrpNm" name="orgGrpNm" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>" class="inp_txt" title="?????????" style="width:80%;" readonly = "readonly" maxlength="10"/> --%>
						</td>

					</tr>
					<%-- <tr id="orgInfo1">
						<th class="th"> * ?????????</th>
						<td class="td" colspan="3">
							<input type="text" id="orgGrpNm" name="orgGrpNm" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>" class="inp_txt" title="?????????" style="width:80%;" readonly = "readonly" maxlength="10"/>
						</td>

					</tr>
					<tr id="orgInfo2">
						<th class="th"> * ?????????</th>
						<td class="td" id="depNmTd">
							<input type="text" name="deptNm" id="deptNm" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" title="??????" maxlength="10"/>
	 					</td>
						<th class="th"> * ??????</th>
						<td class="td">
							<input type="text" name="positionNm" id="positionNm" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" title="??????" maxlength="10"/>
						</td>
					</tr> --%>
						<%} %>
				</tbody>
			</table>

			<%-- <table class="skin_basic_write" id="write_table" style="width: 600px;">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 140px;" />
				<col style="width: *;" />
			</colgroup>
			<!-- colgroup e -->
				<tr>
					<td colspan="2" >?????? ????????? ????????? ????????? ??????. ??????????????? ?????? ??????????????? ??????????????????</td>
				</tr>
				<tr>
					<th>????????????</th>
					<td>
						<input type="password" id="pwd" name="pwd" value=""/>
					</td>
				</tr>
				<tr>
					<th>???????????? ??????</th>
					<td>
						<input type="password" id="rePwd" name="rePwd" value=""/>
					</td>
				</tr>
				</table> --%>

			<div class="MPBtnWrap MAT10">
					<input type="button" onclick="submitGo()" value="??????" class="btn_inp_b_01 FloatR" />
			</div>
		</div>

</form>

<script type="text/javascript">
//<![CDATA[
	//???????????? ??????
	function popupWindow(listMode,userTp){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

		var popUrl="/sys/popup/"+listMode+".do?userTp="+userTp;
		var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}

	//????????????
function orgInfo(orgGrpCd){
		var orgGrpCd = orgGrpCd;
		var orgGrpNm;
		var result = "";
		var params = {
				"orgGrpCd": orgGrpCd
		};
		$.post("/sys/getOrgInfo.do",$.param(params),
		function(data){
			orgGrpNm = data.dataMap.ORG_GRP_NM;
			$("#orgGrpNm").val(orgGrpNm);
			<%--
			if(data.totalCount > 0){
				result="<select id=\"deptNm\" name=\"deptNm\" ";
				var checked = "";
				for(i=0; i<data.totalCount; i++){
					if(data.dataList[i].ORG_GRP_SUB_NM=="<%=util.getStr(dataMap.get("DEPT_NM"))%>"){
						checked="checked=\'checked\'";
						}else{
						checked=""
					}
					result += "<option value=\""+data.dataList[i].ORG_GRP_SUB_NM+"\">"+data.dataList[i].ORG_GRP_SUB_NM+"<\/option>";

				}
				result +="<\/select>"
				$("#depNmTd").html(result);
			}else{
				result="<input id=\"deptNm\" name=\"deptNm\" maxlength=\"30\" value=\"<%=util.getStr(dataMap.get("DEPT_NM"))%>\" >";
				$("#depNmTd").html(result)
			} --%>

		});


	}
function domainChange(){
	var domain = $("#emailDomainChoise > option:selected").val()
	if(domain==""){
		$("#emailDomain").css("background-color","");
		$("#emailDomain").removeAttr("readonly");
		$("#emailDomain").val("");
	}else{
		$("#emailDomain").val(domain);
		$("#emailDomain").css("background-color", "#EEEEEE");
		$("#emailDomain").attr("readonly", true);
	}
};

var idPattern = /[^a-zA-Z0-9]/;
var korPattern = /[^???-???]/;
var engPattern = /[^a-zA-Z- ]/;
var numPattern = /[^\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");

$(document).ready(function(){
	domainChange();

	var orgGrpCd = $("#orgGrpCd").val();
	if(orgGrpCd == "" || orgGrpCd == null){
		$('#blngOrgNm').hide();
		$('#orgInfo1').hide();
		$('#orgInfo2').hide();
		$('#userTpTr').hide();
	}else{
		$("#blngOrgNm").show();
		var orgGrpCd = $("#orgGrpCd").val();
		orgInfo(orgGrpCd);
	}


		$('#orgMngUsrFile1').bind('change', function() {
			var fileName = $('#orgMngUsrFile1').val();
			if(fileName != "" || fileName != null){
				fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
				if(imgPattern.indexOf(fileName)==-1){
					alert("??????????????? bmp, gif, jpg, jpeg, png ????????? ????????? ????????????????????????.");
					$('#orgMngUsrFile1').val("");
					return false;
				}
				/* else if(this.files[0].size<300000){
					alert("300kb ????????? ???????????? ??????????????????.");
					$('#orgMngUsrFile1').val("");
					return false;
				} */
			}
		});

	$('input[name="userTp"]').change(function(){
	    if($(this).val()=='1'){
	    	$("#orgGrpCd").val("");
	    	$("#positionNm").val("");
	    	$('#orgGrpNm').val("");
	    	$('#deptNm').val("");
	    	$('#blngOrgNm').hide();
	    	$('#orgInfo1').hide();
	    	$('#orgInfo2').hide();
	    	$('#userTpTr').hide();
	    }else{
	    	$('#blngOrgNm').show();
	    	$('#orgInfo1').show();
	    	$('#orgInfo2').show();
	    	$('#userTpTr').show();
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

	/* if(!$("input[name='userTp']").is(":checked")){
		alert("???????????? : ????????????????????????.");
		$("#blngOrgGubunOrg").focus();
		return false;
	}else */ if($("input[type=radio][name='userTp']:checked").val()!="1"){
		/* if($("#orgGrpNm").val()==null||$("#orgGrpNm").val()==""){
			alert("???????????? : ????????????????????????.");
			$("#orgGrpNm").focus();
			return false;
		}
		if($("#deptNm").val()==null||$("#deptNm").val()==""){
			alert("????????? : ????????????????????????.");
			$("#deptNm").focus();
			return false;
		}

		if($("#positionNm").val()==null||$("#positionNm").val()==""){
			alert("?????? : ????????????????????????.");
			$("#positionNm").focus();
			return false;
		}  */

		var fileCK=0
	    var fileCheck = document.getElementsByName("fileFlog");
	    var fileTot = fileCheck.length;
	    for (var fi = 0; fi < fileTot; fi++) {
	        if (fileCheck[fi].checked == true) {
	            fileCK++;
	        }
	    }

		var fileCheck = 0;
		var fileCheck2 = $("input[name=fileFlog]").length;
			fileCheck = Number(fileCheck) + Number(fileCheck2) - Number(fileCK);
		var fileCount = $("input[type=file]").length;
			for(i = 1; i <= fileCount; i++) {
					var fileName = $('#orgMngUsrFile'+fileCount).val();
					if(fileName != "" && fileName != null){fileCheck++;}
			}
	}

	/* if($('#pwd').val() == ""){
		alert("??????????????? ?????? ????????????");
		return false;
	}else{
		if($('#pwd').val() != $('#rePwd').val()){
			alert("??????????????? ???????????? ????????????.");
			return false;
		}
	}
	jQuery.post('./userPassCheck.do',
			{
				"pwd" : $('#pwd').val(),
			},
			function(data){
				var successCode = data.successCode;

				if(successCode == "OK"){
					if(confirm("??????????????? ?????????????????????????")){
						$("#mode").val("editProc");
						 $('#fedit').submit();
					}
				}else{
					alert("??????????????? ??????????????????.");
					return false;
				}
			}
		); */
	if(confirm("??????????????? ?????????????????????????")){
		$("#mode").val("editProc");
		 $('#fedit').submit();
	}

}
function fileSet(fileCnt){
	if($('#fileFlog_'+fileCnt).is(':checked')){
		$('#fileBox_'+fileCnt).show();
	}else{
		$('#fileBox_'+fileCnt).hide();
	}
}
//]]>
</script>