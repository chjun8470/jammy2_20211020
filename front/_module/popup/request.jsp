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
	HashMap<String, String> eventMap = request.getAttribute("eventMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("eventMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("dataMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "event";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));
	String userIdx = util.getStr(paramMap.get("userIdx"));

	//out.println(paramMap);

%>
<%@include file="/front/_temple/popup/t_top.jsp" %>
<div class="popup_style" style="padding: 10px;">
	<div class="cont_tit" style="font-size: 20px;">
		<h3>?????? ??????</h3>
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
		<span style="color:red;">&nbsp;* ?????? ?????????????????????.</span><br />
        <span>
        	 &nbsp;* ????????? ????????? ?????? ????????????????????????.<br />
        	 &nbsp;* ????????? ????????? ???????????? ??????????????? ????????????.
        </span>

		<table class="skin_basic_write">
			<caption>1<%=util.getStr(dataMap.get("EVENT_TYPE_NM"))%>2 ???????????? ????????????</caption>
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 80%;" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="col"><span style="color:red; font-size:11pt;">*</span> ??????</th>
					<td>
						<input type="text" class="inp_text" name="userNm" id="userNm" value="<%=util.getStr(dataMap.get("PSN_NM"))%>" style="width: 100%;" maxlength="100" title="??????"/>
					</td>
				</tr>
				<tr>
					<th scope="col"><span style="color:red; font-size:11pt;">*</span> ??????</th>
					<td>
						<input type="checkbox" id="genderTypeCd_M" name="genderTypeCd" value="M" <%if("M".equals(util.getStr(dataMap.get("GENDER_TYPE_CD")))) {%> checked="checked" <%}%> onclick="check_only(this)"><label for="genderTypeCd_M"> ??????</label>&nbsp;&nbsp;
						<input type="checkbox" id="genderTypeCd_F" name="genderTypeCd" value="F" <%if("F".equals(util.getStr(dataMap.get("GENDER_TYPE_CD")))) {%> checked="checked" <%}%> onclick="check_only(this)"><label for="genderTypeCd_F"> ??????</label>
					</td>
				</tr>
				<tr>
					<th scope="col"><span style="color:red; font-size:11pt;">*</span> ??????<br/>(??????/?????????,?????????)</th>
					<td>
						<input type="hidden" name="loginOrgCd" id="loginOrgCd" value="<%=util.getStr(dataMap.get("ORG_GRP_CD"))%>" />
						<input type="text" class="inp_text" name="loginOrgNm" id="loginOrgNm" value="<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>" style="border-style: none;" readOnly title="?????? ??????/?????????"/>
						<input type="text" class="inp_text" name="loginOrgDept" id="loginOrgDept" value="<%=util.getStr(dataMap.get("DEPT_NM"))%>" style="border-style: none;" readOnly title="?????????"/>

						<span style="float: right;"><input type="checkbox" id="changeOrgGrp" name="changeOrgGrp" value="Y" onClick="openOrgGrp(this)"> ??????</span>

						<span id="eventManageOrgTd" style="display:none;">
							<br><br>
							<input type="hidden" name="eventManageOrgCd" id="eventManageOrgCd" value="" />
							<input type="text" class="inp_text" name="eventManageOrgNm" id="eventManageOrgNm" value="" style="width: 85%;" maxlength="100" />
							<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="btn_inp_g_01" onclick="popupWindow('orgList')" >
						</span>
						<span id="eventManageOrgSubTd"></span>
					</td>
				</tr>
				<tr>
					<th scope="col">??????</th>
					<td>
						<input type="text" class="inp_text" name=positionNm id="positionNm" value="<%=util.getStr(dataMap.get("POSITION_NM"))%>" style="width: 100%;" maxlength="100" title="??????"/>
					</td>
				</tr>
				<tr>
					<th scope="col"><span style="color:red; font-size:11pt;">*</span> ????????????</th>
					<td>
						<input type="text" class="inp_text" name="telNo" id="telNo" value="<%=util.getStr(dataMap.get("TEL_NO"))%>" style="width: 100%;" maxlength="100" title="????????????"/>
					</td>
				</tr>
				<tr>
					<th scope="col"><span style="color:red; font-size:11pt;">*</span> E-mail</th>
					<td>
						<input type="text" class="inp_text" name="email" id="email" value="<%=util.getStr(dataMap.get("EMAIL"))%>" style="width: 100%; border-width: 0px;" readOnly title="?????????"/>
					</td>
				</tr>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 480px;">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('request')"/>
			<input type="button" class="btn_inp_w_01" value="??????" onclick="pageClose()"/>
		</div>
		<!--// bo_btn -->
	</div>

	</form>
</div>

<!--????????? ?????? ??????????????? ?????? -->
<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/cms/back/func_sys.js"></script>
<script type="text/javascript" src="/js/board.js"></script>
<script type="text/javascript">
//<![CDATA[

	//????????????
	function check_only(chk){
        var obj = document.getElementsByName("genderTypeCd");
        for(var i=0; i<obj.length; i++){
            if(obj[i] != chk){
                obj[i].checked = false;
            }
        }
    }
	//????????????
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

	/*---------???????????? S----------*/
	//???????????? ??????
	function popupWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/popup/"+listMode+".do";
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
			orgGrpNm = data.dataMap.ORG_GRP_NM; //?????????
			orgGrpCd = data.dataMap.ORG_GRP_CD; //????????????
			$("#eventManageOrgNm").val(orgGrpNm);
			$("#eventManageOrgCd").val(orgGrpCd);


			$("#eventManageOrgSubNm").remove();
			result = "<input class=\"inp_text\" id=\"eventManageOrgSubNm\" name=\"eventManageOrgSubNm\" style=\"width: 85%;\" maxlength=\"30\" />";
			$("#eventManageOrgSubTd").append(result)
		});
	}
	/*---------???????????? E----------*/

	function pageClose(){
		window.close();
	}
	function goSubmit(mode){

		if (confirm("?????? ??????????????????????????") == true){ //??????
			//validation check Start
			if($('#userNm').val() == ""){
				alert("????????? ??????????????????");
				$("#userNm").focus();
				return false;
			}

			if($('#changeOrgGrp:checked').val() == 'Y') {
				if($('#eventManageOrgNm').val() == ""){
				alert("??????????????? ??????????????????");
				$("#eventManageOrgNm").focus();
				return false;
				}
				if($('#eventManageOrgSubNm').val() == ""){
					alert("??????????????? ??????????????????");
					$("#eventManageOrgSubNm").focus();
					return false;
				}
			}

			if($('#telNo').val() == ""){
				alert("??????????????? ??????????????? ??????????????????");
				$("#telNo").focus();
				return false;
			}
			//validation check End

			$('#mode').val(mode);
			popupForm.submit();

		}else{ //??????
			return;
		}
	}
//]]>
</script>
<%@include file="/front/_temple/popup/t_footer.jsp" %>