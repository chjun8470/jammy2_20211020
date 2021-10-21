<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	//response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

    HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	String userIdx = util.getStr(paramMap.get("userIdx"));
	System.out.println("edit.jsp userIdx::"+userIdx);
%>




<script type="text/javascript">
//<![CDATA[
var idPattern = /[^a-zA-Z0-9]/;
var korPattern = /[^가-힣]/;
var engPattern = /[^a-zA-Z]/;
var numPattern = /[^\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");

$(document).ready(function(){

		if($('#blngOrgGubunOrg:checked').val() == 1){
			$('#blngOrgNm').show();
		};
		if($('#blngOrgGubunPerson:checked').val() == 2){
			$('#blngOrgNm').hide();
		};

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

		/* 소속기관 */
		$('input[name="blngOrgGubun"]').change(function(){
		    if($(this).val()=='2'){
		    	$('#blngOrgNm').val("");
		    	$('#blngOrgNm').hide();
		    }else{
		    	$('#blngOrgNm').show();
		    }
		});

		/* datepicker */
		$("#birthDate").datepicker({

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

		/* 비밀번호 확인 */
		$('#password').change(function(){
			$('#pwd_signed').html('');
		});
		$('#confirmPassword').change(function(){
			if($('#password').val() == $('#confirmPassword').val()){
				$('#pwd_signed').html('비밀 번호가 일치합니다.').css('color','black');
			}else if($('#password').val() != $('#confirmPassword').val()){
				$('#pwd_signed').html('비밀 번호가 일치하지 않습니다.').css('color','red');
			}else{
				$('#pwd_signed').html('');
			}
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

	if($("#passredata:checked").val() == 'Y'){

		if($('#password').val() == ""){
			alert("비밀 번호를 입력 해주세요");
			return false;
		}else{
			if($('#password').val() != $('#confirmPassword').val()){
				alert("비밀 번호가 일치하지 않습니다.");
				return false;
			}
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
	}

	/* if($("#password").val()!=$("#confirmPassword").val()){
		alert("비밀번호 : 일치하지않습니다.");
		$("#confirmPassword").focus();
		return false;
	}*/

	if($("#telNo1 > option:selected").val()==null || $("#telNo1 > option:selected").val()==""){
		alert("전화번호 : 필수입력값입니다.");
		$("#telNo1").focus();
		return false;
	}

	if($("#telNo2").val()==null||$("#telNo2").val()==""){
		alert("전화번호 : 필수입력값입니다.");
		$("#telNo2").focus();
		return false;
	}else if(!isNaN($("#telNo2").val())){
		alert("전화번호 : 숫자만 입력해주세요.");
		$("#telNo2").focus();
		return false;
	}

	if($("#telNo3").val()==null||$("#telNo3").val()==""){
		alert("전화번호 : 필수입력값입니다.");
		$("#telNo3").focus();
		return false;
	}else if(!isNaN($("#telNo3").val())){
		alert("전화번호 : 숫자만 입력해주세요.");
		$("#telNo3").focus();
		return false;
	}

	if($("#cpNo1 > option:selected").val()==null || $("#cpNo1 > option:selected").val()==""){
		alert("핸드폰번호 : 필수입력값입니다.");
		$("#cpNo1").focus();
		return false;
	}else if(!isNaN($("#cpNo1").val())){
		alert("핸드폰번호 : 숫자만 입력해주세요.");
		$("#cpNo1").focus();
		return false;
	}

	if($("#cpNo2").val()==null||$("#cpNo2").val()==""){
		alert("핸드폰번호: 필수입력값입니다.");
		$("#cpNo2").focus();
		return false;
	}else if(!isNaN($("#cpNo2").val())){
		alert("핸드폰번호 : 숫자만 입력해주세요.");
		$("#cpNo2").focus();
		return false;
	}

	if($("#cpNo3").val()==null||$("#cpNo3").val()==""){
		alert("핸드폰번호: 필수입력값입니다.");
		$("#cpNo3").focus();
		return false;
	}else if(!isNaN($("#cpNo3").val())){
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

	$("#authForm").submit();
}
//]]>
</script>

<form name="authForm" id="authForm" action="/web/jnspUserEditProc.do" method="post" >
	<input type="hidden" name="mode" id="mode" value="edit" />
	<input type="hidden" name="idCheck" id="idCheck" />
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />

	<div id="container" style="width:800px; background-color:#FFFFFF;" >
		<!--div class="contents_box"-->
		<div style="margin-right:10px;padding-left:5px;">

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
							<input type="text" name="psnNm" maxlength="24" value="<%=util.getStr(dataMap.get("PSN_NM"))%>" id="psnNm" style="width:180px;" class="txtbox" title="이름">
						</td>
						<th class="th"> * 영문이름</th>
						<td class="td">
							<input type="text" name="engPsnNm" maxlength="24" value="<%=util.getStr(dataMap.get("ENG_PSN_NM"))%>" id="engPsnNm" style="width:180px;" class="txtbox" title="영문이름">
						</td>
					</tr>
					<tr>
						<th class="th"> * 성별구분</th>
						<td class="td">
							<input type="radio" name="genderTypeCd" value="M" <%if("M".equals(util.getStr(dataMap.get("GENDER_TYPE_CD")))) {%>checked="checked"<%} %> id="genderTypeCdMale" style="width:20px;">
							<label for="genderTypeCdMale">남자</label>
							<input type="radio" name="genderTypeCd" value="F" <%if("F".equals(util.getStr(dataMap.get("GENDER_TYPE_CD")))) {%>checked="checked"<%} %> id="genderTypeCdFemale" style="width:20px;">
							<label for="genderTypeCdFemale">여자</label>
						</td>
						<th class="th" align="center" valign="middle"> * 외국인여부</th>
						<td class="td">
							<input type="radio" name="frgnYn" value="N" <%if("N".equals(util.getStr(dataMap.get("FRGN_YN")))) {%>checked="checked"<%} %> id="frgnYnY" style="width:20px;" title="내국인">
							<label for="frgnYnY">내국인</label>
							<input type="radio" name="frgnYn" value="Y" <%if("Y".equals(util.getStr(dataMap.get("FRGN_YN")))) {%>checked="checked"<%} %> id="frgnYnN" style="margin-left: 20px; display: inline-block; width:20px" title="외국인" disabled="disabled">
							<label for="frgnYnN">외국인</label>
						</td>
					</tr>
					<tr>
						<th class="th"> * 사용자 ID</th>
						<td class="td" colspan="3"><%=util.getStr(dataMap.get("USER_ID"))%></td>
					</tr>
					<tr>
						<th class="th"> 비밀번호수정</th>
						<td class="td" colspan="3">
							<input type="checkbox" id="passredata" onclick="if($('#passredata:checked').val() == 'Y') {$('#pwdchange').show(); $('#password').val(''); $('#confirmPassword').val(''); }else {$('#pwdchange').hide(); $('#password').val(''); $('#confirmPassword').val('');}" name="passredata" value="Y" />&nbsp;
							<label for="passredata">비밀번호 변경</label>

							<!--비밀번호 수정 input S-->
							<div id="pwdchange" style="display:none;">
								<table class="tbl08">
									<colgroup>
										<col width="20%">
										<col width="80%">
									</colgroup>
									<tr>
									  <td>비밀번호&nbsp;:</td>
									  <td>
									 	<input type="password" name="password" maxlength="20" value="" id="password" style="width:150px;" class="txtbox" title="비밀번호" >
									  </td>
									</tr>
									<tr>
									  <td>비밀번호확인&nbsp;:</td>
									  <td>
										<input type="password" name="confirmPassword" maxlength="20" value="" id="confirmPassword" style="width:150px;" class="txtbox" title="비밀번호 확인">
										<span id="pwd_signed"></span>
									  </td>
									</tr>
								</table>
							</div>
							<!--비밀번호 수정 input E-->

						</td>
					 </tr>
					 <tr>
						<th class="th"> * 전화번호</th>
						<td class="td">
							<span id="inTel">
								<select name="telNo1" id="telNo1" style="width: 50px;" title="사무실전화번호 국번">
									<option value="02" <%if("02".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>02</option>
									<option value="031"<%if("031".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>031</option>
									<option value="032"<%if("032".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>032</option>
									<option value="033"<%if("033".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>033</option>
									<option value="041"<%if("041".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>041</option>
									<option value="042"<%if("042".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>042</option>
									<option value="043"<%if("043".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>043</option>
									<option value="044"<%if("044".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>044</option>
									<option value="051"<%if("051".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>051</option>
									<option value="052"<%if("052".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>052</option>
									<option value="053"<%if("053".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>053</option>
									<option value="054"<%if("054".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>054</option>
									<option value="055"<%if("055".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>055</option>
									<option value="061"<%if("061".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>061</option>
									<option value="062"<%if("062".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>062</option>
									<option value="063"<%if("063".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>063</option>
									<option value="064"<%if("064".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>064</option>
									<option value="070"<%if("070".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>070</option>
									<option value="010"<%if("010".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>010</option>
									<option value="011"<%if("011".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>011</option>
									<option value="016"<%if("016".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>016</option>
									<option value="017"<%if("017".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>017</option>
									<option value="018"<%if("018".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>018</option>
									<option value="019"<%if("019".equals(util.getStr(dataMap.get("TEL_NO1")))) {%>selected="selected"<%} %>>019</option>
								</select>
								&nbsp;-&nbsp;
								<input type="text" name="telNo2" style="width:50px" maxlength="4" value="<%=util.getStr(dataMap.get("TEL_NO2"))%>" id="telNo2" class="txtbox" title="사무실전화 앞번호">
								&nbsp;-&nbsp;
								<input type="text" name="telNo3" style="width:50px" maxlength="4" value="<%=util.getStr(dataMap.get("TEL_NO3"))%>" id="telNo3" class="txtbox" title="사무실전화 뒷번호">
							</span>
							<span id="outTel" style="display: none;">
								<input type="text" name="telNo" maxlength="30" value="<%=util.getStr(dataMap.get("TEL_NO"))%>" id="telNo" class="txtbox" title="전화번호">
							</span>
						</td>
						<th class="th"> * 핸드폰번호</th>
						<td class="td">
							<span id="inCp">
								<select name="cpNo1" id="cpNo1" style="width: 50px;" title="휴대폰 국번">
									<option value="010" <%if("010".equals(util.getStr(dataMap.get("CP_NO1")))) {%>selected="selected"<%} %>>010</option>
									<option value="011" <%if("011".equals(util.getStr(dataMap.get("CP_NO1")))) {%>selected="selected"<%} %>>011</option>
									<option value="016" <%if("016".equals(util.getStr(dataMap.get("CP_NO1")))) {%>selected="selected"<%} %>>016</option>
									<option value="017" <%if("017".equals(util.getStr(dataMap.get("CP_NO1")))) {%>selected="selected"<%} %>>017</option>
									<option value="018" <%if("018".equals(util.getStr(dataMap.get("CP_NO1")))) {%>selected="selected"<%} %>>018</option>
									<option value="019" <%if("019".equals(util.getStr(dataMap.get("CP_NO1")))) {%>selected="selected"<%} %>>019</option>
								</select>
								&nbsp;-&nbsp;
								<input type="text" name="cpNo2" style="width:50px" maxlength="4" value="<%=util.getStr(dataMap.get("CP_NO2"))%>" id="cpNo2" class="txtbox" title="휴대폰 앞번호">
								&nbsp;-&nbsp;
								<input type="text" name="cpNo3" style="width:50px" maxlength="4" value="<%=util.getStr(dataMap.get("CP_NO3"))%>" id="cpNo3" class="txtbox" title="휴대폰 뒷번호">
							</span>
						</td>
					</tr>
					<tr>
						<th class="th"> * 이메일</th>
						<td class="td" colspan="3">
							<input type="text" name="emailId" maxlength="20" value="<%=util.getStr(dataMap.get("EMAIL_ID"))%>" id="emailId" class="txtbox" title="이메일아이디">
							&nbsp;@&nbsp;
							<input type="text" name="emailDomain" maxlength="50" value="<%=util.getStr(dataMap.get("EMAIL_DOMAIN"))%>" id="emailDomain" class="txtbox" title="이메일도메인">
							<select name="emailDomainChoise" id="emailDomainChoise" title="이메일주소도메인선택" >
								<option value="" <%if("".equals(util.getStr(dataMap.get("EMAIL_DOMAIN")))) {%>selected="selected"<%} %>>직접입력</option>
								<option value="empal.com" <%if("empal.com".equals(util.getStr(dataMap.get("EMAIL_DOMAIN")))) {%>selected="selected"<%} %>>엠파스</option>
								<option value="naver.com" <%if("naver.com".equals(util.getStr(dataMap.get("EMAIL_DOMAIN")))) {%>selected="selected"<%} %>>네이버</option>
								<option value="hanmail.net" <%if("hanmail.net".equals(util.getStr(dataMap.get("EMAIL_DOMAIN")))) {%>selected="selected"<%} %>>다음</option>
								<option value="hotmail.com" <%if("hotmail.com".equals(util.getStr(dataMap.get("EMAIL_DOMAIN")))) {%>selected="selected"<%} %>>핫메일</option>
								<option value="yahoo.co.kr" <%if("yahoo.co.kr".equals(util.getStr(dataMap.get("EMAIL_DOMAIN")))) {%>selected="selected"<%} %>>야후</option>
								<option value="nate.com" <%if("nate.com".equals(util.getStr(dataMap.get("EMAIL_DOMAIN")))) {%>selected="selected"<%} %>>네이트</option>
							</select>
						</td>
					</tr>

					<tr>
						<th class="th"> * 소속기관</th>
						<td class="td" colspan="3">
							<input type="radio" name="blngOrgGubun" value="1" <%if("1".equals(util.getStr(dataMap.get("BLNG_ORG_GUBUN")))) {%>checked="checked"<%} %> id="blngOrgGubunOrg" style="width:20px;" title="기관" /><label for="blngOrgGubunOrg">기관</label>
							<input type="radio" name="blngOrgGubun" value="2" <%if("2".equals(util.getStr(dataMap.get("BLNG_ORG_GUBUN")))) {%>checked="checked"<%} %> id="blngOrgGubunPerson" style="width:20px; display: inline-block;" title="개인" /><label for="blngOrgGubunPerson">개인</label>
							<span id="orgList" style="padding-left: 15px;">
								<input type="text" name="blngOrgNm" value="<%=util.getStr(dataMap.get("BLNG_ORG_NM"))%>" id="blngOrgNm" style="width: 320px;" class="txtbox" title="소속기관명" maxlength="30" />
							</span><br />
							<span style="color:#F00; ">&nbsp;*&nbsp;개인 등록자는 일부 JEINET 서비스에 대하여 사용권한이 제한될 수 있습니다.</span>
						</td>
					</tr>
					<tr>
						<th class="th"> * 부서명</th>
						<td class="td">
	 						<input type="text" name="deptNm" value="<%=util.getStr(dataMap.get("DEPT_NM"))%>" id="deptNm" style="width:180px;" class="txtbox" title="부서명" maxlength="30" />
						</td>
						<th class="th"> * 직위</th>
						<td class="td">
							<input type="text" name="position" value="<%=util.getStr(dataMap.get("POSITION"))%>" id="position" style="width:180px;" class="txtbox" title="직위" maxlength="10" />
						</td>
					</tr>
					<tr>
						<th class="th"> * 기관주소</th>
						<td class="td" colspan="3">
							<input type="text" name="blngOrgZipCode" value="<%=util.getStr(dataMap.get("BLNG_ORG_ZIP_CODE"))%>" id="blngOrgZipCode" style="width:100px;" class="txtbox" title="기관주소" maxlength="10" readonly = "readonly" />
							<input type="text" name="blngOrgAddr" value="<%=util.getStr(dataMap.get("BLNG_ORG_ADDR"))%>" id="blngOrgAddr" style="width:300px;" class="txtbox" title="기관주소" maxlength="100" readonly="readonly" />
							<input type="button" class="btn_inp_b_01" id = "deptPostButton" value="찾아보기" onclick = "orgPost()" />

							<input type="text" name="blngOrgAddrDtl" value="<%=util.getStr(dataMap.get("BLNG_ORG_ADDR_DTL"))%>" id="blngOrgAddrDtl" style="width:470px;" class="txtbox" title="기관주소" maxlength="100" />
						</td>
					</tr>
					<tr>
						<th class="th"> * 부서(센터)주소</th>
						<td class="td" colspan="3">
							<input type="text" name="deptZipCode" value="<%=util.getStr(dataMap.get("DEPT_ZIP_CODE"))%>" id="deptZipCode" style="width:100px;" class="txtbox" title="부서(센터)주소"  maxlength="100" readonly = "readonly" />
							<input type="text" name="deptAddr" value="<%=util.getStr(dataMap.get("DEPT_ADDR"))%>" id="deptAddr" style="width:300px;" class="txtbox" title="부서(센터)주소" maxlength="100"  readonly="readonly" />
							<input type="button" class="btn_inp_b_01" id = "deptPostButton" value="찾아보기"  onclick = "deptPost()" />

							<input type="text" name="deptAddrDtl" value="<%=util.getStr(dataMap.get("DEPT_ADDR_DTL"))%>" id="deptAddrDtl" style="width:470px;" class="txtbox" title="기관주소" maxlength="100" />
						</td>
					</tr>
				</tbody>
			</table>

			<!-- btn -->
			<div class="btn_box" >
				<div class="btn_right_box" >
					<input type="button" class="btn_inp_b_01"  value="수정"  onclick="submitGo()" />
				</div>
			</div>

		</div>
	</div>
</form>
