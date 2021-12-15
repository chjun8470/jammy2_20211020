<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("dataMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> eduCodeList = request.getAttribute("eduCodeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eduCodeList");

	String mode = util.getStr(paramMap.get("mode"));

	if("".equals(mode)) mode = "write";

	String fileGrp = "eduOrgInfo";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>

<style>

#bgLayer {
  position:fixed;
  left:0;
  top:0;
  z-index:1001;
  width:100%;
  height:100%;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";
  filter: alpha(opacity=50);
  -khtml-opacity: 0.5;
  -moz-opacity: 0.5;
  opacity:0.5;
  background-color:#000;
  display:none;

}

#dataCheck{
 position:fixed;
  z-index:1002;
  width:400px;
  min-height:200px;
  background-color:#FFFFFF;
  display:none;
  text-align: left;
}

span.required{
	color:#ff0000;
	padding-right:5px;
	vertical-align:middle;
	float:right;
	clear:both;
}
</style>

<div id="bgLayer" onclick="dataCheckExit();"></div>
<div id="dataCheck"></div>

<div class="clear_wrap">
	<div class="left_box w75">
	<p class="tr mb5"></p>

	<form id = "fwrite" name = "fwrite" method="post" action="/sys/jnspEduProc.do" enctype="multipart/form-data">
		<input type="hidden" id="mode" name = "mode" value = "<%=mode%>"/>
		<input type="hidden" id="reUrl" name="reUrl" value="<%=myPage%>" />
		<input type="hidden" id="eduState" name="eduState" value="" />

		<table class="skin_basic_write">
			<caption>교육정보 등록</caption>
			<colgroup>
				<col style="width: 15%;" />
				<col style="width: 35%;" />
				<col style="width: 15%;" />
				<col style="width: 35%;" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduNm">교육명</label><span class="required">*</span></th>
					<td colspan="3">
						<input type="text" class="inp_text"  name="eduNm" id="eduNm" style="width: 800px;" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduCur">교육과정</label><span class="required">*</span></th>
					<td colspan="3">
						<input type="text" class="inp_text" name="eduCur" id="eduCur" value="<%=util.getStr(dataMap.get("EDU_CUR"))%>" style="width: 800px;" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduUseFlag1">JNTIS사용여부</label></th>
					<td class="top_sell brn">
						<label><input type="radio" name="eduUseFlag" id="eduUseFlag1" value="10" checked="checked" /> 표시</label>&nbsp;
						<label><input type="radio" name="eduUseFlag" id="eduUseFlag2" value="20"/> 미표시</label>
					</td>
				</tr>

				<!--
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduCateCd">교육분류</label></th>
					<td colspan="3">
						<select class="select" id="eduCateCd" name="eduCateCd" style="height:24px;">
							<option value="">==선택==</option>
							<%-- <%
								if(eduCodeList.size()>0){
									for(HashMap rs:eduCodeList) {%>
								<option value="<%=rs.get("CODE_CD")%>" ><%=rs.get("CODE_NM")%></option>
							<%
									}
								}
							%> --%>
						</select>
					</td>
				</tr>
				-->

				<%-- <tr>
					<th scope="col" class="top_sell bln"><label for="eduState">교육신청상태</label><span class="required">*</span></th>
					<td colspan="3">
						<%if(loginVO.getAuthLv().equals("99")){ %>
						<select class="select" name="eduState" id="eduState" style="height:24px;">
							<option value="10">신청</option>
							<option value="20">승인</option>
							<option value="30">반려</option>
						</select>
						<%}else{ %>
						신청
						<%}%>
					</td>
				</tr>
				<%if(loginVO.getAuthLv().equals("99")){ %>
				<tr id="rejectTr" style="display:none">
					<th scope="col" class="top_sell bln" ><label for="eduReject">반려내용</label><span class="required">*</span></th>
					<td colspan="3">

						<textarea cols="50" rows="4" maxlength="500" name="eduReject" id="eduReject"></textarea>
					</td>
				</tr>
				<%} %>--%>

				<tr>
					<th scope="col" class="top_sell bln">주최/후원</th>
					<td colspan="3">
						<input type="text" class="inp_text" name="eduAuspicesNm" id="eduAuspicesNm" style="width: 800px;" maxlength="100"/>
					</td>
				</tr>

				<tr>
					<th scope="col" class="top_sell bln"><label for="orgGrpNm">교육기관</label><span class="required">*</span></th>
					<td colspan="3">
						<span id="eduOrgTd">
						<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=util.getStr(loginVO.getAuthLv() ).equals("99")?"":util.getStr(loginVO.getOrgGrpCd())%>"/>
						<input type="text" class="inp_text" maxlength="20" name="orgGrpNm" id="orgGrpNm" value="<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>" style="width:500px" maxlength="100" placeholder=" 기관검색버튼을 클릭해주세요." readonly="readonly"/>
						<%if( util.getStr(loginVO.getAuthLv() ).equals("99")){ %>
							<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="btn_inp_g_01" style="" onclick="popupWindow('orgList')">
						<%}%>
						</span>
						<span id="eduOrgSubTd" <%if( !util.getStr(loginVO.getAuthLv()).equals("99")){ %>style="display:none;"<% } %> >
							<input id="eduOrgSubNm" name="eduOrgSubNm" class="inp_text" style="width: 500px;" maxlength="30" placeholder=" 부서명을 직접입력해주세요." />
						</span>
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduOrdStDt">접수기간</label><span class="required">*</span></th>
					<td colspan="3">
						<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduOrdStDt" name="eduOrdStDt" />
						~
						<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduOrdEdDt" name="eduOrdEdDt" />
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduStDt">교육기간</label><span class="required">*</span></th>
					<td colspan="3">
					<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduStDt" name="eduStDt" />
						~
					<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduEdDt" name="eduEdDt" "/>
					</td>
				</tr>
				<!-- <tr>
					<th scope="col" class="top_sell bln"><label for="eduTime">안내사항</label></th>
					<td colspan="3">
						<textarea class="inp_text" id="eduTime" name="eduTime" style="width:70%;height:200px"></textarea>
					</td>
				</tr> -->
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduTotalTime">총교육시간</label><span class="required">*</span></th>
					<td colspan="3">
						<input type="text" class="inp_text" maxlength="20" id="eduTotalTime" name="eduTotalTime" value=""/> 시간
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduPlace">교육장소</label><span class="required">*</span></th>
					<td colspan="3">
						<input type="text" class="inp_text" maxlength="50" id="eduPlace" name="eduPlace" value="<%=util.getStr(dataMap.get("ADDR1"))%>" style="width:500px" readonly="readonly"/>
						<input type="button" id="eduPostButton" value="찾아보기" class="btn_inp_g_01" onclick="eduPost()">
						<br/>
						<input type="text" class="inp_text" maxlength="100" id="eduPlaceDetail" name="eduPlaceDetail" value="<%=util.getStr(dataMap.get("ADDR2"))%>" style="width:500px"/>
					</td>
				</tr>
				<tr>
					<th scope="col"><label for="mapX">지도</label></th>
					<td colspan="3">
						<input type="hidden" maxlength="20" id="mapX" name="mapX" maxlength="20"  value="<%=util.getStr(dataMap.get("MAP_X"))%>"/>
						<input type="hidden" maxlength="20" id="mapY" name="mapY" maxlength="20"  value="<%=util.getStr(dataMap.get("MAP_Y"))%>"/>
						<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduTarget">교육대상</label></th>
					<td>
						<input type="text" class="inp_text" name="eduTarget" id="eduTarget" value="" style="width: 98%;" maxlength="100" />
					</td>
					<th scope="col" class="top_sell bln"><label for="eduPeople">수강인원</label><span class="required">*</span></th>
					<td>
						<input type="text" class="inp_text" name="eduPeople" id="eduPeople" value="" style="width: 110px;" maxlength="100" /> 명
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduFreeYn1">교육비</label></th>
					<td colspan="3">
						<label><input type="radio" name="eduFreeYn" id="eduFreeYn1" value="Y" checked="checked" /> 무료</label>&nbsp;&nbsp;
						<label><input type="radio" name="eduFreeYn" id="eduFreeYn2" value="N" /> 유료</label>

						<span id="eduPayBox" style="display:none">
							<input type="text" class="inp_text" maxlength="9" name="eduPay" id="eduPay" value="0" />원
						</span>
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduInsurance1">고용보험적용여부</label></th>
					<td colspan="3">
						<label><input type="radio" name="eduInsurance" id="eduInsurance1" value="Y" checked="checked" /> 적용</label>&nbsp;&nbsp;
						<label><input type="radio" name="eduInsurance" id="eduInsurance2" value="N" /> 미적용</label>
					</td>
				</tr>
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduUserNm">강사정보</label><span class="required">*</span></th>
					<td colspan="3">

						<table class="skin_basic_write">
							<tr>
								<th style="width:100px;">소속</th>
								<td style="width:200px;">
									<input class="inp_txt" type="text" name="eduUserSector" id="eduUserSector"  style="width:200px;" />
								</td>
								<th style="width:100px;">직위</th>
								<td style="width:200px;">
									<input class="inp_txt" type="text" name="eduUserDept" id="eduUserDept"  style="width:200px;" />
								</td>
							</tr>
							<tr>
								<th style="width:100px;">강사명</th>
								<td style="width:200px;">
									<input class="inp_txt" type="text" name="eduUserNm" id="eduUserNm"  style="width:200px;">
								</td>
								<th>전화번호</th>
								<td>
									<input class="inp_txt" type="text" name="eduUserTel" id="eduUserTel"  style="width:200px;">
								</td>
							</tr>
							<tr>
								<th>휴대전화</th>
								<td>
									<input class="inp_txt" type="text" name="eduUserCpNo" id="eduUserCpNo"  style="width:200px;">
								</td>
								<th>이메일</th>
								<td>
									<input class="inp_txt" type="text" name="eduUserEmail" id="eduUserEmail"  style="width:200px;">
								</td>
							</tr>
						</table>

					</td>
				</tr>
				<tr>
					<th scope="col"><label for="eduContent">교육내용</label></th>
					<td colspan="3">
						<textarea name="eduContent" id="eduContent" style="width: 100%; height: 350px; font-size:10pt;"></textarea>
                    </td>
				</tr>

				<!-- 교육안내문 = 파일첨부  -->
				<!--
				<tr>
					<th scope="col" class="top_sell bln"><label for="eduInfo">교육안내문</label></th>
					<td class="top_sell brn">
						<textarea cols="50" rows="4" maxlength="500" name="eduInfo" id="eduInfo"></textarea>
					</td>
				</tr>
				<tr id="eduOrgInfoTR">
					<th scope="col"><label for="eduOrgInfoFile1">교육안내문</label></th>
					<td colspan="3"><input type="file" name="eduOrgInfoFile1"  id="eduOrgInfoFile1"  title="파일첨부" />
						<input type="hidden" name="fileSn" value="1"/>
					</td>
				</tr>
				-->

				<tr id="eduOrgInfoTR">
                    <th scope="row" class="tit"> 교육안내문</th>
                    <td colspan="3">
	                	<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
		                	<div>
		                    	<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
		                    	<input type="hidden" name="fileSn" value="1"/>
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
				<tr>
					<th scope="col" class="top_sell bln"><label for="operPsnNm">교육문의</label><span class="required">*</span></th>
					<td colspan="3">
						<input type="hidden" name="managerUserIdx" id="equUserIdx"/>
						<input type="text" class="inp_text" maxlength="20" name="managerUserNm" id="operPsnNm" readonly="readonly"/>
						<input type="button" name="operData" id="operData" class="btn_inp_g_01" value="회원정보 조회" onclick="popupWindow('orgUserPop')">
						<table class="skin_basic_write">
							<tr>
								<th style="width:100px;">기관명</th>
								<td style="width:200px;">
									<input class="inp_txt" type="text" name="operOrgGrp" id="operOrgGrp" value="" style="border-width:0px; width:200px;" readonly>
								</td>
								<th style="width:100px;">부서명</th>
								<td style="width:200px;">
									<input class="inp_txt" type="text" name="operOrgGrpSub" id="operDeptTd" value="" style="border-width:0px; width:200px;" readonly>
								</td>
							</tr>
							<tr>
								<th style="width:100px;">담당자</th>
								<td style="width:200px;">
									<input class="inp_txt" type="text" name="operChargerTd" id="operChargerTd" value="" style="border-width:0px; width:200px;" readonly>
								</td>
								<th style="width:100px;">직위</th>
								<td style="width:200px;">
									<input class="inp_txt" type="text" name="operPositionTd" id="operPositionTd" value="" style="border-width:0px; width:200px;" readonly>
								</td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td>
									<input class="inp_txt" type="text" name="operTelTd" id="operTelTd" value="" style="border-width:0px; width:200px;" readonly>
								</td>
								<th>이메일</th>
								<td>
									<input class="inp_txt" type="text" name="operEmailTd" id="operEmailTd" value="" style="border-width:0px; width:200px;" readonly>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<th>수료증발급 여부</th>
					<td colspan="3">
						<label><input type="radio" id="certiYn1" name="certiYn" value="1" checked="checked" /> 직접등록</label>&nbsp;
						<label><input type="radio" id="certiYn2" name="certiYn" value="2"/> 온라인발급</label>
					</td>
				</tr>
				<tr id="eduOrgStampTR" style="display:none;">
					<th scope="col"><label for="eduOrgStampFile1">대표 직인(도장)</label></th>
					<td colspan="3"><input type="file" name="eduOrgStampFile1"  id="eduOrgStampFile1"  title="파일첨부" />
						<input type="hidden" name="fileSn" value="1"/>
					</td>
				</tr>
				<tr id="certiTR" style="display:none;">
					<th>교육 수료증</th>
					<td colspan="3">
						<p>수료증 발급시 수료증 하단에 표시될 내용입니다.</p>
						<table class="skin_basic_write">
							<caption>수료증 하단내용</caption>
							<colgroup>
								<col width="30%">
								<col width="70%">
							</colgroup>
							<tbody>
								<tr>
									<th><label for="certiOrg">발급기관</label></th>
									<td><input type="text" class="inp_text" name="certiOrg" id="certiOrg" maxlength="12"/></td>
								</tr>
								<tr>
									<th>발급자</th>
									<td><input type="text" class="inp_text" name="certiDirector" id="certiDirector" maxlength="12"/></td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</form>

	<!-- bo_btn  -->
	<div class="btn_box">
		<div class="btn_right_box">
			<input class="btn_inp_b_01" type="button" onclick="submitGo();" value="등록">
			<input class="btn_inp_w_01" type="button" onclick="pageListGo()" value="목록">
		</div>
	</div>

	</div>
