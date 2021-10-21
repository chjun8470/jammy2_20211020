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
	
	String orgGrpCd = util.getStr(dataMap.get("ORG_GRP_CD"));
	String deptNmOption = util.getStr(dataMap.get("DEPT_NM"));
	String userTp = util.getStr(dataMap.get("USER_TP"));
%>
	<form name="fwrite" id="fwrite" action="/sso/editAgeProc.do" method="post" enctype="multipart/form-data">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="reUrl" id="reUrl" value="" />
		<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=orgGrpCd %>" onChange="orgInfo()"/>
		<input type="hidden" name="deptNmOption" id="deptNmOption" value="<%=deptNmOption %>"/>
		<input type="hidden" name="userTp" id="userTp" value="<%=userTp %>"/>
	
		<div class="join">

	        <table class="skin_basic_write" id="write_table" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다." style="width: 600px;">


			<!-- colgroup s -->
			<colgroup>
				<col style="width: 90px;" />
				<col style="width: *;" />
			</colgroup>
			<!-- colgroup e -->
				<tr>
					<td colspan="2" >기관을 변경할 경우. 일반 회원으로 전환 됩니다.</td>
				</tr>
				<tr id="userTpTr">
						<th class="th"> * 소속기관</th>
						<td class="td" colspan="3">
							<label><input type="radio" name="userTp" value="1"id="userTp1" style="margin-left: 20px;  display: inline-block; width:20px;" title="개인"  <%=util.getStr(dataMap.get("USER_TP")).equals("1")? "checked='checked'" : "'" %>/>개인</label>
							<label><input type="radio" name="userTp" value="2"id="userTp2" style="width:20px;" title="기업"  <%=util.getStr(dataMap.get("USER_TP")).equals("2")? "checked='checked'" : "'" %>/>기업</label>
							<label><input type="radio" name="userTp" value="3"id="userTp3" style="width:20px;" title="기관"  <%=util.getStr(dataMap.get("USER_TP")).equals("3")? "checked='checked'" : "'" %>/>기관</label>
							<label><input type="radio" name="userTp" value="4"id="userTp4" style="width:20px;" title="부서"  <%=util.getStr(dataMap.get("USER_TP")).equals("4")? "checked='checked'" : "'" %>/>부서</label>
<%-- 							<% if (dataMap.get("USER_TP").equals("2")||dataMap.get("USER_TP").equals("3")){%> --%>
							<span id="orgList" style="padding-left: 15px;" >
								<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm1" class="btn_inp_b_01" onclick="popupWindow('orgList','2')" />
							</span>
							<span id="orgList" style="padding-left: 15px;" >
								<input type="button" name="blngOrgNm" value="기업검색" id="blngOrgNm2" class="btn_inp_b_01" onclick="popupWindow('orgList','1')" />
							</span>
<%-- 							<%} %> --%>
							<br/>
							<span style="color:#F00; "> *  개인 등록자는 일부 JEINET 서비스에 대하여 사용권한이 제한될 수 있습니다.</span>
						</td>
					</tr>
<%-- 					<% if (util.getStr(dataMap.get("USER_TP")).equals("2")||util.getStr(dataMap.get("USER_TP")).equals("3")){%> --%>
					<tr id="orgInfo1">
						<th class="th" id="thNm"></th>
						<td class="td" colspan="3">
							<input type="text" id="orgGrpNm" name="orgGrpNm" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>" class="inp_txt" title="기관명" style="width:80%;" readonly = "readonly" maxlength="10"/>
						</td>

					</tr>
					<tr id="orgInfo2">
						<th class="th" id="depNmTh"> * 부서명</th>
						<td class="td" id="depNmTd">
							<input type="text" name="deptNm" id="deptNm" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" readonly = "readonly" title="부서/센터명" maxlength="10"/>
							<span id="orgDeptList" style="padding-left: 15px;" >
								<input type="button" name="blngOrgNm" value="부서검색" id="orgSubNm" class="btn_inp_b_01" onclick="popupSubWindow('orgSubList')" />
							</span>
	 					</td>
						<th class="th"> * 직위</th>
						<td class="td">
							<input type="text" name="positionNm" id="positionNm" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" title="직위" maxlength="10"/>
						</td>
					</tr>
<%-- 					<%} %> --%>
				</table>

		        <!-- bo_btn  -->
		        <div class="join_btn_box">
		        	<input type="button" class="btn_inp_b_01" value="확인" onclick="submitGo()"/>
		        </div>
		        <!--// bo_btn -->

        	</div>
      </form>

<script type="text/javascript">
//<![CDATA[
function submitGo(){
	if(confirm("변경된 내용을 적용하시겠습니까?")){
		if(confirm("권한이 초기화 됩니다.")){
			$("#fwrite").submit();
		}
		return false
	}
	return false		
}

