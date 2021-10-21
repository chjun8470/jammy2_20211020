<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%
HashMap<String, String> certiMap = session.getAttribute("certiMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)session.getAttribute("certiMap");
session.setAttribute("certiMap", null);
session.setAttribute("certiMap2", certiMap);
//String fileGrp = "orgMngUsr";
//String fileSubGrp = "";
//String fileFullGrp =fileGrp+fileSubGrp;

//page = request.getRequestURL();

%>
tttt
<script type="text/javascript">
//<![CDATA[
// 타이틀 변경
document.title = '정보입력 - 회원가입 - 전남과학기술정보시스템';

$(document).ready(function(){
	window.resizeTo("836", "800");

			/* $('#orgMngUsrFile1').bind('change', function() {
				var fileName = $('#orgMngUsrFile1').val();
				if(fileName != "" || fileName != null){
					fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
					if(imgPattern.indexOf(fileName)==-1){
						alert("첨부파일은 bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다.");
						$('#orgMngUsrFile1').val("");
						return false;
					}
					//else if(this.files[0].size<300000){
						//alert("300kb 이상의 이미지를 등록해주세요.");
						//$('#orgMngUsrFile1').val("");
						//return false;
					//}
				}
			}); */

	if($("#userTp").val() == 2){
		$("#deptNm").removeAttr("readonly");
	}
	$('input[name="userTp"]').change(function(){
		if($(this).val()=='3'){
			$('#userTp').val($(this).val());
	    	$('#orgGrpCd').val("");
	    	$('#positionNm').val("");
	    	$('#orgGrpNm').val("");
	    	$('#deptNm').val("");
	    	$('#orgSubNm').show();
	    	$('#blngOrgNm1').show();
	    	$('#orgInfo1').show();
	    	$('#orgInfo2').show();
	    	$('#userTpTr').show();
	    	$('#blngOrgNm2').show();
	    	$('#depNmTh').show();
			$('#depNmTd').show();
		}
	});
});




	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fwrite').submit();
	}
	//기관검색 팝업
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		if(listMode == "orgList"){
			if($('#userTp').val() == '3'){
				var popUrl="/web/popup/"+listMode+".do?userTp=2";
			}else if($('#userTp').val() == '2'){
				var popUrl="/web/popup/"+listMode+".do?userTp=1";
			}
		}else{
			if($('#orgGrpCd').val() == ''){
				alert("기관명을 입력해 주십시오");
				return false;
			}
			var popUrl="/sys/popup/"+listMode+".do?orgGrpCd="+$("#orgGrpCd").val();
		}
			var popOption="width=817, height=650, resizable=no, scrollbars=yes, status=no;";
			window.open(popUrl,"",popOption);
	}

	//부서검색팝업
 	//function popupWindow2(listMode){

 	//	var popUrl="/web/popup/"+listMode+".do";
 	//	var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
 	//	window.open(popUrl,"",popOption);
 	//}

	//기관정보
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
			$("#orgGrpCd").val(orgGrpCd);
			/*
			if(data.totalCount > 0){
				result="<select id=\"deptNm\" name=\"deptNm\" ";
				for(i=0; i<data.totalCount; i++){
					result += "<option value=\""+data.dataList[i].ORG_GRP_SUB_NM+"\">"+data.dataList[i].ORG_GRP_SUB_NM+"</option>";
				}
				result +="</select>"
				$("#depNmTd").html(result);
				/* $("#positionNm").val("");
				$("#positionNm").removeAttr("readonly"); *\/

			}else{
				result="<input id=\"deptNm\" name=\"deptNm\" maxlength=\"30\">";
				$("#depNmTd").html(result)
				/* $("#positionNm").val("");
				$("#positionNm").removeAttr("readonly"); *\/
				/* $("#positionNm").attr("readonly"); *\/
			}
			*/
// 			result="<input id=\"deptNm\" name=\"deptNm\" maxlength=\"30\">";
// 			$("#depNmTd").html(result)
			$("#positionNm").val("");
			$("#positionNm").removeAttr("readonly");
		});


	}

	//부서정보