</div>

<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
$(document).ready(function(){

	$('input[name="eduFreeYn"]').change(function(){
		if($(this).val()=='Y'){
			$('#eduPay').val("0");
			$('#eduPayBox').hide();
		}else{
			$('#eduPayBox').show();
		}
	});

	$("#eduOrdStDt, #eduOrdEdDt, #eduStDt, #eduEdDt").datepicker({
		//showOn : "both",
		//buttonImage: "button.png",

		showMonthAfterYear : true,
		showButtonPanel : true,
		changeMonth : true,
		changeYear : true,
		nextText : '다음 달',
		prevText : '이전 달',
		currentText : '오늘 날짜',
		closeText : '닫기',
		dateFormat : "yy-mm-dd",
		dayNames : ['일요일','월요일','화요일','수요일','목요일','금요일','토요일'],
		dayNamesMin : ['일','월','화','수','목','금','토'],
		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
	});

	// 접수기간  시작일 값에 따른 종료일 선택 값 제한
	$('#eduOrdStDt').datepicker("option", "maxDate", $("#eduOrdEdDt").val());
	$('#eduOrdStDt').datepicker("option", "onClose", function ( selectedDate ) {
		$("#eduOrdEdDt").datepicker( "option", "minDate", selectedDate );
	});

	// 접수기간 종료일 값에 따른 시작일 선택 값 제한
	$('#eduOrdEdDt').datepicker("option", "minDate", $("#eduOrdStDt").val());
	$('#eduOrdEdDt').datepicker("option", "onClose", function ( selectedDate ) {
		$("#eduOrdStDt").datepicker( "option", "maxDate", selectedDate );
	});


	// 교육기간  시작일 값에 따른 종료일 선택 값 제한
	$('#eduStDt').datepicker("option", "maxDate", $("#eduEdDt").val());
	$('#eduStDt').datepicker("option", "onClose", function ( selectedDate ) {
		$("#eduEdDt").datepicker( "option", "minDate", selectedDate );
	});

	// 교육기간 종료일 값에 따른 시작일 선택 값 제한
	$('#eduEdDt').datepicker("option", "minDate", $("#eduStDt").val());
	$('#eduEdDt').datepicker("option", "onClose", function ( selectedDate ) {
		$("#eduStDt").datepicker( "option", "maxDate", selectedDate );
	});

	<%--
	//반려사유
	<%if(loginVO.getAuthLv().equals("99")){ %>
	$("#eduState").change(function(){
		if($(this).val()=='30'){
			$('#rejectTr').show();
		}else{
			$('#rejectTr').hide();
		}
	});
	<%}%> --%>
});

