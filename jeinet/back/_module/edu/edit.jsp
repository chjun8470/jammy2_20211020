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
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, String>> eduCodeList = request.getAttribute("eduCodeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eduCodeList");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
%>
<style scoped>
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

</style>
<div id="bgLayer" onclick="dataCheckExit();"></div>
<div id="dataCheck"></div>
<div class="clear_wrap">
						<div class="left_box w75">
					<p class="tr mb5"></p>
<form id = "fwrite" name = "fwrite" method="post" action="/sys/jnspEduProc.do" enctype="multipart/form-data">

	<input type="hidden" id="mode" name = "mode" value = "<%=mode%>"/>
	<input type="hidden" name= "eduId" id = "eduId" value="<%=util.getStr(paramMap.get("eduId"))%>"/>
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />

					<table id="step1" class="skin_basic_write">
						<caption>교육정보 상세정보수정</caption>
						<colgroup>
				   			<col style="width:200px">
				   			<col style="width:800px">
						</colgroup>
						<tbody>

						<tr>
							<th scope="col" class="top_sell bln"><label for="eduNm">교육명</label></th>
							<td class="top_sell brn">
								<input type="text" class="inp_text" maxlength="20" style="width:300px" name="eduNm" id="eduNm" value="<%=util.getStr(dataMap.get("EDU_NM"))%>"/>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduCur">교육과정</label></th>
							<td class="top_sell brn">
								<input type="text" class="inp_text" maxlength="20" style="width:300px" name="eduCur" id="eduCur" value="<%=util.getStr(dataMap.get("EDU_CUR"))%>"/>
							</td>
						</tr>
						<!-- <tr>
							<th scope="col" class="top_sell bln"><label for="eduCateCd">교육분류</label></th>
							<td class="top_sell brn">
								<select class="select" id="eduCateCd" name="eduCateCd" style="height:24px;">
									<option value="">==선택==</option>
									<%if(eduCodeList.size()>0){
										for(HashMap rs:eduCodeList) {%>
										<option value="<%=rs.get("CODE_CD")%>" <%=rs.get("CODE_CD").equals(dataMap.get("EDU_CATE_CD"))?"selected='selected'":""%>><%=rs.get("CODE_NM")%></option>
									<%}
									}%>
								</select>
							</td>
						</tr>
						 -->
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduState">교육신청상태</label></th>
							<td class="top_sell brn">
							<%if(loginVO.getAuthLv().equals("99")){ %>
							<select class="select" name="eduState" id="eduState" style="height:24px;">
								<option value="10" <%=util.getStr(dataMap.get("EDU_STATE")).equals("10")?"selected='selected'":"" %>>신청</option>
								<option value="20" <%=util.getStr(dataMap.get("EDU_STATE")).equals("20")?"selected='selected'":"" %>>승인</option>
								<option value="30" <%=util.getStr(dataMap.get("EDU_STATE")).equals("30")?"selected='selected'":"" %>>반려</option>
							</select>
							<%}else{ %>
								<%=util.getStr(dataMap.get("EDU_STATE")).equals("10")?"신청":"" %>
								<%=util.getStr(dataMap.get("EDU_STATE")).equals("20")?"승인":"" %>
								<%=util.getStr(dataMap.get("EDU_STATE")).equals("30")?"반려":"" %>
							<%}%>
							</td>
						</tr>

						<tr id="rejectTr" <%=util.getStr(dataMap.get("EDU_STATE")).equals("30")?"":"style='display:none'" %>>
							<th scope="col" class="top_sell bln" ><label for="eduReject">반려내용</label></th>
							<td class="top_sell brn">
							<%if(loginVO.getAuthLv().equals("99")){ %>
							<textarea cols="50" rows="4" maxlength="500" name="eduReject" id="eduReject"><%=util.getStr(dataMap.get("EDU_REJECT"))%></textarea>
							<%}else{%>
							<pre><%=util.getStr(dataMap.get("EDU_REJECT")) %></pre>
							<% }%>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln">주최/후원</th>
							<td class="top_sell brn" colspan="3">
								<input type="text" class="inp_text" name="eduAuspicesNm" id="eduAuspicesNm" value="<%=util.getStr(dataMap.get("EDU_AUSPICES_NM"))%>"/>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="orgGrpNm">교육기관</label></th>
							<td class="top_sell brn">
							<%if(loginVO.getAuthLv().equals("99")){ %>
							<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=util.getStr(dataMap.get("ORG_GRP_CD"))%>"/>
							<input type="text" class="inp_text" maxlength="20" name="orgGrpNm" id="orgGrpNm" value="<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>" readonly="readonly"/>
							<%}else{ out.println(util.getStr(dataMap.get("ORG_GRP_NM")));
							} %>
							<%if(loginVO.getAuthLv().equals("99")){ %>
							<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="btn_inp_b_01" style="" onclick="popupWindow('orgList')">
							<%} %>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduOrdStDt">신청기간</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduOrdStDt" name="eduOrdStDt" value="<%=util.getStr(dataMap.get("EDU_ORD_ST_DT"))%>"/>
								~
							<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduOrdEdDt" name="eduOrdEdDt" value="<%=util.getStr(dataMap.get("EDU_ORD_ED_DT"))%>"/>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduStDt">교육기간</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduStDt" name="eduStDt" value="<%=util.getStr(dataMap.get("EDU_ST_DT"))%>"/>
								~
							<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduEdDt" name="eduEdDt" value="<%=util.getStr(dataMap.get("EDU_ED_DT"))%>"/>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduTime">안내사항</label></th>
							<td class="top_sell brn">
								<textarea class="inp_text" id="eduTime" name="eduTime" style="width:70%;height:200px"><%=util.getStr(dataMap.get("EDU_TIME"))%></textarea>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduTotalTime">총교육시간</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" id="eduTotalTime" name="eduTotalTime" value="<%=util.getIntStr(dataMap.get("EDU_TOTAL_TIME"))%>"/>(시간)
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduPlace">교육장소</label></th>
							<td class="top_sell brn">
								<input type="text" class="inp_text" maxlength="50" id="eduPlace" name="eduPlace" value="<%=util.getStr(dataMap.get("EDU_PLACE"))%>" readonly="readonly" style="width:200px"/>
								<input type="button" id="eduPostButton" value="찾아보기" class="btn_inp_b_01" onclick="eduPost()">
								<br/>
								<input type="text" class="inp_text" maxlength="100" class="inputBox_2" id="eduPlaceDetail" name="eduPlaceDetail" value="<%=util.getStr(dataMap.get("EDU_PLACE_DETAIL"))%>" style="width:400px"/>
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="mapX">지도</label></th>
							<td>
							<input type="hidden" maxlength="20" id="mapX" name="mapX" maxlength="20" value="<%=util.getStr(dataMap.get("MAP_X"))%>">
							<input type="hidden" maxlength="20" id="mapY" name="mapY" maxlength="20" value="<%=util.getStr(dataMap.get("MAP_Y"))%>">
							<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
							</td>
						</tr>

						<tr>
							<th scope="col" class="top_sell bln"><label for="eduPeople">수강인원</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" id="eduPeople" name="eduPeople" value="<%=util.getIntStr(dataMap.get("EDU_PEOPLE"))%>"/>명
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduUseFlag1">사용여부</label></th>
							<td class="top_sell brn">
							<label><input type="radio" name="eduUseFlag" id="eduUseFlag1" value="10" <%=util.getIntStr(dataMap.get("EDU_USE_FLAG")).equals("10")? "checked='checked'":""%>/>사용</label>
							<label><input type="radio" name="eduUseFlag" id="eduUseFlag2" value="20" <%=util.getIntStr(dataMap.get("EDU_USE_FLAG")).equals("20")? "checked='checked'":""%>/>미사용</label>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduUserNm">강사정보</label></th>
							<td class="top_sell brn" colspan="3">
							<table class="skin_basic_write">
									<tr>
										<th style="width:100px;">소속</th>
										<td style="width:200px;">
											<input class="inp_txt" type="text" name="eduUserSector" id="eduUserSector" value="<%=util.getStr(dataMap.get("EDU_USER_SECTOR"))%>" style="width:200px;">
										</td>
										<th style="width:100px;">직위</th>
										<td style="width:200px;">
											<input class="inp_txt" type="text" name="eduUserDept" id="eduUserDept" value="<%=util.getStr(dataMap.get("EDU_USER_DEPT"))%>" style="width:200px;">
										</td>
									</tr>
									<tr>
										<th style="width:100px;">강사명</th>
										<td style="width:200px;">
											<input class="inp_txt" type="text" name="eduUserNm" id="eduUserNm" value="<%=util.getStr(dataMap.get("EDU_USER_NM"))%>" style="width:200px;">
										</td>
										<th>전화번호</th>
										<td>
											<input class="inp_txt" type="text" name="eduUserTel" id="eduUserTel" value="<%=util.getStr(dataMap.get("EDU_USER_TEL"))%>" style="width:200px;">
										</td>
									</tr>
									<tr>
										<th>휴대전화</th>
										<td>
											<input class="inp_txt" type="text" name="eduUserCpNo" id="eduUserCpNo" value="<%=util.getStr(dataMap.get("EDU_USER_CP_NO"))%>" style="width:200px;">
										</td>
										<th>이메일</th>
										<td>
											<input class="inp_txt" type="text" name="eduUserEmail" id="eduUserEmail" value="<%=util.getStr(dataMap.get("EDU_USER_EMAIL"))%>" style="width:200px;">
										</td>
									</tr>
									
								</table>
							
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="operPsnNm">교육문의</label></th>
							<td class="top_sell brn">
							<input type="hidden" name="managerUserIdx" id="equUserIdx" value="<%=util.getStr(dataMap.get("MANAGER_USER_IDX"))%>"/>
							<input type="text" class="inp_text" maxlength="20" name="managerUserNm" id="operPsnNm" value="<%=util.getStr(dataMap.get("MANAGER_USER_NM"))%>" readonly="readonly"/>
							<input type="button" name="operData" class="btn_inp_b_01" id="operData" value="회원정보 조회" onclick="popupWindow('orgUserPop')">
							<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">기관명</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operOrgGrp" id="operOrgGrp" value="<%=util.getStr(dataMap.get("MANAGER_ORG_GRP_NM"))%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">부서명</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operOrgGrpSub" id="operOrgGrpSub" value="<%=util.getStr(dataMap.get("MANAGER_DEPT_NM"))%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">담당자</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operChargerTd" id="operChargerTd" value="<%=util.getStr(dataMap.get("MANAGER_USER_NM"))%>" style="border-width:0px; width:200px;" readonlyd>
	                					</td>
	                					<th style="width:100px;">직위</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operPositionTd" id="operPositionTd" value="<%=util.getStr(dataMap.get("MANAGER_POSITION_NM"))%>" style="border-width:0px; width:200px;" readonlyd>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>전화번호</th>
	                					<td>
	                						<input class="inp_txt"  type="text" name="operTelTd" id="operTelTd" value="<%=util.getStr(dataMap.get("MANAGER_TEL_NO")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th>이메일</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="operEmailTd" id="operEmailTd" value="<%=util.getStr(dataMap.get("MANAGER_EMAIL"))%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                			</table>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduFreeYn1">교육비</label></th>
							<td class="top_sell brn">
							<label><input type="radio" name="eduFreeYn" id="eduFreeYn1" value="Y" <%=util.getStr(dataMap.get("EDU_FREE_YN")).equals("Y")? "checked='checked'" : ""%>> 무료</label>
							<label><input type="radio" name="eduFreeYn" id="eduFreeYn2" value="N" <%=util.getStr(dataMap.get("EDU_FREE_YN")).equals("N")? "checked='checked'" : ""%>> 유료</label>

							<span id="eduPayBox" <%=util.getIntStr(dataMap.get("EDU_FREE_YN")).equals("Y")? "style='display:none'":""%>>
								<input type="text" class="inp_text" maxlength="20" name="eduPay" id="eduPay" value="<%=util.getIntStr(dataMap.get("EDU_PAY")) %>"/>원
							</span>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduInsurance1">교용보험적용여부</label></th>
							<td class="top_sell brn">
							<label><input type="radio" name="eduInsurance" id="eduInsurance1" value="Y" <%=util.getStr(dataMap.get("EDU_INSURANCE")).equals("Y")? "checked='checked'":""%>>적용</label>
							<label><input type="radio" name="eduInsurance" id="eduInsurance2" value="N" <%=util.getStr(dataMap.get("EDU_INSURANCE")).equals("N")? "checked='checked'" : ""%>>미적용</label>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduTel">문의연락처</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" id="eduTel" name="eduTel" value="<%=util.getStr(dataMap.get("EDU_TEL"))%>"/>
							<br/>
							ex) 010-000-0000
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduTarget">교육대상</label></th>
							<td class="top_sell brn">
							<textarea cols="50" rows="4" maxlength="500" name="eduTarget" id="eduTarget"><%=util.getStr(dataMap.get("EDU_TARGET"))%></textarea>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduContent">교육내용</label></th>
							<td class="top_sell brn">
							<textarea cols="50" rows="4" maxlength="500" name="eduContent" id="eduContent"><%=util.getStr(dataMap.get("EDU_CONTENT"))%></textarea>
							</td>
						</tr>
						<!-- <tr>
							<th scope="col" class="top_sell bln"><label for="eduInfo">교육안내문</label></th>
							<td class="top_sell brn">
							<textarea cols="50" rows="4" maxlength="500" name="eduInfo" id="eduInfo"><%=util.getStr(dataMap.get("EDU_INFO"))%></textarea>
							</td>
						</tr> -->
						<tr id="orgInfoTR">
							<th scope="col"><label for="eduOrgInfoFile1">교육안내문</label></th>
							<td colspan="3">
							<% if(util.getStr(String.valueOf(dataMap.get("Info_FILE_ID"))).equals("")){%>
							<input type="file" name="eduOrgInfoFile1"  id="eduOrgInfoFile1"  title="파일첨부" />
							<input type="hidden" name="fileSn"  value="3" />
							<%}else{%>
							<ul class="file" style="line-height: 22px;">
								<li class="text">
									<input type="hidden" name="fileSn"  value="3" />
									<input type="checkbox" name="fileFlog" id="fileFlog_3"
											value="<%=util.getStr(String.valueOf(dataMap.get("Info_FILE_ID")))%>" onclick="fileSet('3')" /> &nbsp;
									<label for="fileFlog_3">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;

									<img class='org_Info' src="<%=util.getStr(dataMap.get("Info_FILE_SRC"))%>" alt='<%=util.getStr(dataMap.get("Info_FILE_TITLE")) %>' style='width:100px;height:100px'/>

								</li>
							</ul>
							<div id="fileBox_3" style="display:none">
								<input type="file" name="eduOrgInfoFile1"  id="eduOrgInfoFile1"  title="파일첨부"  />
							</div>
							<%}%>
							</td>
						</tr>
						<tr id="orgStampTR">
							<th scope="col"><label for="eduOrgStampFile1">대표 직인(도장)</label></th>
							<td colspan="3">
							<% if(util.getStr(String.valueOf(dataMap.get("STAMP_FILE_ID"))).equals("")){%>
							<input type="file" name="eduOrgStampFile1"  id="eduOrgStampFile1"  title="파일첨부" />
							<input type="hidden" name="fileSn"  value="3" />
							<%}else{%>
							<ul class="file" style="line-height: 22px;">
								<li class="text">
									<input type="hidden" name="fileSn"  value="3" />
									<input type="checkbox" name="fileFlog" id="fileFlog_3"
											value="<%=util.getStr(String.valueOf(dataMap.get("STAMP_FILE_ID")))%>" onclick="fileSet('3')" /> &nbsp;
									<label for="fileFlog_3">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;

									<img class='org_stamp' src="<%=util.getStr(dataMap.get("STAMP_FILE_SRC"))%>" alt='<%=util.getStr(dataMap.get("STAMP_FILE_TITLE")) %>' style='width:100px;height:100px'/>

								</li>
							</ul>
							<div id="fileBox_3" style="display:none">
								<input type="file" name="eduOrgStampFile1"  id="eduOrgStampFile1"  title="파일첨부"  />
							</div>
							<%}%>
							</td>
						</tr>
						<tr id="certiTR">
							<th>교육 수료증</th>
							<td colspan="3">
							<p>수료증 발급시 수료증 하단에 표시될 내용입니다.</p>
							<table class="skin_basic_write">
								<caption>수료증 하단내용</caption>
								<colgroup>
									<col width="40%">
									<col width="60%">
								</colgroup>
								<tbody>
								<tr>
									<th><label for="certiOrg">발급기관</label></th>
									<td><input type="text" name="certiOrg" id="certiOrg" maxlength="12" value="<%=util.getStr(dataMap.get("CERTI_ORG"))%>"/></td>
								</tr>
								<tr>
									<th>발급자</th>
									<td><input type="text" name="certiDirector" id="certiDirector" maxlength="12" value="<%=util.getStr(dataMap.get("CERTI_DIRECTOR"))%>"/></td>
								</tr>
								</tbody>
							</table>
							</td>
						</tr>
					</tbody>
				</table>

