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
		String telNo1 ="";
		String telNo2 ="";
		String telNo3 ="";
		if(telNo.length()>9){
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
		if(telNo.length()>9){
			int c1 = cpNo.indexOf("-");
			int c2 = cpNo.indexOf("-",c1+1);
			cpNo1 = cpNo.substring(0, c1);
			cpNo2 = cpNo.substring(c1+1, c2);
			cpNo3 = cpNo.substring(c2+1);
		}
	//tel E
%>
	<form name="fedit" id="fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="userIdx" id="userIdx" value="<%=util.getStr(paramMap.get("userIdx")) %>" />
		<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?mode=view&userIdx=<%=util.getStr(paramMap.get("userIdx")) %>" />
		<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=orgGrpCd %>" onChange="orgInfo()"/>
		<input type="hidden" name="deptNmOption" id="deptNmOption" value="<%=deptNmOption %>"/>
		<input type="hidden" name="authLv" id="authLv" value="<%=util.getStr(dataMap.get("AUTH_LV"))%>"/>
		<input type="hidden" name="idCheck" id="idCheck" />

		<div class="skin_bbs_write" style="margin-top: 30px">
	   		<table class="skin_basic_write">
	   			<caption>전문가등록</caption>
                <colgroup>
                	<col style="width:20%">
					<col style="width:30%">
					<col style="width:20%">
					<col style="width:30%">
               	</colgroup>
				<tbody>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 사용자 ID</th>
						<td class="td">
							<input type="text" name="userId" maxlength="20" value="<%=util.getStr(dataMap.get("USER_ID")) %>" id="userId" class="inp_txt" title="사용자ID" readOnly style="border:0px">
							<input type="button" name="btnPwReset" id="btnPwReset" onclick="pwReset('<%=util.getStr(paramMap.get("userIdx")) %>', '<%=util.getStr(dataMap.get("USER_ID")) %>', '<%=email %>')" value="비밀번호 재설정" class="btn_inp_b_01" />
						</td>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 이 름</th>
						<td class="td">
							<input type="text" name="psnNm" maxlength="24" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" id="psnNm" class="inp_txt" title="이름">
						</td>
					</tr>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 성별구분</th>
						<td class="td">
							<input type="radio" name="genderTypeCd" value="M" id="genderTypeCdMale" style="width:20px;" <%=util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("M")? "checked='checked'" : "" %>><label for="genderTypeCdMale">남자</label>
							<input type="radio" name="genderTypeCd" value="F" id="genderTypeCdFemale" style="width:20px;" <%=util.getStr(dataMap.get("GENDER_TYPE_CD")).equals("F")? "checked='checked'" : "" %>><label for="genderTypeCdFemale">여자</label>
						</td>
						<th class="th" style="align:center; valign:middle"> <span style="color:red; font-size:10pt;">*</span> 외국인여부</th>
						<td class="td">
							<input type="radio" name="frgnYn" value="N" id="frgnYnY" style="width:20px;" title="내국인" <%=util.getStr(dataMap.get("FRGN_YN")).equals("N")? "checked='checked'" : "" %>><label for="frgnYnY">내국인</label>
							<input type="radio" name="frgnYn" value="Y" id="frgnYnN" style="margin-left: 20px; width:20px" title="외국인" <%=util.getStr(dataMap.get("FRGN_YN")).equals("Y")? "checked='checked'" : "" %>><label for="frgnYnN">외국인</label>
						</td>
					</tr>
					 <tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 전화번호</th>
						<td class="td">
							<span id="inTel">
								<input type="hidden" name="telNo" value="" id="telNo">
								<select name="telNo1" id="telNo1" class="select_box" style="width: 60px;" title="사무실전화번호 국번"><option value="02">02</option>
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
								<input type="text" name="telNo2" class="inp_txt" style="width:50px" maxlength="4" value="<%=telNo2%>" id="telNo2" title="사무실전화 앞번호"> -
								<input type="text" name="telNo3" class="inp_txt" style="width:50px" maxlength="4" value="<%=telNo3%>" id="telNo3" class="txtbox" title="사무실전화 뒷번호">
							</span>
						</td>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 핸드폰번호</th>
						<td class="td">
							<span id="inCp">
								<input type="hidden" name="cpNo" value="" id="cpNo">
								<select name="cpNo1" id="cpNo1" class="select_box" style="width: 60px;" title="휴대폰 국번">
									<option value="010" <%if(cpNo1.equals("010")) { %> selected="selected" <% } %>>010</option>
									<option value="011" <%if(cpNo1.equals("011")) { %> selected="selected" <% } %>>011</option>
									<option value="016" <%if(cpNo1.equals("016")) { %> selected="selected" <% } %>>016</option>
									<option value="017" <%if(cpNo1.equals("017")) { %> selected="selected" <% } %>>017</option>
									<option value="018" <%if(cpNo1.equals("018")) { %> selected="selected" <% } %>>018</option>
									<option value="019" <%if(cpNo1.equals("019")) { %> selected="selected" <% } %>>019</option>
								</select> -
								<input type="text" name="cpNo2" class="inp_txt" style="width:50px" maxlength="4" value="<%=cpNo2%>" id="cpNo2" class="txtbox" title="휴대폰 앞번호"> -
								<input type="text" name="cpNo3" class="inp_txt" style="width:50px" maxlength="4" value="<%=cpNo3%>" id="cpNo3" class="txtbox" title="휴대폰 뒷번호">
							</span>
						</td>
					</tr>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 이메일</th>
						<td class="td" colspan="3">
							<input type="text" name="email" class="inp_txt read_txt"  id="email" readonly="readonly" value="<%=email %>" />
						</td>

					 <tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 회원분류</th>
						<td class="td" colspan="3">
							<input type="radio" name="userTp" value="3" id="userTp3" style="width:20px;" title="기관" <%=util.getStr(dataMap.get("USER_TP")).equals("3")? "checked='checked'" : "" %>><label for="userTp3">기관회원</label>
							<span id="orgList" style="padding-left: 15px;">
								<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgList','2')" >
							</span><br>
							<span style="color:#F00; "> <span style="color:red; font-size:10pt;">*</span> 개인 등록자는 일부 JEINET 서비스에 대하여 사용권한이 제한될 수 있습니다.</span>
						</td>
					</tr>
					<tr id="orgInfo1">
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 기관명</th>
						<td class="td" colspan="3">
							<input type="text" id="orgGrpNm" name="orgGrpNm" class="inp_txt" value="" title="기관명" style="width:80%;" readonly = "readonly">
						</td>

					</tr>
					<tr id="orgInfo2">
						<th class="th" id="deptNmTh"> <span style="color:red; font-size:10pt;">*</span> 부서명</th>
						<td id="deptNmTd">
							<input type="text" id="deptNm" name="deptNm" class="inp_txt" readonly = "readonly" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" title="부서명" style="width:60%;">
							<input type="button" name="blngOrgNm" value="부서검색" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgSubList')" >
	 					</td>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 직급</th>
						<td class="td">
							<input type="text" class="inp_txt" name="positionNm" id="positionNm" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" title="직위" maxlength="10"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	<div class="btn_box" >
			<div class="btn_right_box" >
				<input type="button" onclick="goSubmit('list')" class="btn_inp_w_01" value="목록"/>
				<input type="button" onclick="submitGo()" value="수정" class="btn_inp_b_01" />
			</div>
		</div>

</form>

<script type="text/javascript">
	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fedit').submit();
	}
	//기관검색 팝업
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

	//기관정보
	function orgInfo(orgGrpCd, cnt){
		var orgGrpCd = orgGrpCd;
		var orgGrpNm;
		var result = "";
		var params = {
				"orgGrpCd": orgGrpCd
		};
		$.post("/sys/getOrgInfo.do",$.param(params),
		function(data){
			if(cnt != 'cnt'){$("#deptNm").val("");}
			orgGrpNm = data.dataMap.ORG_GRP_NM;
			$("#orgGrpNm").val(orgGrpNm);
		});


	}