function pageListGo(){
	$('#mode').val('list');
	$('#fwrite').attr('action','/sys/sys_edu.do');
	$('#fwrite').submit();
}

//팝업
function popupWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

	var popUrl="/sys/popup/"+listMode+".do";
	var popOption="width=500, height=550, resizable=no, scrollbars=no, status=no;";
	window.open(popUrl,"",popOption);
}

function dataCheckExit(){
	$("#bgLayer,#dataCheck").hide();
	$("#dataCheck").css("width","400px");
	$("#dataCheck").html("");
}

//Editor
var oEditors = [];
$(function(){
	//추가 글꼴 목록
	//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "eduContent",
		sSkinURI: "/js/webeditor_nhn/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			fOnBeforeUnload : function(){}
			//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
		},  //boolean
		fCreator : "createSEditor2"
	});
});

</script>


<script type="text/javascript">
	/*---------지도 S-----------*/
	var korPattern = /[가-힣]/;
	var onlyKorPattern = /[^가-힣]/;
	var engPattern = /[a-zA-Z]/;
	var numPattern = /[\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
	var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;


		function eduPost(){
			new daum.Postcode({
				oncomplete: function(data) {

					// $("#zipcode").val(data.zonecode);
					 $("#eduPlace").val(data.address);
					 $("#eduPlaceDetail").focus();

					 /**/
						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = data.address; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수

						// 기본 주소가 도로명 타입일때 조합한다.
						if(data.addressType === 'R'){
							//법정동명이 있을 경우 추가한다.
							if(data.bname !== ''){
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if(data.buildingName !== ''){
								extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
						}

						// 주소 정보를 해당 필드에 넣는다.
						//$("#location").val(fullAddr);
						// 주소로 좌표를 검색
						geocoder.addr2coord(data.address, function(status, result) {
							// 정상적으로 검색이 완료됐으면
							if (status === daum.maps.services.Status.OK) {
								// 해당 주소에 대한 좌표를 받아서
								var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
								   $("#mapX").val(result.addr[0].lat);
								   $("#mapY").val(result.addr[0].lng);
								// 지도를 보여준다.
								mapContainer.style.display = "block";
								map.relayout();
								// 지도 중심을 변경한다.
								map.setCenter(coords);
								// 마커를 결과값으로 받은 위치로 옮긴다.
								marker.setPosition(coords)
							}
						});

				}
			}).open();
		}
		////////////////지이도

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			mapOption = {
				center: new daum.maps.LatLng(35.2268795, 126.8429492),
				level: 5 // 지도의 확대 레벨
			};

		//지도를 미리 생성
		var map = new daum.maps.Map(mapContainer, mapOption);
		//주소-좌표 변환 객체를 생성
		var geocoder = new daum.maps.services.Geocoder();
		//마커를 미리 생성
		var marker = new daum.maps.Marker({
			position: new daum.maps.LatLng(35.2268795, 126.8429492),
			map: map
		});

		daum.maps.event.addListener(map, 'click', function(mouseEvent) {
			   searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
					if (status === daum.maps.services.Status.OK) {

						  // 클릭한 위도, 경도 정보를 가져옵니다
						  var latlng = mouseEvent.latLng;
						  // 마커 위치를 클릭한 위치로 옮깁니다
						  marker.setPosition(latlng);
						  //페이지에 값 넣어주기(상세주소, X좌표, Y좌표)
					   //$("#location").val(result[0].jibunAddress.name);
						  $("#mapX").val(latlng.getLat());
					   $("#mapY").val(latlng.getLng());

					   marker.setMap(map);

					}
			   });
		 });

		 // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		 daum.maps.event.addListener(map, 'idle', function() {
			   searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		 });

		 function searchAddrFromCoords(coords, callback) {
			   // 좌표로 행정동 주소 정보를 요청합니다
			   geocoder.coord2addr(coords, callback);
		 }

		 function searchDetailAddrFromCoords(coords, callback) {
			   // 좌표로 법정동 상세 주소 정보를 요청합니다
			   geocoder.coord2detailaddr(coords, callback);
		 }

		 // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		 function displayCenterInfo(status, result) {
			   if (status === daum.maps.services.Status.OK) {
					$("#centerAddr").html(result[0].fullName);
			   }
		 }
