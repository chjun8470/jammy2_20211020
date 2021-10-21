<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

String fileGrp = "Corporate";
String fileSubGrp = "";
String fileFullGrp =fileGrp+fileSubGrp;

%>
<script type="text/javascript">
//<![CDATA[

var idPattern = /[^a-zA-Z0-9]/;
var korPattern = /[^가-힣]/;
var engPattern = /[^a-zA-Z- ]/;
var numPattern = /[^\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");

$(document).ready(function(){
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


		$('input[name="blngOrgGubun"]').change(function(){
		    if($(this).val()=='70'){
		    	$('#blngOrgNm').show();
		    }else{
		    	$('#blngOrgNm').val("");
		    	$('#blngOrgNm').hide();
		    }
		});

		$("#birthDate").datepicker({
//			showOn : "both",
//	    	buttonImage: "button.png",

	    	showMonthAfterYear : true,
	    	showButtonPanel : true,
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
});

function orgPost(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
             $("#blngOrgZipCode").val(data.zonecode);
             $("#blngOrgAddr").val(data.address);
             $("#blngOrgAddrDtl").focus();
        }
    }).open();
}

function deptPost(){
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
             $("#deptZipCode").val(data.zonecode);
             $("#deptAddr").val(data.address);
             $("#deptAddrDtl").focus();
        }
    }).open();
}

 function userCheck(){
	var userId = $("#userId").val();
	var err = 0;

	if(userId !=null && userId != ""){
		if(userId.length < 6 || userId.length > 20){
			alert("영문숫자 조합 6~20자리를 입력해주세요.");
			return false;
		}else if(!isNaN(userId)){
			alert("영문숫자 조합 6~20자리를 입력해주세요.");
			return false;
		}

		if(idPattern.test(userId)){
			alert("영문숫자 조합 6~20자리를 입력해주세요.");
			$("#userId").focus();
			$("#idCheck").val("0");
		     return false;
		 } else {



			$.ajax({
	             type: "POST",
	             data : {
	            	 userId : userId
	             },
	             url : './jnspUserCheck.do',
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
	}else{
		alert("ID를 입력해주세요.");
		$("#userId").focus();
		return false;
	}
}


function submitGo(){

	var userId = $("#userId").val();
	var err = 0;
	if($("#psnNm").val()==null||$("#psnNm").val()==""){
		alert("이름 : 필수입력값입니다.");
		$("#psnNm").focus();
		return false;
	}else{

		if(korPattern.test($("#psnNm").val())){
			alert("이름 : 한글만 입력해주세요.");
			$("#psnNm").focus();
			return false;
			}
		}

	if($("#engPsnNm").val()==null||$("#engPsnNm").val()==""){
		alert("영문이름 : 필수입력값입니다.");
		$("#engPsnNm").focus();
		return false;
	}else{
		if(engPattern.test($("#engPsnNm").val())){
		alert("영문이름 : 영문만 입력해주세요.");
		$("#engPsnNm").focus();
		return false;
		}
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
	}else if(userId !=null && userId != ""){
		if(userId.length < 6 || userId.length > 20){
			alert("영문숫자 조합 6~20자리를 입력해주세요.");
			return false;
		}else if(!isNaN(userId)){
			alert("영문숫자 조합 6~20자리를 입력해주세요.");
			return false;
		}
		if(idPattern.test(userId)){
			alert("영문숫자 조합 6~20자리를 입력해주세요.");
			$("#userId").focus();
			$("#idCheck").val("0");
		     return false;
		 }
	}else if($("#idCheck").val()=="0"){
		alert("아이디 : 사용하실 수 없는 아이디입니다.");
		$("#userId").focus();
		return false;
	}

	if($("#password").val()==null||$("#password").val()==""){
		alert("비밀번호 : 필수입력값입니다.");
		$("#password").focus();
		return false;
	}else if($("#password").val().length<8 || $("#password").val().length>20){
		alert("비밀번호 : 8자이상 20자이하까지만 입력이 가능합니다.");
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
	/* if($("#telNo1").val()==null||$("#telNo1").val()==""){
		alert("전화번호 : 필수입력값입니다.");
		$("#telNo1").focus();
		return false;
	}else if(isNaN($("#telNo1").val())){
		alert("전화번호 : 숫자만 입력해주세요.");
		$("#telNo1").focus();
		return false;
	} */



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


	if(!$("input[name='blngOrgGubun']").is(":checked")){
		alert("소속기관 : 필수입력값입니다.");
		$("#blngOrgGubunOrg").focus();
		return false;
	}else if($("input[type=radio][name='blngOrgGubun']:checked").val()==1){
		if($("#blngOrgNm").val()==null||$("#blngOrgNm").val()==""){
			alert("소속기관 : 필수입력값입니다.");
			$("#blngOrgGubunOrg").focus();
			return false;
		}
	}

	if($("#corporateCode").val()==null||$("#corporateCode").val()==""){
		alert("법인번호 : 필수입력값입니다.");
		$("#corporateCode").focus();
		return false;
	}

	if($("#deptNm").val()==null||$("#deptNm").val()==""){
		alert("부서명 : 필수입력값입니다.");
		$("#deptNm").focus();
		return false;
	}

	if($("#position").val()==null||$("#position").val()==""){
		alert("직위 : 필수입력값입니다.");
		$("#position").focus();
		return false;
	}

	if($("#blngOrgAddr").val()==null||$("#blngOrgAddr").val()==""||$("#blngOrgAddrDtl").val()==null||$("#blngOrgAddrDtl").val()==""){
		alert("기관주소 : 필수입력값입니다.");
		$("#blngOrgAddr").focus();
		return false;
	}

	if($("#deptAddr").val()==null||$("#deptAddr").val()==""||$("#deptAddrDtl").val()==null||$("#deptAddrDtl").val()==""){
		alert("부서(센터)주소 : 필수입력값입니다.");
		$("#deptAddr").focus();
		return false;
	}

	var fileCheck = 0;
	var fileCount = $("input[type=file]").length;
		for(i = 1; i <= fileCount; i++) {
				var fileName = $('#CorporateFile'+fileCount).val();
				if(fileName != "" && fileName != null){fileCheck++;}
		}

	/* if(!$("input[name='dmabrSlctCd']").is(":checked")){
		alert("거주지 국내외 구분 : 필수입력값입니다.");
		$("#dmabrSlctCdIn").focus();
		return false;
	}

	if($("#blngOrgZipCode").val()==null||$("#blngOrgZipCode").val()==""){
		alert("우편번호 : 필수입력값입니다.");
		$("#blngOrgZipCode").focus();
		return false;
	}

	if($("#addr").val()==null||$("#addr").val()==""){
		alert("지번주소 : 필수입력값입니다.");
		$("#addr").focus();
		return false;
	}

	if($("#addrDtl").val()==null||$("#addrDtl").val()==""){
		alert("지번주소 : 필수입력값입니다.");
		$("#addrDtl").focus();
		return false;
	}
	*/



	/*
	if($("#jobDivCd > option:selected").val()==null || $("#jobDivCd > option:selected").val()==""){
		alert("직업 : 필수입력값입니다.");
		$("#jobDivCd").focus();
		return false;
	}

	if($("#userTypeCd > option:selected").val()==null || $("#userTypeCd > option:selected").val()==""){
		alert("직업 : 필수입력값입니다.");
		$("#userTypeCd").focus();
		return false;
	}
	/*
	if($("#birthDate").val()==null||$("#birthDate").val()==""){
		alert("생년월일 : 필수입력값입니다.");
		$("#birthDate").focus();
		return false;
	} */

	$("#authForm").submit();
}

//]]>
</script>


		<!-- <div id="login_footer">
			Copyright 2015. Elsys all rights reserved by CES
		</div> -->







		<!-------->
<!-- 		<div class="header"> -->
<!-- 		        <div class="img"> -->
<!-- 					<img src="/imgs/main/img_test.png" alt="지역 연구장비를 한곳에! 연구장비정보망  Jeonnam Research &Development Equipment Infomation Network"/> -->
<!--                 </div> -->
<!--         </div> -->
		<!-------->

        <!---contents----->
		<div class="contents" style="height:700px;margin:20px;border:5px solid lightgrey;">

            <!----contents_btn----->
			<div class="contents_btn">

				<div class="sign_logo" style="text-align:center">
		            	<img src="/imgs/main/bg_main_sign.png" alt="sign"/>
                	</div>

<form name="authForm" id="authForm" method="post" action="/sys/jnspUserProc.do" enctype="multipart/form-data" style="margin:10px;">
	<input type="hidden" name="mode" id="mode" value="auth" />
	<input type="hidden" name="idCheck" id="idCheck"/>

<!-- 	<div class="title_box">

		<div class="login_title_nm">
				EL' PAGE SYSTEM Sign Up
		</div>
	</div> -->
	<div id="container" style="width:800px;background-color:#FFFFFF">
	<div class="contents_box" >
<table class="tbl04">
			<colgroup>
				<col width="20%">
				<col width="30%">
				<col width="20%">
				<col width="30%">
			</colgroup>
			<tbody>
				<tr>
					<th class="th"> * 이 름</th>
					<td class="td">
<!-- 							<input type="text" name="psnNm" maxlength="24" value="황인선" readonly="readonly" id="psnNm" style="background:#eeeeee; width:200px;" class="txtbox" title="이름"> -->
					<input type="text" name="psnNm" maxlength="24" value="" id="psnNm" class="txtbox" title="이름">
					</td>
					<th> * 영문이름</th>
					<td class="td">
						<input type="text" name="engPsnNm" maxlength="24" value="" id="engPsnNm" class="txtbox" title="영문이름">
					</td>
				</tr>
				<tr>
					<th class="th"> * 성별구분</th>
					<td class="td">
						<input type="radio" name="genderTypeCd" value="M" checked="checked" id="genderTypeCdMale" style="width:20px;"><label for="genderTypeCdMale">남자</label>
						<input type="radio" name="genderTypeCd" value="F" id="genderTypeCdFemale" style="width:20px;"><label for="genderTypeCdFemale">여자</label>
					</td>
					<th class="th" align="center" valign="middle"> * 외국인여부</th>
					<td class="td">
						<input type="radio" name="frgnYn" value="N" checked="checked" id="frgnYnY" style="width:20px;" title="내국인"><label for="frgnYnY">내국인</label>
						<input type="radio" name="frgnYn" value="Y" id="frgnYnN" style="margin-left: 20px; display: inline-block; width:20px" title="외국인" disabled="disabled"><label for="frgnYnN">외국인</label>
					</td>
				</tr>
				<tr>
					<th class="th"> * 사용자 ID</th>
					<td class="td" colspan="3">
						<input type="text" name="userId" maxlength="20" value="" id="userId" class="txtbox" title="사용자ID" >
						<input type="button" id="btnCheckUserId" class="btn_inp_b_01" value="중복확인" onclick="userCheck()" title="아이디 중복 확인(새 창 열림)">
						* 영문 또는 영문숫자 조합 6~20자리
						<div id = "checkValue"></div>
					</td>
				</tr>
				<tr>
					<th class="th"> * 비밀번호</th>
					<td class="td" colspan="3">
						<input type="password" name="password" maxlength="20" value="" id="password" style="width:200px;" class="txtbox simplePassMeterInput" title="비밀번호" >
<!-- 						<div id="passwordMessage" style="color:#f00; margin-top: 10px;"> *  영문자와 숫자 및 특수문자를 조합 9자리 이상</div> -->
					</td>
				</tr>
				<tr>
					<th class="th"> * 비밀번호 확인</th>
					<td class="td" colspan="3">
						<input type="password" name="confirmPassword" maxlength="20" value="" id="confirmPassword" style="width:200px;" class="txtbox" title="비밀번호 확인">
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
					<th class="th"> * 전화번호</th>
					<td class="td">
						<span id="inTel">
							<select name="telNo1" id="telNo1" style="width: 60px;" title="사무실전화번호 국번"><option value="02">02</option>
								<option value="031">031</option>
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
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option></select> -
							<input type="text" name="telNo2" style="width:50px" maxlength="4" value="" id="telNo2" title="사무실전화 앞번호"> -
							<input type="text" name="telNo3" style="width:50px" maxlength="4" value="" id="telNo3" class="txtbox" title="사무실전화 뒷번호">
						</span>
						<span id="outTel" style="display: none;">
							<input type="text" name="telNo" maxlength="30" value="" id="telNo" class="txtbox" title="전화번호">
						</span>
					</td>
					<th class="th"> * 핸드폰번호</th>
					<td class="td">
						<span id="inCp">
							<select name="cpNo1" id="cpNo1" style="width: 60px;" title="휴대폰 국번"><option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option></select> -
							<input type="text" name="cpNo2" style="width:50px" maxlength="4" value="" id="cpNo2" class="txtbox" title="휴대폰 앞번호"> -
							<input type="text" name="cpNo3" style="width:50px" maxlength="4" value="" id="cpNo3" class="txtbox" title="휴대폰 뒷번호">
						</span>
						<span id="outCp" style="display: none;">
							<input type="text" name="cpNo" maxlength="30" value="" id="cpNo" class="txtbox" title="휴대폰 번호">
						</span>
					</td>
				</tr>
				<tr>
					<th class="th"> * 이메일</th>
					<td class="td" colspan="3">
						<input type="hidden" name="email" value="" id="email">
						<input type="text" name="emailId" maxlength="20" value="" id="emailId" class="txtbox" title="이메일아이디"> @
						<input type="text" name="emailDomain" maxlength="50" value="" id="emailDomain" class="txtbox" title="이메일도메인">
						<select name="emailDomainChoise" id="emailDomainChoise" title="이메일주소도메인선택" >
							<option value="" selected="selected">직접입력</option>
							<option value="empal.com">엠파스</option>
							<option value="naver.com">네이버</option>
							<option value="hanmail.net">다음</option>
							<option value="hotmail.com">핫메일</option>
							<option value="yahoo.co.kr">야후</option>
							<option value="nate.com">네이트</option>
						</select>
<!-- 						<span style="color:#f00; "><br> *  가입 완료 후 인증 메일이 발송 됩니다. <br/></span> -->
					</td>
				</tr>
				<!-- <tr>
					<th class="th">메일수신여부</th>
					<td class="td" colspan="3"><input type="checkbox" name="emailRecvYn" value="Y" checked="checked" id="emailRecvYn" style="margin-right: 10px;"><span style="color:#f00; "><label for="emailRecvYn">JEINET에서 제공하는 메일을 수신합니다.</label></span><br><span style="color:#f00; "> *  JEINET에서는 국가R&amp;D 정보 메일을 제공하고 있습니다.</span></td>
				</tr> -->
				 <tr>
					<th class="th"> * 소속기관</th>
					<td class="td" colspan="3">
						<input type="radio" name="blngOrgGubun" value="10" checked="checked"  id="blngOrgGubunPerson" style="margin-left: 20px; display: inline-block; width:20px;" title="일반"><label for="blngOrgGubunPerson">개인</label>
<!-- 						<input type="radio" name="blngOrgGubun" value="60" id="blngOrgGubunPro" style="width:20px;" title="전문가"><label for="blngOrgGubunOrg">전문가</label> -->
						<input type="radio" name="blngOrgGubun" value="60"id="blngOrgGubunCompany" style="width:20px;" title="기업"><label for="blngOrgGubunOrg">기업</label>
						<input type="radio" name="blngOrgGubun" value="70"id="blngOrgGubunOrg" style="width:20px;" title="기관"><label for="blngOrgGubunOrg">기관</label>
						<span id="orgList" style="padding-left: 15px;">
<!-- 							<input type="hidden" name="blngOrgCd" value="" id="blngOrgCd"> -->
							<input type="text" name="blngOrgNm" value="" id="blngOrgNm" style="width: 380px;display:none" class="txtbox" title="소속기관명" maxlength="30" >
<!-- 							<input type="button" id="btnOrgSearch" class="btn_johoe" value="찾아보기" title="소속기관 찾기(새 창 열림)"> -->
						</span><br>
						<span style="color:#F00; "> *  개인 등록자는 일부 JEINET 서비스에 대하여 사용권한이 제한될 수 있습니다.</span>
					</td>
				</tr>
				<tr>
					<th class="th"> * 전문가여부</th>
					<td class="td" colspan="3">
						<input type="radio" name="proYn" value="Y" checked="checked"  id="proY" style="margin-left: 20px; display: inline-block; width:20px;" title="전문가"><label for="proYn">전문가</label>
						<input type="radio" name="proYn" value="N" id="proN" style="margin-left: 20px; display: inline-block; width:20px;" title="비전문가"><label for="proYn">비전문가</label>
					</td>
				</tr>
				 <tr>
					<th class="th"> * 법인번호</th>
					<td class="td" colspan="3">
							<input type="text" name="corporateCode" value="" id="corporateCode" style="width: 380px;" class="txtbox" title="법인번호" maxlength="30" />
					</td>
				</tr>
				<tr>
					<th class="th"> * 부서명</th>
					<td class="td">
 						<input type="text" name="deptNm" maxlength="30" value="" id="deptNm" class="txtbox" title="부서명">
					</td>
					<th class="th"> * 직위</th>
					<td class="td">
						<input type="text" name="position" id="position"  title="직위" maxlength="10"/>
					</td>
				</tr>
				<tr>
					<th class="th"> * 기관주소</th>
					<td class="td" colspan="3">
						<input type="text" name="blngOrgZipCode" maxlength="10" value="" id="blngOrgZipCode"  class="txtbox" title="기관주소" style="width:100px" readonly = "readonly">
						<input type="text" name="blngOrgAddr" maxlength="100" value="" id="blngOrgAddr"  class="txtbox" title="기관주소" style="width:300px" readonly="readonly">
						<input type="button" id = "deptPostButton" value="찾아보기" class="btn_inp_b_01" onclick = "orgPost()" />

						<input type="text" name="blngOrgAddrDtl" maxlength="100" value="" id="blngOrgAddrDtl"  class="txtbox" title="기관주소" style="width:400px" >
					</td>
				</tr>


				<tr>
					<th class="th"> * 부서(센터)주소</th>
					<td class="td" colspan="3">

						<input type="text" name="deptZipCode" maxlength="100" value="" id="deptZipCode"  class="txtbox" title="부서(센터)주소"  style="width:100px" readonly = "readonly">
						<input type="text" name="deptAddr" maxlength="100" value="" id="deptAddr"  class="txtbox" title="부서(센터)주소"  style="width:300px" readonly="readonly">
						<input type="button" onclick = "deptPost()" id = "deptPostButton" value="찾아보기" class="btn_inp_b_01"/>

						<input type="text" name="deptAddrDtl" maxlength="100" value="" id="deptAddrDtl"  class="txtbox" title="기관주소" style="width:400px" >

					</td>
				</tr>
				<tr>
                			<th scope="row" class="bln"><label for="fileList" id="fileImage"> * 법인등록증</label></th>
                			<td>
	              	<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div >
	              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
						</div>
	              	</div>

	              	<div style="display:inline-block;vertical-align:bottom;">
	              		<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
						<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
	              	</div>

	        <script type="text/javascript">
					var arrfileCnt = new Array();
					arrfileCnt['<%=fileFullGrp%>'] = 2;
		            function addRowFile(fileGrpnm){
	            		var fileHtml = "<div>";
	            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
	            		fileHtml += "</div>";

            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
            			arrfileCnt[fileGrpnm]++;
	            	}

		            function delRowFile(fileGrpnm){
		            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
		            		return;
		            	}
		            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
		            	arrfileCnt[fileGrpnm]--;
		            }
	        </script>

	              	</td>
                		</tr>
				<!-- <tr>
					<th class="th"> * 거주지 국내외 구분</th>
					<td class="td" colspan="3">
						<input type="radio" name="dmabrSlctCd" value="1" checked="checked" id="dmabrSlctCdIn" style="width:20px;" title="국내"><label for="dmabrSlctCdIn">국내</label>
						<input type="radio" name="dmabrSlctCd" value="2" id="dmabrSlctCdOut" style="margin-left: 20px; display: inline-block; width:20px;" title="국외"><label for="dmabrSlctCdOut">국외</label>
					</td>
				</tr>
				<tr>
					<th class="th"> * 우편번호</th>
					<td class="td" colspan="3">
						<input type="text" name="blngOrgZipCode" maxlength="7" value="" readonly="readonly" id="blngOrgZipCode" class="txtbox" title="소속기관우편번호" readonly="readonly" onclick="callPost()">
						<input type="button" id="btnblngOrgZipCodeSearch" class="btn_gray" value="우편번호" title="우편번호 검색(새 창 열림)" onclick="callPost()">
					</td>
				</tr>
				 -->
				<!--  <tr>
					<th class="th">팩스</th>
					<td class="td">
						<span id="inFax">
							<select name="faxNo1" id="faxNo1" style="width: 60px;" title="팩스 국번"><option value="02">02</option>
								<option value="031">031</option>
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
								<option value="070">070</option></select> -
							<input type="text" name="faxNo2" maxlength="4" value="" id="faxNo2"  class="txtbox" title="팩스 앞번호"> -
							<input type="text" name="faxNo3" maxlength="4" value="" id="faxNo3"  class="txtbox" title="팩스 뒷번호">
						</span>
						국외
						<span id="outFax" style="display: none;">
							<input type="text" name="faxNo" maxlength="30" value="" id="faxNo" class="txtbox" title="팩스번호">
						</span>
					</td>
				</tr> -->

				<!-- <tr>
					<th class="th">직책명</th>
					<td class="td">
						<input type="text" name="positionNm" maxlength="30" value="" id="positionNm" class="txtbox" title="직책명">
					</td>
					<th class="th">담당업무</tH>
					<td class="td">
						<input type="text" name="institJobNm" maxlength="120" value="" id="institJobNm" class="txtbox" title="담당업무">
					</td>
				</tr>
				<tr>
					<th class="th"> * 직업</th>
					<td class="td">
						<select name="jobDivCd" id="jobDivCd" title="직업"><option value="">전체</option>
							<option value="01">공무원</option>
							<option value="02">연구원</option>
							<option value="03">교수</option>
							<option value="04">학생</option>
							<option value="05">사무직</option>
							<option value="06">제조업</option>
							<option value="07">IT관련종사자</option>
							<option value="08">금융업</option>
							<option value="09">언론사</option>
							<option value="10">전문직</option>
							<option value="11">기타</option>
						</select>
					</td>
					<th class="th"> * 사용자유형</th>
					<td class="td">
						<select name="userTypeCd" id="userTypeCd" title="사용자 유형"><option value="">전체</option>
							<option value="01">연구자(대학,출연(연),연구소 등)</option>
							<option value="07">연구자(기업)</option>
							<option value="02">과제관리기관</option>
							<option value="03">부처</option>
							<option value="06">일반이용자</option>
						</select>
					</td>
				</tr>
				 <tr>
					<th class="th">추천인ID</th>
					<td class="td"><input type="text" name="recommenderId" value="" id="recommenderId" class="txtbox" title="추천인ID"></td>
					<th class="th"> * 생년월일</th>
					<td class="td">
							<input type="text" name="birthDate" value="" id="birthDate">
					</td>
				</tr> -->
			</tbody>
		</table>
	</div>
	<div class="btn_box" >
			<div class="btn_right_box" >
				<input type="button" onclick="window.close();" class="btn_inp_w_01" value="취소"/>
				<input type="button" onclick="submitGo()" value="등록" class="btn_inp_b_01" />
			</div>
		</div>

</div>

</form>



            </div>
            <!----contents_btn----->

        </div>
		<!----contents---->