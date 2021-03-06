<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String list_mode = util.getStr(paramMap.get("list_mode"));
	HashMap<String,String> dataMap = new HashMap<String , String>();
	ArrayList<HashMap<String, String>> fileList = new ArrayList();
	ArrayList<HashMap<String, String>> imgfileList = new ArrayList();
	ArrayList<HashMap<String, String>> statementfileList = new ArrayList();
	ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
	ArrayList<HashMap<String, String>> areaSigunguList = request.getAttribute("areaSigunguList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaSigunguList");
	ArrayList<HashMap<String, String>> areaList = request.getAttribute("areaList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("areaList");

	if(list_mode.equals("utility")){
		dataMap = request.getAttribute("utilityData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("utilityData");
		statementfileList = request.getAttribute("statementfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("statementfileList");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	}
	if(list_mode.equals("design")){
		dataMap = request.getAttribute("designData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("designData");
		statementfileList = request.getAttribute("statementfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("statementfileList");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	}
	if(list_mode.equals("brand")){
		dataMap = request.getAttribute("brandData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("brandData");
		statementfileList = request.getAttribute("statementfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("statementfileList");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	}
	if(list_mode.equals("program")){
		dataMap = request.getAttribute("programData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("programData");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	}
	if(list_mode.equals("knowhow")){
		dataMap = request.getAttribute("knowhowData") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("knowhowData");
		imgfileList = request.getAttribute("imgfileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("imgfileList");
		fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	}

	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String siteId = util.getStr(paramMap.get("siteId"));
	String mode = util.getStr(paramMap.get("mode"));
	String idx = util.getStr(paramMap.get("idx"));
	if("".equals(mode)) mode = "edit";

	String fileGrp = "registration";
	String fileImgGrp = "registartion_img";
	String fileStatementGrp = "registartion_statement";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String fileFullImgGrp = fileImgGrp+fileSubGrp;
	String fileFullStatementGrp = fileStatementGrp+fileSubGrp;

	int cnt = 0;
	int scCnt = 0;
%>
<style type="text/css">
	#utility_list {display:none;}
	#design_list {display:none;}
	#brand_list {display:none;}
	#program_list {display:none;}
	#knowhow_list {display:none;}
</style>

<script type="text/javascript">
$(document).ready(function() {
	var skin = "<%=list_mode%>";
	$('#utility_list').css('display', 'none');
	$('#design_list').css('display', 'none');
	$('#brand_list').css('display', 'none');
	$('#program_list').css('display', 'none');
	$('#knowhow_list').css('display', 'none');
	$('#'+skin+'_list').css('display', 'block');
});
</script>

	<div id="utility_list">
	<form name="utility_fedit" 	id = "utility_fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
		<input type="hidden" 	id = "utility_mode" 		name = "mode" 		value = "<%=mode%>"/>
		<input type="hidden" 	id = "utility_idx" 			name = "idx" 		value = "<%=util.getIntStr(dataMap.get("SEARCH_PATENT_IDX"))%>"/>
		<input type="hidden" 	id = "utility_reUrl" 		name="reUrl" 		value="<%=myPage%>?mode=view&amp;list_mode=<%=list_mode%>&amp;idx=<%=idx%>" />
		<input type="hidden" 	id = "utility_list_mode" 	name="list_mode" 	value="<%=list_mode%>" />
		<input type="hidden" 	id = "utility_state" 	name = "state" 			value = "<%=util.getIntStr(dataMap.get("STATE"))%>"/>
		<input type="hidden" 	id = "utility_no" 			name = "no" 			value = "0"/>
		<input type="hidden" 	name = "area" 		value = "<%=util.getIntStr(dataMap.get("AREA"))%>"/>

		<div class="skin_bbs_write" style="margin-top: 30px">
		<h2 class="tit2">????????????</h2>
				<span style="color:red; font-size:10pt;"> * ?????? ?????????????????????.</span>
	            <table class="skin_basic_write">
				<caption>????????????</caption>
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
				<tbody>
					<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<input type="text" name="utilityAplcNo" id="utilityAplcNo" value="<%=util.getStr(dataMap.get("APLC_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" onKeyUp="NoCntCheck('utility')"  />
								<input type="hidden" name="utilityAplcNoReal" id="utilityAplcNoReal" value="<%=util.getStr(dataMap.get("APLC_NO")) %>" />
								<br/><span id = "utility_noResult"></span>
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td>
								&nbsp;&nbsp;?????? <input type="radio" name="utilityAplcNation" id="utilityAplcNationA" value="A" onclick="showNationNm('A')" <%=(util.getStr(dataMap.get("APLC_NATION"))).equals("????????????")? "checked='checked'" : "" %>>
								&nbsp;&nbsp;?????? <input type="radio" name="utilityAplcNation" id="utilityAplcNationB" value="B" onclick="showNationNm('B')" <%=(util.getStr(dataMap.get("APLC_NATION"))).equals(util.getStr(dataMap.get("APLC_NATION")))? "checked='checked'" : "" %>>
								<input type="text" name="utilityNationNm" id="utilityNationNm" value="<%=util.getStr(dataMap.get("NATION_NM")) %>" <%=(util.getStr(dataMap.get("APLC_NATION"))).equals(util.getStr(dataMap.get("APLC_NATION")))? "style='width: 50%;'" : "style='width: 50%; display:none;'" %> maxlength="100" placeholder="?????????(????????? ?????? ???)" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<input type="text" name="utilityAplcDt" id="utilityAplcDt" value="<%=util.getStr(dataMap.get("APLC_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td>
								<input type="text" name="utilityAplcUser" id="utilityAplcUser" value="<%=util.getStr(dataMap.get("APLC_USER")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????(??????)</th>
							<td>
								<input type="text" name="utilityInventionKorNm" id="utilityInventionKorNm" value="<%=util.getStr(dataMap.get("INVENTION_KOR_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="300" />
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????(??????)</th>
							<td>
								<input type="text" name="utilityInventionEngNm" id="utilityInventionEngNm" value="<%=util.getStr(dataMap.get("INVENTION_ENG_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="300" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td>
								<input type="text" name="utilityInventor" id="utilityInventor" value="<%=util.getStr(dataMap.get("INVENTOR")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">?????????</th>
							<td>
								<input type="text" name="utilityAgent" id="utilityAgent" value="<%=util.getStr(dataMap.get("AGENT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>ICP??????</th>
							<td colspan="3">
								<input type="text" name="utilityIcpCl" id="utilityIcpCl" value="<%=util.getStr(dataMap.get("ICP_CL")) %>" style="width: 96%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<select name="utilityRightSe" id="utilityRightSe" style="width: 90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("RIGHT_SE"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="B" <%=(util.getStr(dataMap.get("RIGHT_SE"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
								 </select>
								</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<select name="utilityRightStatus" id="utilityRightStatus" style="width: 90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="B" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="C" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="D" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="E" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="F" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="G" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????(??????)")? "selected='selected'" : "" %> >??????(??????)</option>
									<option value="H" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????(?????????)")? "selected='selected'" : "" %> >??????(?????????)</option>
								 </select>
							</td>
						</tr>
						<tr>

							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<input type="text" name="utilityRegNo" id="utilityRegNo" value="<%=util.getStr(dataMap.get("REG_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<input type="text" name="utilityRegDt" id="utilityRegDt" value="<%=util.getStr((String.valueOf(dataMap.get("REG_DT")))) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="utilityPublicNo" id="utilityPublicNo" value="<%=util.getStr(dataMap.get("PUBLIC_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="utilityPublicDt" id="utilityPublicDt" value="<%=util.getStr(dataMap.get("PUBLIC_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<select name="utilityBeforeInfo" id="utilityBeforeInfo"  style="width:90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("??????, ????????????, ????????????")? "selected='selected'" : "" %> >??????, ????????????, ????????????</option>
									<option value="B" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="C" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="D" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="E" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="F" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
								</select>
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<select name="utilityTchnlgyyGrade" id="utilityTchnlgyyGrade"  style="width:90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("TCHNLGYY_GRADE"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="B" <%=(util.getStr(dataMap.get("TCHNLGYY_GRADE"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="C" <%=(util.getStr(dataMap.get("TCHNLGYY_GRADE"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="D" <%=(util.getStr(dataMap.get("TCHNLGYY_GRADE"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="E" <%=(util.getStr(dataMap.get("TCHNLGYY_GRADE"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????(?????????)</th>
							<td>
								<select name="utilityTchnlgyMCl" id="utilityTchnlgyMCl"  style="width:90%;" onchange="standardDeth1('utility')">
				 	  				<option value="">???????????????</option>
									<% for(HashMap rs:standardList) {%>
									<option value="<%=util.getStr(rs.get("CODE"))%>" <%=util.getStr(dataMap.get("U_TCHNLGY_M_CL")).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
									<%}%>
				 	  			</select>
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????(?????????)</th>
							<td>
								<input type="hidden" id="utilitySCl" value="<%=util.getStr(dataMap.get("U_TCHNLGY_S_CL"))%>">
								<select name="utilityTchnlgySCl" id="utilityTchnlgySCl"  style="width:90%;">
									<option value="">???????????????</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td colspan="3">
								<textarea name="utilityTechnologyDc" id="utilityTechnologyDc" style="width: 95%; font-size:10pt;" maxlength="100"><%=util.getStr(dataMap.get("TECHNOLOGY_DC")) %></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????????????????</th>
							<td>
								<input type="text" name="utilityFirstPaymentDt" id="utilityFirstPaymentDt" value="<%=util.getStr(dataMap.get("FIRST_PAYMENT_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">????????????????????????</th>
							<td>
								<input type="text" name="utilityYearPaymentDt" id="utilityYearPaymentDt" value="<%=util.getStr(dataMap.get("YEAR_PAYMENT_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>

						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>???????????????</th>
							<td>
								<input type="hidden" name="OwnOrg" id="utilityOwnOrgNm" value="<%=util.getStr(dataMap.get("OWN_ORG_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnOrgNm" id="utilityOwnOrg" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100" readonly="readonly"/>
								<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ){ %>
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm1" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgList')" >
								<% } %>
							</td>
							<th scope="row" class="tit">???????????????</th>
							<td>
								<input type="hidden" name="OwnDept" id="utilityOwnDeptNm" value="<%=util.getStr(dataMap.get("OWN_DEPT_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnDeptNm" id="utilityOwnDept" value="<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100" readonly="readonly"/>
								<input type="button" name="blngOrgNm" value="????????????" id="OwnDept1" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgSubList')" >
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
								&nbsp;&nbsp;???????????? <input type="radio" name="utilityArea" id="utilityArea1" value="1" onclick="area2('utilitysearchArea','1')"  <%if(util.getStr(dataMap.get("AREA")).equals("1")) { %>checked="checked" <% } %> />
								&nbsp;&nbsp;???????????? ??? ?????? <input type="radio" name="utilityArea" id="utilityArea2" value="2"  onclick="area2('utilitysearchArea','2')"  <%if(util.getStr(dataMap.get("AREA")).equals("2")) { %>checked="checked" <% } %> />&nbsp;&nbsp;
								<select class="p_select" name="utilitysearchArea" id="utilitysearchArea1">
									<option value="">???????????????</option>
									<%
										int utilitynumArea = 1;
										for(HashMap rs:areaSigunguList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea++; } %>
								</select>
								<select class="p_select" name="utilitysearchArea2" id="utilitysearchArea2">
									<option value="">???????????????</option>
									<%
										int utilitynumArea2 = 1;
										for(HashMap rs:areaList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea2++; } %>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
								<input type="hidden" name="ManagerIdx" id="utilityManagerIdx" value="<%=util.getStr(dataMap.get("MANAGER_IDX")) %>" style="width: 70%; font-size:10pt;" maxlength="100" />
								<input type="button" name="operData" id="utilityoperData" value="????????? ??????" class="btn_inp_g_01" onclick="popupWindow('registrationUserList')">
								<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerOrgNm" value="<%=util.getStr(dataMap.get("MANAGER_ORG")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerDeptNm"  id="utilityManagerPsnNm" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPsnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">??????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPosition" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>????????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerTel" value="<%=util.getStr(dataMap.get("TEL_NO")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th>?????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerEmail" value="<%=util.getStr(dataMap.get("EMAIL")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>

	                			</table>
							</td>
						</tr>

						<%-- <tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>???????????????</th>
							<td>
								<input type="text" name="utilityOwnOrgNm" id="utilityOwnOrgNm" value="<%=util.getStr(dataMap.get("OWN_ORG_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">???????????????</th>
							<td>
								<input type="text" name=utilityOwnDeptNm id="utilityOwnDeptNm" value="<%=util.getStr(dataMap.get("OWN_DEPT_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
								&nbsp;&nbsp;???????????? <input type="radio" name="utilityArea" id="utilityArea1" value="1" onclick="area2('utilitysearchArea','1')"  <%if(util.getStr(dataMap.get("AREA")).equals("1")) { %>checked="checked" <% } %> />
								&nbsp;&nbsp;???????????? ??? ?????? <input type="radio" name="utilityArea" id="utilityArea2" value="2"  onclick="area2('utilitysearchArea','2')"  <%if(util.getStr(dataMap.get("AREA")).equals("2")) { %>checked="checked" <% } %> />&nbsp;&nbsp;
								<select class="p_select" name="utilitysearchArea" id="utilitysearchArea1">
									<option value="">???????????????</option>
									<%
										int utilitynumArea = 1;
										for(HashMap rs:areaSigunguList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea++; } %>
								</select>
								<select class="p_select" name="utilitysearchArea" id="utilitysearchArea2">
									<option value="">???????????????</option>
									<%
										int utilitynumArea2 = 1;
										for(HashMap rs:areaList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% utilitynumArea2++; } %>
								</select>
							</td>
						</tr> --%>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
								<%
								if(imgfileList.size() > 0){
							%>
									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:imgfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<input type="checkbox" name="imgfileFlog" id="utility_img_fileFlog_<%=fileCnt%>"
													value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('utility_img_')" />&nbsp;
											????????????&nbsp;&nbsp;
											 <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" class="img-view"  alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/>
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
											<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)

										</li>
									<% fileCnt++; }%>
									</ul>
									<div style="display: none;" id="utility_img_<%=fileFullImgGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="utility_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>
									<%-- <script type="text/javascript">
													var arrfileCnt = new Array();

													function fileSet(fileCnt){

														if($('#'+fileCnt+'fileFlog_1').is(':checked')){
															$('#'+fileCnt+'<%=fileFullImgGrp%>fileGrpBox').attr("style","display:inline-block;");
														}else{
															$('#<%=fileFullImgGrp%>File1').val("");
															$('#'+fileCnt+'<%=fileFullImgGrp%>fileGrpBox').attr("style","display:none;");
														}
													}
								</script> --%>
				            <% }else{ %>
									<div style="display: inline-block;">
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="utility_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>
						      <% } %>
							</td>
				</tr>

						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<%-- <td>
								<input type="text" name="utilityDetailedStatement" id="utilityDetailedStatement" value="<%=util.getStr(dataMap.get("DETAILED_STATEMENT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td> --%>
							<td colspan="3">
											<%
								if(statementfileList.size() > 0){
							%>
									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:statementfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));

									%>
										<li class="text">
											<input type="checkbox" name="statementfileFlog" id="utility_statement_fileFlog_<%=fileCnt%>"
													value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileStatementSet('utility_statement_')" />&nbsp;
											????????????&nbsp;&nbsp;
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
											<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
										</li>
									<% fileCnt++; }%>
									</ul>
									<div style="display: none;" id="utility_statement_<%=fileFullStatementGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullStatementGrp%>File1" id="utility_statement_<%=fileFullStatementGrp%>File1" title="????????????" />
										</div>
									</div>

				            <% }else{ %>
									<div style="display: inline-block;" >
										<div>
											<input type="file" name="<%=fileFullStatementGrp%>File1" id="utility_statement_<%=fileFullStatementGrp%>File1" title="????????????" />
										</div>
									</div>
						      <% } %>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????</th>
							<td colspan="3">
								<%
						if(fileList.size() > 0){
					%>
							<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
							<%
								int fileCnt = 1;
								for(HashMap rs:fileList){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));

							%>
								<li class="text">
									<input type="checkbox" name="fileFlog" id="utility_fileFlog_<%=fileCnt%>"
											value="<%=util.getStr(rs.get("FILE_ID"))%>" />&nbsp;
									????????????&nbsp;&nbsp;
									<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
									<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
								</li>
							<% fileCnt++; }%>
							</ul>
							<div style="display: inline-block;" id="utility_<%=fileFullGrp%>fileGrpBox">
								<div>
									<input type="file" name="<%=fileFullGrp%>File1" id="utility_<%=fileFullGrp%>File1" title="????????????" />
								</div>
							</div>
							<div style="display: inline-block; vertical-align: bottom;">
								<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="utility_addRowFile('<%=fileFullGrp%>');" />
								<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="utility_delRowFile('<%=fileFullGrp%>');" />
							</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					            function utility_addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='utility_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
				            		fileHtml += "</div>";

			            			$('#utility_'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}

					            function utility_delRowFile(fileGrpnm){
					            	if($('#utility_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#utility_'+fileGrpnm+'fileGrpBox > div').eq($('#utility_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }


				            </script>

		            <% }else{ %>
							<div style="display: inline-block;"  id="utility_<%=fileFullGrp%>fileGrpBox">
								<div>
									<input type="file" name="<%=fileFullGrp%>File1" id="utility_<%=fileFullGrp%>File1" title="????????????" />
								</div>
							</div>
							<div style="display: inline-block; vertical-align: bottom;">
								<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="utility_addRowFile('<%=fileFullGrp%>');" />
								<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="utility_delRowFile('<%=fileFullGrp%>');" />
							</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '2';
					            function utility_addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='utility_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
				            		fileHtml += "</div>";

			            			$('#utility_'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}

					            function utility_delRowFile(fileGrpnm){
					            	if($('#utility_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#utility_'+fileGrpnm+'fileGrpBox > div').eq($('#utility_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }

				            </script>

				     	 <% } %>
					      	</td>
						</tr>
					</tbody>
			</table>
			<!-- bo_btn  -->
			<div class="btn_right_box" style="text-align: right; width: 980px;">
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goCheck('utility')"/>
				<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('view', 'utility')"/>
			</div>
			<!--// bo_btn -->
		</div>
	</form>
	</div>


	<div id="design_list">
	<form name="design_fedit" id = "design_fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
		<input type="hidden"  id = "design_mode" 		name = "mode" 					value = "<%=mode%>"/>
		<input type="hidden"  id = "design_idx"  		name = "idx" 					value = "<%=util.getIntStr(dataMap.get("SEARCH_DESIGN_IDX"))%>"/>
		<input type="hidden"  id = "design_reUrl"		 name = "reUrl" 		value="<%=myPage%>?mode=view&amp;list_mode=<%=list_mode%>&amp;idx=<%=idx%>" />
		<input type="hidden"  id = "design_list_mode"	 name = "list_mode" 	value="<%=list_mode%>" />
		<input type="hidden"  id = "design_state" 	 	 name = "state" 		value = "<%=util.getIntStr(dataMap.get("STATE"))%>"/>
		<input type="hidden" 	id = "design_no" 			name = "no" 		value = "0"/>
		<input type="hidden" 	name = "area" 			value = "<%=util.getIntStr(dataMap.get("AREA"))%>"/>
		<div class="skin_bbs_write" style="margin-top: 30px">
		<h2 class="tit2">?????????</h2>
				<span style="color:red; font-size:10pt;"> * ?????? ?????????????????????.</span>
	            <table class="skin_basic_write">
				<caption>????????????</caption>
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
				<tbody>
					<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<input type="text" name="designAplcNo" id="designAplcNo" value="<%=util.getStr(dataMap.get("APLC_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" onKeyUp="NoCntCheck('design')" />
								<input type="hidden" name="designAplcNoReal" id="designAplcNoReal" value="<%=util.getStr(dataMap.get("APLC_NO")) %>"  />
								<br/><span id = "design_noResult"></span>
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<input type="text" name="designAplcDt" id="designAplcDt" value="<%=util.getStr(dataMap.get("APLC_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td>
								<input type="text" name="designAplcUser" id="designAplcUser" value="<%=util.getStr(dataMap.get("APLC_USER")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td>
								&nbsp;???????????? <input type="radio" name="designKoreaCl"  id="sortA" value="A" onclick="showSort('A')" <%=(util.getStr(dataMap.get("KOREA_CL"))).equals("A")? "checked='checked'" : "" %>>
								&nbsp;&nbsp;???????????? <input type="radio" name="designKoreaCl" id="sortB" value="B" onclick="showSort('B')" <%=!(util.getStr(dataMap.get("KOREA_CL"))).equals("A")? "checked='checked'" : "" %>>
								&nbsp;&nbsp;<input type="text" name="designIntrlCl" id="designIntrlCl" value="<%=util.getStr((String.valueOf(dataMap.get("INTRL_CL")))) %>" <%=!(util.getStr(dataMap.get("KOREA_CL"))).equals("A")? "style='width: 43%;'" : "style='width: 43%; display:none;'" %> maxlength="100" placeholder="????????????" />
							</td>

						</tr>
						<tr>
							<th scope="row" class="tit">?????????????????????</th>
							<td>
								<input type="text" name="designDesignNo" id="designDesignNo" value="<%=util.getStr(dataMap.get("DESIGN_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>??????</th>
							<td>
								<input type="text" name="designUseNm" id="designUseNm" value="<%=util.getStr(dataMap.get("USE_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td colspan="3">
								<select name="designRightStatus" id="designRightStatus" style="width: 90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="B" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="C" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="D" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="E" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="F" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="G" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????(??????)")? "selected='selected'" : "" %> >??????(??????)</option>
								 </select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td>
								<input type="text" name="designCreationUser" id="designCreationUser" value="<%=util.getStr(dataMap.get("CREATION_USER")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">?????????</th>
							<td>
								<input type="text" name="designAgent" id="designAgent" value="<%=util.getStr(dataMap.get("AGENT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="designRegNo" id="designRegNo" value="<%=util.getStr(dataMap.get("REG_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="designRegDt" id="designRegDt" value="<%=util.getStr(dataMap.get("REG_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<%-- <tr>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="designPublicNo" id="designPublicNo" value="<%=util.getStr(dataMap.get("PUBLIC_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="designPublicDt" id="designPublicDt" value="<%=util.getStr(dataMap.get("PUBLIC_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr> --%>
						<tr>

							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td>
								<select name="designBeforeInfo" id="designBeforeInfo"  style="width: 90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("??????, ????????????, ????????????")? "selected='selected'" : "" %> >??????, ????????????, ????????????</option>
									<option value="B" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="C" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="D" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="E" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="F" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
								</select>
							</td>
							<th scope="row" class="tit">????????????????????????</th>
							<td>
								<input type="text" name="designYearPaymentDt" id="designYearPaymentDt" value="<%=util.getStr(dataMap.get("YEAR_PAYMENT_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????(?????????)</th>
							<td>
								<select name="designTchnlgyMCl" id="designTchnlgyMCl"  style="width: 90%;" onchange="standardDeth1('design')">
				 	  				<option value="">???????????????</option>
									<% for(HashMap rs:standardList) {%>
									<option value="<%=util.getStr(rs.get("CODE"))%>" <%if(util.getStr(dataMap.get("D_TCHNLGY_M_CL")).equals(util.getStr(rs.get("CODE")))) { %>selected="selected" <% } %>><%=util.getStr(rs.get("NAME"))%></option>
									<%}%>
				 	  			</select>
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????(?????????)</th>
							<td>
								<input type="hidden" id="designSCl" value="<%=util.getStr(dataMap.get("D_TCHNLGY_S_CL"))%>">
								<select name="designTchnlgySCl" id="designTchnlgySCl"  style="width: 90%;">
									<option value="">???????????????</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td colspan="3">
								<textarea name="designTechnologyDc" id="designTechnologyDc" style="width: 93%; font-size:10pt;" maxlength="100"><%=util.getStr(dataMap.get("TECHNOLOGY_DC")) %></textarea>
							</td>

						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>???????????????</th>
							<td>
								<input type="hidden" name="OwnOrg" id="designOwnOrgNm" value="<%=util.getStr(dataMap.get("OWN_ORG_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnOrgNm" id="designOwnOrg" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100"  readonly="readonly"/>
								<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ){ %>
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm2" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgList')" >
								<% } %>
							</td>
							<th scope="row" class="tit">???????????????</th>
							<td>
								<input type="hidden" name="OwnDept" id="designOwnDeptNm" value="<%=util.getStr(dataMap.get("OWN_DEPT_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnDeptNm" id="designOwnDept" value="<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100"  readonly="readonly"/>
								<input type="button" name="blngOrgNm" value="????????????" id="OwnDept2" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgSubList')" >
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
								&nbsp;&nbsp;???????????? <input type="radio" name="designArea" id="designArea1" value="1" onclick="area2('designsearchArea','1')"  <%if(util.getStr(dataMap.get("AREA")).equals("1")) { %>checked="checked" <% } %> />
								&nbsp;&nbsp;???????????? ??? ?????? <input type="radio" name="designArea" id="designArea2" value="2"  onclick="area2('designsearchArea','2')"  <%if(util.getStr(dataMap.get("AREA")).equals("2")) { %>checked="checked" <% } %> />&nbsp;&nbsp;
								<select class="p_select" name="designsearchArea" id="designsearchArea1">
									<option value="">???????????????</option>
									<%
										int designnumArea = 1;
										for(HashMap rs:areaSigunguList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% designnumArea++; } %>
								</select>
								<select class="p_select" name="designsearchArea" id="designsearchArea2" style="display:none;">
									<option value="">???????????????</option>
									<%
										int designnumArea2 = 1;
										for(HashMap rs:areaList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% designnumArea2++; } %>
								</select>
							</td>
					</tr>
					<tr>
						<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
						<td colspan="3">
							<input type="hidden" name="ManagerIdx" id="designManagerIdx" value="<%=util.getStr(dataMap.get("MANAGER_IDX")) %>" style="width: 70%; font-size:10pt;" maxlength="100" />
							<input type="button" name="operData" id="designoperData" value="????????? ??????" class="btn_inp_g_01" onclick="popupWindow('registrationUserList')">
							<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerOrgNm" value="<%=util.getStr(dataMap.get("MANAGER_ORG")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerDeptNm"  id="designManagerPsnNm" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPsnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">??????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPosition" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>????????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerTel" value="<%=util.getStr(dataMap.get("TEL_NO")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th>?????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerEmail" value="<%=util.getStr(dataMap.get("EMAIL")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>

	                			</table>
						</td>
					</tr>
					<tr>
						<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
							<%
								if(imgfileList.size() > 0){
							%>
									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:imgfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<input type="checkbox" name="imgfileFlog" id="design_img_fileFlog_<%=fileCnt%>" value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('design_img_')" />&nbsp;
											????????????&nbsp;&nbsp;
											 <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" class="img-view"  alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/>
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
											<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)

										</li>
									<% fileCnt++; }%>
									</ul>
									<div style="display: none;"  id="design_img_<%=fileFullImgGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="design_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>

				            <% }else{ %>
									<div style="display: inline-block;" id="<%=fileFullImgGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="design_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>
						      <% } %>
						      </td>
					</tr>
					<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<%-- <td>
								<input type="text" name="utilityDetailedStatement" id="utilityDetailedStatement" value="<%=util.getStr(dataMap.get("DETAILED_STATEMENT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td> --%>
							<td colspan="3">
											<%
								if(statementfileList.size() > 0){
							%>
									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:statementfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));

									%>
										<li class="text">
											<input type="checkbox" name="statementfileFlog" id="design_statement_fileFlog_<%=fileCnt%>" value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileStatementSet('design_statement_')" />&nbsp;
											????????????&nbsp;&nbsp;
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
											<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
										</li>
									<% fileCnt++; }%>
									</ul>
									<div style="display: none;" id="design_statement_<%=fileFullStatementGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullStatementGrp%>File1" id="design_statement_<%=fileFullStatementGrp%>File1" title="????????????" />
										</div>
									</div>
				            <% }else{ %>
									<div style="display: inline-block;" >
										<div>
											<input type="file" name="<%=fileFullStatementGrp%>File1" id="design_statement_<%=fileFullStatementGrp%>File1" title="????????????" />
										</div>
									</div>
						      <% } %>
							</td>
						</tr>
					<tr>
						 <th scope="row" class="tit">????????????</th>
					<td colspan="3">
					<%
						if(fileList.size() > 0){
					%>
							<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
							<%
								int fileCnt = 1;
								for(HashMap rs:fileList){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
							%>
								<li class="text">
									<input type="checkbox" name="fileFlog" id="design_fileFlog_<%=fileCnt%>"
											value="<%=util.getStr(rs.get("FILE_ID"))%>" />&nbsp;
									????????????&nbsp;&nbsp;
									<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
									<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
								</li>
							<% fileCnt++; }%>
							</ul>
							<div style="display: inline-block;" id="design_<%=fileFullGrp%>fileGrpBox">
								<div>
									<input type="file" name="<%=fileFullGrp%>File1" id="design_<%=fileFullGrp%>File1" title="????????????" />
								</div>
							</div>
							<div style="display: inline-block; vertical-align: bottom;">
								<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="design_addRowFile('<%=fileFullGrp%>');" />
								<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="design_delRowFile('<%=fileFullGrp%>');" />
							</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					            function design_addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='design_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
				            		fileHtml += "</div>";

			            			$('#design_'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}

					            function design_delRowFile(fileGrpnm){
					            	if($('#design_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#design_'+fileGrpnm+'fileGrpBox > div').eq($('#design_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }
				            </script>

		            <% }else{ %>
							<div style="display: inline-block;"  id="design_<%=fileFullGrp%>fileGrpBox">
								<div>
									<input type="file" name="<%=fileFullGrp%>File1" id="design_<%=fileFullGrp%>File1" title="????????????" />
								</div>
							</div>
							<div style="display: inline-block; vertical-align: bottom;">
								<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="design_addRowFile('<%=fileFullGrp%>');" />
								<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="design_delRowFile('<%=fileFullGrp%>');" />
							</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '2';
					            function design_addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='design_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
				            		fileHtml += "</div>";

			            			$('#design_'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}

					            function design_delRowFile(fileGrpnm){
					            	if($('#design_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#design_'+fileGrpnm+'fileGrpBox > div').eq($('#design_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }

				            </script>

				     	 <% } %>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- bo_btn  -->
			<div class="btn_right_box" style="text-align: right; width: 980px;">
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goCheck('design')"/>
				<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('view', 'design')"/>
			</div>
			<!--// bo_btn -->
		</div>
	</form>
	</div>

	<div id="brand_list">
	<form name="brand_fedit" id="brand_fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
		<input type="hidden" id = "brand_mode" 			name = "mode" 		value = "<%=mode%>"/>
		<input type="hidden" id = "brand_idx" 			name = "idx" 		value = "<%=util.getIntStr(dataMap.get("SEARCH_BRAND_IDX"))%>"/>
		<input type="hidden" id = "brand_reUrl" 		name = "reUrl" 		value ="<%=myPage%>?mode=view&amp;list_mode=<%=list_mode%>&amp;idx=<%=idx%>" />
		<input type="hidden" id = "brand_list_mode" 	name = "list_mode" 	value ="<%=list_mode%>" />
		<input type="hidden" id = "brand_state" 		name = "state" 		value = "<%=util.getIntStr(dataMap.get("STATE"))%>"/>
		<input type="hidden" id = "brand_no" 			name = "no"			value ="0" 	 />
		<input type="hidden" 	name = "area" 			value = "<%=util.getIntStr(dataMap.get("AREA"))%>"/>

		<div class="skin_bbs_write" style="margin-top: 30px">
		<h2 class="tit2">??????</h2>
				<span style="color:red; font-size:10pt;"> * ?????? ?????????????????????.</span>
	            <table class="skin_basic_write">
				<caption>????????????</caption>
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
				<tbody>
					<tr>
							<th scope="row" class="tit">??????(????????????)??????</th>
							<td>
								<input type="text" name="brandIntrlAplcNo" id="brandIntrlAplcNo" value="<%=util.getStr(dataMap.get("INTRL_APLC_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" onKeyUp="NoCntCheck('brand')" />
								<input type="hidden" name="brandIntrlAplcNoReal" id="brandIntrlAplcNoReal" value="<%=util.getStr(dataMap.get("INTRL_APLC_NO")) %>" />
								<br/><span id = "brand_noResult"></span>
							</td>
							<th scope="row" class="tit">??????(????????????)??????</th>
							<td>
								<input type="text" name="brandIntrlAplcDt" id="brandIntrlAplcDt" value="<%=util.getStr(dataMap.get("INTRL_APLC_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">?????????</th>
							<td>
								<input type="text" name="brandAplcUser" id="brandAplcUser" value="<%=util.getStr(dataMap.get("APLC_USER")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">?????????</th>
							<td>
								<input type="text" name="brandAgent" id="brandAgent" value="<%=util.getStr(dataMap.get("AGENT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">??????</th>
							<td colspan="3">
								<input type="text" name="brandUseNm" id="brandUseNm" value="<%=util.getStr((String.valueOf(dataMap.get("USE_NM")))) %>" style="width: 96%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="brandGoodsCl" id="brandGoodsCl" value="<%=util.getStr(dataMap.get("GOODS_CL")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="brandFigureCode" id="brandFigureCode" value="<%=util.getStr(dataMap.get("FIGURE_CODE")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
							<tr>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="brandRegNo" id="brandRegNo" value="<%=util.getStr(dataMap.get("REG_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="brandRegDt" id="brandRegDt" value="<%=util.getStr(dataMap.get("REG_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="brandPblancNo" id="brandPblancNo" value="<%=util.getStr(dataMap.get("PBLANC_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="brandPblancDt" id="brandPblancDt" value="<%=util.getStr(dataMap.get("PBLANC_DT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<%-- <th scope="row" class="tit">????????????</th>
							<td>
								<select name="brandRightCl" id="brandRightCl"  style="width: 90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("RIGHT_CL"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="B" <%=(util.getStr(dataMap.get("RIGHT_CL"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="C" <%=(util.getStr(dataMap.get("RIGHT_CL"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="D" <%=(util.getStr(dataMap.get("RIGHT_CL"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="E" <%=(util.getStr(dataMap.get("RIGHT_CL"))).equals("???????????????????????????")? "selected='selected'" : "" %> >???????????????????????????</option>
									<option value="F" <%=(util.getStr(dataMap.get("RIGHT_CL"))).equals("??????/?????????")? "selected='selected'" : "" %> >??????/?????????</option>
									<option value="G" <%=(util.getStr(dataMap.get("RIGHT_CL"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="H" <%=(util.getStr(dataMap.get("RIGHT_CL"))).equals("???????????????????????????")? "selected='selected'" : "" %> >???????????????????????????</option>
									<option value="I" <%=(util.getStr(dataMap.get("RIGHT_CL"))).equals("??????????????????(????????????)")? "selected='selected'" : "" %> >??????????????????(????????????)</option>
								</select>
							</td> --%>
							<th scope="row" class="tit">????????????</th>
							<td>
								<select name="brandRightStatus" id="brandRightStatus"  style="width: 90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="B" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="C" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="D" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="E" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="F" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="G" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????(??????)")? "selected='selected'" : "" %> >??????(??????)</option>
									<option value="H" <%=(util.getStr(dataMap.get("RIGHT_STATUS"))).equals("??????(?????????)")? "selected='selected'" : "" %> >??????(??????)</option>
								</select>
							</td>
							<th scope="row" class="tit">????????????</th>
							<td>
								<select name="brandBeforeInfo" id="brandBeforeInfo"  style="width: 90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("??????, ????????????, ????????????")? "selected='selected'" : "" %> >??????, ????????????, ????????????</option>
									<option value="B" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="C" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="D" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="E" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="F" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????(?????????)</th>
							<td>
								<select name="brandTchnlgyMCl" id="brandTchnlgyMCl"  style="width: 90%;" onchange="standardDeth1('brand')">
				 	  				<option value="">???????????????</option>
									<% for(HashMap rs:standardList) {%>
									<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(dataMap.get("B_TCHNLGY_M_CL"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
									<%}%>
				 	  			</select>
							</td>
							<th scope="row" class="tit">????????????(?????????)</th>
							<td>
								<input type="hidden" id="brandSCl" value="<%=util.getStr(dataMap.get("B_TCHNLGY_S_CL"))%>">
								<select name="brandTchnlgySCl" id="brandTchnlgySCl"  style="width: 90%;">
									<option value="">???????????????</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????</th>
							<td colspan="3">
								<textarea  name="brandTechnologyDc" id="brandTechnologyDc" style="width: 95%;"  ><%=util.getStr(dataMap.get("TECHNOLOGY_DC")) %></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>???????????????</th>
							<td>
								<input type="hidden" name="OwnOrg" id="brandOwnOrgNm" value="<%=util.getStr(dataMap.get("OWN_ORG_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnOrgNm" id="brandOwnOrg" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100"  readonly="readonly"/>
								<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ){ %>
									<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm3" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgList')" >
								<% } %>
							</td>
							<th scope="row" class="tit">???????????????</th>
							<td>
								<input type="hidden" name="OwnDept" id="brandOwnDeptNm" value="<%=util.getStr(dataMap.get("OWN_DEPT_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnDeptNm" id="brandOwnDept" value="<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100"  readonly="readonly"/>
								<input type="button" name="blngOrgNm" value="????????????" id="OwnDept3" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgSubList')" >
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">?????????</th>
							<td colspan="3">
								&nbsp;&nbsp;???????????? <input type="radio" name="brandArea" id="brandArea1" value="1" onclick="area2('brandsearchArea','1')" <%if(util.getStr(dataMap.get("AREA")).equals("1")) { %>checked="checked" <% } %> />
								&nbsp;&nbsp;???????????? ??? ?????? <input type="radio" name="brandArea" id="brandArea2" value="2"  onclick="area2('brandsearchArea','2')" <%if(util.getStr(dataMap.get("AREA")).equals("2")) { %>checked="checked" <% } %> />&nbsp;&nbsp;
								<select class="p_select" name="brandsearchArea" id="brandsearchArea1">
									<option value="">???????????????</option>
									<%
										int brandnumArea = 1;
										for(HashMap rs:areaSigunguList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% brandnumArea++; } %>
								</select>
								<select class="p_select" name="brandsearchArea" id="brandsearchArea2" style="display:none;">
									<option value="">???????????????</option>
									<%
										int brandnumArea2 = 1;
										for(HashMap rs:areaList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% brandnumArea2++; } %>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
								<input type="hidden" name="ManagerIdx" id="brandManagerIdx" value="<%=util.getStr(dataMap.get("MANAGER_IDX")) %>" style="width: 70%; font-size:10pt;" maxlength="100" />
								<input type="button" name="operData" id="brandoperData" value="????????? ??????" class="btn_inp_g_01" onclick="popupWindow('registrationUserList')">
								<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerOrgNm" value="<%=util.getStr(dataMap.get("MANAGER_ORG")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerDeptNm"  id="brandManagerPsnNm" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPsnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">??????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPosition" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>????????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerTel" value="<%=util.getStr(dataMap.get("TEL_NO")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th>?????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerEmail" value="<%=util.getStr(dataMap.get("EMAIL")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>

	                			</table>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????????????????</th>
							<td colspan="3">
								<input type="text" name="brandYearPaymentDt" id="brandYearPaymentDt" value="<%=util.getStr(dataMap.get("YEAR_PAYMENT_DT")) %>" style="width: 35%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
					<tr>
						<th scope="row" class="tit">?????????</th>
							<td colspan="3">
							<%
								if(imgfileList.size() > 0){
							%>
									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:imgfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<input type="checkbox" name="imgfileFlog" id="brand_img_fileFlog_<%=fileCnt%>"
													value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('brand_img_')" />&nbsp;
											????????????&nbsp;&nbsp;
											 <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" class="img-view"  alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/>
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
											<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)

										</li>
									<% fileCnt++; }%>
									</ul>
									<div  style="display: none;"  id="brand_img_<%=fileFullImgGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="brand_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>
				            <% }else{ %>
									<div style="display: inline-block;" id="<%=fileFullImgGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="brand_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>
						      <% } %>
						      </td>
						</tr>
						<tr>
							<th scope="row" class="tit">?????????</th>
							<td colspan="3">
											<%
								if(statementfileList.size() > 0){
							%>
									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:statementfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));

									%>
										<li class="text">
											<input type="checkbox" name="statementfileFlog" id="brand_statement_fileFlog_<%=fileCnt%>"
													value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileStatementSet('brand_statement_')" />&nbsp;
											????????????&nbsp;&nbsp;
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
											<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
										</li>
									<% fileCnt++; }%>
									</ul>
									<div style="display: none;" id="brand_statement_<%=fileFullStatementGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullStatementGrp%>File1" id="brand_statement_<%=fileFullStatementGrp%>File1" title="????????????" />
										</div>
									</div>
				            <% }else{ %>
									<div style="display: inline-block;" >
										<div>
											<input type="file" name="<%=fileFullStatementGrp%>File1" id="brand_statement_<%=fileFullStatementGrp%>File1" title="????????????" />
										</div>
									</div>
						      <% } %>
							</td>
						</tr>
						<tr>
						 <th scope="row" class="tit">????????????</th>
							<td colspan="3">
					<%
						if(fileList.size() > 0){
					%>
							<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
							<%
								int fileCnt = 1;
								for(HashMap rs:fileList){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
								%>
								<li class="text">
									<input type="checkbox" name="fileFlog" id="brand_fileFlog_<%=fileCnt%>"
											value="<%=util.getStr(rs.get("FILE_ID"))%>" />&nbsp;
									????????????&nbsp;&nbsp;
									<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
									<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
								</li>
							<% fileCnt++; }%>
							</ul>
							<div style="display: inline-block;" id="brand_<%=fileFullGrp%>fileGrpBox">
								<div>
									<input type="file" name="<%=fileFullGrp%>File1" id="brand_<%=fileFullGrp%>File1" title="????????????" />
								</div>
							</div>
							<div style="display: inline-block; vertical-align: bottom;">
								<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="brand_addRowFile('<%=fileFullGrp%>');" />
								<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="brand_delRowFile('<%=fileFullGrp%>');" />
							</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					            function brand_addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='brand_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
				            		fileHtml += "</div>";

			            			$('#brand_'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}

					            function brand_delRowFile(fileGrpnm){
					            	if($('#brand_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#brand_'+fileGrpnm+'fileGrpBox > div').eq($('#brand_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }
				            </script>

		            <% }else{ %>
							<div style="display: inline-block;"  id="brand_<%=fileFullGrp%>fileGrpBox">
								<div>
									<input type="file" name="<%=fileFullGrp%>File1" id="brand_<%=fileFullGrp%>File1" title="????????????" />
								</div>
							</div>
							<div style="display: inline-block; vertical-align: bottom;">
								<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="brand_addRowFile('<%=fileFullGrp%>');" />
								<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="brand_delRowFile('<%=fileFullGrp%>');" />
							</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '2';
					            function brand_addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='brand_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
				            		fileHtml += "</div>";

			            			$('#brand_'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}

					            function brand_delRowFile(fileGrpnm){
					            	if($('#brand_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#brand_'+fileGrpnm+'fileGrpBox > div').eq($('#brand_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }

				            </script>

				     	 <% } %>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- bo_btn  -->
			<div class="btn_right_box" style="text-align: right; width: 980px;">
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goCheck('brand')"/>
				<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('view', 'brand')"/>
			</div>
			<!--// bo_btn -->
		</div>
	</form>
	</div>

	<div id="program_list">
	<form name="program_fedit" id="program_fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
		<input type="hidden" id = "program_mode" 			name = "mode"  		value = "<%=mode%>"/>
		<input type="hidden" id = "program_idx" 			name = "idx" 		value = "<%=util.getIntStr(dataMap.get("SEARCH_PROGRAM_IDX"))%>"/>
		<input type="hidden" id = "program_reUrl" 			name = "reUrl" 		value="<%=myPage%>?mode=view&amp;list_mode=<%=list_mode%>&amp;idx=<%=idx%>" />
		<input type="hidden" id = "program_list_mode" 		name = "list_mode" 	value="<%=list_mode%>" />
		<input type="hidden" id = "program_state" 			name = "state" 		value = "<%=util.getIntStr(dataMap.get("STATE"))%>"/>
		<input type="hidden" 	id = "program_no" 			name = "no"  		value="0"/>
		<input type="hidden" 	name = "area" 			value = "<%=util.getIntStr(dataMap.get("AREA"))%>"/>

		<div class="skin_bbs_write" style="margin-top: 30px">
		<h2 class="tit2">????????????</h2>
				<span style="color:red; font-size:10pt;"> * ?????? ?????????????????????.</span>
	            <table class="skin_basic_write">
				<caption>????????????</caption>
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
				<tbody>
						<tr>
							<th scope="row" class="tit">????????????</th>
							<td>
								<input type="text" name="programRegNo" id="programRegNo" value="<%=util.getStr(dataMap.get("REG_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100"  onKeyUp="NoCntCheck('program')" />
								<input type="hidden" name="programCrtWorkDeReal" id="programCrtWorkDeReal" value="<%=util.getStr(dataMap.get("CRT_WORK_DE")) %>" />
								<br/><span id = "program_noResult"></span>
							</td>
							<th scope="row" class="tit">???????????????</th>
							<td>
								<input type="text" name="programRegDe" id="programRegDe" value="<%=util.getStr(dataMap.get("REG_DE")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">???????????????</th>
							<td>
								<input type="text" name="programCrtWorkDe" id="programCrtWorkDe" value="<%=util.getStr(dataMap.get("CRT_WORK_DE")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">???????????????</th>
							<td>
								<input type="text" name="programPublictDe" id="programPublictDe" value="<%=util.getStr(dataMap.get("PUBLICT_DE")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>

						<tr>
							<th scope="row" class="tit">??????</th>
							<td>
								<input type="text" name="programUseNm" id="programUseNm" value="<%=util.getStr(dataMap.get("USE_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">????????????</th>
							<td>

								<select name="programBeforeInfo" id="programBeforeInfo"  style="width: 90%;">
									<option value="">???????????????</option>
									<option value="A" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("??????, ????????????, ????????????")? "selected='selected'" : "" %> >??????, ????????????, ????????????</option>
									<option value="B" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("??????")? "selected='selected'" : "" %> >??????</option>
									<option value="C" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="D" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="E" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="F" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">?????????????????????</th>
							<td>
								<input type="text" name="programPgmAuthor" id="programPgmAuthor" value="<%=util.getStr(dataMap.get("PGM_AUTHOR")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<th scope="row" class="tit">?????????????????????</th>
							<td>
								<input type="text" name="programCrtParticipant" id="programCrtParticipant" value="<%=util.getStr(dataMap.get("CRT_PARTICIPANT")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">????????????(?????????)</th>
							<td>
								<select name="programTchnlgyMCl" id="programTchnlgyMCl"  style="width: 90%;" onchange="standardDeth1('program')">
				 	  				<option value="">???????????????</option>
									<% for(HashMap rs:standardList) {%>
									<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(dataMap.get("P_TCHNLGY_M_CL"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
									<%}%>
				 	  			</select>
							</td>
							<th scope="row" class="tit">????????????(?????????)</th>
							<td>
								<input type="hidden" id="programSCl" value="<%=util.getStr(dataMap.get("P_TCHNLGY_S_CL"))%>">
								<select name="programTchnlgySCl" id="programTchnlgySCl"  style="width: 90%;">
									<option value="">???????????????</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">??????????????????</th>
							<td colspan="3">
								<textarea name="programPgmDc" id="programPgmDc" style="width: 95%; font-size:10pt;" maxlength="100"><%=util.getStr((String.valueOf(dataMap.get("PGM_DC")))) %></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">???????????????</th>
							<td>
								<input type="hidden" name="OwnOrg" id="programOwnOrgNm" value="<%=util.getStr(dataMap.get("OWN_ORG_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnOrgNm" id="programOwnOrg" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100" readonly="readonly"/>
								<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ){ %>
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm4" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgList')" >
								<% } %>
							</td>
							<th scope="row" class="tit">???????????????</th>
							<td>
								<input type="hidden" name="OwnDept" id="programOwnDeptNm" value="<%=util.getStr(dataMap.get("OWN_DEPT_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnDeptNm" id="programOwnDept" value="<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100" readonly="readonly"/>
								<input type="button" name="blngOrgNm" value="????????????" id="OwnDept4" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgSubList')" >
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit">?????????</th>
							<td colspan="3">
								&nbsp;&nbsp;???????????? <input type="radio" name="programArea" id="programArea1" value="1" onclick="area2('programsearchArea','1')" <%if(util.getStr(dataMap.get("AREA")).equals("1")) { %>checked="checked" <% } %> />
								&nbsp;&nbsp;???????????? ??? ?????? <input type="radio" name="programArea" id="programArea2" value="2"  onclick="area2('programsearchArea','2')" <%if(util.getStr(dataMap.get("AREA")).equals("2")) { %>checked="checked" <% } %> />&nbsp;&nbsp;
								<select class="p_select" name="programsearchArea" id="programsearchArea1">
									<option value="">???????????????</option>
									<%
										int programnumArea = 1;
										for(HashMap rs:areaSigunguList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% programnumArea++; } %>
								</select>
								<select class="p_select" name="programsearchArea" id="programsearchArea2" style="display:none;">
									<option value="">???????????????</option>
									<%
										int programnumArea2 = 1;
										for(HashMap rs:areaList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% programnumArea2++; } %>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
								<input type="hidden" name="ManagerIdx" id="programManagerIdx" value="<%=util.getStr(dataMap.get("MANAGER_IDX")) %>" style="width: 70%; font-size:10pt;" maxlength="100" />
								<input type="button" name="operData" id="programoperData" value="????????? ??????" class="btn_inp_g_01" onclick="popupWindow('registrationUserList')">
								<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerOrgNm" value="<%=util.getStr(dataMap.get("MANAGER_ORG")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerDeptNm"  id="programManagerPsnNm" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPsnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">??????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPosition" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>????????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerTel" value="<%=util.getStr(dataMap.get("TEL_NO")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th>?????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerEmail" value="<%=util.getStr(dataMap.get("EMAIL")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>

	                			</table>
							</td>
						</tr>
					<tr>
					<th scope="row" class="tit">?????????</th>
							<td colspan="3">
							<%
								if(imgfileList.size() > 0){
							%>
									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:imgfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<input type="checkbox" name="imgfileFlog" id="program_img_fileFlog_<%=fileCnt%>" value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('program_img_')" />&nbsp;
											????????????&nbsp;&nbsp;
											 <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" class="img-view"  alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/>
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
											<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)

										</li>
									<% fileCnt++; }%>
									</ul>
									<div style="display: none;"  id="program_img_<%=fileFullImgGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="program_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>
				            <% }else{ %>
									<div style="display: inline-block;" id="<%=fileFullImgGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="program_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>
						      <% } %>
						      </td>
				</tr>
				<tr>

						<th scope="row" class="tit">??????????????????</th>
						<td colspan="3">
					<%
						if(fileList.size() > 0){
					%>
							<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
							<%
								int fileCnt = 1;
								for(HashMap rs:fileList){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
							%>
								<li class="text">
									<input type="checkbox" name="fileFlog" id="program_fileFlog_<%=fileCnt%>"
											value="<%=util.getStr(rs.get("FILE_ID"))%>" />&nbsp;
									????????????&nbsp;&nbsp;
									<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
									<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
								</li>
							<% fileCnt++; }%>
							</ul>
							<div style="display: inline-block;" id="program_<%=fileFullGrp%>fileGrpBox">
								<div>
									<input type="file" name="<%=fileFullGrp%>File1" id="program_<%=fileFullGrp%>File1" title="????????????" />
								</div>
							</div>
							<div style="display: inline-block; vertical-align: bottom;">
								<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="program_addRowFile('<%=fileFullGrp%>');" />
								<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="program_delRowFile('<%=fileFullGrp%>');" />
							</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					            function program_addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='program_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
				            		fileHtml += "</div>";

			            			$('#program_'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}

					            function program_delRowFile(fileGrpnm){
					            	if($('#program_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#program_'+fileGrpnm+'fileGrpBox > div').eq($('#program_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }
				            </script>

		            <% }else{ %>
							<div style="display: inline-block;"  id="program_<%=fileFullGrp%>fileGrpBox">
								<div>
									<input type="file" name="<%=fileFullGrp%>File1" id="program_<%=fileFullGrp%>File1" title="????????????" />
								</div>
							</div>
							<div style="display: inline-block; vertical-align: bottom;">
								<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="program_addRowFile('<%=fileFullGrp%>');" />
								<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="program_delRowFile('<%=fileFullGrp%>');" />
							</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '2';
					            function program_addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='program_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
				            		fileHtml += "</div>";

			            			$('#program_'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}

					            function program_delRowFile(fileGrpnm){
					            	if($('#program_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#program_'+fileGrpnm+'fileGrpBox > div').eq($('#program_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }

				            </script>

				     	 <% } %>
						</td>
					</tr>
				</tbody>
			</table>
			<!-- bo_btn  -->
			<div class="btn_right_box" style="text-align: right; width: 980px;">
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goCheck('program')"/>
				<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('view', 'program')"/>
			</div>
			<!--// bo_btn -->
		</div>
	</form>
	</div>

	<div id="knowhow_list">
	<form name="knowhow_fedit" 	id = "knowhow_fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
		<input type="hidden" 	id = "knowhow_mode" name = "mode" 		value = "<%=mode%>"/>
		<input type="hidden" 	id = "knowhow_idx" 	name = "idx" 		value = "<%=util.getIntStr(dataMap.get("SEARCH_KNOWHOW_IDX"))%>"/>
		<input type="hidden" 	id = "knowhow_reUrl" 		name = "reUrl"  	value="<%=myPage%>?mode=view&amp;list_mode=<%=list_mode%>&amp;idx=<%=idx%>" />
		<input type="hidden" 	id = "knowhow_list_mode" 	name = "list_mode"  value="<%=list_mode%>" />
		<input type="hidden" 	id = "knowhow_state" 		name = "state" 		value = "<%=util.getIntStr(dataMap.get("STATE"))%>"/>
		<input type="hidden" 	id = "knowhow_no" 			name = "no"  		value="0"/>
		<input type="hidden" 	name = "area" 			value = "<%=util.getIntStr(dataMap.get("AREA"))%>"/>

		<div class="skin_bbs_write" style="margin-top: 30px">
		<h2 class="tit2">?????????</h2>
				<span style="color:red; font-size:10pt;"> * ?????? ?????????????????????.</span>
	            <table class="skin_basic_write">
				<caption>????????????</caption>
					<colgroup>
						<col style="width:15%" />
						<col style="width:35%" />
						<col style="width:15%" />
						<col style="width:35%" />
					</colgroup>
				<tbody>
					<tr>
							<%-- <th scope="row" class="tit">???????????????</th>
							<td>
								<input type="text" name="knowHowNo" id="knowHowNo" value="<%=util.getStr(dataMap.get("KNOW_HOW_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" onKeyUp="NoCntCheck('knowhow')" />
								<input type="hidden" name="knowHowNoReal" id="knowHowNoReal" value="<%=util.getStr(dataMap.get("KNOW_HOW_NO")) %>" />
								<br/><span id = "knowhow_noResult"></span>
							</td> --%>
							<th class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td  colspan="3" >
								<input type="text" name="knowhowTchnlgyNm" id="knowhowTchnlgyNm" value="<%=util.getStr(dataMap.get("TCHNLGY_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>

						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????(?????????)</th>
							<td>
								<select name="knowhowTchnlgyMCl" id="knowhowTchnlgyMCl"  style="width:90%;" onchange="standardDeth1('knowhow')">
				 	  				<option value="">???????????????</option>
									<% for(HashMap rs:standardList) {%>
									<option value="<%=util.getStr(rs.get("CODE"))%>" <%=(util.getStr(dataMap.get("H_TCHNLGY_M_CL"))).equals(util.getStr(rs.get("CODE")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("NAME"))%></option>
									<%}%>
				 	  			</select>
							</td>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????(?????????)</th>
							<td>
								<input type="hidden" id="knowhowSCl" value="<%=util.getStr(dataMap.get("H_TCHNLGY_S_CL"))%>">
								<select name="knowhowTchnlgySCl" id="knowhowTchnlgySCl"  style="width:90%;">
									<option value="">???????????????</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>???????????????</th>
							<td>
								<input type="hidden" name="OwnOrg" id="knowhowOrgNm" value="<%=util.getStr(dataMap.get("ORG_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnOrgNm" id="knowhowOrg" value="<%=util.getStr(dataMap.get("ORG_GRP_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100"  readonly="readonly"/>

								<% if( util.getStr( loginVO.getAuthLv() ).equals("99") ){ %>
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm5" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgList')" >
								<% } %>
							</td>
							<th scope="row" class="tit">??????(??????)???</th>
							<td>
								<input type="hidden" name="OwnDept" id="knowhowDeptNm" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
								<input type="text" name="OwnDeptNm" id="knowhowDept" value="<%=util.getStr(dataMap.get("ORG_GRP_SUB_NM")) %>" style="width: 70%; font-size:10pt;" maxlength="100"  readonly="readonly"/>
								<input type="button" name="blngOrgNm" value="????????????" id="OwnDept5" class="btn_inp_g_01"  onclick="popupWindow('registrationOrgSubList')" >
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
								&nbsp;&nbsp;???????????? <input type="radio" name="knowhowArea" id="knowhowArea1" value="1" onclick="area2('knowhowsearchArea','1')" <%if(util.getStr(dataMap.get("AREA")).equals("1")) { %>checked="checked" <% } %> />
								&nbsp;&nbsp;???????????? ??? ?????? <input type="radio" name="knowhowArea" id="knowhowArea2" value="2"  onclick="area2('knowhowsearchArea','2')" <%if(util.getStr(dataMap.get("AREA")).equals("2")) { %>checked="checked" <% } %> />&nbsp;&nbsp;
								<select class="p_select" name="knowhowsearchArea" id="knowhowsearchArea1">
									<option value="">???????????????</option>
									<%
										int knowhownumArea = 1;
										for(HashMap rs:areaSigunguList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% knowhownumArea++; } %>
								</select>
								<select class="p_select" name="knowhowsearchArea" id="knowhowsearchArea2" style="display:none;">
									<option value="">???????????????</option>
									<%
										int knowhownumArea2 = 1;
										for(HashMap rs:areaList) {
										%>
									<option <%if(util.getStr(dataMap.get("AREA_SIGUNGU")).equals(util.getStr(rs.get("CODE_CD")))) { %>selected <% } %>
									value="<%=util.getStr(rs.get("CODE_CD"))%>"><%=util.getStr(rs.get("CODE_NM"))%></option>
									<% knowhownumArea2++; } %>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td colspan="3">
								<input type="hidden" name="ManagerIdx" id="knowhowManagerIdx" value="<%=util.getStr(dataMap.get("MANAGER_IDX")) %>" style="width: 70%; font-size:10pt;" maxlength="100" />
								<input type="button" name="operData" id="knowhowoperData" value="????????? ??????" class="btn_inp_g_01" onclick="popupWindow('registrationUserList')">
								<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerOrgNm" value="<%=util.getStr(dataMap.get("MANAGER_ORG")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerDeptNm"  id="knowhowManagerPsnNm" value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPsnNm" value="<%=util.getStr(dataMap.get("PSN_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">??????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="ManagerPosition" value="<%=util.getStr(dataMap.get("POSITION_NM")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>????????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerTel" value="<%=util.getStr(dataMap.get("TEL_NO")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th>?????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="ManagerEmail" value="<%=util.getStr(dataMap.get("EMAIL")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>

	                			</table>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td  colspan="3">
								<select name="knowhowBeforeInfo" id="knowhowBeforeInfo"  style="width: 37%;">
									<option value="">???????????????</option>
									<option value="E" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
									<option value="G" <%=(util.getStr(dataMap.get("BEFORE_INFO"))).equals("????????????")? "selected='selected'" : "" %> >????????????</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<td colspan="3">
								<textarea name="knowhowTechnologyDc" id="knowhowTechnologyDc" style="width: 98%; font-size:10pt;" ><%=dataMap.get("TECHNOLOGY_DC")%></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<td>
							<%
								if(imgfileList.size() > 0){
							%>
									<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
									<%
										int fileCnt = 1;
										for(HashMap rs:imgfileList){
											String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
									%>
										<li class="text">
											<input type="checkbox" name="imgfileFlog" id="knowhow_img_fileFlog_<%=fileCnt%>" value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('knowhow_img_')" />&nbsp;
											????????????&nbsp;&nbsp;
											 <img src="<%=util.getStr(dataMap.get("IMG_FILE_PATH"))+util.getStr(dataMap.get("IMG_TITLE"))%>" class="img-view"  alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/>
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" alt="?????????" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
											<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)

										</li>
									<% fileCnt++; }%>
									</ul>
									<div  style="display: none;"  id="knowhow_img_<%=fileFullImgGrp%>fileGrpBox" >
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="knowhow_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>
				            <% }else{ %>
									<div style="display: inline-block;" id="<%=fileFullImgGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullImgGrp%>File1" id="knowhow_img_<%=fileFullImgGrp%>File1" title="????????????" />
										</div>
										<br/>* 177x136px ????????? ????????? ??????????????????.
									</div>
						      <% } %>
						      </td>


							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>??????????????????</th>
							<td>
								<%
									if(fileList.size() > 0){
								%>
										<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
										<%
											int fileCnt = 1;
											for(HashMap rs:fileList){
												String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																	+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
																	+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
										%>
										<li class="text">
											<input type="checkbox" name="fileFlog" id="knowhow_fileFlog_<%=fileCnt%>"
													value="<%=util.getStr(rs.get("FILE_ID"))%>" />&nbsp;
											????????????&nbsp;&nbsp;
											<%-- <img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/> --%>
											<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
										</li>
									<% fileCnt++; }%>
									</ul>
									<div style="display: inline-block;" id="knowhow_<%=fileFullGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullGrp%>File1" id="knowhow_<%=fileFullGrp%>File1" title="????????????" />
										</div>
									</div>
									<div style="display: inline-block; vertical-align: bottom;">
										<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="knowhow_addRowFile('<%=fileFullGrp%>');" />
										<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="knowhow_delRowFile('<%=fileFullGrp%>');" />
									</div>
									<script type="text/javascript">
										var arrfileCnt = new Array();
										arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
							            function knowhow_addRowFile(fileGrpnm){
						            		var fileHtml = "<div>";
						            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='knowhow_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
						            		fileHtml += "</div>";

					            			$('#knowhow_'+fileGrpnm+'fileGrpBox').append(fileHtml);
					            			arrfileCnt[fileGrpnm]++;
						            	}

							            function knowhow_delRowFile(fileGrpnm){
							            	if($('#knowhow_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
							            		return;
							            	}
							            	$('#knowhow_'+fileGrpnm+'fileGrpBox > div').eq($('#knowhow_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
							            	arrfileCnt[fileGrpnm]--;
							            }
						            </script>

				            <% }else{ %>
									<div style="display: inline-block;"  id="knowhow_<%=fileFullGrp%>fileGrpBox">
										<div>
											<input type="file" name="<%=fileFullGrp%>File1" id="knowhow_<%=fileFullGrp%>File1" title="????????????" />
										</div>
									</div>
									<div style="display: inline-block; vertical-align: bottom;">
										<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="knowhow_addRowFile('<%=fileFullGrp%>');" />
										<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="knowhow_delRowFile('<%=fileFullGrp%>');" />
									</div>
									<script type="text/javascript">
										var arrfileCnt = new Array();
										arrfileCnt['<%=fileFullGrp%>'] = '2';
							            function knowhow_addRowFile(fileGrpnm){
						            		var fileHtml = "<div>";
						            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='knowhow_"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
						            		fileHtml += "</div>";

					            			$('#knowhow_'+fileGrpnm+'fileGrpBox').append(fileHtml);
					            			arrfileCnt[fileGrpnm]++;
						            	}

							            function knowhow_delRowFile(fileGrpnm){
							            	if($('#knowhow_'+fileGrpnm+'fileGrpBox > div').size() <= 1){
							            		return;
							            	}
							            	$('#knowhow_'+fileGrpnm+'fileGrpBox > div').eq($('#knowhow_'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
							            	arrfileCnt[fileGrpnm]--;
							            }

						            </script>

						     	 <% } %>
							</td>
						</tr>
					</tbody>
			</table>
			 <table class="skin_basic_write">
				<caption>????????????</caption>
					<colgroup>
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
						<col style="width:20%" />
					</colgroup>
					<tbody  id="participantList">
						<tr>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>???????????????</th>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>??????</th>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>????????????</th>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
							<th scope="row" class="tit"><span style="color:red; font-size:10pt;"> * </span>?????????</th>
						</tr>
						<tr>
							<td>
								<input type="text" name="knowhowRspnberUserNm" id="knowhowRspnberUserNm" value="<%=util.getStr(dataMap.get("RSPNBER_USER_NM")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td>
								<input type="text" name="knowhowRspnberOfcPosition" id="knowhowRspnberOfcPosition" value="<%=util.getStr(dataMap.get("RSPNBER_OFC_POSITION")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td>
								<input type="text" name="knowhowRspnberTelNo" id="knowhowRspnberTelNo" value="<%=util.getStr(dataMap.get("RSPNBER_TEL_NO")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td>
								<input type="text" name="knowhowRspnberMobilePhone" id="knowhowRspnberMobilePhone" value="<%=util.getStr(dataMap.get("RSPNBER_MOBILE_PHONE")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td>
								<input type="text" name="knowhowRspnberEmail" id="knowhowRspnberEmail" value="<%=util.getStr(dataMap.get("RSPNBER_EMAIL")) %>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
						</tr>
						<%-- <tr>
							<th scope="row" class="tit" colspan="2">???????????????(??????)</th>
							<th scope="row" class="tit">???????????????(??????)</th>
							<th scope="row" class="tit">???????????????(??????)</th>
							<th scope="row" class="tit"></th>
						</tr>
<%
if(!(util.getStr(dataMap.get("PARTICIPANT_USER_NAME"))).equals("") && !(util.getStr(dataMap.get("PARTICIPANT_USER_NAME"))).equals(null)){
		String name[] = dataMap.get("PARTICIPANT_USER_NAME").split(", ");
		String position[] = dataMap.get("PARTICIPANT_POSITION").split(", ");
		String ofcPosition[] = dataMap.get("PARTICIPANT_OFC_POSITION").split(", ");
		if(name.length > 0){
			for(int i=0; i<name.length; i++){

%>						<tr>
							<td colspan="2">
								<input type="hidden" name="cnt" id="<%=cnt%>" />
								<input type="text" name="knowhowParticipantUserName" id="knowhowParticipantUserName<%=cnt%>" value="<%=name[i]%>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td>
								<input type="text" name="knowhowParticipantPosition" id="knowhowParticipantPosition<%=cnt%>" value="<%=position[i]%>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td>
								<input type="text" name="knowhowParticipantOfcPosition" id="knowhowParticipantOfcPosition<%=cnt%>" value="<%=ofcPosition[i]%>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td style="text-align: center; vertical-align: middle;">
								<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow()" />
                               	&nbsp<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow(this)" />
							</td>
						</tr>
<%				cnt++;
			}
		}else{
%>
						<tr>
							<td colspan="2">
								<input type="hidden" name="cnt" id="<%=cnt%>" />
								<input type="text" name="knowhowParticipantUserName" id="knowhowParticipantUserName<%=cnt%>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td>
								<input type="text" name="knowhowParticipantPosition" id="knowhowParticipantPosition<%=cnt%>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td>
								<input type="text" name="knowhowParticipantOfcPosition" id="knowhowParticipantOfcPosition<%=cnt%>" style="width: 90%; font-size:10pt;" maxlength="100" />
							</td>
							<td style="text-align: center; vertical-align: middle;">
								<input type="button" name="addbtn" value="+" style="width:30px;height:20px;" onclick="addRow()" />
                               	&nbsp<input type="button" name="delbtn" value="-" style="width:30px;height:20px;" onclick="delRow(this)" />
							</td>
						</tr>
<%		}
}
%>

 --%>

				</tbody>
			</table>
			<!-- bo_btn  -->
			<div class="btn_right_box" style="text-align: right; width: 980px;">
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goCheck('knowhow')"/>
				<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('view', 'knowhow')"/>
			</div>
			<!--// bo_btn -->
		</div>
	</form>
	</div>

<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	function popupWindow(listMode){
		var popUrl="";
    	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,width=300,height=400,left=0,top=0';
		if(listMode == 'registrationOrgSubList'){
			popUrl="/sys/popup/"+listMode+".do?orgGrpCd="+$('input[name=OwnOrg]').val();
		}else{
    		popUrl="/sys/popup/"+listMode+".do";
		}
   		var popOption="width=450, height=550, resizable=no, scrollbars=no, status=no;";
    	window.open(popUrl,"",popOption);
     }

	function fileSet(fileCnt){
		if($('#'+fileCnt+'fileFlog_1').is(':checked')){
			$('#'+fileCnt+'<%=fileFullImgGrp%>fileGrpBox').attr("style","display:inline-block;");
		}else{
			$('#'+fileCnt+'<%=fileFullImgGrp%>File1').val("");
			$('#'+fileCnt+'<%=fileFullImgGrp%>fileGrpBox').attr("style","display:none;");
		}
	}

	function fileStatementSet(fileCnt){

		if($('#'+fileCnt+'fileFlog_1').is(':checked')){
			$('#'+fileCnt+'<%=fileFullStatementGrp%>fileGrpBox').attr("style","display:inline-block;");
		}else{
			$('#'+fileCnt+'<%=fileFullStatementGrp%>File1').val("");
			$('#'+fileCnt+'<%=fileFullStatementGrp%>fileGrpBox').attr("style","display:none;");
		}
	}
	function goSubmit(mode, list_mode){

		if(mode=="editProc"){
			//????????? ??????
			if (confirm("??????????????????????????") == true){ //??????
				/* if(permEditor=="Y"){
					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				} */
			}else{ //??????
			    return;
			}
		}

		var form_name = "";
		var form_mode = "";
		if(list_mode == "utility"){
			form_name = "utility_fedit";
			form_mode = "utility_mode";
		}
		if(list_mode == "design"){
			form_name = "design_fedit";
			form_mode = "design_mode";
		}
		if(list_mode == "brand"){
			form_name = "brand_fedit";
			form_mode = "brand_mode";
		}
		if(list_mode == "program"){
			form_name = "program_fedit";
			form_mode = "program_mode";
		}
		if(list_mode == "knowhow"){
			form_name = "knowhow_fedit";
			form_mode = "knowhow_mode";
		}
		$('#'+form_mode).val(mode);
		$('#'+form_name).submit();
	}

	var permEditor = $('#permEditor').val();
	if(permEditor=="Y"){
	    var oEditors = [];
		$(function(){
			// ?????? ?????? ??????
			//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "contents",
				sSkinURI: "/js/webeditor_nhn/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true,				// ?????? ?????? ?????? (true:??????/ false:???????????? ??????)
					bUseVerticalResizer : true,		// ????????? ?????? ????????? ?????? ?????? (true:??????/ false:???????????? ??????)
					bUseModeChanger : true,			// ?????? ???(Editor | HTML | TEXT) ?????? ?????? (true:??????/ false:???????????? ??????)
					//aAdditionalFontList : aAdditionalFontSet,		// ?????? ?????? ??????
				}, //boolean

				fCreator : "createSEditor2"
			});
		});
	}


	var fileCount = $("input[type=file]").length;
		for(i = 1; i <= fileCount; i++) {
			$('#jnsptotalFile'+fileCount).bind('change', function(){
				var fileName = $('#jnsptotalFile'+fileCount).val();
				if(fileName != "" || fileName != null){
					fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
					if(imgPattern.indexOf(fileName)==-1){
						alert("??????????????? bmp, gif, jpg, jpeg, png ????????? ????????? ????????????????????????.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}else if(this.files[0].size<300000){
						alert("300kb ????????? ???????????? ??????????????????.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}
				}
			});
		}

		$(".addImageBtn,.delImageBtn").bind('click', function(){
			var fileCount = $("input[type=file]").length;
			$('#jnsptotalFile'+fileCount).bind('change', function(){
				var fileName = $('#jnsptotalFile'+fileCount).val();

				if(fileName != "" || fileName != null){
				    fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
				    if(imgPattern.indexOf(fileName)==-1){
				   		alert("??????????????? bmp, gif, jpg, jpeg, png ????????? ????????? ????????????????????????.");
				   		$('#jnsptotalFile'+fileCount).val("");
				   		return false;
				    }else if(this.files[0].size<300000){
						alert("300kb ????????? ???????????? ??????????????????.");
						$('#jnsptotalFile'+fileCount).val("");
						return false;
					}
				}
			});
		});


	 	function check_only(chk){
           var obj = document.getElementsByName("noticeAt");
           for(var i=0; i<obj.length; i++){
               if(obj[i] != chk){
                   obj[i].checked = false;
               }
           }
     	}



	 	$( document ).ready(function() {
	 		var areaId = "";
	 		var areaNo = $('input[name=area]').val();

			var cb;
			cb = $('#noticeCheck').val();
			$('input:checkbox[name="noticeAt"]').each(function() {

		    	if(this.value == cb){ //??? ??????
		        	this.checked = true; //checked ??????
		      	}
			 });
			var list_mode = "<%=list_mode%>";
			var result = "";
			var deth3 = "";
			var value = "";
			if(list_mode == "utility"){
				deth3 = $("#utilityTchnlgyMCl").val();
				value = $("#utilitySCl").val();
	        	$("#utilityTchnlgySCl").html("");
	        	areaId = "utilitysearchArea";
			}else if(list_mode == "brand"){
				deth3 = $("#brandTchnlgyMCl").val();
				value = $("#brandSCl").val();
	        	$("#brandTchnlgySCl").html("");
	        	areaId = "brandsearchArea";
	        }else if(list_mode == "program"){
				deth3 = $("#programTchnlgyMCl").val();
				value = $("#programSCl").val();
		        $("#programTchnlgySCl").html("");
		        areaId = "programsearchArea";
			}else if(list_mode == "design"){
				deth3 = $("#designTchnlgyMCl").val();
				value = $("#designSCl").val();
		        $("#designTchnlgySCl").html("");
		        areaId = "designsearchArea";
			}else{
				deth3 = $("#knowhowTchnlgyMCl").val();
	        	value = $("#knowhowSCl").val();
	        	$("#knowhowTchnlgySCl").html("");
				areaId = "knowhowsearchArea";
			}
			area2(areaId,areaNo ,'start');
				$.ajax({
		            type: "POST",
		            data : {
		           	 deth3 : deth3
		            },
		            url : '/sys/dethCheck.do',
		            dataType : 'json',
		            success : function(data){
			            result += "<option value=''>???????????????.</option>";
			            for(i=0; i<data.cnt; i++){
				           	if(value == data.dataList[i].CODE){
			        			result += "<option value=\""+data.dataList[i].CODE+"\" selected='selected'>"+data.dataList[i].NAME+"</option>";

			        		}else{
			        			result += "<option value=\""+data.dataList[i].CODE+"\" >"+data.dataList[i].NAME+"</option>";
			        		}
			            }
			        	if(list_mode == "utility"){
			           		$("#utilityTchnlgySCl").append(result);
			           	}else if(list_mode == "brand"){
			           		$("#brandTchnlgySCl").append(result);
			           	}else if(list_mode == "program"){
			           		$("#programTchnlgySCl").append(result);
			           	}else if(list_mode == "design"){
		           			$("#designTchnlgySCl").append(result);
						}else{
					        $("#knowhowTchnlgySCl").append(result);
						}
	           		}
	            });



	 });
	 	function area2(mode,no,start){
		if(no =="2"){
			if(start != "start"){
				$("#"+mode+"1").val("");
			}
			$("#"+mode+"1").attr("name","0");
			$("#"+mode+"2").attr("name",mode);
			$("#"+mode+"1").hide();
			$("#"+mode+"2").show();
		}else{
			if(start != "start"){
				$("#"+mode+"2").val("");
			}
			$("#"+mode+"2").attr("name","0");
			$("#"+mode+"1").attr("name",mode);
			$("#"+mode+"2").hide();
			$("#"+mode+"1").show();
		}
	}


	 	function standardDeth1(mode){
		var result = "";
		var deth3 = "";

		if(mode == "utility"){
			deth3 = $("#utilityTchnlgyMCl").val();
	        $("#utilityTchnlgySCl").html("");
		}else if(mode == "design"){
			deth3 = $("#designTchnlgyMCl").val();
	        $("#designTchnlgySCl").html("");
		}else if(mode == "brand"){
			deth3 = $("#brandTchnlgyMCl").val();
	        $("#brandTchnlgySCl").html("");
		}else if(mode == "program"){
			deth3 = $("#programTchnlgyMCl").val();
	        $("#programTchnlgySCl").html("");
		}else if(mode == "knowhow"){
			deth3 = $("#knowhowTchnlgyMCl").val();
	        $("#knowhowTchnlgySCl").html("");
		}
	 	$.ajax({
	            type: "POST",
	            data : {
	           	 deth3 : deth3
	            },
	            url : '/sys/dethCheck.do',
	            dataType : 'json',
	            success : function(data){
	            result += "<option value=''>???????????????.</option>";
	           	for(i=0; i<data.cnt; i++){
					result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
				}
	           		if(mode == "utility"){
	           			$("#utilityTchnlgySCl").append(result);
	           		}else if(mode == "design"){
	           			$("#designTchnlgySCl").append(result);
					}else if(mode == "brand"){
						$("#brandTchnlgySCl").append(result);
					}else if(mode == "program"){
						$("#programTchnlgySCl").append(result);
					}else if(mode == "knowhow"){
				        $("#knowhowTchnlgySCl").append(result);
					}
	    	}
	   	});
	}

	function showNationNm(val){
		if(val == "A"){
			$("#utilityNationNm").val("");
			$("#utilityNationNm").hide();
		}else{
			$("#utilityNationNm").val("");
			$("#utilityNationNm").show();
		}
	}
	function showSort(val){
		if(val == "A"){
			$("#designIntrlCl").val("");
			$("#designIntrlCl").hide();
		}else{
			$("#designIntrlCl").val("");
			$("#designIntrlCl").show();
		}
	}

 	 $("#utilityAplcDt ,#utilityRegDt ,#utilityPublicDt ,#utilityFirstPaymentDt ,#utilityYearPaymentDt ,#designAplcDt ,#designPublicDt, "
	 +"#designRegDt ,#designYearPaymentDt ,#brandIntrlAplcDt ,#brandPblancDt ,#brandRegDt ,#brandYearPaymentDt ,#programCrtWorkDe ,#programPublictDe ,#programRegDe ,#knowhowRegDt").datepicker({
       	showMonthAfterYear : true,
			showButtonPanel : true,
			changeMonth : true,
			changeYear : true,
			nextText : '?????? ???',
			prevText : '?????? ???',
			currentText : '?????? ??????',
			closeText : '??????',
			dateFormat : "yy-mm-dd",
			dayNames : [ '?????????', '?????????', '?????????', '?????????', '?????????', '?????????', '?????????' ],
			dayNamesMin : [ '???', '???', '???', '???', '???', '???', '???' ],
			monthNames : [ '1???', '2???', '3???', '4???', '5???', '6???', '7???', '8???', '9???', '10???', '11???', '12???' ],
			monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
       });
function NoCntCheck(list_mode){

	var no = "";
	noResult = "";
	var result ="";
	if(list_mode == "utility"){
		no = $("#utilityAplcNo").val();
		noResult = "#utility_noResult";
	}else if(list_mode == "design"){
		no = $("#designAplcNo").val();
		noResult = "#design_noResult";
	}else if(list_mode == "brand"){
		no = $("#brandIntrlAplcNo").val();
		noResult = "#brand_noResult";
	}else if(list_mode == "program"){
		no = $("#programRegNo").val();
		noResult = "#program_noResult";
	}else if(list_mode == "knowhow"){
		no = $("#knowHowNo").val();
		noResult = "#knowhow_noResult";
	}

	var check ="";
		if(list_mode == "utility"){
			check = $("#utilityAplcNoReal").val();
		}else if(list_mode == "design"){
			check = $("#designAplcNoReal").val();
		}else if(list_mode == "brand"){
			check = $("#brandIntrlAplcNoReal").val();
		}else if(list_mode == "program"){
			check = $("#programRegNoReal").val();
		}else if(list_mode == "knowhow"){
			check = $("#knowHowNoReal").val();
	}

	if(no !=null && no != ""){
	$.ajax({
            type: "POST",
            data : {
           	 noCnt : no
            },
            url : '/sys/getNoCnt.do',
            dataType : 'json',
            success : function(data){
            	result = data.noCnt;
			if(check == no){
				result = "0";
			}

           	 if(result == "0"){
           		 $("input[name='no']").val("0");
           		 $(noResult).css("color", "blue")
				 $(noResult).css("margin-left", "10px")
				 $(noResult).text('?????? ???????????????.');
           	 }else{
           		 $("input[name='no']").val("1");
           		 $(noResult).css("color", "red")
				 $(noResult).css("margin-left", "10px")
				 $(noResult).text('?????? ??????????????????.');
           	 }
            }
   	});

	}else{
		alert("???????????? ?????? ??????????????? ??????????????????.");
		if(mode == "utility"){
			$("#utilityAplcNo").focus();
		}else if(mode == "design"){
			$("#designAplcNo").focus();
		}else if(mode == "brand"){
			$("#brandIntrlAplcNo").focus();
		}else if(mode == "program"){
			$("#programRegNo").focus();
		}else if(list_mode == "knowhow"){
			$("#knowHowNo").focus();
		}
		return false;
	}
}

  		function addRow(){

                var cnt = $('input[name=cnt]:last').attr('id'); //lc_dt0::String???

                /* ????????????  */
                if($("#knowhowParticipantUserName"+cnt).val() == ""){
                     alert("???????????????(??????)??? ?????? ????????????");
                     return false;
                }
                if($("#knowhowParticipantPosition"+cnt).val() == ""){
                     alert("???????????????(??????)??? ?????? ????????????");
                     return false;
                }
                if($("#knowhowParticipantOfcPosition"+cnt).val() == ""){
                     alert("???????????????(??????)??? ?????? ????????????");
                     return false;
                }


                var intCnt = parseInt(cnt)+1; //???::1 int????????? ??????

                var row = "";
                row += "<tr>";
                row += "<td colspan='2'> <input type='hidden' name='cnt' id='"+intCnt+"' />"
                row += "<input type='text' name='knowhowParticipantUserName' id='knowhowParticipantUserName"+intCnt+"' style='width: 90%; font-size:10pt;' maxlength='100' /></td>";
                row += "<td><input type='text' name='knowhowParticipantPosition' id='knowhowParticipantPosition"+intCnt+"' style='width: 90%; font-size:10pt;' maxlength='100' /></td>";
                row += "<td><input type='text' name='knowhowParticipantOfcPosition' id='knowhowParticipantOfcPosition"+intCnt+"' style='width: 90%; font-size:10pt;' maxlength='100' /></td>";
                row += "<td style='text-align: center; vertical-align: middle;'>"
                row += "<input type='button' name='addbtn' value='+' style='width:30px;height:20px;' onclick='addRow();' />";
                row += "&nbsp<input type='button' name='delbtn' value='-' style='width:30px;height:20px;' onclick='delRow(this);' /></td>";
                row += "</tr>";

                //alert(row);
               $("#participantList").append(row);

           }

           function delRow(myThis){

                if($('input[name=lc_nm]').size() == 1){
                     alert("?????? ??? ??? ????????????.");
                     return false;
                };

                var parenttr = $(myThis).parent().parent().remove();
           }

var idPattern = /[^a-zA-Z0-9]/;
var korPattern = /[^???-???]/;
var engPattern = /[^a-zA-Z- ]/;
var numPattern = /[^\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
var imgFormat = "\.(bmp|gif|jpg|jpeg|png|JPG|BMP|GIP|JPEG|PNG)$";
var pdfFormat = "\.(pdf|PDF)$";
var datePattern = /^[0-9]{4}-[0-9]{2}-[0-9]{2}/;
var emailPattern = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
var mobilePhonePattern = /^\d{3}-\d{3,4}-\d{4}$/;
var phonePattern = /^\d{2,3}-\d{3,4}-\d{4}$/;

function goCheck(list_mode){
	var value = new Array();
	var vNum = 0;
	var file = new Array();
	var fNum = 0;
	var num = new Array();
	var nNum = 0;
	var date = new Array();
	var dNum = 0;
	var check = "" ;
	var msg ="";

	if(list_mode == "utility"){
			<%-- if($("#utilityAplcNo").val() == null || $("#utilityAplcNo").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if(!$("input[name='utilityAplcNation']").is(":checked")){
				value[vNum]  = "?????????";
				vNum++;
			}
			if($("#utilityAplcDt").val() == null ||$("#utilityAplcDt").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#utilityAplcUser").val() == null ||$("#utilityAplcUser").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("#utilityInventionKorNm").val() == null ||$("#utilityInventionKorNm").val() == ""){
				value[vNum] = "????????????(??????)";
				vNum++;
			}
			if($("#utilityInventionEngNm").val() == null ||$("#utilityInventionEngNm").val() == ""){
				value[vNum] = "????????????(??????)";
				vNum++;
			}
			if($("#utilityInventor").val() == null ||$("#utilityInventor").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("#utilityIcpCl").val() == null ||$("#utilityIcpCl").val() == ""){
				value[vNum] = "ICP??????";
				vNum++;
			}
			 if ($("select[name=utilityRightSe]").val() == null ||$("select[name=utilityRightSe]").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			 if($("select[name=utilityRightStatus]").val() == null ||$("select[name=utilityRightStatus]").val() == ""){
			 	value[vNum] = "????????????";
				vNum++;
			 }
			if($("#utilityRegNo").val() == null ||$("#utilityRegNo").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#utilityRegDt").val() == null ||$("#utilityRegDt").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("select[name=utilityBeforeInfo]").val() == null ||$("select[name=utilityBeforeInfo]").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("select[name=utilityTchnlgyyGrade]").val() == null ||$("select[name=utilityTchnlgyyGrade]").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#utilityTchnlgyMCl").val() == null ||$("#utilityTchnlgyMCl").val() == ""){
				value[vNum] = "????????????(?????????)";
				vNum++;
			}
			if($("#utilityTchnlgySCl").val() == null ||$("#utilityTchnlgySCl").val() == ""){
				value[vNum] = "????????????(?????????)";
				vNum++;
			}
			if($("#utilityTechnologyDc").val() == null ||$("#utilityTechnologyDc").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#utilityOwnOrgNm").val() == null ||$("#utilityOwnOrgNm").val() == ""){
				value[vNum] = "???????????????";
				vNum++;
			}
			if($("[name=utilitysearchArea]").val() == null ||$("[name=utilitysearchArea]").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("#utility_img_<%=fileFullImgGrp%>File1").val() == null || $("#utility_img_<%=fileFullImgGrp%>File1").val() == ""){
				file[fNum] = "?????????";
				fNum++;
			}
			if($("#utility_statement_<%=fileFullStatementGrp%>File1").val() == null || $("#utility_statement_<%=fileFullStatementGrp%>File1").val() == ""){
				file[fNum] = "?????????";
				fNum++;
			}
			if(isNaN($("#utilityAplcNo").val())){
				num[nNum] = "????????????";
				nNum++;
			}
			if(isNaN($("#utilityRegNo").val())){
				num[nNum] = "????????????";
				nNum++;
			}
			if($("#utilityAplcDt").val() != "" && datePattern.test($("#utilityAplcDt").val()) == false){
				date[dNum] = "????????????";
				dNum++;
			}
			if($("#utilityRegDt").val() != "" && datePattern.test($("#utilityRegDt").val()) == false){
				date[dNum] = "????????????";
				dNum++;
			}
			if($("input[name='no']").val()!="0"){
				check += "* ???????????? ?????? ???????????? ??????????????? ???????????????. \n";
			}
			if($("#utility_img_<%=fileFullImgGrp%>File1").val() != "" && (new RegExp(imgFormat)).test($("#utility_img_<%=fileFullImgGrp%>File1").val()) == false){
				check += "* ?????????????????? ??????????????????. \n : ????????? \n";
			}
			if($("#utility_statement_<%=fileFullStatementGrp%>File1").val() != "" && (new RegExp(pdfFormat)).test($("#utility_statement_<%=fileFullStatementGrp%>File1").val()) == false){
				check += "* PDF????????? ??????????????????. \n : ????????? \n";
			} --%>

	}else if(list_mode == "design"){
			<%-- if($("#designAplcNo").val() == null || $("#designAplcNo").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#designAplcDt").val() == null ||$("#designAplcDt").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#designAplcUser").val() == null ||$("#designAplcUser").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("#designUseNm").val() == null ||$("#designUseNm").val() == ""){
				value[vNum] = "??????";
				vNum++;
			}
			if($("select[name=designRightStatus]").val() == null ||$("select[name=designRightStatus]").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#designCreationUser").val() == null ||$("#designCreationUser").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("select[name=designBeforeInfo]").val() == null ||$("select[name=designBeforeInfo]").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("select[name=designTchnlgyMCl]").val() == null ||$("select[name=designTchnlgyMCl]").val() == ""){
				value[vNum] = "????????????(?????????)";
				vNum++;
			}
			if($("select[name=designTchnlgySCl]").val() == null ||$("select[name=designTchnlgySCl]").val() == ""){
				value[vNum] = "????????????(?????????)";
				vNum++;
			}
			if($("#designTechnologyDc").val() == null ||$("#designTechnologyDc").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#designOwnOrgNm").val() == null ||$("#designOwnOrgNm").val() == ""){
				value[vNum] = "???????????????";
				vNum++;
			}
			if(!$("input[name='designArea']").is(":checked")){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("[name=designsearchArea]").val() == null ||$("[name=designsearchArea]").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("#design_img_<%=fileFullImgGrp%>File1").val() == null || $("#design_img_<%=fileFullImgGrp%>File1").val() == ""){
				file[fNum] = "?????????";
				fNum++;
			}
			if($("#design_statement_<%=fileFullStatementGrp%>File1").val() == null || $("#design_statement_<%=fileFullStatementGrp%>File1").val() == ""){
				file[fNum] = "?????????";
				fNum++;
			}
			if(isNaN($("#designAplcNo").val())){
				num[nNum] = "????????????";
				nNum++;
			}
			if(isNaN($("#designRegNo").val())){
				num[nNum] = "????????????";
				nNum++;
			}
			if($("#designAplcDt").val() != "" && datePattern.test($("#designAplcDt").val()) == false){
				date[dNum] = "????????????";
				dNum++;
			}
			if($("#designRegDt").val() != "" && datePattern.test($("#designRegDt").val()) == false){
				date[dNum] = "????????????";
				dNum++;
			}
			if($("input[name='no']").val()!="0"){
				check += "* ???????????? ?????? ???????????? ??????????????? ???????????????. \n";
			}
			if($("#design_img_<%=fileFullImgGrp%>File1").val() != "" && (new RegExp(imgFormat)).test($("#design_img_<%=fileFullImgGrp%>File1").val()) == false){
				check += "* ?????????????????? ??????????????????. \n : ????????? \n";
			}
			if($("#design_statement_<%=fileFullStatementGrp%>File1").val() != "" && (new RegExp(pdfFormat)).test($("#design_statement_<%=fileFullStatementGrp%>File1").val()) == false){
				check += "* PDF????????? ??????????????????. \n : ????????? \n";
			} --%>
	}else if(list_mode == "brand"){
			<%-- if($("#brandIntrlAplcNo").val() == null ||$("#brandIntrlAplcNo").val() == ""){
				value[vNum] = "??????(????????????)??????";
				vNum++;
			}
			if($("#brandIntrlAplcDt").val() == null ||$("#brandIntrlAplcDt").val() == ""){
				value[vNum] = "??????(????????????)??????";
				vNum++;
			}
			if($("#brandUseNm").val() == null ||$("#brandUseNm").val() == ""){
				value[vNum] = "??????";
				vNum++;
			}
			if($("#brandGoodsCl").val() == null ||$("#brandGoodsCl").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#brandFigureCode").val() == null ||$("#brandFigureCode").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#brandRegNo").val() == null ||$("#brandRegNo").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#brandRegDt").val() == null ||$("#brandRegDt").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("select[name=brandRightStatus]").val() == null ||$("select[name=brandRightStatus]").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("select[name=brandBeforeInfo]").val() == null ||$("select[name=brandBeforeInfo]").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("select[name=brandTchnlgyMCl]").val() == null ||$("select[name=brandTchnlgyMCl]").val() == ""){
				value[vNum] = "????????????(?????????)";
				vNum++;
			}
			if($("select[name=brandTchnlgySCl]").val() == null ||$("select[name=brandTchnlgySCl]").val() == ""){
				value[vNum] = "????????????(?????????)";
				vNum++;
			}
			if($("#brandTechnologyDc").val() == null ||$("#brandTechnologyDc").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#brandOwnOrgNm").val() == null ||$("#brandOwnOrgNm").val() == ""){
				value[vNum] = "???????????????";
				vNum++;
			}
			if(!$("input[name='brandArea']").is(":checked")){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("[name=brandsearchArea]").val() == null ||$("[name=brandsearchArea]").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("#brand_img_<%=fileFullImgGrp%>File1").val() == null || $("#brand_img_<%=fileFullImgGrp%>File1").val() == ""){
				file[fNum] = "?????????";
				fNum++;
			}
			if($("#brand_statement_<%=fileFullStatementGrp%>File1").val() == null || $("#brand_statement_<%=fileFullStatementGrp%>File1").val() == ""){
				file[fNum] = "?????????";
				fNum++;
			}
			if(isNaN($("#brandIntrlAplcNo").val())){
				num[nNum] = "??????(????????????)??????";
				nNum++;
			}
			if(isNaN($("#brandRegNo").val())){
				num[nNum] = "????????????";
				nNum++;
			}
			if($("#brandIntrlAplcDt").val() != "" && datePattern.test($("#brandIntrlAplcDt").val()) == false){
				date[dNum] = "??????(????????????)??????";
				dNum++;
			}
			if($("#brandRegDt").val() != "" && datePattern.test($("#brandRegDt").val()) == false){
				date[dNum] = "????????????";
				dNum++;
			}
			if($("input[name='no']").val()!="0"){
				check += "* ???????????? ?????? ???????????? ??????????????? ???????????????. \n";
			}
			if($("#brand_img_<%=fileFullImgGrp%>File1").val() != "" && (new RegExp(imgFormat)).test($("#brand_img_<%=fileFullImgGrp%>File1").val()) == false){
				check += "* ?????????????????? ??????????????????. \n : ????????? \n";
			}
			if($("#brand_statement_<%=fileFullStatementGrp%>File1").val() != "" && (new RegExp(pdfFormat)).test($("#brand_statement_<%=fileFullStatementGrp%>File1").val()) == false){
				check += "* PDF????????? ??????????????????. \n : ????????? \n";
			}
 --%>
	}else if(list_mode == "program"){
			<%-- if($("#programCrtWorkDe").val() == null ||$("#programCrtWorkDe").val() == ""){
				alert("??????????????? : ????????????????????????.");
				$("#programCrtWorkDe").focus();
				return false;
			}else if($("input[name='no']").val() != "0"){
				alert("???????????? ?????? ???????????? ??????????????? ???????????????.");
				return false;
			}else if(datePattern.test($("#programCrtWorkDe").val()) == false){
				alert("??????????????? : ex) 2016-01-01");
				$("#programCrtWorkDe").focus();
				return false;
			}else if($("#programPublictDe").val() == null ||$("#programPublictDe").val() == ""){
				alert("??????????????? : ????????????????????????.");
				$("#programPublictDe").focus();
				return false;
			}else if(datePattern.test($("#programPublictDe").val()) == false){
				alert("??????????????? : ex) 2016-01-01");
				$("#programPublictDe").focus();
				return false;
			}else if($("#programRegDe").val() == null ||$("#programRegDe").val() == ""){
				alert("??????????????? : ????????????????????????.");
				$("#programRegDe").focus();
				return false;
			}else if(datePattern.test($("#programRegDe").val()) == false){
				alert("??????????????? : ex) 2016-01-01");
				$("#programRegDe").focus();
				return false;
			}else if($("#programRegNo").val() == null || $("#programRegNo").val() == ""){
				alert("???????????? : ????????????????????????.");
				$("#programRegNo").focus();
				return false;
			}else if(isNaN($("#programRegNo").val())){
				alert("???????????? : ????????? ??????????????????.");
				$("#programRegNo").focus();
				return false;
			}else if($("#programUseNm").val() == null || $("#programUseNm").val() == ""){
				alert("?????? : ????????????????????????.");
				$("#programUseNm").focus();
				return false;
			}else if($("#programPgmAuthor").val() == null || $("#programPgmAuthor").val() == ""){
				alert("????????????????????? : ????????????????????????.");
				$("#programPgmAuthor").focus();
				return false;
			}else if($("#programOwnOrgNm").val() == null || $("#programOwnOrgNm").val() == ""){
				alert("??????????????? : ????????????????????????.");
				$("#programOwnOrgNm").focus();
				return false;
			}else if($("#programOwnDeptNm").val() == null || $("#programOwnDeptNm").val() == ""){
				alert("??????????????? : ????????????????????????.");
				$("#programOwnDeptNm").focus();
				return false;
			}else if($("#programTchnlgyMCl").val() == null || $("#programTchnlgyMCl").val() == ""){
				alert("????????????(?????????) : ????????????????????????.");
				$("#programTchnlgyMCl").focus();
				return false;
			}else if($("#programTchnlgySCl").val() == null || $("#programTchnlgySCl").val() == ""){
				alert("????????????(?????????) : ????????????????????????.");
				$("#programTchnlgySCl").focus();
				return false;
			}else if($("#programBeforeInfo").val() == null || $("#programBeforeInfo").val() == ""){
				alert("???????????? : ????????????????????????.");
				$("#programBeforeInfo").focus();
				return false;
			}else if($("#programPgmDc").val() == null || $("#programPgmDc").val() == ""){
				alert("?????????????????? : ????????????????????????.");
				$("#programPgmDc").focus();
				return false;
			}else if(!$("input[name='programArea']").is(":checked")){
				alert("???????????? : ????????????????????????.");
				$("select[name='programsearchArea']").focus();
				return false;
			}else if($('#programsearchArea1').val() == "" && $('#programsearchArea2').val() == "" ){
				alert("????????? : ????????????????????????.");
				$("select[name='programsearchArea']").focus();
				return false;
			}else if($("#program_img_<%=fileFullImgGrp%>File1").val() != null && $("#program_img_<%=fileFullImgGrp%>File1").val() != "" && (new RegExp(imgFormat)).test($("#program_img_<%=fileFullImgGrp%>File1").val()) == false){
				alert("????????? : ?????????????????? ??????????????????.");
				return false;
			}
 --%>

	}else if(list_mode == "knowhow"){
			<%-- if($("#knowhowTchnlgyNm").val() == null ||$("#knowhowTchnlgyNm").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("select[name=knowhowTchnlgyMCl]").val() == null ||$("select[name=knowhowTchnlgyMCl]").val() == ""){
				value[vNum] = "????????????(?????????)";
				vNum++;
			}
			if($("select[name=knowhowTchnlgySCl]").val() == null ||$("select[name=knowhowTchnlgySCl]").val() == ""){
				value[vNum] = "????????????(?????????)";
				vNum++;
			}
			if($("#knowhowOrgNm").val() == null ||$("#knowhowOrgNm").val() == ""){
				value[vNum] = "???????????????";
				vNum++;
			}
			if(!$("input[name='knowhowArea']").is(":checked")){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("[name=knowhowsearchArea]").val() == null ||$("[name=knowhowsearchArea]").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("select[name=knowhowBeforeInfo]").val() == null ||$("select[name=knowhowBeforeInfo]").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#knowhowTechnologyDc").val() == null ||$("#knowhowTechnologyDc").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#knowhowRspnberUserNm").val() == null ||$("#knowhowRspnberUserNm").val() == ""){
				value[vNum] = "???????????????";
				vNum++;
			}
			if($("#knowhowRspnberOfcPosition").val() == null ||$("#knowhowRspnberOfcPosition").val() == ""){
				value[vNum] = "??????";
				vNum++;
			}
			if($("#knowhowRspnberTelNo").val() == null ||$("#knowhowRspnberTelNo").val() == ""){
				value[vNum] = "????????????";
				vNum++;
			}
			if($("#knowhowRspnberMobilePhone").val() == null ||$("#knowhowRspnberMobilePhone").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("#knowhowRspnberEmail").val() == null ||$("#knowhowRspnberEmail").val() == ""){
				value[vNum] = "?????????";
				vNum++;
			}
			if($("#knowhow_img_<%=fileFullImgGrp%>File1").val() == null || $("#knowhow_img_<%=fileFullImgGrp%>File1").val() == ""){
				file[fNum] = "?????????";
				fNum++;
			}
			if($("#knowhow_<%=fileFullGrp%>File1").val() == null || $("#knowhow_<%=fileFullGrp%>File1").val() == ""){
				file[fNum] = "??????????????????";
				fNum++;
			}
			if($("#knowhowRspnberTelNo").val() != "" && phonePattern.test($("#knowhowRspnberTelNo").val()) == false){
				check += "* ex) 2016-01-01 \n : ????????????";
			}
			if($("#knowhowRspnberMobilePhone").val() != "" && mobilePhonePattern.test($("#knowhowRspnberMobilePhone").val()) == false){
				check += "* ex) 010-0000-0000 \n : ?????????";
			}
			if($("#knowhowRspnberEmail").val() != "" && emailPattern.test($("#knowhowRspnberEmail").val()) == false){
				check += "* ex) 0000000@gmail.com \n : ?????????";
			}

			if($("#knowhow_img_<%=fileFullImgGrp%>File1").val() != "" && (new RegExp(imgFormat)).test($("#knowhow_img_<%=fileFullImgGrp%>File1").val()) == false){
				check += "* ?????????????????? ??????????????????. \n : ????????? \n";
			} --%>

	}

	if(value != null){
			for(a=0; a<vNum; a++){
				if(a ==0){
					var msg ="* ???????????????????????????. \n : ";
				}
					msg += value[a];

				if( a < vNum-1){
					msg += ", ";
				}else{
					msg += " \n";
				}
			}
		}
		if(file != null){
			for(b=0; b<fNum; b++){
				if(b ==0){
					msg += "* ????????? ??????????????????. \n : ";
				}
					msg += file[b];

				if( b < fNum-1){
					msg += ", ";
				}else{
					msg += " \n";
				}
			}
		}
		if(num != null){
			for(c=0; c< nNum; c++){
				if(c == 0){
					msg += "* ????????? ??????????????????. \n : ";
				}
					msg += num[c];

				if( c < nNum-1){
					msg += ", ";
				}else{
					msg += " \n";
				}
			}
		}
		if(date != null){
			for(d=0; d< dNum; d++){
				if(d == 0){
					msg += "* ex) 2016-01-01 \n : ";
				}
					msg += date[d];

				if( d < dNum-1){
					msg += ", ";
				}else{
					msg += " \n";
				}
			}
		}

		msg += check;
	if(msg != null && msg != ""){
				alert(msg);
				return false;
	}

	if($("#"+list_mode+"_state").val() == "2" || $("#"+list_mode+"_state").val() == "6" || $("#"+list_mode+"_state").val() == "7" ){
		goSubmit('upInsertProc', list_mode);
	}else{
		goSubmit('editProc', list_mode);
	}
}
</script>