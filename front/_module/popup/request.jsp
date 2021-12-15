<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.Set,java.util.regex.*,java.text.*,java.net.*" %>
<%
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("dataMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");

	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String mode = util.getIntStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String userIdx = util.getStr(paramMap.get("userIdx"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));
	String listMode = paramMap.get("listMode");

%>
<%@include file="/front/_temple/popup/t_top.jsp" %>
<div class="popup_style" style="padding: 10px;">
	<div class="cont_tit" style="font-size: 20px;">
		<h3>행사 신청</h3>
	</div>
	<form action="/web/manageEvent.do" name="popupForm" id="popupForm" method="post" class="banner_search">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="m" id="m" value="<%=m%>" />
		<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
		<input type="hidden" name="userIdx" id="userIdx" value="<%=userIdx%>" />
		<input type="hidden" name="eventIdx" id="eventIdx" value="<%=eventIdx%>" />
		<%-- <input type="text" name="reUrl" id="reUrl" value="/jntis/sub.do?m=<%=m%>&mode=view&listMode=list&eventIdx=<%=eventIdx%>" /> --%>
		<input type="hidden" name="reUrl" id="reUrl" value="popClose" />

	<div class="skin_bbs_write" style="margin-top: 10px;">
		<span style="color:red;">&nbsp;* 필수 입력사항입니다.</span><br />
        <span>
        	 &nbsp;* 로그인 정보로 기본 입력되어있습니다.<br />
        	 &nbsp;* 문의처 정보가 다를경우 수정하시기 바랍니다.
        </span>

		<table class="skin_basic_write">
			<caption>작성하기</caption>
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 80%;" />
			</colgroup>
			<tbody>
				<tr>
					<th><span style="color:red; font-size:11pt;">*</span> 이름</th>
					<td>
						<input type="text" class="inp_text" name="userNm" id="userNm" value="<%=util.getStr(dataMap.get("PSN_NM"))%>" style="width: 100%;" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th><span style="color:red; font-size:11pt;">*</span> 성별</th>
					<td>
						<input type="checkbox" id="genderTypeCd_M" name="genderTypeCd" value="M" <%if("M".equals(util.getStr(dataMap.get("GENDER_TYPE_CD")))) {%> checked="checked" <%}%> onclick="check_only(this)"><label for="genderTypeCd_M"> 남성</label>&nbsp;&nbsp;
						<input type="checkbox" id="genderTypeCd_F" name="genderTypeCd" value="F" <%if("F".equals(util.getStr(dataMap.get("GENDER_TYPE_CD")))) {%> checked="checked" <%}%> onclick="check_only(this)"><label for="genderTypeCd_F"> 여성</label>
					</td>
				</tr>
				<tr>
					<th><span style="color:red; font-size:11pt;">*</span> 소속<br/>(기업/기관명,부서명)</th>
					<td>
						<input type="hidden" name="loginOrgCd" id="loginOrgCd" value="<%=util.getStr(dataMap.get("ORG_GRP_CD"))%>" />
						<input type="text" class="inp_text" name="loginOrgNm" id="loginOrgNm" value="<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>" style="border-style: none;" readOnly/>
						<input type="text" class="inp_text" name="loginOrgDept" id="loginOrgDept" value="<%=util.getStr(dataMap.get("DEPT_NM"))%>" style="border-style: none;" readOnly/>

						<span style="float: right;"><input type="checkbox" id="changeOrgGrp" name="changeOrgGrp" value="Y" onClick="openOrgGrp(this)"> 수정</span>

						<span id="eventManageOrgTd" style="display:none;">
							<br><br>
							<input type="hidden" name="eventManageOrgCd" id="eventManageOrgCd" value="" />
							<input type="text" class="inp_text" name="eventManageOrgNm" id="eventManageOrgNm" value="" style="width: 85%;" maxlength="100" />
							<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="btn_inp_g_01" onclick="popupWindow('orgList')" >
						</span>
						<span id="eventManageOrgSubTd"></span>
					</td>
				</tr>
				<tr>
					<th>직위</th>
					<td>
						<input type="text" class="inp_text" name=positionNm id="positionNm" value="<%=util.getStr(dataMap.get("POSITION_NM"))%>" style="width: 100%;" maxlength="100"/>
					</td>
				</tr>
				<tr>
					<th><span style="color:red; font-size:11pt;">*</span> 전화번호</th>
					<td>
						<input type="text" class="inp_text" name="telNo" id="telNo" value="<%=util.getStr(dataMap.get("TEL_NO"))%>" style="width: 100%;" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th><span style="color:red; font-size:11pt;">*</span> E-mail</th>
					<td>
						<input type="text" class="inp_text" name="email" id="email" value="<%=util.getStr(dataMap.get("EMAIL"))%>" style="width: 100%; border-width: 0px;" readOnly/>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 480px;">
			<input type="button" class="btn_inp_b_01" value="신청" onclick="goSubmit('request')"/>
			<input type="button" class="btn_inp_w_01" value="취소" onclick="pageClose()"/>
		</div>
		<!--// bo_btn -->
	</div>

	</form>