</script>


<%if(loginVO.getAuthLv().equals("99")){ %>
<script type="text/javascript">

/*---------기관검색 S----------*/
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
		$("#orgGrpNm").val(orgGrpNm);
		$("#orgGrpCd").val(orgGrpCd);

		$("#eduPlace").val(data.dataMap.ADDR1);
		$("#eduPlaceDetail").val(data.dataMap.ADDR2);
		$("#mapX").val(data.dataMap.MAP_X);
		$("#mapY").val(data.dataMap.MAP_Y);
		$("#eduTel").val(data.dataMap.CORP_PHONE);


		//$("#eduOrgSubNm").remove();
		result = "<input id=\"eduOrgSubNm\" name=\"eduOrgSubNm\" class=\"inp_text\" style=\"width: 500px;\" maxlength=\"30\" placeholder=\" 부서명을 직접입력해주세요.\" >";
		//$("#eduOrgSubTd").append(result);
		$("#eduOrgSubTd").show();
		$("#eduOrgSubNm").val("");


		//geocoder.addr2coord(data.dataMap.ADDR1, function(status, result) {
			// 정상적으로 검색이 완료됐으면
			//if (status === daum.maps.services.Status.OK){
				// 해당 주소에 대한 좌표를 받아서
				var coords = new daum.maps.LatLng($("#mapX").val(),$("#mapY").val());
				// 지도를 보여준다.
				mapContainer.style.display = "block";
				map.relayout();
				// 지도 중심을 변경한다.
				map.setCenter(coords);
				// 마커를 결과값으로 받은 위치로 옮긴다.
				marker.setPosition(coords);
			//}
		//});

	});
}
/*---------기관검색 E----------*/
</script>
<%}%>



