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
	String userAppState = util.getStr(paramMap.get("userAppState"));
%>

	<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />
		<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="" onChange="orgInfo()"/>
		<input type="hidden" name="userAppState" id="userAppState" value="<%=userAppState%>"/>
		<input type="hidden" name="idCheck" id="idCheck" />
		<input type="hidden" name="userTp" id="userTp" />

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
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 이 름</th>
						<td class="td" colspan="3">
							<input type="text" name="psnNm" maxlength="24" value="" id="psnNm"  class="inp_txt"  title="이름">
						</td>
					</tr>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 성별구분</th>
						<td class="td">
							<input type="radio" name="genderTypeCd" value="M" checked="checked" id="genderTypeCdMale" style="width:20px;"><label for="genderTypeCdMale">남자</label>
							<input type="radio" name="genderTypeCd" value="F" id="genderTypeCdFemale" style="width:20px;"><label for="genderTypeCdFemale">여자</label>
						</td>
						<th class="th" style="align:center; valign:middle"> <span style="color:red; font-size:10pt;">*</span> 외국인여부</th>
						<td class="td">
							<input type="radio" name="frgnYn" value="N" checked="checked" id="frgnYnY" style="width:20px;" title="내국인"><label for="frgnYnY">내국인</label>
							<input type="radio" name="frgnYn" value="Y" id="frgnYnN" style="margin-left: 20px; display: inline-block; width:20px" title="외국인" disabled="disabled"><label for="frgnYnN">외국인</label>
						</td>
					</tr>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 사용자 ID</th>
						<td class="td" colspan="3">
							<input type="hidden" name="userId" maxlength="20" value="" id="userId" class="inp_txt read_txt" title="사용자ID" readonly="readonly">
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
							<div id = "checkValue"></div>
						</td>
					</tr>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 비밀번호</th>
						<td class="td" colspan="3">
							<input type="password" name="password" maxlength="20" value="" id="password" style="width:200px;"  class="inp_txt simplePassMeterInput" title="비밀번호" >
	<!-- 						<div id="passwordMessage" style="color:#f00; margin-top: 10px;"> <span style="color:red; font-size:10pt;">*</span>  영문자와 숫자 및 특수문자를 조합 9자리 이상</div> -->
						</td>
					</tr>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 비밀번호 확인</th>
						<td class="td" colspan="3">
							<input type="password" name="confirmPassword" maxlength="20" value="" id="confirmPassword" style="width:200px;"  class="inp_txt" title="비밀번호 확인">
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
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 전화번호</th>
						<td class="td">
							<span id="inTel">
								<input type="hidden" name="telNo" value="" id="telNo">
								<select name="telNo1" id="telNo1"  class="select_box"  style="width: 60px;" title="사무실전화번호 국번"><option value="02">02</option>
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
								</select> -
								<input type="text" name="telNo2"  class="inp_txt" style="width:50px" maxlength="4" value="" id="telNo2" title="사무실전화 앞번호"> -
								<input type="text" name="telNo3"  class="inp_txt" style="width:50px" maxlength="4" value="" id="telNo3" class="txtbox" title="사무실전화 뒷번호">
							</span>
						</td>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 핸드폰번호</th>
						<td class="td">
							<span id="inCp">
								<input type="hidden" name="cpNo" value="" id="cpNo">
								<select name="cpNo1" id="cpNo1"  class="select_box" style="width: 60px;" title="휴대폰 국번"><option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option></select> -
								<input type="text" name="cpNo2"  class="inp_txt" style="width:50px" maxlength="4" value="" id="cpNo2" class="txtbox" title="휴대폰 앞번호"> -
								<input type="text" name="cpNo3"  class="inp_txt" style="width:50px" maxlength="4" value="" id="cpNo3" class="txtbox" title="휴대폰 뒷번호">
							</span>
						</td>
					</tr>
					<tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 이메일</th>
						<td class="td" colspan="3">
							<input type="text" name="email" value="" id="email" class="inp_txt read_txt" readonly="readonly">
						</td>
					</tr>
					 <tr>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 회원분류</th>
						<td class="td" colspan="3">
							<input type="radio" name="userTp" value="3" id="blngOrgGubunOrg" checked="checked"  style="width:20px;" title="기관"><label for="blngOrgGubunOrg">기관회원</label>
							<span id="orgList" style="padding-left: 15px;">
								<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgList')" >
							</span><br>
							<span style="color:#F00; "> <span style="color:red; font-size:10pt;">*</span>  개인 등록자는 일부 JEINET 서비스에 대하여 사용권한이 제한될 수 있습니다.</span>
						</td>
					</tr>
					<tr id="orgInfo1">
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 기관명</th>
						<td class="td" colspan="3">
							<input type="text" id="orgGrpNm" name="orgGrpNm" class="inp_txt" value="" title="기관명" style="width:80%;" readonly = "readonly">
						</td>

					</tr>
					<tr id="orgInfo2">
						<th class="th" id="deptTh"> <span style="color:red; font-size:10pt;">*</span> 부서명</th>
						<td id="deptTd" >
							<input type="text"  class="inp_txt" name="deptNm" id="deptNm" readonly = "readonly" title="부서" maxlength="10"/>
							<input type="button" name="blngOrgNm" value="부서검색" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgSubList')" >
	 					</td>
						<th class="th"> <span style="color:red; font-size:10pt;">*</span> 직급</th>
						<td class="td" >
							<input type="text"  class="inp_txt" name="positionNm" id="positionNm"  title="직급" maxlength="10"/>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	<div class="btn_box" >
			<div class="btn_right_box" >
				<input type="button" onclick="submitGo()" value="등록" class="btn_inp_b_01" />
				<input type="button" onclick="goSubmit('list')" class="btn_inp_w_01" value="목록"/>
			</div>
		</div>

