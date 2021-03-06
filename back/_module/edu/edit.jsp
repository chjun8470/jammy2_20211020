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
ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
	
	String fileGrp = "eduOrgInfo";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
		
	
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
	<input type="hidden" name="eduType" id="eduType" value="<%=util.getStr(paramMap.get("eduType"))%>" />

					<table id="step1" class="skin_basic_write">
						<caption>???????????? ??????????????????</caption>
						<colgroup>
				   			<col style="width:200px">
				   			<col style="width:800px">
						</colgroup>
						<tbody>

						<tr>
							<th scope="col" class="top_sell bln"><label for="eduNm">?????????</label></th>
							<td class="top_sell brn">
								<input type="text" class="inp_text" maxlength="100" style="width:300px" name="eduNm" id="eduNm" value="<%=util.getStr(dataMap.get("EDU_NM"))%>"/>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduCur">????????????</label></th>
							<td class="top_sell brn">
								<input type="text" class="inp_text" maxlength="100" style="width:300px" name="eduCur" id="eduCur" value="<%=util.getStr(dataMap.get("EDU_CUR"))%>"/>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduUseFlag1">JNTIS????????????</label></th>
							<td class="top_sell brn">
								<label><input type="radio" name="eduUseFlag" id="eduUseFlag1" value="10" <% if(util.getStr(dataMap.get("EDU_USE_FLAG")).equals("10")){%>checked="checked" <% } %> /> ??????</label>&nbsp;
								<label><input type="radio" name="eduUseFlag" id="eduUseFlag2" value="20" <% if(util.getStr(dataMap.get("EDU_USE_FLAG")).equals("20")){%>checked="checked" <% } %> /> ?????????</label>
							</td>
						</tr>
						<%-- <tr>
							<th scope="col" class="top_sell bln"><label for="eduCateCd">????????????</label></th>
							<td class="top_sell brn">
								<select class="select" id="eduCateCd" name="eduCateCd" style="height:24px;">
									<option value="">==??????==</option>
									<%if(eduCodeList.size()>0){
										for(HashMap rs:eduCodeList) {%>
										<option value="<%=rs.get("CODE_CD")%>" <%=rs.get("CODE_CD").equals(dataMap.get("EDU_CATE_CD"))?"selected='selected'":""%>><%=rs.get("CODE_NM")%></option>
									<%}
									}%>
								</select>
							</td>
						</tr> --%>
						<%-- <tr>
							<th scope="col" class="top_sell bln"><label for="eduState">??????????????????</label></th>
							<td class="top_sell brn">
							<%if(loginVO.getAuthLv().equals("99")){ %>
							<select class="select" name="eduState" id="eduState" style="height:24px;">
								<option value="10" <%=util.getStr(dataMap.get("EDU_STATE")).equals("10")?"selected='selected'":"" %>>??????</option>
								<option value="20" <%=util.getStr(dataMap.get("EDU_STATE")).equals("20")?"selected='selected'":"" %>>??????</option>
								<option value="30" <%=util.getStr(dataMap.get("EDU_STATE")).equals("30")?"selected='selected'":"" %>>??????</option>
							</select>
							<%}else{ %>
								<%=util.getStr(dataMap.get("EDU_STATE")).equals("10")?"??????":"" %>
								<%=util.getStr(dataMap.get("EDU_STATE")).equals("20")?"??????":"" %>
								<%=util.getStr(dataMap.get("EDU_STATE")).equals("30")?"??????":"" %>
							<%}%>
							</td>
						</tr> --%>