<script type="text/javascript">

//수료증여부
$('input[name="certiYn"]').change(function(){
    if($(this).val()=='1'){
    	$('#certiTR').hide();
    	$("#eduOrgStampTR").hide();
    }else{
    	$("#certiTR").show();
    	$("#eduOrgStampTR").show();
    }
});

function submitGo(){

	var errMsg = "";
	if($("#eduNm").val()==null || $("#eduNm").val()==""){
		errMsg+="교육명 : 필수입력사항입니다."+"<br/>";
	}
	if($("#eduCur").val()==null || $("#eduCur").val()==""){
		errMsg+="교육과정 : 필수입력사항입니다."+"<br/>";
	}
	/*if($("#eduCateCd > option:selected").val()==null || $("#eduCateCd > option:selected").val()==""){
		errMsg+="교육분류 : 필수입력사항입니다."+"<br/>";
	}*/
	<%-- <%if(loginVO.getAuthLv().equals("99")){ %>
	if($("#eduState > option:selected").val()==null || $("#eduState > option:selected").val()==""){
		errMsg+="교육신청상태 : 필수입력사항입니다."+"<br/>";
	}else if($("#eduState > option:selected").val()=="30"){
		if($("#eduReject").val()==null || $("#eduCateCd > option:selected").val()==""){
			errMsg+="반려내용 : 필수입력사항입니다."+"<br/>";
		}
	}
	<%}%> --%>

	<%if(loginVO.getAuthLv().equals("99")){ %>
	if($("#orgGrpNm").val()==null || $("#orgGrpNm").val()==""){
		errMsg+="교육기관 : 필수입력사항입니다."+"<br/>";
	}
	if($('#eduOrgSubNm').val() == ""){
		errMsg+="교육기관 부서명 : 필수입력사항입니다."+"<br/>";
	}
	<%}%>

	if($("#eduOrdStDt").val()==null || $("#eduOrdStDt").val()==""){
		errMsg+="접수기간 : 필수입력사항입니다."+"<br/>";
	}else if($("#eduOrdEdDt").val()==null || $("#eduOrdEdDt").val()==""){
		errMsg+="접수기간 : 필수입력사항입니다."+"<br/>";
	}

	if($("#eduStDt").val()==null || $("#eduStDt").val()==""){
		errMsg+="교육기간 : 필수입력사항입니다."+"<br/>";
	}else if($("#eduEdDt").val()==null || $("#eduEdDt").val()==""){
		errMsg+="교육기간 : 필수입력사항입니다."+"<br/>";
	}

	/* if($("#eduTime").val()==null || $("#eduTime").val()==""){
		errMsg+="안내사항 : 필수입력사항입니다."+"<br/>";
	} */

	if($("#eduTotalTime").val()==null || $("#eduTotalTime").val()==""){
		errMsg+="총교육시간 : 필수입력사항입니다."+"<br/>";
	}else if(isNaN($("#eduTotalTime").val()) == true){
		errMsg+="총교육시간 : 숫자만 입력해주세요."+"<br/>";
	}

	if($("#eduPlace").val()==null || $("#eduPlace").val()==""){
		errMsg+="교육장소 : 필수입력사항입니다."+"<br/>";
	}else if($("#eduPlaceDetail").val()==null || $("#eduPlaceDetail").val()==""){
		errMsg+="교육장소 : 필수입력사항입니다."+"<br/>";
	}

	if($("#mapX").val()==null || $("#mapX").val()==""){
		errMsg+="지도 : 필수입력사항입니다."+"<br/>";
	}else if($("#mapY").val()==null || $("#mapY").val()==""){
		errMsg+="지도 : 필수입력사항입니다."+"<br/>";
	}

	if($("#eduPeople").val()==null || $("#eduPeople").val()==""){
		errMsg+="수강인원 : 필수입력사항입니다."+"<br/>";
	}else if(isNaN($("#eduPeople").val()) == true){
		errMsg+="수강인원 : 숫자만 입력해주세요."+"<br/>";
	}

	if(!$("input[name='eduUseFlag']").is(":checked")){
		errMsg+="JNTIS사용여부 : 필수입력사항입니다."+"<br/>";
	}

	/* if($("#eduUserSector").val()==null || $("#eduUserSector").val()==""){
		errMsg+="강사소속 : 필수입력사항입니다."+"<br/>";
	}
	if($("#eduUserDept").val()==null || $("#eduUserDept").val()==""){
		errMsg+="강사직위 : 필수입력사항입니다."+"<br/>";
	}
	if($("#eduUserNm").val()==null || $("#eduUserNm").val()==""){
		errMsg+="강사명 : 필수입력사항입니다."+"<br/>";
	}
	if($("#eduUserTel").val()==null || $("#eduUserTel").val()==""){
		errMsg+="강사소속 : 필수입력사항입니다."+"<br/>";
	}
	if($("#eduUserCpNo").val()==null || $("#eduUserCpNo").val()==""){
		errMsg+="강사직위 : 필수입력사항입니다."+"<br/>";
	}
	if($("#eduUserEmail").val()==null || $("#eduUserEmail").val()==""){
		errMsg+="강사명 : 필수입력사항입니다."+"<br/>";
	} */


	if($("#operPsnNm").val()==null || $("#operPsnNm").val()==""||$("#equUserIdx").val()==null || $("#equUserIdx").val()==""){
		errMsg+="교육문의 : 필수입력사항입니다."+"<br/>";
	}
	/*
	if($("#eduTel").val()==null || $("#eduTel").val()==""){
		errMsg+="전화번호 : 필수입력사항입니다."+"<br/>";
	}else if(!telPattern.test($('#eduTel').val())){
		errMsg+="전화번호 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
	}
	*/

	if(errMsg==""){
		if(confirm("등록하시겠습니까?")){

			oEditors.getById["eduContent"].exec("UPDATE_CONTENTS_FIELD", []);
		$("#eduState").val("10"); //무조건 '신청'으로 등록
		$("#mode").val("write");
		$("#fwrite").attr('method','post');
		$("#fwrite").submit();
		}
	}else{
		errMsg="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + errMsg;
		errMsg="<div style='margin:20px'><h2>데이터 검증결과</h2>" + errMsg;

		errMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기' class='btn_inp_w_01'/></div>";
		errMsg+="</div>";
		$('#dataCheck').html(errMsg);
		$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
		$("#dataCheck").css("top","200px");
		$('#dataCheck,#bgLayer').show();
		return false;
	}

}

var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
var fileName3 = $('#eduOrgStampFile1').val();
if(fileName3 != "" && fileName3 != null){
	fileName3 = fileName3.slice(fileName3.indexOf(".") + 1).toLowerCase();
	if(imgPattern.indexOf(fileName3)==-1){
		errMsg+="기업 직인(도장)이미지는   bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다."+"<br/>";
		//$('#orgManageFile1').val("");
	}/*else if(this.files[0].size<300000){
		alert("300kb 이상의 이미지를 등록해주세요.");
		$('#jnsptotalFile'+fileCount).val("");
	}*/
}

</script>