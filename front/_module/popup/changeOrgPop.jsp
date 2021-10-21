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
	System.out.println("changeOrg userIdx::"+userIdx);

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

if($("#blngOrgGubunSelect").val()!=null||$("#blngOrgGubunSelect").val()!=""){
	$("#blngOrgGubun").val($("#blngOrgGubunSelect").val());
}

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

function submitGo(){

	if($("#blngOrgGubun").val()==null||$("#blngOrgGubun").val()==""){
		alert("소속기관 : 필수입력값입니다.");
		$("#blngOrgGubun").focus();
		return false;
	}

	if($("#blngOrgAddr").val()==null||$("#blngOrgAddr").val()==""||$("#blngOrgAddrDtl").val()==null||$("#blngOrgAddrDtl").val()==""){
		alert("기관주소 : 필수입력값입니다.");
		$("#blngOrgAddr").focus();
		return false;
	}

	var fileCheck = 0;
	var fileCount = $("input[type=file]").length;
		for(i = 1; i <= fileCount; i++) {
				var fileName = $('#CorporateFile'+fileCount).val();
				if(fileName != "" && fileName != null){fileCheck++;}
		}

	$("#authForm").submit();
}
//]]>
</script>

<form name="authForm" id="authForm" action="/web/changeOrgUpdate.do" method="post" enctype="multipart/form-data">
<!-- 	<input type="hidden" name="mode" id="mode" value="upOrg" /> -->
	<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />

	<h1 align="center">::기관회원변경신청 정보입력::</h1>

	<div id="container" style="width:800px;margin:10px;border:5px solid lightgrey;" >
		<!--div class="contents_box"-->
		<div style="padding:10px;">

<!-- skin_basic_list s -->
		<table class="skin_basic_write" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 50%;" />

			</colgroup>
			<tbody>
				<tr>
					<th class="th"> * 소속기관</th>
					<td class="td" colspan="3">
						<input type="text" name="blngOrgGubun" id="blngOrgGubun" title="소속기관입력" />
						<input type="button" class="btn_inp_b_01" value="찾아보기" name="orgSearchBtn" id="orgSearchBtn" title="소속기관찾아보기" onclick="orgSearchPopUp('orgSearchPop')"/>
					</td>
				</tr>
				<tr>
					<th class="th"> * 부서명</th>
					<td class="td">
						<select name="deptNm" id="SelectdeptNm" title="부서명">
							<option value="" />
						</select>

 						<input type="text" name="deptNm" maxlength="30" value="" id="deptNm" class="txtbox" title="부서명">
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
					<th class="th"> * 법인번호</th>
					<td class="td" colspan="3">
						<input type="text" name="corporateCode" value="" id="corporateCode" style="width: 380px;" class="txtbox" title="법인번호" maxlength="30" />
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
	              	</td>
                </tr>

			</tbody>
		</table>

			<!-- btn -->
			<div class="btn_box" >
				<div class="btn_right_box" style="margin:20px;">
					<input type="button" class="btn_inp_b_01" value="기관회원변경신청" onclick="submitGo()" />
				</div>
			</div>

		</div>
	</div>
</form>

	<script type="text/javascript">
	//<![CDATA[
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

	    //기관찾아보기 팝업
		function orgSearchPopUp(listMode){
			var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
			var popUrl="/web/web_popup.do?listMode="+listMode;
			 popOption="width=500, height=500, resizable=no, scrollbars=no, status=no;";
			window.open(popUrl,"",popOption);
		}

	    //부서명 호출
// 		$(document).ready(function(){
// 			var org_grp_cd = $("#deptNm").val();
// 			alert("값이뭐라고오오 ? " + org_grp_cd);
// 			if($("#deptNm").val()!=null||$("#deptNm").val()!=""){
// 				var params = {
//                         "org_grp_cd":org_grp_cd
//                         };
//                 jQuery.post("/web/changeOrgUpdate.do",$.param(params),
//                 function(data) {
//                      viewOrgSubList(data);
//                 });
// 			}
// 		});
	//]]>
	</script>