<%-- 
						<tr id="rejectTr" <%=util.getStr(dataMap.get("EDU_STATE")).equals("30")?"":"style='display:none'" %>>
							<th scope="col" class="top_sell bln" ><label for="eduReject">????????????</label></th>
							<td class="top_sell brn">
							<%if(loginVO.getAuthLv().equals("99")){ %>
							<textarea cols="50" rows="4" maxlength="500" name="eduReject" id="eduReject"><%=util.getStr(dataMap.get("EDU_REJECT"))%></textarea>
							<%}else{%>
							<pre><%=util.getStr(dataMap.get("EDU_REJECT")) %></pre>
							<% }%>
							</td>
						</tr> --%>
						<tr>
							<th scope="col" class="top_sell bln">??????/??????</th>
							<td class="top_sell brn" colspan="3">
								<input type="text" class="inp_text" name="eduAuspicesNm" id="eduAuspicesNm" value="<%=util.getStr(dataMap.get("EDU_AUSPICES_NM"))%>"/>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="orgGrpNm">????????????</label></th>
							<td class="top_sell brn">
								<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=util.getStr(dataMap.get("ORG_GRP_CD"))%>"/>
								<input type="text" class="inp_text" maxlength="20" name="orgGrpNm" id="orgGrpNm" value="<%=util.getStr(dataMap.get("ORG_GRP_NM"))%>" style="width:500px" maxlength="100" placeholder=" ????????????????????? ??????????????????." readonly="readonly"/>
							<%if(loginVO.getAuthLv().equals("99")){ %>
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="btn_inp_b_01" style="" onclick="popupWindow('orgList')">
							<%} %>
							<span id="eduOrgSubTd" >
								<input id="eduOrgSubNm" name="eduOrgSubNm" value="<%=util.getStr(dataMap.get("EDU_ORG_SUB_NM"))%>" class="inp_text" style="width: 500px;" maxlength="30" placeholder=" ???????????? ????????????????????????." />
							</span>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduOrdStDt">????????????</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduOrdStDt" name="eduOrdStDt" value="<%=util.getStr(dataMap.get("EDU_ORD_ST_DT"))%>"/>
								~
							<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduOrdEdDt" name="eduOrdEdDt" value="<%=util.getStr(dataMap.get("EDU_ORD_ED_DT"))%>"/>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduStDt">????????????</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduStDt" name="eduStDt" value="<%=util.getStr(dataMap.get("EDU_ST_DT"))%>"/>
								~
							<input type="text" class="inp_text" maxlength="20" readonly="readonly" id="eduEdDt" name="eduEdDt" value="<%=util.getStr(dataMap.get("EDU_ED_DT"))%>"/>
							</td>
						</tr>
						<%-- <tr>
							<th scope="col" class="top_sell bln"><label for="eduTime">????????????</label></th>
							<td class="top_sell brn">
								<textarea class="inp_text" id="eduTime" name="eduTime" style="width:70%;height:200px"><%=util.getStr(dataMap.get("EDU_TIME"))%></textarea>
							</td>
						</tr> --%>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduTotalTime">???????????????</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" id="eduTotalTime" name="eduTotalTime" value="<%=util.getIntStr(dataMap.get("EDU_TOTAL_TIME"))%>"/>(??????)
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduPlace">????????????</label></th>
							<td class="top_sell brn">
								<input type="text" class="inp_text" maxlength="50" id="eduPlace" name="eduPlace" value="<%=util.getStr(dataMap.get("EDU_PLACE"))%>" readonly="readonly" style="width:200px"/>
								<input type="button" id="eduPostButton" value="????????????" class="btn_inp_b_01" onclick="eduPost()">
								<br/>
								<input type="text" class="inp_text" maxlength="100" class="inputBox_2" id="eduPlaceDetail" name="eduPlaceDetail" value="<%=util.getStr(dataMap.get("EDU_PLACE_DETAIL"))%>" style="width:400px"/>
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="mapX">??????</label></th>
							<td>
							<input type="hidden" maxlength="20" id="mapX" name="mapX" maxlength="20" value="<%=util.getStr(dataMap.get("MAP_X"))%>">
							<input type="hidden" maxlength="20" id="mapY" name="mapY" maxlength="20" value="<%=util.getStr(dataMap.get("MAP_Y"))%>">
							<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduPeople">????????????</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" id="eduTarget" name="eduTarget" value="<%=util.getIntStr(dataMap.get("EDU_TARGET"))%>"/>???
							</td>
						</tr>

						<tr>
							<th scope="col" class="top_sell bln"><label for="eduPeople">????????????</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" id="eduPeople" name="eduPeople" value="<%=util.getIntStr(dataMap.get("EDU_PEOPLE"))%>"/>???
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduFreeYn1">?????????</label></th>
							<td class="top_sell brn">
							<label><input type="radio" name="eduFreeYn" id="eduFreeYn1" value="Y" <%=util.getStr(dataMap.get("EDU_FREE_YN")).equals("Y")? "checked='checked'" : ""%>> ??????</label>
							<label><input type="radio" name="eduFreeYn" id="eduFreeYn2" value="N" <%=util.getStr(dataMap.get("EDU_FREE_YN")).equals("N")? "checked='checked'" : ""%>> ??????</label>

							<span id="eduPayBox" <%=util.getIntStr(dataMap.get("EDU_FREE_YN")).equals("Y")? "style='display:none'":""%>>
								<input type="text" class="inp_text" maxlength="9" name="eduPay" id="eduPay" value="<%=util.getIntStr(dataMap.get("EDU_PAY")) %>"/>???
							</span>
							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduInsurance1">????????????????????????</label></th>
							<td class="top_sell brn">
							<label><input type="radio" name="eduInsurance" id="eduInsurance1" value="Y" <%=util.getStr(dataMap.get("EDU_INSURANCE")).equals("Y")? "checked='checked'":""%>>??????</label>
							<label><input type="radio" name="eduInsurance" id="eduInsurance2" value="N" <%=util.getStr(dataMap.get("EDU_INSURANCE")).equals("N")? "checked='checked'" : ""%>>?????????</label>
							</td>
						</tr>
						<%-- <tr>
							<th scope="col" class="top_sell bln"><label for="eduUseFlag1">????????????</label></th>
							<td class="top_sell brn">
							<label><input type="radio" name="eduUseFlag" id="eduUseFlag1" value="10" <%=util.getIntStr(dataMap.get("EDU_USE_FLAG")).equals("10")? "checked='checked'":""%>/>??????</label>
							<label><input type="radio" name="eduUseFlag" id="eduUseFlag2" value="20" <%=util.getIntStr(dataMap.get("EDU_USE_FLAG")).equals("20")? "checked='checked'":""%>/>?????????</label>
							</td>
						</tr> --%>
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduUserNm">????????????</label></th>
							<td class="top_sell brn" colspan="3">
							<table class="skin_basic_write">
									<tr>
										<th style="width:100px;">??????</th>
										<td style="width:200px;">
											<input class="inp_txt" type="text" name="eduUserSector" id="eduUserSector" value="<%=util.getStr(dataMap.get("EDU_USER_SECTOR"))%>" style="width:200px;">
										</td>
										<th style="width:100px;">??????</th>
										<td style="width:200px;">
											<input class="inp_txt" type="text" name="eduUserDept" id="eduUserDept" value="<%=util.getStr(dataMap.get("EDU_USER_DEPT"))%>" style="width:200px;">
										</td>
									</tr>
									<tr>
										<th style="width:100px;">?????????</th>
										<td style="width:200px;">
											<input class="inp_txt" type="text" name="eduUserNm" id="eduUserNm" value="<%=util.getStr(dataMap.get("EDU_USER_NM"))%>" style="width:200px;">
										</td>
										<th>????????????</th>
										<td>
											<input class="inp_txt" type="text" name="eduUserTel" id="eduUserTel" value="<%=util.getStr(dataMap.get("EDU_USER_TEL"))%>" style="width:200px;">
										</td>
									</tr>
									<tr>
										<th>????????????</th>
										<td>
											<input class="inp_txt" type="text" name="eduUserCpNo" id="eduUserCpNo" value="<%=util.getStr(dataMap.get("EDU_USER_CP_NO"))%>" style="width:200px;">
										</td>
										<th>?????????</th>
										<td>
											<input class="inp_txt" type="text" name="eduUserEmail" id="eduUserEmail" value="<%=util.getStr(dataMap.get("EDU_USER_EMAIL"))%>" style="width:200px;">
										</td>
									</tr>

								</table>

							</td>
						</tr>
						<tr>
							<th scope="col" class="top_sell bln"><label for="operPsnNm">????????????</label></th>
							<td class="top_sell brn">
							<input type="hidden" name="managerUserIdx" id="equUserIdx" value="<%=util.getStr(dataMap.get("MANAGER_USER_IDX"))%>"/>
							<input type="text" class="inp_text" maxlength="20" name="managerUserNm" id="operPsnNm" value="<%=util.getStr(dataMap.get("MANAGER_USER_NM"))%>" readonly="readonly"/>
							<input type="button" name="operData" class="btn_inp_b_01" id="operData" value="???????????? ??????" onclick="popupWindow('orgUserPop')">
							<table class="skin_basic_write">
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operOrgGrp" id="operOrgGrp" value="<%=util.getStr(dataMap.get("MANAGER_ORG_GRP_NM"))%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operOrgGrpSub" id="operOrgGrpSub" value="<%=util.getStr(dataMap.get("MANAGER_DEPT_NM"))%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th style="width:100px;">?????????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operChargerTd" id="operChargerTd" value="<%=util.getStr(dataMap.get("MANAGER_USER_NM"))%>" style="border-width:0px; width:200px;" readonlyd>
	                					</td>
	                					<th style="width:100px;">??????</th>
	                					<td style="width:200px;">
	                						<input class="inp_txt" type="text" name="operPositionTd" id="operPositionTd" value="<%=util.getStr(dataMap.get("MANAGER_POSITION_NM"))%>" style="border-width:0px; width:200px;" readonlyd>
	                					</td>
	                				</tr>
	                				<tr>
	                					<th>????????????</th>
	                					<td>
	                						<input class="inp_txt"  type="text" name="operTelTd" id="operTelTd" value="<%=util.getStr(dataMap.get("MANAGER_TEL_NO")) %>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                					<th>?????????</th>
	                					<td>
	                						<input class="inp_txt" type="text" name="operEmailTd" id="operEmailTd" value="<%=util.getStr(dataMap.get("MANAGER_EMAIL"))%>" style="border-width:0px; width:200px;" readonly>
	                					</td>
	                				</tr>
	                			</table>
							</td>
						</tr>
						<%-- <tr>
							<th scope="col" class="top_sell bln"><label for="eduTel">???????????????</label></th>
							<td class="top_sell brn">
							<input type="text" class="inp_text" maxlength="20" id="eduTel" name="eduTel" value="<%=util.getStr(dataMap.get("EDU_TEL"))%>"/>
							<br/>
							ex) 010-000-0000
							</td>
						</tr> --%>
						
						<tr>
							<th scope="col" class="top_sell bln"><label for="eduContent">????????????</label></th>
							<td class="top_sell brn">
							<textarea style="width:100%;" rows="4" maxlength="500" name="eduContent" id="eduContent"><%=util.getStr(dataMap.get("EDU_CONTENT"))%></textarea>
							</td>
						</tr>
						<!-- <tr>
							<th scope="col" class="top_sell bln"><label for="eduInfo">???????????????</label></th>
							<td class="top_sell brn">
							<textarea cols="50" rows="4" maxlength="500" name="eduInfo" id="eduInfo"><%=util.getStr(dataMap.get("EDU_INFO"))%></textarea>
							</td>
						</tr> -->
						<tr id="orgInfoTR">
							<th scope="col"><label for="eduOrgInfoFile1">???????????????</label></th>
							<td colspan="3">
							<% 
					if(fileList.size() > 0){
				%>
						<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px; height:100%;">
						<%
							int fileCnt = 1;
							for(HashMap rs:fileList){
								String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
													+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
													+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
							<li class="text">
								<input type="checkbox" name="fileFlog" id="fileFlog_<%=fileCnt%>"
										value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" />&nbsp;
								<label for="fileFlog_<%=fileCnt%>">????????????</label>&nbsp;&nbsp;
								<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)
								<%--<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:200px;padding:10px"/>--%>
								<%--<%=util.deStr(rs.get("FILE_ORGN_NM")) (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>

							</li>
						<% fileCnt++; }%>
						</ul>
						<div style="display: inline-block;"
							id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
							<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
						</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					            function addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
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

								function fileSet(fileCnt){
									if($('#fileFlog_'+fileCnt).is(':checked')){
										$('#fileBox_'+fileCnt).show();
									}else{
										$('#fileBox_'+fileCnt).hide();
									}
								}
				            </script>

	            <% }else{ %>
						<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
							<input type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
						</div>
						<script type="text/javascript">
							var arrfileCnt = new Array();
							arrfileCnt['<%=fileFullGrp%>'] = 2;
				            function addRowFile(fileGrpnm){
			            		var fileHtml = "<div>";
			            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
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
			      <% } %>
							</td>
						</tr>
						<tr>
							<th>??????????????? ??????</th>
							<td colspan="3">
								<label><input type="radio" id="certiYn1" name="certiYn" value="1" <% if( util.getStr(String.valueOf(dataMap.get("CERTI_YN"))).equals("1") ){ %>checked="checked"<% } %> /> ????????????</label>&nbsp;
								<label><input type="radio" id="certiYn2" name="certiYn" value="2" <% if( util.getStr(String.valueOf(dataMap.get("CERTI_YN"))).equals("2") ){ %>checked="checked"<% } %> /> ???????????????</label>
							</td>
						</tr>
						<tr id="orgStampTR" <% if( util.getStr(String.valueOf(dataMap.get("CERTI_YN"))).equals("1") ){ %>style="display:none;"<% } %> >
							<th scope="col"><label for="eduOrgStampFile1">?????? ??????(??????)</label></th>
							<td colspan="3">
							<% if(util.getStr(String.valueOf(dataMap.get("STAMP_FILE_ID"))).equals("")){%>
							<input type="file" name="eduOrgStampFile1"  id="eduOrgStampFile1"  title="????????????" />
							<input type="hidden" name="fileSn"  value="3" />
							<%}else{%>
							<ul class="file" style="line-height: 22px;">
								<li class="text">
									<input type="hidden" name="fileSn"  value="3" />
									<input type="checkbox" name="fileFlog" id="fileFlog_3"
											value="<%=util.getStr(String.valueOf(dataMap.get("STAMP_FILE_ID")))%>" onclick="fileSet('3')" /> &nbsp;
									<label for="fileFlog_3">????????????</label>&nbsp;&nbsp;&nbsp;&nbsp;

									<img class='org_stamp' src="<%=util.getStr(dataMap.get("STAMP_FILE_SRC"))%>" alt='<%=util.getStr(dataMap.get("STAMP_FILE_TITLE")) %>' style='width:100px;height:100px'/>

								</li>
							</ul>
							<div id="fileBox_3" style="display:none">
								<input type="file" name="eduOrgStampFile1"  id="eduOrgStampFile1"  title="????????????"  />
							</div>
							<%}%>
							</td>
						</tr>
						<tr id="certiTR" <% if( util.getStr(String.valueOf(dataMap.get("CERTI_YN"))).equals("1") ){ %>style="display:none;"<% } %> >
							<th>?????? ?????????</th>
							<td colspan="3">
							<p>????????? ????????? ????????? ????????? ????????? ???????????????.</p>
							<table class="skin_basic_write">
								<caption>????????? ????????????</caption>
								<colgroup>
									<col width="40%">
									<col width="60%">
								</colgroup>
								<tbody>
								<tr>
									<th><label for="certiOrg">????????????</label></th>
									<td><input type="text" name="certiOrg" id="certiOrg" maxlength="12" value="<%=util.getStr(dataMap.get("CERTI_ORG"))%>"/></td>
								</tr>
								<tr>
									<th>?????????</th>
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
							<input class="btn_inp_b_01" type="button" onclick="submitGo();" value="??????">
							<input class="btn_inp_w_01" type="button" onclick="pageViewGo()" value="??????">
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
		nextText : '?????? ???',
		prevText : '?????? ???',
		currentText : '?????? ??????',
		closeText : '??????',
		dateFormat : "yy-mm-dd",
		dayNames : ['?????????','?????????','?????????','?????????','?????????','?????????','?????????'],
		dayNamesMin : ['???','???','???','???','???','???','???'],
		monthNames : ['1???','2???','3???','4???','5???','6???','7???','8???','9???','10???','11???','12???'],
		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
	});

	// ????????????  ????????? ?????? ?????? ????????? ?????? ??? ??????
	$('#eduOrdStDt').datepicker("option", "maxDate", $("#eduOrdEdDt").val());
	$('#eduOrdStDt').datepicker("option", "onClose", function ( selectedDate ) {
		$("#eduOrdEdDt").datepicker( "option", "minDate", selectedDate );
	});

	// ???????????? ????????? ?????? ?????? ????????? ?????? ??? ??????
	$('#eduOrdEdDt').datepicker("option", "minDate", $("#eduOrdStDt").val());
	$('#eduOrdEdDt').datepicker("option", "onClose", function ( selectedDate ) {
		$("#eduOrdStDt").datepicker( "option", "maxDate", selectedDate );
	});


	// ????????????  ????????? ?????? ?????? ????????? ?????? ??? ??????
	$('#eduStDt').datepicker("option", "maxDate", $("#eduEdDt").val());
	$('#eduStDt').datepicker("option", "onClose", function ( selectedDate ) {
		$("#eduEdDt").datepicker( "option", "minDate", selectedDate );
	});

	// ???????????? ????????? ?????? ?????? ????????? ?????? ??? ??????
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
		if(confirm("?????????????????????????")){
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


var korPattern = /[???-???]/;
var onlyKorPattern = /[^???-???]/;
var engPattern = /[a-zA-Z]/;
var numPattern = /[\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;
	//////////////////????????????

	function eduPost(){
		new daum.Postcode({
			oncomplete: function(data) {

				// $("#zipcode").val(data.zonecode);
				 $("#eduPlace").val(data.address);
				 $("#eduPlaceDetail").focus();

				 /**/
					// ??? ????????? ?????? ????????? ?????? ????????? ????????????.
					// ???????????? ????????? ?????? ?????? ????????? ??????('')?????? ????????????, ?????? ???????????? ?????? ??????.
					var fullAddr = data.address; // ?????? ?????? ??????
					var extraAddr = ''; // ????????? ?????? ??????

					// ?????? ????????? ????????? ???????????? ????????????.
					if(data.addressType === 'R'){
						//??????????????? ?????? ?????? ????????????.
						if(data.bname !== ''){
							extraAddr += data.bname;
						}
						// ???????????? ?????? ?????? ????????????.
						if(data.buildingName !== ''){
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
						}
						// ?????????????????? ????????? ?????? ????????? ????????? ???????????? ?????? ????????? ?????????.
						fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
					}

					// ?????? ????????? ?????? ????????? ?????????.
					//$("#location").val(fullAddr);
					// ????????? ????????? ??????
					//geocoder.addr2coord(data.address, function(status, result) {
					geocoder.addressSearch(data.address, function(result, status) {
						// ??????????????? ????????? ???????????????
						if (status === kakao.maps.services.Status.OK) {
								// ?????? ????????? ?????? ????????? ?????????
								//var coords = new kakao.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
								var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
								   $("#mapX").val(result[0].y);
								   $("#mapY").val(result[0].x);
								// ????????? ????????????.
								mapContainer.style.display = "block";
								map.relayout();
								// ?????? ????????? ????????????.
								map.setCenter(coords);
								// ????????? ??????????????? ?????? ????????? ?????????.
								marker.setPosition(coords)
							}
					});

			}
		}).open();
	}
	////////////////?????????

	var mapContainer = document.getElementById('map'), // ????????? ????????? div
		mapOption = {
			center: new daum.maps.LatLng(<%=dataMap.get("MAP_X")%>, <%=dataMap.get("MAP_Y")%>), // ????????? ????????????
			level: 5 // ????????? ?????? ??????
		};

	//????????? ?????? ??????
	var map = new daum.maps.Map(mapContainer, mapOption);
	//??????-?????? ?????? ????????? ??????
	var geocoder = new daum.maps.services.Geocoder();
	//????????? ?????? ??????
	var marker = new daum.maps.Marker({
		position: new daum.maps.LatLng(<%=dataMap.get("MAP_X")%>, <%=dataMap.get("MAP_Y")%>),
		map: map
	});

	daum.maps.event.addListener(map, 'click', function(mouseEvent) {
		   searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
				if (status === daum.maps.services.Status.OK) {

					  // ????????? ??????, ?????? ????????? ???????????????
					  var latlng = mouseEvent.latLng;
					  // ?????? ????????? ????????? ????????? ????????????
					  marker.setPosition(latlng);
					  //???????????? ??? ????????????(????????????, X??????, Y??????)
				   //$("#location").val(result[0].jibunAddress.name);
					  $("#mapX").val(latlng.getLat());
				   $("#mapY").val(latlng.getLng());

				   marker.setMap(map);

				}
		   });
	 });

	 // ?????? ????????? ?????? ????????? ???????????? ??? ?????? ?????? ????????? ?????? ?????? ????????? ??????????????? ???????????? ???????????????
	 daum.maps.event.addListener(map, 'idle', function() {
		   searchAddrFromCoords(map.getCenter(), displayCenterInfo);
	 });

	 function searchAddrFromCoords(coords, callback) {
		   // ????????? ????????? ?????? ????????? ???????????????
		   geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);
	 }

	 function searchDetailAddrFromCoords(coords, callback) {
		   // ????????? ????????? ?????? ?????? ????????? ???????????????
		   geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	 }

	 // ?????? ??????????????? ?????? ??????????????? ?????? ??????????????? ???????????? ???????????????
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
            // ??????????????? ????????? ???????????????