//기관검색 팝업
function popupWindow(listMode,userTp){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

	var popUrl="/sys/popup/"+listMode+".do?userTp="+userTp;
	var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
	window.open(popUrl,"",popOption);
}
//부서검색 팝업
function popupSubWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
	var grpCd = $('#orgGrpCd').val();
	if(grpCd == null || grpCd == ''){
		alert("기관을 선택을 하십시오.");
		return false;
	}
	var popUrl="/sys/popup/"+listMode+".do?orgGrpCd="+grpCd;
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
			$("#orgGrpNm").val(orgGrpNm);
		});
	}
$(document).ready(function(){
	
	var userTp = $("#userTp").val();
	if(userTp == "1"){
		$("#orgGrpCd").val("");
    	$("#positionNm").val("");
    	$('#orgGrpNm').val("");
    	$('#deptNm').val("");
		$('#blngOrgNm1').hide();
		$('#blngOrgNm2').hide();
		$('#orgInfo1').hide();
		$('#orgInfo2').hide();
		/* $('#userTpTr').hide(); */
	}else if(userTp == "2"){
		$("#blngOrgNm1").hide();
		$("#orgSubNm").hide();
		$("#blngOrgNm2").show();
		$('#orgInfo1').show();
		$('#orgInfo2').show();
		$('#deptNm').removeAttr("readonly");
		$('#thNm').text(' * 기업명');
		var orgGrpCd = $("#orgGrpCd").val();
		orgInfo(orgGrpCd);
	}else if(userTp == "3"){
		$("#blngOrgNm2").hide();
		$("#depNmTh").hide();
		$("#depNmTd").hide();
		$("#blngOrgNm1").show();
		$('#orgInfo1').show();
		$('#orgInfo2').show();
		$('#thNm').text(' * 기관명');
		var orgGrpCd = $("#orgGrpCd").val();
		orgInfo(orgGrpCd);
	}else if(userTp == "4"){
		$("#blngOrgNm2").hide();
		$("#depNmTh").show();
		$("#depNmTd").show();
		$("#blngOrgNm1").show();
		$('#orgInfo1').show();
		$('#orgInfo2').show();
		$('#thNm').text(' * 기관명');
		var orgGrpCd = $("#orgGrpCd").val();
		orgInfo(orgGrpCd);
	}
	$('input[name="userTp"]').change(function(){
		if($(this).val()=='1'){
			$('#userTp').val($(this).val());
			$("#orgGrpCd").val("");
	    	$("#positionNm").val("");
	    	$('#orgGrpNm').val("");
	    	$('#deptNm').val("");
	    	$('#blngOrgNm1').hide();
	    	$('#blngOrgNm2').hide();
	    	$('#orgInfo1').hide();
	    	$('#orgInfo2').hide();
	    	$('#userTpTr').show();
	    }else if($(this).val()=='2'){
	    	$('#userTp').val($(this).val());
	    	$("#orgGrpCd").val("");
	    	$("#positionNm").val("");
	    	$('#orgGrpNm').val("");
	    	$('#deptNm').val("");
	    	$('#deptNm').removeAttr("readonly");
	    	$('#thNm').text(' * 기업명'); 
	    	$('#blngOrgNm2').show();
	    	$('#orgInfo1').show();
	    	$('#orgInfo2').show();
	    	$('#userTpTr').show();
	    	$("#orgSubNm").hide();
	    	$('#blngOrgNm1').hide();
	    	$("#depNmTh").show();
			$("#depNmTd").show();
	    }else if($(this).val()=='3'){
	    	$('#userTp').val($(this).val());
	    	$("#orgGrpCd").val("");
	    	$("#positionNm").val("");
	    	$('#orgGrpNm').val("");
	    	$('#deptNm').val("");
	    	$('#thNm').text(' * 기관명');
	    	$("#orgSubNm").show();
	    	$('#blngOrgNm1').show();
	    	$('#orgInfo1').show();
	    	$('#orgInfo2').show();
	    	$('#userTpTr').show();
	    	$('#blngOrgNm2').hide();
	    	$("#depNmTh").hide();
			$("#depNmTd").hide();
	    }else if($(this).val()=='4'){
	    	$('#userTp').val($(this).val());
	    	$("#orgGrpCd").val("");
	    	$("#positionNm").val("");
	    	$('#orgGrpNm').val("");
	    	$('#deptNm').val("");
	    	$('#thNm').text(' * 기관명');
	    	$('#deptNm').attr("readonly","readonly");
	    	$("#orgSubNm").show();
	    	$('#blngOrgNm1').show();
	    	$('#orgInfo1').show();
	    	$('#orgInfo2').show();
	    	$('#userTpTr').show();
	    	$('#blngOrgNm2').hide();
	    	$("#depNmTh").show();
			$("#depNmTd").show();
	    }
	});
});

//]]>
</script>