</form>
			  <div class="btn_box" >

						<div class="btn_right_box" >
							<input class="btn_inp_b_01" type="button" onclick="submitGo();" value="수정">
							<input class="btn_inp_w_01" type="button" onclick="pageViewGo()" value="이전">
						</div>
			 </div>
			</div>
</div>
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
//		showOn : "both",
//		buttonImage: "button.png",

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

	// 신청기간  시작일 값에 따른 종료일 선택 값 제한
	$('#eduOrdStDt').datepicker("option", "maxDate", $("#eduOrdEdDt").val());
	$('#eduOrdStDt').datepicker("option", "onClose", function ( selectedDate ) {
		$("#eduOrdEdDt").datepicker( "option", "minDate", selectedDate );
	});

	// 신청기간 종료일 값에 따른 시작일 선택 값 제한
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

	<%if(loginVO.getAuthLv().equals("99")){ %>
	$("#eduState").change(function(){
	    if($(this).val()=='30'){
	    	$('#rejectTr').show();
	    }else{
	    	$('#rejectTr').hide();
	    }
	});
	<%}%>


	///////////////
});
	function pageViewGo(){
		$('#mode').val('view');
		$('#fwrite').attr("action","./sys_edu.do");
		$('#fwrite').submit();
	}
	function pageDelGo(){
		if(confirm("삭제하시겠습니까?")){
			$('#mode').val('del');
			$('#fwrite').attr("action","./sys_edu.do");
			$('#fwrite').submit();
		}
	}

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

