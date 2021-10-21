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
    	<h2 class="join_step">STEP 03. 가입완료</h2>
    </div>

    <div class="hide">가입완료</div>

	<div class="hello_jeinet">
		<img src="/img/mobile/login/hello.png" class="hello_img">
		<h1>환영합니다!</h1>
		<p>{이름}님, 회원가입을 축하합니다.</p>
		<p>JEINET의 새로운 아이디는 {ID}입니다.</p>
		<br>
		<p>이제 JEINET의 모든 기능을 이용하실 수 있습니다.</p>
	</div>

</form>