// 	 function deptInfo(deptSubNm){
// 		var deptSubNm = deptSubNm;
// 		var deptSubNm;
// 		var result = "";
// 		var params = {
// 				"orgGrpCd": orgGrpCd
// 		};
// 		$.post("/sys/getOrgInfo.do",$.param(params),
// 		function(data){
// 			orgGrpNm = data.dataMap.ORG_GRP_NM;
// 			$("#orgGrpNm").val(orgGrpNm);
// 			$("#orgGrpCd").val(orgGrpCd);
// 			/*
// 			if(data.totalCount > 0){
// 				result="<select id=\"deptNm\" name=\"deptNm\" ";
// 				for(i=0; i<data.totalCount; i++){
// 					result += "<option value=\""+data.dataList[i].ORG_GRP_SUB_NM+"\">"+data.dataList[i].ORG_GRP_SUB_NM+"</option>";
// 				}
// 				result +="</select>"
// 				$("#depNmTd").html(result);
// 				/* $("#positionNm").val("");
// 				$("#positionNm").removeAttr("readonly"); *\/

// 			}else{
// 				result="<input id=\"deptNm\" name=\"deptNm\" maxlength=\"30\">";
// 				$("#depNmTd").html(result)
// 				/* $("#positionNm").val("");
// 				$("#positionNm").removeAttr("readonly"); *\/
// 				/* $("#positionNm").attr("readonly"); *\/
// 			}
// 			*/
// 			result="<input id=\"deptNm\" name=\"deptNm\" maxlength=\"30\">";
// 			$("#depNmTd").html(result)
// 			$("#positionNm").val("");
// 			$("#positionNm").removeAttr("readonly");
// 		});


// 	}


var emailPattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
var idPattern = /[^a-zA-Z0-9]/;
var korPattern = /[^가-힣]/;
var engPattern = /[^a-zA-Z- ]/;
var numPattern = /[^\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");

$(document).ready(function(){

	<%if(util.getStr(paramMap.get("userTp")).equals("2")||util.getStr(paramMap.get("userTp")).equals("3")){%>
		<%if(util.getStr(paramMap.get("userTp")).equals("2")){%>
			$('#photoTr').hide();
		<%}%>
<%}else{%>
$('#orgTpTr').hide();
$('#blngOrgNm').hide();
$('#orgInfo1').hide();
$('#orgInfo2').hide();
$('#photoTr').hide();

<%}
%>


	$('input[name="authLv"]').change(function(){
	    if($(this).val()=='01'){
	    	$("#orgGrpCd").val("");
	    	$("#positionNm").val("");
	    	$('#orgGrpNm').val("");
	    	$('#deptNm').val("");
	    	$('#blngOrgNm').hide();
	    	$('#orgInfo1').hide();
	    	$('#orgInfo2').hide();
	    }else{
	    	$('#blngOrgNm').show();
	    	$('#orgInfo1').show();
	    	$('#orgInfo2').show();
	    }
	});

	$("#emailDomainChoise").change(function() {
		if (this.value == "") {
			$("#emailDomain").css("background-color", "");
			$("#emailDomain").removeAttr("readonly");
			$("#emailDomain").val("");
		} else {
			$("#emailDomain").val(this.value);
			$("#emailDomain").css("background-color", "#EEEEEE");
			$("#emailDomain").attr("readonly", true);
		}
		var id = $("#emailId").val() + "@" + this.value;
		$("#userId").val(id);
		$("#email").val(id);
	});

	$("#emailId").keyup(function() {
		if(this.value.indexOf(" ") >= 0) {
			this.value = this.value.trim().replace(/(\s*)/g, "");
		}
		var id = $(this).val() + "@"+ $("#emailDomain").val();
		$("#userId").val(id);
		$("#email").val(id);
	});

	$("#emailDomain").keyup(function() {
		if(this.value.indexOf(" ") >= 0) {
			this.value = this.value.trim().replace(/(\s*)/g, "");
		}
		var id = $("#emailId").val() + "@"+ $(this).val();
		$("#userId").val(id);
		$("#email").val(id);
	});
});

function userCheck(){
	var userId = $("#userId").val();
	var err = 0;

	if(userId !=null && userId != ""){
		/* if (!emailCheck(userId)) {
			alert("영문숫자 조합 6~20자리를 입력해주세요.");
			return false;
		} */

		if (!emailPattern.test(userId)) {
			alert("이메일 양식을 입력해주세요.");
			$("#idCheck").val("0");
			return false;
		 } else {

			$.ajax({
	             type: "POST",
	             data : {
	            	 id : userId
	             },
	             url : '/web/jnspUserCheck.do',
	             dataType : 'json',
	             success : function(data){
	            	 if(data.check=="0"){
	            		 $("#idCheck").val("1");
	            		 alert("사용하실수 있는 ID 입니다.");
	            	 }else{
	            		 $("#idCheck").val("0");
	            		 alert("사용하실수 없는 ID 입니다.");
	            	 }
	             }
	    	});

		}
		userEmailCheck();
	}else{
		alert("ID를 입력해주세요.");
		$("#userId").focus();
		return false;
	}
}

/////////////////

function userEmailCheck(){

		if($("#emailId").val()==null||$("#emailId").val()==""){
			alert("이메일 : 필수입력값입니다.");
			$("#emailId").focus();
			return false;
		}
		if($("#emailDomain").val()==null||$("#emailDomain").val()==""){
			alert("이메일 : 필수입력값입니다.");
			$("#emailDomain").focus();
			return false;
		}
		var email = $("#emailId").val()+"@"+$("#emailDomain").val();

			$.ajax({
	             type: "POST",
	             data : {
	            	 email : email
	             },
	             url : '/web/jnspUserCheck.do',
	             dataType : 'json',
	             success : function(data){
	            	 if(data.check=="0"){
	            		 $("#emailCheck").val("1");
	            		 //alert("사용하실수 있는 이메일입니다.");
	            	 }else{
	            		 $("#emailCheck").val("0");
	            		 //alert("사용하실수 없는 이메일입니다.");
	            	 }
	             }
	    	});

	}

////////////


function submitGo(){

	var userId = $("#userId").val();
	var err = 0;
	if($("#psnNm").val()==null||$("#psnNm").val()==""){
		alert("이름 : 필수입력값입니다.");
		$("#psnNm").focus();
		return false;
	}else{
	<%if(util.getStr(paramMap.get("grobalTp")).equals("1")){%>
		if(korPattern.test($("#psnNm").val())){
			alert("이름 : 한글만 입력해주세요.");
			$("#psnNm").focus();
			return false;
			}
	<%}else{%>
		if(engPattern.test($("#psnNm").val())){
			alert("이름 : 영문만 입력해주세요.");
			$("#psnNm").focus();
			return false;
			}
	<%}%>
	}
	if(!$("input[name='genderTypeCd']").is(":checked")){
		alert("성별구분 : 필수입력값입니다.");
		$("#genderTypeCdMale").focus();
		return false;
	}
	if(!$("input[name='frgnYn']").is(":checked")){
		alert("외국인여부 : 필수입력값입니다.");
		$("#frgnYnY").focus();
		return false;
	}
	if($("#userId").val()==null||$("#userId").val()==""){
		alert("아이디 : 필수입력값입니다.");
		$("#userId").focus();
		return false;
	}else if($("#idCheck").val()==null||$("#idCheck").val()==""){
		alert("아이디 : 중복확인이 필요합니다.");
		//userCheck();
		$("#userId").focus();
		return false;
	}else if($("#idCheck").val()=="0"){
		alert("아이디 : 사용하실수 없는 ID입니다.");
		//userCheck();
		$("#userId").focus();
		return false;
	}

	if($("#password").val()==null||$("#password").val()==""){
		alert("비밀번호 : 필수입력값입니다.");
		$("#password").focus();
		return false;
	}else if( !chkPwd( $("#password").val() ) ){
		//alert("비밀번호 : 8자이상 20자이하까지만 입력이 가능합니다.");
		$("#password").focus();
		return false;
	}

	if($("#confirmPassword").val()==null||$("#confirmPassword").val()==""){
		alert("비밀번호확인 : 필수입력값입니다.");
		$("#confirmPassword").focus();
		return false;
	}else if($("#confirmPassword").val().length<8 || $("#confirmPassword").val().length>20){
		alert("비밀번호 : 8자이상 20자이하까지만 입력이 가능합니다.");
		$("#confirmPassword").focus();
		return false;
	}

	if($("#password").val()!=$("#confirmPassword").val()){
		alert("비밀번호 : 일치하지않습니다.");
		$("#confirmPassword").focus();
		return false;
	}

	if($("#telNo1 > option:selected").val()==null || $("#telNo1 > option:selected").val()==""){
		alert("전화번호 : 필수입력값입니다.");
		$("#telNo1").focus();
		return false;
	}

	if($("#telNo2").val()==null||$("#telNo2").val()==""){
		alert("전화번호 : 필수입력값입니다.");
		$("#telNo2").focus();
		return false;
	}else if(isNaN($("#telNo2").val())){
		alert("전화번호 : 숫자만 입력해주세요.");
		$("#telNo2").focus();
		return false;
	}

	if($("#telNo3").val()==null||$("#telNo3").val()==""){
		alert("전화번호 : 필수입력값입니다.");
		$("#telNo3").focus();
		return false;
	}else if(isNaN($("#telNo3").val())){
		alert("전화번호 : 숫자만 입력해주세요.");
		$("#telNo3").focus();
		return false;
	}

	var telNo = $("#telNo1").val()+"-"+$("#telNo2").val()+"-"+$("#telNo3").val();
	$("#telNo").val(telNo);

	if($("#cpNo1 > option:selected").val()==null || $("#cpNo1 > option:selected").val()==""){
		alert("핸드폰번호 : 필수입력값입니다.");
		$("#cpNo1").focus();
		return false;
	}else if(isNaN($("#cpNo1").val())){
		alert("핸드폰번호 : 숫자만 입력해주세요.");
		$("#cpNo1").focus();
		return false;
	}
	if($("#cpNo2").val()==null||$("#cpNo2").val()==""){
		alert("핸드폰번호: 필수입력값입니다.");
		$("#cpNo2").focus();
		return false;
	}else if(isNaN($("#cpNo2").val())){
		alert("핸드폰번호 : 숫자만 입력해주세요.");
		$("#cpNo2").focus();
		return false;
	}

	if($("#cpNo3").val()==null||$("#cpNo3").val()==""){
		alert("핸드폰번호: 필수입력값입니다.");
		$("#cpNo3").focus();
		return false;
	}else if(isNaN($("#cpNo3").val())){
		alert("핸드폰번호 : 숫자만 입력해주세요.");
		$("#cpNo3").focus();
		return false;
	}
	$("#cpNo").val(cpNo);

	if($("#emailId").val()==null||$("#emailId").val()==""){
		alert("이메일 : 필수입력값입니다.");
		$("#emailId").focus();
		return false;
	}

	if($("#emailDomain").val()==null||$("#emailDomain").val()==""){
		alert("이메일 : 필수입력값입니다.");
		$("#emailDomain").focus();
		return false;
	}else if($("#emailCheck").val()==null||$("#emailCheck").val()==""){
		alert("이메일 : 중복확인이 필요합니다.");
		//emailCheck();
		$("#emailId").focus();
		return false;
	}else if($("#emailCheck").val()=="0"){
		alert("이메일 : 사용하실수 없는 이메일입니다.");
		//emailCheck();
		$("#emailId").focus();
		return false;fileCheck
	}

	var email = $("#emailId").val()+"@"+$("#emailDomain").val();
	$("#email").val(email);
	var telNo = $("#telNo1").val()+"-"+$("#telNo2").val()+"-"+$("#telNo3").val();
	$("#telNo").val(telNo);
	var cpNo = $("#cpNo1").val()+"-"+$("#cpNo2").val()+"-"+$("#cpNo3").val();
	$("#cpNo").val(cpNo);


	<% if( !util.getStr(paramMap.get("userTp")).equals("1") ){ %>
	if($("#orgGrpCd").val()==null||$("#orgGrpCd").val()==""){
		alert("소속기관 : 필수입력값입니다.");
		$("#blngOrgNm").focus();
		return false;
	}
	<% } %>

	$("#mode").val("auth");
	 $('#authForm').submit();
}
//]]>
</script>

<form name="authForm" id="authForm" method="post" action="/web/jnspUserProc.do" enctype="multipart/form-data" >
	<input type="hidden" name="mode" id="mode" value="auth" />
	<input type="hidden" name="idCheck" id="idCheck"/>
	<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="" onchange="orgInfo()"/>
	<input type="hidden" name="page" id="page" value="<%=page %>" />
	<input type="hidden" name="userTp" id="userTp" value="<%=util.getStr(paramMap.get("userTp")) %>" />

	<div class="join_order">
    	<h2 class="join_step">STEP 02. 회원정보입력</h2>
    </div>

    <div class="hide">회원정보입력</div>

			<table class="skin_basic_write" summary="회원정보입력 테이블로 이름, 성별구분, 외국인여부, 사용자 ID, 비밀번호, 비밀번호 확인, 전화번호, 핸드폰번호, 이메일 등으로 구성되어있습니다.">
	   			<caption>회원정보입력</caption>
                <colgroup>
                	<col width="15%">
					<col width="35%">
					<col width="20%">
					<col width="30%">
               	</colgroup>
				<tbody>
					<tr>
						<th class="r_line"><label for="psnNm"> * <%=util.getStr(paramMap.get("grobalTp")).equals("1") ? "이 름": "영문 이름"%></label></th>
						<td class="td" colspan="3">
							<input type="text" name="psnNm" maxlength="24" value="<%=util.getStr(certiMap.get("psnNm")) %>" id="psnNm" class="txtbox">
						</td>
					</tr>
					<tr>
						<th class="r_line"> * 성별구분</th>
						<td class="r_line">
							<input type="radio" name="genderTypeCd" value="M" title="남자" <%=util.getStr(certiMap.get("genderTypeCd")).equals("M")? "checked='checked'" :"" %> id="genderTypeCdMale" style="width:20px;"><label for="genderTypeCdMale">남자</label>
							<input type="radio" name="genderTypeCd" value="F" title="여자" <%=util.getStr(certiMap.get("genderTypeCd")).equals("F")? "checked='checked'" :"" %> id="genderTypeCdFemale" style="width:20px;"><label for="genderTypeCdFemale">여자</label>

						</td>
						
					</tr>
					<tr>
						<th class="r_line" align="center" valign="middle"> * 외국인여부</th>
						<td class="td">
							<input type="radio" name="frgnYn" value="N" id="frgnYnY" style="width:20px;" title="내국인" <%=util.getStr(paramMap.get("grobalTp")).equals("1")||util.getStr(certiMap.get("globalTp")).equals("1") ? "checked='checked' ": "disabled='disabled'"%>><label for="frgnYnY">내국인</label>
							<input type="radio" name="frgnYn" value="Y" id="frgnYnN" style="margin-left: 20px;  display: inline-block; width:20px" title="외국인" <%=util.getStr(paramMap.get("grobalTp")).equals("2")||util.getStr(certiMap.get("globalTp")).equals("2") ? "checked='checked' ": "disabled='disabled'"%>><label for="frgnYnN">외국인</label>
						</td>
					</tr>
					<tr>
						<th class="r_line"><label for="userId"> * 사용자 ID</label></th>
						<td class="td" colspan="3">
							<input type="hidden" name="userId" maxlength="20" value="" id="userId" class="txtbox" readonly="readonly" >
							<input type="text" name="emailId" maxlength="20" value="" id="emailId" class="inp_txt" title="이메일아이디"> @
							<input type="text" name="emailDomain" maxlength="50" value="" id="emailDomain" class="inp_txt" title="이메일도메인">
							<select name="emailDomainChoise" id="emailDomainChoise" class="select_box" title="이메일주소도메인선택">
									<option value="" selected="selected">직접입력</option>
									<option value="empal.com">empal.com</option>
									<option value="naver.com">naver.com</option>
									<option value="hanmail.net">hanmail.net</option>
									<option value="hotmail.com">hotmail.com</option>
									<option value="yahoo.co.kr">yahoo.co.kr</option>
									<option value="nate.com">nate.com</option>
									<option value="korea.kr">korea.kr</option>
									<option value="jntp.or.kr">jntp.or.kr</option>
							</select>
							<input type="button" id="btnCheckUserId" class="btn_inp_b_01" value="중복확인" onclick="userCheck()" title="아이디 중복 확인(새 창 열림)">
							* 영문 또는 영문숫자 조합 6~20자리
							<div id = "checkValue"></div>
						</td>
					</tr>
					<tr>
						<th class="r_line"><label for="password"> * 비밀번호</label></th>
						<td class="td" colspan="3">
							<input type="password" name="password" maxlength="20" value="" id="password" style="width:200px;" class="txtbox simplePassMeterInput" >
	<!-- 						<div id="passwordMessage" style="color:#f00; margin-top: 10px;"> *  영문자와 숫자 및 특수문자를 조합 9자리 이상</div> -->
						</td>
					</tr>
					<tr>
						<th class="r_line"><label for="confirmPassword"> * 비밀번호 확인</label></th>
						<td class="td" colspan="3">
							<input type="password" name="confirmPassword" maxlength="20" value="" id="confirmPassword" style="width:200px;" class="txtbox" >
							<!-- <input type="button" id="securityGrade" class="btn_gray" title="보안등급안내" value="보안등급안내">
							<div id="securityGradeDes" style="display: none;">
								○ 불가 : - 8자이하, 20자초과<br>
				        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- ID와 동일한 문자열 포함<br>
				        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 동일 문자를 3번 이상 사용 할 경우(예 :aaa, 111)<br>
				        		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- 연속된 문자를 사용 할 경우(예 :123, abc)<br>
								○ 낮음 : 영문자나 숫자, 특수문자만 사용하는 경우 등<br>
								○ 적정 신: 영문대/소문자, 특수문자, 숫자의 조합<br>
								○ 높음 : 영문대/소문자, 특수문자, 숫자를 모두 포함<br>
								* 특수문자 : !@#$%^&amp;*-_+=?&lt;&gt;:|{} 만 사용 가능
							</div> -->
						</td>
					 </tr>
					 <tr>
						<th class="r_line"><label for="telNo1"> * 전화번호</label></th>
						<td class="r_line">
							<span id="inTel">
								<input type="hidden" name="telNo" value="" id="telNo">
								<select name="telNo1" id="telNo1" style="width: 60px;" title="지역번호 선택">
									<option value="02">02</option>
									<option value="031" >031</option>
									<option value="032">032</option>
									<option value="033">033</option>
									<option value="041">041</option>
									<option value="042">042</option>
									<option value="043">043</option>
									<option value="044">044</option>
									<option value="051">051</option>
									<option value="052">052</option>
									<option value="053">053</option>
									<option value="054">054</option>
									<option value="055">055</option>
									<option value="061">061</option>
									<option value="062">062</option>
									<option value="063">063</option>
									<option value="064">064</option>
									<option value="070">070</option>
								</select> -
								<input type="text" name="telNo2" style="width:50px" maxlength="4" value="" id="telNo2" title="사무실전화 앞번호"> -
								<input type="text" name="telNo3" style="width:50px" maxlength="4" value="" id="telNo3" class="txtbox" title="사무실전화 뒷번호">
							</span>
						</td>
					</tr>
					<tr>
						<th class="r_line"><label for="cpNo1"> * 핸드폰번호</label></th>
						<td class="td">
							<span id="inCp">
								<input type="hidden" name="cpNo" value="" id="cpNo">
								<select name="cpNo1" id="cpNo1" style="width: 60px;" title="서비스 번호 선택">
									<option value="010">010</option>
									<option value="011" <%=util.getStr(certiMap.get("cpNo1")).equals("011")? "selected='selected'" : "" %>>011</option>
									<option value="016" <%=util.getStr(certiMap.get("cpNo1")).equals("016")? "selected='selected'" : "" %>>016</option>
									<option value="017" <%=util.getStr(certiMap.get("cpNo1")).equals("017")? "selected='selected'" : "" %>>017</option>
									<option value="018" <%=util.getStr(certiMap.get("cpNo1")).equals("018")? "selected='selected'" : "" %>>018</option>
									<option value="019" <%=util.getStr(certiMap.get("cpNo1")).equals("019")? "selected='selected'" : "" %>>019</option></select> -
								<input type="text" name="cpNo2" style="width:50px" maxlength="4" value="<%=util.getStr(certiMap.get("cpNo2"))%>" id="cpNo2" class="txtbox" title="휴대폰 중간번호"> -
								<input type="text" name="cpNo3" style="width:50px" maxlength="4" value="<%=util.getStr(certiMap.get("cpNo3"))%>" id="cpNo3" class="txtbox" title="휴대폰 뒷번호">
							</span>
						</td>
					</tr>
					<tr>
						<th class="r_line"><label for="emailId"> * 이메일</label></th>
						<td class="td" colspan="3">
							<input type="text" name="email" value="" id="email" class="inp_txt" readonly="readonly">
							<input type="hidden" id="emailCheck" name="emailCheck" value=""/>
							<!-- <input type="button" id="btnCheckEmail" class="btn_inp_b_01" value="중복확인" onclick="userEmailCheck()" title="이메일 중복 확인(새 창 열림)"> -->
						</td>
					</tr>
					 <tr id="orgTpTr">
						<th class="r_line"> * 소속기관</th>
						<td class="td" colspan="3">
							<span id="orgList" style="padding-left: 15px;">
								<input type="button" name="blngOrgNm" value="<%=util.getStr(paramMap.get("userTp")).equals("2")?"기업":"기관" %>검색" id="blngOrgNm" class="btn_inp_b_01"  onclick="popupWindow('orgList')" >
							</span><br />
							<span style="color:#F00; "> *  개인 등록자는 일부 JEINET 서비스에 대하여 사용권한이 제한될 수 있습니다.</span>
						</td>
					</tr>
					<tr id="orgInfo1">
						<th class="r_line"><label for="orgGrpNm"> * <%=util.getStr(paramMap.get("userTp")).equals("2")?"기업":"기관" %>명</label></th>
						<td class="td" colspan="3">
							<input type="text" id="orgGrpNm" name="orgGrpNm" class="inp_txt" value="" style="width:45%;" readonly = "readonly">
						</td>

					</tr>
					<tr id="orgInfo2">
						<th class="r_line" id="depNmTh"><label for="deptNm"> * 부서명</label></th>
						<td class="r_line" id="depNmTd">
							<input type="text" name="deptNm" id="deptNm" maxlength="15" />
							<input type="button" name="blngDeptNm" value="부서검색" id="blngDeptNm" class="btn_inp_b_01"  onclick="popupWindow('orgSubList')" >
	 					</td>
						<th class="r_line l_line"><label for="positionNm"> * 직위</label></th>
						<td class="td" colspan="3">
							<input type="text" name="positionNm" id="positionNm"  maxlength="10" />
						</td>
					</tr>
				</tbody>
			</table>


		<div class="btn_box" >
			<div class="btn_right_box " style="float:right; margin-right:10px;">
				<input type="button" onclick="submitGo()" value="등록" class="btn_inp_b_01" />
				<input type="button" onclick="document.location.href='/sso/login.do'" class="btn_inp_w_01" value="이전"/>
			</div>
		</div>

</form>