</script>



<script type="text/javascript">


var korPattern = /[가-힣]/;
var onlyKorPattern = /[^가-힣]/;
var engPattern = /[a-zA-Z]/;
var numPattern = /[\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
var telPattern = /^\d{2,3}\-\d{3,4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;
	//////////////////검색관련

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
			center: new daum.maps.LatLng(<%=dataMap.get("MAP_X")%>, <%=dataMap.get("MAP_Y")%>), // 지도의 중심좌표
			level: 5 // 지도의 확대 레벨
		};

	//지도를 미리 생성
	var map = new daum.maps.Map(mapContainer, mapOption);
	//주소-좌표 변환 객체를 생성
	var geocoder = new daum.maps.services.Geocoder();
	//마커를 미리 생성
	var marker = new daum.maps.Marker({
		position: new daum.maps.LatLng(<%=dataMap.get("MAP_X")%>, <%=dataMap.get("MAP_Y")%>),
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

function orgInfo(orgGrpCd){
	var result = "";
	var params = {
			"orgGrpCd": orgGrpCd
	};
	$.post("/sys/getOrgInfo.do",$.param(params),
	function(data){
		$("#orgGrpCd").val(orgGrpCd);
		$("#orgGrpNm").val(data.dataMap.ORG_GRP_NM);
		$("#eduPlace").val(data.dataMap.ADDR1);
		$("#eduPlaceDetail").val(data.dataMap.ADDR2);
		$("#mapX").val(data.dataMap.MAP_X);
		$("#mapY").val(data.dataMap.MAP_Y);
		$("#eduTel").val(data.dataMap.CORP_PHONE);

        //geocoder.addr2coord(data.dataMap.ADDR1, function(status, result) {
            // 정상적으로 검색이 완료됐으면
//            if (status === daum.maps.services.Status.OK) {
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
</script>
<%}%>
<script type="text/javascript">

function submitGo(){

	var errMsg = "";
	if($("#eduNm").val()==null || $("#eduNm").val()==""){
		errMsg+="교육명 : 필수입력사항입니다."+"<br/>";
	}
	if($("#eduCur").val()==null || $("#eduCur").val()==""){
		errMsg+="교육과정 : 필수입력사항입니다."+"<br/>";
	}
	/*
	if($("#eduCateCd > option:selected").val()==null || $("#eduCateCd > option:selected").val()==""){
		errMsg+="교육분류 : 필수입력사항입니다."+"<br/>";
	}*/
	<%if(loginVO.getAuthLv().equals("99")){ %>
	if($("#eduState > option:selected").val()==null || $("#eduState > option:selected").val()==""){
		errMsg+="교육신청상태 : 필수입력사항입니다."+"<br/>";
	}else if($("#eduState > option:selected").val()=="30"){
		if($("#eduReject").val()==null || $("#eduCateCd > option:selected").val()==""){
			errMsg+="반려내용 : 필수입력사항입니다."+"<br/>";
		}
	}

	if($("#orgGrpNm").val()==null || $("#orgGrpNm").val()==""){
		errMsg+="교육기관 : 필수입력사항입니다."+"<br/>";
	}
	<%} %>
	if($("#eduOrdStDt").val()==null || $("#eduOrdStDt").val()==""){
		errMsg+="신청기간 : 필수입력사항입니다."+"<br/>";
	}else if($("#eduOrdEdDt").val()==null || $("#eduOrdEdDt").val()==""){
		errMsg+="신청기간 : 필수입력사항입니다."+"<br/>";
	}

	if($("#eduStDt").val()==null || $("#eduStDt").val()==""){
		errMsg+="교육기간 : 필수입력사항입니다."+"<br/>";
	}else if($("#eduEdDt").val()==null || $("#eduEdDt").val()==""){
		errMsg+="교육기간 : 필수입력사항입니다."+"<br/>";
	}

	if($("#eduTime").val()==null || $("#eduTime").val()==""){
		errMsg+="안내사항 : 필수입력사항입니다."+"<br/>";
	}


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
		errMsg+="사용여부 : 필수입력사항입니다."+"<br/>";
	}

	if($("#eduUserSector").val()==null || $("#eduUserSector").val()==""){
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
	}

	if($("#operPsnNm").val()==null || $("#operPsnNm").val()==""||$("#equUserIdx").val()==null || $("#equUserIdx").val()==""){
		errMsg+="교육문의 : 필수입력사항입니다."+"<br/>";
	}
	if($("#eduTel").val()==null || $("#eduTel").val()==""){
		errMsg+="전화번호 : 필수입력사항입니다."+"<br/>";
	}else if(!telPattern.test($('#eduTel').val())){
		errMsg+="전화번호 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
	}
	if(errMsg==""){

		if(confirm("수정하시겠습니까?")){
		$("#mode").val("edit");
		$("#fwrite").attr('method','post');
		$('#fwrite').attr("action","./jnspEduProc.do");
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

			function fileSet(fileCnt){
				if($('#fileFlog_'+fileCnt).is(':checked')){
					$('#fileBox_'+fileCnt).show();
				}else{
					$('#fileBox_'+fileCnt).hide();
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