</div>

<!--팝업창 내용 적용시키는 부분 -->
<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/cms/back/func_sys.js"></script>
<script type="text/javascript" src="/js/board.js"></script>
<script type="text/javascript">
//<![CDATA[

	//성별체크
	function check_only(chk){
        var obj = document.getElementsByName("genderTypeCd");
        for(var i=0; i<obj.length; i++){
            if(obj[i] != chk){
                obj[i].checked = false;
            }
        }
    }
	//소속수정
	function openOrgGrp(chk){
		 if($('#changeOrgGrp:checked').val() == 'Y') {

	        $('#eventManageOrgTd').show();
        }else {

        	$('#eventManageOrgTd').hide();
			$('#eventManageOrgCd').val('');
	        $('#eventManageOrgNm').val('');
	        $('#eventManageOrgSubNm').val('');
       }
	}

	/*---------기관검색 S----------*/
	//기관검색 팝업
	function popupWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/popup/"+listMode+".do";
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
			orgGrpNm = data.dataMap.ORG_GRP_NM; //기관명
			orgGrpCd = data.dataMap.ORG_GRP_CD; //기관코드
			$("#eventManageOrgNm").val(orgGrpNm);
			$("#eventManageOrgCd").val(orgGrpCd);


			$("#eventManageOrgSubNm").remove();
			result = "<input class=\"inp_text\" id=\"eventManageOrgSubNm\" name=\"eventManageOrgSubNm\" style=\"width: 85%;\" maxlength=\"30\" />";
			$("#eventManageOrgSubTd").append(result)
		});
	}
	/*---------기관검색 E----------*/

	function pageClose(){
		window.close();
	}
	function goSubmit(mode){

		if (confirm("정말 등록하시겠습니까??") == true){ //확인
			//validation check Start
			if($('#userNm').val() == ""){
				alert("이름을 입력해주세요");
				$("#userNm").focus();
				return false;
			}

			if($('#changeOrgGrp:checked').val() == 'Y') {
				if($('#eventManageOrgNm').val() == ""){
				alert("소속기관을 입력해주세요");
				$("#eventManageOrgNm").focus();
				return false;
				}
				if($('#eventManageOrgSubNm').val() == ""){
					alert("소속부서를 입력해주세요");
					$("#eventManageOrgSubNm").focus();
					return false;
				}
			}

			if($('#telNo').val() == ""){
				alert("연락받으실 전화번호를 입력해주세요");
				$("#telNo").focus();
				return false;
			}
			//validation check End

			$('#mode').val(mode);
			popupForm.submit();

		}else{ //취소
			return;
		}
	}
//]]>
</script>
<%@include file="/front/_temple/popup/t_footer.jsp" %>