</form>

<script type="text/javascript">
	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fwrite').submit();
	}
	//기관검색 팝업
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

		if(listMode == 'orgList'){
			var popUrl="/sys/popup/"+listMode+".do?userTp=2";
		}else if(listMode == 'orgSubList'){
			var popUrl="/sys/popup/"+listMode+".do?orgGrpCd="+$('#orgGrpCd').val();
		}
		var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}

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

			$("#deptNm").val("");
			$("#orgGrpNm").val(orgGrpNm);
			$('#userAppState').val("10");
	    	$('#blngOrgNm').show();
	    	$('#orgInfo1').show();
	    	$('#orgInfo2').show();
	    	if($('#userTp').val() == '3'){
	    		$('#deptTh').show();
	    		$('#deptTd').show();
	    	}
		});


	}



var emailPattern = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
var idPattern = /[^a-zA-Z0-9]/;
var korPattern = /[^가-힣]/;
var engPattern = /[^a-zA-Z- ]/;
var numPattern = /[^\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");

$(document).ready(function(){
	$('#orgInfo1').show();
	$('#orgInfo2').show();
	$('#userTp').val('3');

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

		var id = $("#emailId").val() + "@" + this.value;
		$("#userId").val(id);
		$("#email").val(id);
	});
	$('input[name="userTp"]').change(function(){
		if($(this).val()=='3'){
			$("#userTp").val($(this).val());
			$("#orgGrpNm").val("");
			$("#deptNm").val("");
			$("#positionNm").val("");
			$('#orgInfo1').show();
			$('#orgInfo2').show();
		}
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

		if (!emailPattern.test(userId)) {
			alert("이메일 양식을 입력해주세요.");
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

	if(!$("input[name='userTp']").is(":checked")){
		alert("소속기관 : 필수입력값입니다.");
		$("#blngOrgGubunOrg").focus();
		return false;
	}else if($("input[type=radio][name='userTp']:checked").val()==1){
		if($("#blngOrgNm").val()==null||$("#blngOrgNm").val()==""){
			alert("소속기관 : 필수입력값입니다.");
			$("#blngOrgGubunOrg").focus();
			return false;
		}
	}
	if($('#userTp').val() == '4' ){
		if($("#deptNm").val()==null||$("#deptNm").val()==""){
			alert("부서명 : 필수입력값입니다.");
			$("#deptNm").focus();
			return false;
		}
	}
	if($("#positionNm").val()==null||$("#positionNm").val()==""){
		alert("직급 : 필수입력값입니다.");
		$("#positionNm").focus();
		return false;
	}

	$("#mode").val("writeProc");
	 $('#fwrite').submit();
}

</script>