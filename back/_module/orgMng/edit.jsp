<%@ page import="ucar.nc2.util.xml.Parse"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>

<%
	String display = "sub";
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	String fileGrp = "orgManage";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, String>> companyType = request.getAttribute("companyType") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("companyType");
	ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");
	ArrayList<HashMap<String, String>> agencyType = request.getAttribute("agencyType") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyType");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));


	String labX = util.getStr(dataMap.get("LAB_MAP_X")) == null ? "35.2268795" : util.getStr(dataMap.get("LAB_MAP_X"));
	String labY = util.getStr(dataMap.get("LAB_MAP_Y")) == null ? "126.8429492" : util.getStr(dataMap.get("LAB_MAP_Y"));

	if(util.getStr(dataMap.get("LAB_MAP_X")).length() == 0) {
		labX = "35.2268795";
	}
	if(util.getStr(dataMap.get("LAB_MAP_Y")).length() == 0) {
		labY = "126.8429492";
	}

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
.required{
color:red;
font-size:15px;
vertical-align:middle;
}
</style>
<div id = "bgLayer" onclick="dataCheckExit();"></div>
<div id="dataCheck"></div>
<form id="fwrite" name="fwrite" method="post" action="/sys/sysOrgManageProc.do" enctype="multipart/form-data" >
	<input type="hidden" id="mode" name="mode" value="edit" />
	<input type="hidden" id="orgGrpCd" name="orgGrpCd" value="<%=util.getStr(dataMap.get("ORG_GRP_CD"))%>" />
	<input type="hidden" id="num1" name="userIdx" maxlength="15" value="">
	<input type="hidden" id="num2" name="userIdxPre" maxlength="15" value="<%=util.getStr(dataMap.get("USER_IDX"))%>">
	<input type="hidden" name="authCd" value="2" />
	<div class="clear_wrap">
		<div class="left_box w75">

			<div class="both">
				<div class="fr">
					<h3>
						기업/기관 수정
						<span style="float:right; color:red; font-size:10pt;"> * 필수 입력사항입니다.</span>
					</h3>
					<!-- 기본정보영역 -->
					<table class="skin_basic_write">
						<colgroup>
							<col style="width: 20%;" />
							<col style="width: 30%;" />
							<col style="width: 20%;" />
							<col style="width: 30%;" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><label for="orgType1"><span class="required">*</span>기업/기관구분</label></th>
								<td colspan="3">
									<label><input type="radio" id="orgType1" name="orgType" value="1" <%=util.getStr(dataMap.get("ORG_TYPE")).equals("1")? "checked='checked'; " : ""%>/>기업</label>
									<label><input type="radio" id="orgType2" name="orgType" value="2" <%=util.getStr(dataMap.get("ORG_TYPE")).equals("2")? "checked='checked'" : ""%>/>기관/센터</label>
								</td>
							</tr>
							<tr id="companyType" <%if(!util.getStr(dataMap.get("ORG_TYPE")).equals("1")) { %> style="display: none;" <% } %>>
								<th scope="col"><span class="required">*</span>기업분류</th>
								<td colspan="3">
								<%for(HashMap rs : companyType) { %>
									<label></label><input type="radio" name="companyType" value="<%=rs.get("CODE_CD") %>" <%if(util.getStr(dataMap.get("COMPANY_TYPE_CD")).equals(util.getStr(rs.get("CODE_CD")))) { %> checked="checked" <% } %> /><%=rs.get("CODE_NM") %></label>
								<% } %>
								</td>
							</tr>
							<tr id="agencyType" <%if(!util.getStr(dataMap.get("ORG_TYPE")).equals("2")) { %> style="display: none;" <% } %>>
								<th scope="col"><span class="required">*</span>기관분류</th>
								<td colspan="3">
								<%for(HashMap rs : agencyType) { %>
									<label><input type="radio" name="agencyType" value="<%=rs.get("CODE_CD") %>" <%if(util.getStr(dataMap.get("AGENCY_TYPE")).equals(util.getStr(rs.get("CODE_CD")))) { %> checked="checked" <% } %> /><%=rs.get("CODE_NM") %></label>
								<% } %>
								</td>
							</tr>
							<tr>
								<th scope="col">
									<label for="orgGrpNm"><span class="required">*</span>기업/기관명(국문)</label>
								</th>
								<td scope="col" id="orgTd1" colspan="3"><input type="text" class="inp_text" id="orgGrpNm" name="orgGrpNm"  value="<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>" maxlength="30" size="30" style="width:90%;"/></td>
								<th scope="col" id="orgTd2" style="display: none;"><label for="orgEngNm">기관명(영문)</label></th>
								<td scope="col" id="orgTd3" style="display: none;"><input type="text" class="inp_text" id="orgEngNm" name="orgEngNm" value="<%=util.getStr(dataMap.get("ORG_ENG_NM")) %>" maxlength="30" size="30" style="width:90%;"/></td>
							</tr>
							<%--
							<tr>
								<th scope="col"><label for="orgGrpNm"><span class="required">*</span>기관명</label></th>
								<td scope="col"><input type="text" id="orgGrpNm" name="orgGrpNm" maxlength="30" size="30" value="<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>"></td>
								<th scope="col" <%if(util.getStr(dataMap.get("ORG_TYPE")).equals("1")) { %> style="display: none;" <% } %> id="orgEngNmLine"><label for="orgEngNm">기관명(영문)</label></th>
								<td scope="col" id="orgEngNmILine" <%if(util.getStr(dataMap.get("ORG_TYPE")).equals("1")) { %> style="display: none;" <% } %> ><input type="text" class="inp_text" id="orgEngNm" name="orgEngNm" maxlength="30" size="30" value="<%=util.getStr(dataMap.get("ORG_ENG_NM")) %>"></td>
							</tr>
							--%>
							<%--160826수정 <tr id="authCdTr" <%=!util.getStr(dataMap.get("ORG_TYPE")).equals("2") ? "style='display:none'":"" %>> --%>
							<tr id="authOrgSiteTr"  >
								<th scope="col"><label for="authOrgSite1"><span class="required">*</span>권한/관리사이트</label></th>
								<td colspan="3">
									전남연구장비정보망 :
									<label><input type="radio" id="authOrgSite1_Y" name="authOrgSite1" value="Y" <%=util.getStr(dataMap.get("AUTH_ORG_SITE_1")).equals("Y")? "checked='checked'": ""%>/>Y</label>
									<label><input type="radio" id="authOrgSite1_N" name="authOrgSite1" value="N" <%=util.getStr(dataMap.get("AUTH_ORG_SITE_1")).equals("N")? "checked='checked'": ""%>/>N</label>
									<br/>
									전남지식재산정보은행 :
									<label><input type="radio" id="authOrgSite2_Y" name="authOrgSite2" value="Y" <%=util.getStr(dataMap.get("AUTH_ORG_SITE_2")).equals("Y")? "checked='checked'": ""%>/>Y</label>
									<label><input type="radio" id="authOrgSite2_N" name="authOrgSite2" value="N" <%=util.getStr(dataMap.get("AUTH_ORG_SITE_2")).equals("N")? "checked='checked'": ""%>/>N</label>
									<br/>
									전남과학기술정보시스템 :
									<label><input type="radio" id="authOrgSite3_Y" name="authOrgSite3" value="Y" <%=util.getStr(dataMap.get("AUTH_ORG_SITE_3")).equals("Y")? "checked='checked'": ""%>/>Y</label>
									<label><input type="radio" id="authOrgSite3_N" name="authOrgSite3" value="N" <%=util.getStr(dataMap.get("AUTH_ORG_SITE_3")).equals("N")? "checked='checked'": ""%>/>N</label>
								</td>
							</tr>
							<tr>
								<th scope="col"><label for="applyCd">신청상태</label></th>
								<td colspan="3">
									<select class="select_box" id="applyCd" name="applyCd">
										<option value="10" <%=util.getStr(dataMap.get("APPLY_CD")).equals("10")?"selected='selected'":"" %>>신청</option>
										<option value="20" <%=util.getStr(dataMap.get("APPLY_CD")).equals("20")?"selected='selected'":"" %>>승인</option>
										<option value="30" <%=util.getStr(dataMap.get("APPLY_CD")).equals("30")?"selected='selected'":"" %>>반려</option>
									</select>
								</td>
							</tr>
							<tr id="applyRejectTr" <%=!util.getStr(dataMap.get("APPLY_CD")).equals("30")?"style='display:none'":"" %>>
								<th>반려내용</th>
								<td colspan="3"><textarea cols="50" rows="4" maxlength="500" name="applyReject" maxlength="500" style="width:100%;"><%=util.getStr(dataMap.get("APPLY_REJECT"))%></textarea></td>
							</tr>
							<tr>
								<th scope="col"><label for="areaCd1"><span class="required">*</span>소속지역</label></th>
								<td colspan="3">
									<label>
										<input type="radio" id="areaCd1" name="areaCd" value="1" <%=util.getStr(dataMap.get("AREA_CD")).equals("1")? "checked='checked'": ""%>/>전라남도
									</label>
									<%if(util.getStr(dataMap.get("AREA_CD")).equals("1")) { %>
										<select class="select_box" id='area' name='area'>
										<%for(HashMap rs : areaList) { %>
											<option value="<%=util.getStr(rs.get("CODE_CD")) %>" <%if(util.getStr(dataMap.get("AREA_LOCATION_CD")).equals(util.getStr(rs.get("CODE_CD")))) { %> selected="selected" <% } %> ><%=rs.get("CODE_NM") %></option>
										<% } %>
										</select>
									<% } %>
									<label>
										<input type="radio" id="areaCd1" name="areaCd" value="2" <%=util.getStr(dataMap.get("AREA_CD")).equals("2")? "checked='checked'": ""%>/>지역 외
									</label>
									<%if(util.getStr(dataMap.get("AREA_CD")).equals("2")) { %>
										<select class="select_box" id='otherAreaCd' name='otherAreaCd'>
										<%for(HashMap rs : areaList) { %>
											<option value="<%=util.getStr(rs.get("CODE_CD")) %>" <%if(util.getStr(dataMap.get("OTHER_AREA_CD")).equals(util.getStr(rs.get("CODE_CD")))) { %> selected="selected" <% } %> ><%=rs.get("CODE_NM") %></option>
										<% } %>
										</select>
									<% } %>
								</td>
							</tr>
							<tr>
								<th scope="col"><label for="ornerNm">대표자명</label></th>
								<td colspan="3"><input type="text" class="inp_text" id="ornerNm" name="ornerNm" maxlength="10" value="<%=util.getStr(dataMap.get("ORNER_NM"))%>" style="width:35%;"/></td>
							</tr>
							<tr id="corpTr1" <%if(util.getStr(dataMap.get("ORG_TYPE")).equals("1")) {%>style="display:none;"<%}%>>
								<th scope="col"><label for="corpNum1"><span class="required">*</span>사업자등록번호</label></th>
								<td scope="col" colspan="3"><input type="text" class="inp_text" id="corpNum1" name="corpNum1" maxlength="20" value="<%=util.getStr(dataMap.get("CORP_NUM_1"))%>" style="width:260px;"/></td>
							</tr>
							<tr id="corpTr2" <%if(util.getStr(dataMap.get("ORG_TYPE")).equals("2")) {%>style="display:none;"<%}%>>
								<th scope="col"><label for="corpNum1"><span class="required">*</span>사업자등록번호</label></th>
								<td scope="col"><input type="text" class="inp_text" id="corpNum1" name="corpNum1" maxlength="20" value="<%=util.getStr(dataMap.get("CORP_NUM_1"))%>" style="width:90%;"/></td>
								<th scope="col"><label for="workType">업종</label></th>
								<td scope="col"><input type="text" class="inp_text" id="workType" name="workType" maxlength="20" value="<%=util.getStr(dataMap.get("WORK_TYPE")) %>" style="width:90%;"/></td>
							</tr>
							<tr id="corpTr3" <%if(util.getStr(dataMap.get("ORG_TYPE")).equals("1")) {%>style="display:none;"<%}%>>
								<th scope="col"><label for="corpNum2"><span class="required">*</span>법인등록번호</label></th>
								<td scope="col" colspan="3"><input type="text" class="inp_text" id="corpNum2" name="corpNum2" maxlength="20" value="<%=util.getStr(dataMap.get("CORP_NUM_2"))%>" style="width:260px;"/></td>
							</tr>
							<tr id="corpTr4" <%if(util.getStr(dataMap.get("ORG_TYPE")).equals("2")) {%>style="display:none;"<%}%>>
								<th scope="col"><label for="corpNum2"><span class="required">*</span>법인등록번호</label></th>
								<td scope="col"><input type="text" class="inp_text" id="corpNum2" name="corpNum2" maxlength="20" value="<%=util.getStr(dataMap.get("CORP_NUM_2"))%>" style="width:90%;"/></td>
								<th scope="col"><label for="businessCon">업태</label></th>
								<td scope="col"><input type="text" class="inp_text" id="businessCon" name="businessCon" maxlength="20" value="<%=util.getStr(dataMap.get("BUSINESSCON")) %>" style="width:90%;"/></td>
							</tr>

							<tr>
								<th scope="col"><label for="corpPhone"><span class="required">*</span>대표전화</label></th>
								<td ><input type="text" class="inp_text" id="corpPhone" name="corpPhone" maxlength="20" value="<%=util.getStr(dataMap.get("CORP_PHONE"))%>" style="width:90%;"/></td>
								<th scope="col"><label for="corpFax"><span class="required">*</span>FAX번호</label></th>
								<td ><input type="text" class="inp_text" id="corpFax" name="corpFax" maxlength="20" value="<%=util.getStr(dataMap.get("CORP_FAX"))%>" style="width:90%;"/></td>
							</tr>
							<tr>
								<th scope="col"><label for="homepage">홈페이지</label></th>
								<td colspan="3"><input type="text" class="inp_text" id="homepage" name="homepage" maxlength="50" value="<%=util.getStr(dataMap.get("HOMEPAGE"))%>" style="width:35%;"/></td>
							</tr>
							<tr>
								<th scope="col"><label for="addr1"><span class="required">*</span>주소</label></th>
								<td colspan="3">
									<input type="text" class="inp_text" id="zipcode" name="zipcode" maxlength="10" readonly="readonly" value="<%=util.getStr(dataMap.get("ZIPCODE"))%>">
									<input type="text" class="inp_text" id="addr1" name="addr1" maxlength="50" size="50" readonly="readonly" style="width:37%;" value="<%=util.getStr(dataMap.get("ADDR1"))%>">
									<input type="button" id = "orgPostButton" value="찾아보기" class="btn_inp_g_01" onclick = "orgPost()" />
								</td>
							</tr>
							<tr>
								<th scope="col"><label for="addr2"><span class="required">*</span>상세주소</label></th>
								<td colspan="3"><input type="text" class="inp_text" id="addr2" name="addr2" maxlength="50" size="50" value="<%=util.getStr(dataMap.get("ADDR2"))%>" style="width:100%;"/></td>
							</tr>
							<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ){ %>
								<tr  id="userIdxTr" <%=!util.getStr(dataMap.get("ORG_TYPE")).equals("2") ? "style='display:none'":"" %>>
									<th scope="col"><label for="name">기관관리자</label></th>
									<td colspan="3">
										<input type="text" class="inp_text" id="name" name="name"  maxlength="15" value="<%=util.getStr(dataMap.get("PSN_NM"))%>" style="width:17%;" readonly/>
										<input type="button" name="userData" id="userData" value="기관관리자조회" onclick="popupWindow('userList')" class="btn_inp_g_01">
									</td>
								</tr>
							<% } %>
							
							<tr>
								<th scope="col"><label for="mapX">지도</label></th>
								<td colspan="3">
									<input type="hidden" id="mapX" name="mapX" maxlength="20" value="<%=util.getStr(dataMap.get("MAP_X"))%>">
									<input type="hidden" id="mapY" name="mapY" maxlength="20" value="<%=util.getStr(dataMap.get("MAP_Y"))%>">
									<div id="map" style="width:100%;height:300px;margin-top:5px;"></div>
								</td>
							</tr>
							<tr>
								<th scope="col"><label for="orgNote1">소개</label></th>
								<td colspan="3"><textarea id="orgNote1" name="orgNote1" cols="50" rows="4" maxlength="500" style="width:100%;"><%=util.getStr(dataMap.get("ORG_NOTE_1"))%></textarea></td>
							</tr>
							<tr>
								<th scope="col"><label for="<%=fileFullGrp%>File1">기업/기관 소개자료</label></th>
								<td colspan="3">
								<% if(util.getStr(String.valueOf(dataMap.get("ORG_FILE_ID"))).equals("")){%>
									<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
									<input type="hidden" name="fileSn"  value="1" />
									<br/><span class="required" style="color: red;">PDF 확장자 파일만 업로드가능합니다.</span>
								<%}else{%>
									<ul class="file" style="line-height: 22px;">
										<li class="text">
											<input type="hidden" name="fileSn"  value="1" />
											<input type="checkbox" name="fileFlog" id="fileFlog_1"
													value="<%=util.getStr(String.valueOf(dataMap.get("ORG_FILE_ID")))%>" onclick="fileSet('1')" /> &nbsp;
											<label for="fileFlog_1">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;
											<%=util.getStr(dataMap.get("ORG_FILE_INFO_TITLE_ORG")) %>

										</li>
									</ul>
									<div id="fileBox_1" style="display:none">
										<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부"  />
									</div>
								<%}%>

								</td>
							</tr>
							<tr id="bizRegDocFileTr" style="dispaly:none;">
								<th scope="col"><label for="bizRegDocFile1">사업자등록증</label></th>
								<td colspan="3">
								<% if(util.getStr(String.valueOf(dataMap.get("BIZ_REG_DOC_FILE_ID"))).equals("")){%>
									<input type="file" name="bizRegDocFile1"  id="bizRegDocFile1"  title="파일첨부" />
									<input type="hidden" name="fileSn" value="1"/>
									<br/><span class="required" style="color: red;">PDF, jpg 확장자 파일만 업로드가능합니다.</span>
								<% } else { %>
								<ul class="file" style="line-height:22px;">
									<li class="text">
										<input type="hidden" name="fileSn" value="4" />
										<input type="checkbox" name="fileFlog" id="fileFlog_4" value="<%=util.getStr(String.valueOf(dataMap.get("BIZ_REG_DOC_FILE_ID"))) %>" onclick="fileSet('4')" /> &nbsp;
										<label for="fileFlog_4">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;
										<%=util.getStr(dataMap.get("BIZ_REG_DOC_FILE_TITLE")) %>
									</li>
								</ul>
								<div id="fileBox_4" style="display:none">
									<input type="file" name="bizRegDocFile1" id="bizRegDocFile1" title="파일첨부" />
								</div>
								<% } %>
								</td>
							</tr>
							<tr>
								<th scope="col"><label for="orgCiFile1">CI이미지</label></th>
								<td colspan="3">
								<% if(util.getStr(String.valueOf(dataMap.get("CI_FILE_ID"))).equals("")){%>
								<input type="file" name="orgCiFile1"  id="orgCiFile1"  title="파일첨부" />
								<input type="hidden" name="fileSn"  value="2" />
								<br/><span class="required">150*50 픽셀 크기의 이미지(bmp, gif, jpg, jpeg, png)를 등록해 주세요.</span>
								<%}else{%>
								<ul class="file" style="line-height: 22px;">
									<li class="text">
										<input type="hidden" name="fileSn"  value="2" />
										<input type="checkbox" name="fileFlog" id="fileFlog_2"
												value="<%=util.getStr(String.valueOf(dataMap.get("CI_FILE_ID")))%>" onclick="fileSet('2')" /> &nbsp;
										<label for="fileFlog_2">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;

										<img class='ci_img' src="<%=util.getStr(dataMap.get("CI_FILE_SRC"))%>" alt='<%=util.getStr(dataMap.get("CI_FILE_TITLE")) %>' style='width:150px;height:50px'/>
									</li>
								</ul>
								<div id="fileBox_2" style="display:none">
									<input type="file" name="orgCiFile1"  id="orgCiFile1"  title="파일첨부"  />
									<br/><span class="required">150*50 픽셀 크기의 이미지(bmp, gif, jpg, jpeg, png)를 등록해 주세요.</span>
								</div>
								<%}%>
								</td>
							</tr>
							<tr id="labUse" <%if(!util.getStr(dataMap.get("ORG_TYPE")).equals("1")) { %> style="display: none;" <% } %>>
								<th scope="col"><label for="labUse1"><span class="required">*</span>연구소 유무</label></th>
								<td colspan="3">
									<label><input type="radio" id="labUse1" name="labUse" value="Y" <%if(util.getStr(dataMap.get("LAB_USE_YN")).equals("Y")) { %> checked="checked" <% } %>/>유</label>
									<label><input type="radio" id="labUse2" name="labUse" value="N" <%if(util.getStr(dataMap.get("LAB_USE_YN")).equals("N")) { %> checked="checked" <% } %>/>무</label>
								</td>
							</tr>
							<tr id="labNameLine" <%if(!util.getStr(dataMap.get("LAB_USE_YN")).equals("Y")) { %> style="display:none;" <% } %>>
								<th scope="col"><label for="labName">연구소 이름</label></th>
								<td colspan="3"><input type="text" class="inp_text" id="labName" name="labName" maxlength="100" value="<%=util.getStr(dataMap.get("LAB_NM")) %>" style="width:100%;"/></td>
							</tr>
							<tr id="labFaxLine" <%if(!util.getStr(dataMap.get("LAB_USE_YN")).equals("Y")) { %> style="display:none;" <% } %>>
								<th scope="col"><label for="labPhone">연구소 전화번호</label></th>
								<td scope="col"><input type="text" class="inp_text" id="labPhone" name="labPhone" maxlength="20" value="<%=util.getStr(dataMap.get("LAB_PHONE")) %>" style="width:90%;"/></td>
								<th scope="col"><label for="labFax">연구소 FAX</label></th>
								<td scope="col"><input type="text" class="inp_text" id="labFax" name="labFax" maxlength="20" value="<%=util.getStr(dataMap.get("LAB_FAX")) %>" style="width:90%;"/></td>
							</tr>
							<tr id="labAddr1Line" <%if(!util.getStr(dataMap.get("LAB_USE_YN")).equals("Y")) { %> style="display:none;" <% } %>>
								<th scope="col"><label for="labAddr1">연구소 주소</label></th>
								<td colspan="3">
									<input type="text" class="inp_text" id="labZipcode" name="labZipcode" maxlength="10" value="<%=util.getStr(dataMap.get("LAB_ZIPCODE")) %>" readonly="readonly">
									<input type="text" class="inp_text" id="labAddr1" name="labAddr1" maxlength="50" size="50" value="<%=util.getStr(dataMap.get("LAB_ADDR1")) %>" readonly="readonly">
									<input type="button" id = "orgPostButton" value="찾아보기" class="btn_inp_g_01" onclick = "labPost()" />
								</td>
							</tr>
							<tr id="labAddr2Line" <%if(!util.getStr(dataMap.get("LAB_USE_YN")).equals("Y")) { %> style="display:none;" <% } %>>
								<th scope="col"><label for="labAddr2">연구소 상세주소</label></th>
								<td colspan="3"><input type="text" class="inp_text" id="labAddr2" name="labAddr2" maxlength="50" size="50" value="<%=util.getStr(dataMap.get("LAB_ADDR2")) %>" style="width:100%;"/></td>
							</tr>
							<tr id="labMapLine" <%if(!util.getStr(dataMap.get("LAB_USE_YN")).equals("Y")) { %> style="display:none;" <% } %>>
								<th scope="col"><label for="labMapX">연구소 지도</label></th>
								<td colspan="3">
									<input type="hidden" class="inp_text" id="labMapX" name="labMapX" maxlength="20" value="<%=util.getStr(dataMap.get("LAB_MAP_X")) %>">
									<input type="hidden" class="inp_text" id="labMapY" name="labMapY" maxlength="20" value="<%=util.getStr(dataMap.get("LAB_MAP_Y")) %>">
									<div id="labMap" style="width:100%;height:300px;margin-top:5px;"></div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			</div>
			<div class="btn_box">
				<div class="btn_left_box"></div>
				<div class="btn_right_box">
					<button class="btn_inp_b_01" type="button" onclick="submitGo()">수정</button>
					<button class="btn_inp_b_01" type="button" onclick="pageDelGo()">삭제</button>
					<button class="btn_inp_w_01" type="button" onclick="pageViewGo()">목록</button>
				</div>
			</div>
		</div>