var idPattern = /[^a-zA-Z0-9]/;
var korPattern = /[^가-힣]/;
var engPattern = /[^a-zA-Z- ]/;
var numPattern = /[^\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");

$(document).ready(function(){
	orgGrpCd = $("#orgGrpCd").val();
	orgInfo(orgGrpCd, 'cnt');



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
	if($("input[type=radio][name='userTp']:checked").val() == '3'){
		$('#deptNmTh').show();
		$('#deptNmTd').show();
	}

	$('input[name="userTp"]').change(function(){
		 if($(this).val()=='3'){
			 $('#deptNmTh').show();
			 $('#deptNmTd').show();
		 }
	});
});


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
	var cpNo = $("#cpNo1").val()+"-"+$("#cpNo2").val()+"-"+$("#cpNo3").val();
	$("#cpNo").val(cpNo);

	if(!$("input[name='userTp']").is(":checked")){
		alert("소속기관 : 필수입력값입니다.");
		$("#userTp3").focus();
		return false;
	}else if($("input[type=radio][name='userTp']:checked").val()==1){
		if($("#blngOrgNm").val()==null||$("#blngOrgNm").val()==""){
			alert("소속기관 : 필수입력값입니다.");
			$("#userTp3").focus();
			return false;
		}
	}
	if(confirm("변경된 내용을 적용하시겠습니까?")){
		if(confirm("권한이 초기화 됩니다.")){
			$("#mode").val("editProc");
			$('#fedit').submit();
		}
		return false
	}
	return false

}

function pwReset(idx, id, email) {
	if(confirm('비밀번호를 재설정 하시겠습니까?')) {
		$.ajax({
			url : "/sys/resetPassword.do",
			method : "POST",
			data : {userIdx : idx, userId : id, email : email},
			success : function(data) {
				if(data.succCode == "OK") {
					alert("비밀번호 재설정 메일을 발송하였습니다.");
				} else {
					alert("문제가 발생하였습니다.");
				}
			}
		});
	}
}

</script>