//            if (status === daum.maps.services.Status.OK) {
                // ?????? ????????? ?????? ????????? ?????????
                var coords = new daum.maps.LatLng($("#mapX").val(),$("#mapY").val());
                // ????????? ????????????.
                mapContainer.style.display = "block";
                map.relayout();
                // ?????? ????????? ????????????.
                map.setCenter(coords);
                // ????????? ??????????????? ?????? ????????? ?????????.
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
		errMsg+="????????? : ???????????????????????????."+"<br/>";
	}
	if($("#eduCur").val()==null || $("#eduCur").val()==""){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}
	if($("#eduOrdStDt").val()==null || $("#eduOrdStDt").val()==""){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}else if($("#eduOrdEdDt").val()==null || $("#eduOrdEdDt").val()==""){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}

	if($("#eduStDt").val()==null || $("#eduStDt").val()==""){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}else if($("#eduEdDt").val()==null || $("#eduEdDt").val()==""){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}
	if($("#eduTotalTime").val()==null || $("#eduTotalTime").val()==""){
		errMsg+="??????????????? : ???????????????????????????."+"<br/>";
	}else if(isNaN($("#eduTotalTime").val()) == true){
		errMsg+="??????????????? : ????????? ??????????????????."+"<br/>";
	}

	if($("#eduPlace").val()==null || $("#eduPlace").val()==""){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}else if($("#eduPlaceDetail").val()==null || $("#eduPlaceDetail").val()==""){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}

	if($("#mapX").val()==null || $("#mapX").val()==""){
		errMsg+="?????? : ???????????????????????????."+"<br/>";
	}else if($("#mapY").val()==null || $("#mapY").val()==""){
		errMsg+="?????? : ???????????????????????????."+"<br/>";
	}

	if($("#eduPeople").val()==null || $("#eduPeople").val()==""){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}else if(isNaN($("#eduPeople").val()) == true){
		errMsg+="???????????? : ????????? ??????????????????."+"<br/>";
	}

	if(!$("input[name='eduUseFlag']").is(":checked")){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}


	if($("#operPsnNm").val()==null || $("#operPsnNm").val()==""||$("#equUserIdx").val()==null || $("#equUserIdx").val()==""){
		errMsg+="???????????? : ???????????????????????????."+"<br/>";
	}
	if(errMsg==""){

		if(confirm("?????????????????????????")){
			
	oEditors.getById["eduContent"].exec("UPDATE_CONTENTS_FIELD", []);
		$("#mode").val("edit");
		$("#fwrite").attr('method','post');
		$('#fwrite').attr("action","./jnspEduProc.do");
		$("#fwrite").submit();
		}
	}else{
		errMsg="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + errMsg;
		errMsg="<div style='margin:20px'><h2>????????? ????????????</h2>" + errMsg;

		errMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='??????' class='btn_inp_w_01'/></div>";
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
		errMsg+="?????? ??????(??????)????????????   bmp, gif, jpg, jpeg, png ????????? ????????? ????????????????????????."+"<br/>";
	}
}

//???????????????
$('input[name="certiYn"]').change(function(){
  if($(this).val()=='1'){
  	$('#certiTR').hide();
  	$("#orgStampTR").hide();
  }else{
  	$("#certiTR").show();
  	$("#orgStampTR").show();
  }
});

//var permEditor = $('#permEditor').val();
	    var oEditors = [];
		$(function(){
			// ?????? ?????? ??????
			//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "eduContent",
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
</script>