</form>

<script type="text/javascript">
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

		var popUrl="/sys/popup/"+listMode+".do";
		var popOption="width=550, height=550, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,"",popOption);
	}

	function pageViewGo() {
		$('#mode').val('view');
		$('#fwrite').attr("action", "/sys/sys_org_manage.do");
		$('#fwrite').submit();
	}

	function pageDelGo() {
		if (confirm("삭제하시겠습니까?")) {
			$('#mode').val('del');
			$('#fwrite').submit();
		}
	}
	//////////////////검색관련

	function orgPost(){
	    new daum.Postcode({
	        oncomplete: function(data) {

	             $("#zipcode").val(data.zonecode);
	             $("#addr1").val(data.address);
	             $("#addr2").focus();

	             if(data.address.indexOf("전남")>-1||data.address.indexOf("광주")>-1){
	            	 $('input:radio[name=areaCd]:input[value=1]').attr("checked", "checked");
	             }else{
	            	 $('input:radio[name=areaCd]:input[value=2]').attr("checked", "checked");
	            	}

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
	                           console.log(result.addr[0].lat);
	                           

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
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
	<% if( !util.getStr(dataMap.get("MAP_X")).equals("") && !util.getStr(dataMap.get("MAP_Y")).equals("") ){ %>
   var mapContainer = document.getElementById('map'), // 지도를 표시할 div
	mapOption = {
		center : new daum.maps.LatLng(
		<%=util.getStr(dataMap.get("MAP_X"))%>
		,
		<%=util.getStr(dataMap.get("MAP_Y"))%>
		), // 지도의 중심좌표
		level : 5 // 지도의 확대 레벨
	};
   

	//지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
	//마커를 미리 생성
	var marker = new daum.maps.Marker({
		position : new daum.maps.LatLng(<%=util.getStr(dataMap.get("MAP_X"))%>, <%=util.getStr(dataMap.get("MAP_Y"))%>
	),
		map : map
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
     <% } //지도 실행 조건 해제 %>

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


      //연구소 지도
     var labMapContainer = document.getElementById('labMap'), // 지도를 표시할 div
     labMapOption = {
         center : new daum.maps.LatLng(
		<%=labX%>
			,
		<%=labY%>
			), // 지도의 중심좌표
				level : 5
			// 지도의 확대 레벨
     };

	 //지도를 미리 생성
	 var labMap = new daum.maps.Map(labMapContainer, labMapOption);
	 //주소-좌표 변환 객체를 생성
	 var labGeocoder = new daum.maps.services.Geocoder();
	 //마커를 미리 생성
	 var labMarker = new daum.maps.Marker({
	     position : new daum.maps.LatLng(<%=labX%>, <%=labY%>),
	     map: labMap
	 });
	 daum.maps.event.addListener(labMap, 'click', function(mouseEvent) {
	        searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
	             if (status === daum.maps.services.Status.OK) {

	                   // 클릭한 위도, 경도 정보를 가져옵니다
	                   var latlng = mouseEvent.latLng;
	                   // 마커 위치를 클릭한 위치로 옮깁니다
	                   labMarker.setPosition(latlng);
	                   //페이지에 값 넣어주기(상세주소, X좌표, Y좌표)
	                //$("#location").val(result[0].jibunAddress.name);
	                   $("#labMapX").val(latlng.getLat());
	                $("#labMapY").val(latlng.getLng());

	                labMarker.setMap(labMap);

	             }
	        });
	  });

     function labPost(){
	    new daum.Postcode({
	        oncomplete: function(data) {

	             $("#labZipcode").val(data.zonecode);
	             $("#labAddr1").val(data.address);
	             $("#labAddr2").focus();

	             if(data.address.indexOf("전남")>-1||data.address.indexOf("광주")>-1){
	            	 $('input:radio[name=areaCd]:input[value=1]').attr("checked", "checked");
	             }else{
	            	 $('input:radio[name=areaCd]:input[value=2]').attr("checked", "checked");
	            	}

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
	                labGeocoder.addr2coord(data.address, function(status, result) {
	                    // 정상적으로 검색이 완료됐으면
	                    if (status === daum.maps.services.Status.OK) {
	                        // 해당 주소에 대한 좌표를 받아서
	                        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
	                           $("#labMapX").val(result.addr[0].lat);
	                           $("#labMapY").val(result.addr[0].lng);
	                        // 지도를 보여준다.
	                        labMapContainer.style.display = "block";
	                        labMap.relayout();
	                        // 지도 중심을 변경한다.
	                        labMap.setCenter(coords);
	                        // 마커를 결과값으로 받은 위치로 옮긴다.
	                        labMarker.setPosition(coords)
	                    }
	                });

	        }
	    }).open();
	}

 	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
     daum.maps.event.addListener(labMap, 'idle', function() {
           searchAddrFromCoords(labMap.getCenter(), displayCenterInfo);
     });


     var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
     var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;
			function submitGo(){

					var errMsg = "";

					if(!$("input[type=radio][name='orgType']").is(":checked")){
						errMsg+="기관구분 : 필수입력사항입니다."+"<br/>";
					}
					if( $("input[type=radio][name='orgType']:checked").val() == "1" ){
						if(!$("input[type=radio][name='companyType']").is(":checked")){
							errMsg+="기업분류 : 필수입력사항입니다."+ "<br/>";
						}
					}
					if( $("input[type=radio][name='orgType']:checked").val() == "2" ){
						if(!$("input[type=radio][name='agencyType']").is(":checked")){
							errMsg+="기관분류 : 필수입력사항입니다."+ "<br/>";
						}
					}
					
					/* 
					
					if($("input[type=radio][name='authCd']:checked").val()==2){
						if(!$("input[type=radio][name='authOrgSite1']").is(":checked")||
						   !$("input[type=radio][name='authOrgSite2']").is(":checked")||
						   !$("input[type=radio][name='authOrgSite3']").is(":checked"))
						{
							errMsg+="권한/관리사이트 : 필수입력사항입니다."+"<br/>";
						}
					} */

					if($("#orgGrpNm").val()==null || $("#orgGrpNm").val()==""){
						errMsg+="기관명 : 필수입력사항입니다."+"<br/>";
					}
					if(!$("input[type=radio][name='areaCd']").is(":checked")){
						errMsg+="소속지역 : 필수입력사항입니다."+"<br/>";
					}
					if($("#ornerNm").val()==null || $("#ornerNm").val()==""){
						errMsg+="대표자명 : 필수입력사항입니다."+"<br/>";
					}
					if($("#corpNum1").val()==null || $("#corpNum1").val()==""){
						errMsg+="사업자등록번호 : 필수입력사항입니다."+"<br/>";
					}
					if($("#corpNum2").val()==null || $("#corpNum2").val()==""){
						errMsg+="법인등록번호 : 필수입력사항입니다."+"<br/>";
					}
					if($("#corpPhone").val()==null || $("#corpPhone").val()==""){
						errMsg+="대표전화번호 : 필수입력사항입니다."+"<br/>";
					}else if(!telPattern.test($('#corpPhone').val())){
						errMsg+="대표전화번호 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
					}
					if($("#corpFax").val()==null || $("#corpFax").val()==""){
						errMsg+="대표FAX번호 : 필수입력사항입니다."+"<br/>";
					}else if(!telPattern.test($('#corpFax').val())){
						errMsg+="대표FAX번호 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
					}
					/* if($("#homepage").val()==null || $("#homepage").val()==""){
						errMsg+="홈페이지 : 필수입력사항입니다."+"<br/>";
					} */
					if($("#addr1").val()==null || $("#addr1").val()==""||$("#zipcode").val()==null || $("#zipcode").val()==""){
						errMsg+="기관주소 : 필수입력사항입니다."+"<br/>";
					}
					if($("#addr2").val()==null || $("#addr2").val()==""){
						errMsg+="기관상세주소 : 필수입력사항입니다."+"<br/>";
					}

					/* if($("input[type=radio][name='orgType']:checked").val()==2){
						if($("#name").val()==null || $("#name").val()==""){
							errMsg+="기관관리자 : 필수입력사항입니다."+"<br/>";
						}
					} */

					if($("#mapX").val()==null || $("#mapX").val()==""){
						errMsg+="지도(X좌표) : 필수입력사항입니다."+"<br/>";
					}

					if($("#mapY").val()==null || $("#mapY").val()==""){
						errMsg+="지도(Y좌표) : 필수입력사항입니다."+"<br/>";
					}


					////////////파일첨부
					var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
					var infPattern = new Array("pdf");
					var bizPattern = new Array("pdf","jpg");

					var fileName = $('#orgCiFile1').val(); //CI이미지

					/* 07.29추가 */
					var lenthFile1 = fileName.length;
					fileName = fileName.substring(lenthFile1 - 3).toLowerCase();

					if(fileName != "" && fileName != null){
						//fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase(); //07.29수정
						if(imgPattern.indexOf(fileName)==-1){
							errMsg+="CI이미지는  bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다."+"<br/>";
							//$('#orgCiFile1').val("");
						}/*else if(this.files[0].size<300000){
							alert("300kb 이상의 이미지를 등록해주세요.");
							$('#jnsptotalFile'+fileCount).val("");
						}*/
					}


					var fileName2 = $('#orgManageFile1').val(); //기업&기관 소개자료

					/* 07.29추가 */
					var lenthFile2 = fileName2.length;
					fileName2 = fileName2.substring(lenthFile2 - 3).toLowerCase();

					if(fileName2 != "" && fileName2 != null){
						//fileName2 = fileName2.slice(fileName2.indexOf(".") + 1).toLowerCase(); //07.29수정
						if(infPattern.indexOf(fileName2)==-1){
							errMsg+="기업소개자료는 PDF, 한글, 파워포인트, 워드 확장자 파일만 업로드가능합니다."+"<br/>";
							//$('#orgManageFile1').val("");
						}/*else if(this.files[0].size<300000){
							alert("300kb 이상의 이미지를 등록해주세요.");
							$('#jnsptotalFile'+fileCount).val("");
						}*/
					}


					var fileName4 = $('#bizRegDocFile1').val();//사업자등록증

					/* 07.29추가 */
					var lenthFile4 = fileName4.length;
					fileName4 = fileName4.substring(lenthFile4 - 3).toLowerCase();

					if(fileName4 != "" && fileName4 != null){
						//fileName4 = fileName4.slice(fileName4.indexOf(".") + 1).toLowerCase(); //07.29수정
						if(bizPattern.indexOf(fileName4)==-1){
							errMsg+="사업자등록증은 PDF, jpg 확장자 파일만 업로드가능합니다."+"<br/>";
							//$('#orgManageFile1').val("");
						}/*else if(this.files[0].size<300000){
							alert("300kb 이상의 이미지를 등록해주세요.");
							$('#jnsptotalFile'+fileCount).val("");
						}*/
					}


					///////////////
					if(errMsg==""){
						$('#fwrite').attr("action", "/sys/sysOrgManageProc.do");
						fwrite.submit();
					}else{
						errMsg="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + errMsg;
						errMsg="<div style='margin:20px'><h2>데이터 검증결과</h2>" + errMsg;
						errMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
						errMsg+="</div>";
						$('#dataCheck').html(errMsg);
						$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
			 			//$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
						$("#dataCheck").css("top","200px");
						$('#dataCheck,#bgLayer').show();
						return false;
					}

			}


			if($('input:radio[name=orgType]:checked').val() == '1'){
				$("#orgTd1").attr('colspan',3);
		    	$("#orgTd2").hide();
		    	$("#orgTd3").hide();
		    	$("#bizRegDocFileTr").show();
			}else{
				$("#orgTd1").attr('colspan',1);
		    	$("#orgTd2").show();
		    	$("#orgTd3").show();
		    	$("#bizRegDocFileTr").hide();
			}

			$('#applyCd').change(function(){
				if($(this).val()=='30'){
			    	$('#applyRejectTr').show();
			    }else{
			    	$('#applyRejectTr').hide();
			    }
			});

			$('#applyCd').change(function(){
				if($(this).val()=='30'){
			    	$('#applyRejectTr').show();
			    }else{
			    	$('#applyRejectTr').hide();
			    }
			});

			$('input[name="orgType"]').change(function(){
			    if($(this).val()=='1'){
			    	$('#userIdx').val("");
			    	$('#userIdxTr').hide();
			    	$('#authOrgSiteTr').hide();
			    	$('#authCdTr').hide();
			    	$('#agencyType').hide();
			    	$('#companyType').show();
			    	$('#labUse').show();
			    	$('#workTypeLine').show();
			    	$("#orgTd1").attr('colspan',3);
			    	$("#orgTd2").hide();
			    	$("#orgTd3").hide();
			    	$("#corpTr1").hide();
			    	$("#corpTr2").show();
			    	$("#corpTr3").hide();
			    	$("#corpTr4").show();
			    	$("#bizRegDocFileTr").show();
			    	//$("#orgEngNmLine").hide();
			    	//$("#orgEngNmILine").hide();
			    	$("th:contains('기관')").replaceAll("기관", "기업");
			    }else{
			    	$('#companyType').hide()
			    	$('#labUse').hide()
			    	$('#workTypeLine').hide()
			    	$('#userIdxTr').show();
			    	$('#authCdTr').show();
			    	$('#agencyType').show();
			    	$("#orgTd1").attr('colspan',1);
			    	$("#orgTd2").show();
			    	$("#orgTd3").show();
			    	$("input:radio[name=labUse]:radio[value='Y']").prop("checked", false);
			    	$("input:radio[name=labUse]:radio[value='N']").prop("checked", false);
			    	$("#corpTr1").show();
			    	$("#corpTr2").hide();
			    	$("#corpTr3").show();
			    	$("#corpTr4").hide();
			    	$("#labNameLine").hide();
					$("#labFaxLine").hide();
					$("#labAddr1Line").hide();
					$("#labAddr2Line").hide();
					$("#labMapLine").hide();
					$("#bizRegDocFileTr").hide();
			    	//$("#orgEngNmLine").show();
			    	//$("#orgEngNmILine").show();
			    	if($("input[type=radio][name='authCd']:checked").val()==2){
			    		$('#authOrgSiteTr').show();
			    	}
			    }
			});

			$('input[name="authCd"]').change(function(){
			    if($(this).val()=='1'){
			    	$("input:radio[name='authOrgSite1']").removeAttr("checked");
			    	$("input:radio[name='authOrgSite2']").removeAttr("checked");
			    	$("input:radio[name='authOrgSite3']").removeAttr("checked");
			    	$('#authOrgSiteTr').hide();
			    }else{
			    	$('#authOrgSiteTr').show();
			    }
			});

			$('input[name="areaCd"]').change(function(){
				var areaCd = $(this).val();
			    $("#area").remove();
			    $("#otherAreaCd").remove();
			    $.ajax({
			    	url : "/sys/areaList.do",
					data : {"areaCd" : $(this).val()},
					success : function(data) {
					    var tag = "";
					    if(areaCd == 1) {
					    	tag = "<select class='select_box' id='area' name='area'></select>";
					    } else {
					    	tag = "<select class='select_box' id='otherAreaCd' name='otherAreaCd'></select>";
					    }
					    $("input:radio[name='areaCd']:checked").parent().after(tag);
						for(i = 0; i < data.areaList.length; i++) {
							if(areaCd == 1) {
								$("#area").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
							} else {
								$("#otherAreaCd").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
							}
						}
					},
					error : function() {
						alert("문제가 발생하였습니다.");
					}
			    });
			});

			$('input[name="labUse"]').change(function() {
				if($(this).val() == 'Y') {
					$("#labNameLine").show();
					$("#labFaxLine").show();
					$("#labAddr1Line").show();
					$("#labAddr2Line").show();
					$("#labMapLine").show();
					var coords = new daum.maps.LatLng(35.2268795, 126.8429492);
					labMap.relayout();
					labMap.setCenter(coords);
				} else {
					$("#labNameLine").hide();
					$("#labFaxLine").hide();
					$("#labAddr1Line").hide();
					$("#labAddr2Line").hide();
					$("#labMapLine").hide();
				}
			});

			function dataCheckExit(){
				$("#bgLayer,#dataCheck").hide();
				$("#dataCheck").html("");
			}

			function fileSet(fileCnt){
				if($('#fileFlog_'+fileCnt).is(':checked')){
					$('#fileBox_'+fileCnt).show();
				}else{
					$('#fileBox_'+fileCnt).hide();
				}
			}
</script>