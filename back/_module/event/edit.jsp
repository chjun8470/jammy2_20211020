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
	HashMap<String, String> eventMap = request.getAttribute("eventMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("eventMap");
	HashMap<String, String> loginUserInfo = request.getAttribute("loginUserInfo") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("loginUserInfo");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> eventTypeList = request.getAttribute("eventTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventTypeList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));

	if("".equals(mode)) mode = "write";

	String fileGrp = "event";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>

<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="eventIdx" id="eventIdx" value="<%=eventIdx%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />


	<div class="skin_bbs_write" style="margin-top: 30px; width: 1000px;">
		<span style="color:red; font-size:10pt;"> * ?????? ?????????????????????.</span>
        <table class="skin_basic_write">
        	<caption>????????????</caption>
            <colgroup>
				<col style="width: 15%;" />
				<col style="width: 50%;" />
				<col style="width: 10%;" />
				<col style="width: 25%;" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventNm"> ?????????</label>
					</th>
					<td>
						<input type="text" class="inp_text" name="eventNm" id="eventNm" value="<%=util.getStr(eventMap.get("EVENT_NM"))%>" style="width: 98%;" maxlength="100" />
                    </td>
                    <th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventType"> ????????????</label>
					</th>
					<td>
						<select class="select" name="eventType" id="eventType" style="width:225px; height:24px;">
						<%for(HashMap rs:eventTypeList){%>
							<option value="<%=util.getStr(rs.get("CODE_CD")) %>" <%=(util.getStr(eventMap.get("EVENT_TYPE"))).equals(util.getStr(rs.get("CODE_CD")))? "selected='selected'" : "" %>><%=util.getStr(rs.get("CODE_NM")) %></option>
						<%}%>
	              		</select>
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventAuspicesNm"> ????????????</label>
					</th>
					<td colspan="3">
						<input type="text" class="inp_text" name="eventAuspicesNm" id="eventAuspicesNm" value="<%=util.getStr(eventMap.get("EVENT_AUSPICES_NM"))%>" style="width: 98%;" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventManagementNm"> ????????????</label>
					</th>
					<td colspan="3">
						<span id="eventManageOrgTd">
							<input type="hidden" name="eventManageOrgCd" id="eventManageOrgCd" value="<%=util.getStr(eventMap.get("EVENT_MANAGE_ORG_CD"))%>" />
							<input type="hidden" name="eventManageOrgSubNm_ex" id="eventManageOrgSubNm_ex" value="<%=util.getStr(eventMap.get("EVENT_MANAGE_ORG_SUB_NM"))%>" />
							<input type="text" class="inp_text" name="eventManageOrgNm" id="eventManageOrgNm" value="<%=util.getStr(eventMap.get("EVENT_MANAGE_ORG_NM"))%>" style="width: 70%;" maxlength="100" placeholder=" ????????????????????? ??????????????????." />
							<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('orgList')" >
						</span>

						<span id="eventManageOrgSubTd"></span>
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="recDt"> ??????????????????</label>
					</th>
					<td colspan="3">
						<%String time =  util.getStr(eventMap.get("REQ_ST")) ;%>
						<input type="text" class="inp_text" name="reqStDt" id="reqStDt" value="<%=util.getStr(eventMap.get("REQ_ST_DT"))%>" /> <select class="select" name="reqSt" id="reqSt" style="height:24px;"><%=util.timeOption(time) %></select>??? ~
						<%time =  util.getStr(eventMap.get("REQ_ET")) ;%>
						<input type="text" class="inp_text" name="reqEdDt" id="reqEdDt" value="<%=util.getStr(eventMap.get("REQ_ED_DT"))%>" /> <select class="select" name="reqEt" id="reqEt" style="height:24px;"><%=util.timeOption(time) %></select>???
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="proDt"> ????????????</label>
					</th>
					<td colspan="3">
						<%time =  util.getStr(eventMap.get("EVENT_ST")) ;%>
						<input type="text" class="inp_text" name="eventStDt" id="eventStDt" value="<%=util.getStr(eventMap.get("EVENT_ST_DT"))%>" /> <select class="select" name="eventSt" id="eventSt" style="height:24px;"><%=util.timeOption(time) %></select>??? ~
						<%time =  util.getStr(eventMap.get("EVENT_ET")) ;%>
						<input type="text" class="inp_text" name="eventEdDt" id="eventEdDt" value="<%=util.getStr(eventMap.get("EVENT_ED_DT"))%>" /> <select class="select" name="eventEt" id="eventEt" style="height:24px;"><%=util.timeOption(time) %></select>???
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventPlace"> ????????????</label>
					</th>
					<td colspan="3">
						<input type="text" class="inp_text" name="eventPlace" id="eventPlace" value="<%=util.getStr(eventMap.get("EVENT_PLACE"))%>" style="width: 70%;" maxlength="100" />
						<input type="button" id="eduPostButton" value="????????????" class="btn_inp_b_01" onclick="eduPost()">
						<br>
						<input type="text" class="inp_text" name="eventPlaceDetail" id="eventPlaceDetail" value="<%=util.getStr(eventMap.get("EVENT_PLACE_DETAIL"))%>" style="width: 70%;" maxlength="100" />
					</td>
				</tr>

				<!-- ???????????? -->
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventPlace"> ??????</label>
					</th>
					<td colspan="3">
						<!--X??? -->
						<input type="hidden" maxlength="20" class="inputBox_1" id="mapX" name="mapX" maxlength="20"  value="<%=util.getStr(eventMap.get("MAP_X"))%>"/>
						<!--Y??? -->
						<input type="hidden" maxlength="20" class="inputBox_1" id="mapY" name="mapY" maxlength="20"  value="<%=util.getStr(eventMap.get("MAP_Y"))%>"/>
						<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
					</td>
				</tr>


				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventTarget"> ????????????</label>
					</th>
					<td>
						<input type="text" class="inp_text" name="eventTarget" id="eventTarget" value="<%=util.getStr(eventMap.get("EVENT_TARGET"))%>" style="width: 98%;" maxlength="100" />
                    </td>
                    <th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventPeople"> ????????????</label>
					</th>
					<td>
						<input type="text" class="inp_text" name="eventPeople" id=eventPeople value="<%=util.getStr(eventMap.get("EVENT_PEOPLE"))%>" style="width: 110px;" maxlength="100" /> ???
					</td>
				</tr>
				<tr>
					<th class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventFreeYn"> ???????????????</label>
					</th>
					<td colspan="3">
							<input type="checkbox" id="eventFree_N" name="eventFreeYn" value="N" onclick="check_only(this)"  <%=(util.getStr(eventMap.get("EVENT_FREE_YN"))).equals("N")? "checked='checked'" : "" %>/><label for="eventFree_N"> ??????</label>&nbsp;&nbsp;
							<input type="checkbox" id="eventFree_Y" name="eventFreeYn" value="Y" onclick="check_only(this);" <%=(util.getStr(eventMap.get("EVENT_FREE_YN"))).equals("Y")? "checked='checked'" : "" %>/>
							<label for="eventFree_Y"> ??????</label>&nbsp;&nbsp;
							<!--?????????-->
							<span id="eventPay_box" <%if(util.getStr(eventMap.get("EVENT_FREE_YN")).equals("N")){%>style="display:none;"<%} %> >
								<input type="text" class="inp_text" name="eventPay" id="eventPay" value="<%=util.getStr(eventMap.get("EVENT_PAY"))%>" style="width: 190px; maxlength="100"  />???
							</span>
					</td>
				</tr>
				<tr>
                    <th scope="row" class="tit">
                        <label for="eventContents"> ????????????</label>
                    </th>
                    <td class="con-txt" colspan="3">
                        <textarea name="eventContents" id="eventContents" style="width: 100%; height: 350px; font-size:10pt;"><%=eventMap.get("EVENT_CONTENTS")%></textarea>
                    </td>
                </tr>

				<!-- ??????????????? = ????????????  -->
				<tr>
                    <th scope="row" class="tit"> ???????????????</th>
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
								<input type="checkbox" name="fileFlog" id="fileFlog_<%=fileCnt%>"
										value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" />&nbsp;
								<label for="fileFlog_<%=fileCnt%>">????????????</label>&nbsp;&nbsp;
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
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
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span> ?????????
					</th>
					<td colspan="3">
						<div>
							<table class="skin_basic_write">
								<caption>????????????</caption>
					            <colgroup>
									<col style="width: 15%;" />
									<col style="width: 85%;" />
								</colgroup>
								<tbody>
									<tr>
										<th>?????????</th>
										<td>
											<input type="text" class="inp_text" name="referenceOrgNm" id="referenceOrgNm" value="<%=util.getStr(eventMap.get("REFERENCE_ORG_NM"))%>" style="width: 100%;" maxlength="100" />
										</td>
									</tr>
									<tr>
										<th>?????????</th>
										<td>
											<input type="text" class="inp_text" name="referenceOrgSubNm" id="referenceOrgSubNm" value="<%=util.getStr(eventMap.get("REFERENCE_ORG_SUB_NM"))%>" style="width: 100%;" maxlength="100" />
										</td>
									</tr>
									<tr>
										<th>????????????</th>
										<td>
											<input type="text" class="inp_text" name="referenceCharger" id="referenceCharger" value="<%=util.getStr(eventMap.get("REFERENCE_CHARGER"))%>" style="width: 100%;" maxlength="100" />
										</td>
									</tr>
									<tr>
										<th>????????????</th>
										<td>
											<input type="text" class="inp_text" name="referencePhone" id="referencePhone" value="<%=util.getStr(eventMap.get("REFERENCE_PHONE"))%>" style="width: 100%;" maxlength="100" placeholder=" ex. 010-1234-5678" />
										</td>
									</tr>
									<tr>
										<th>?????????</th>
										<td>
											<input type="text" class="inp_text" name="referenceEmail" id="referenceEmail" value="<%=util.getStr(eventMap.get("REFERENCE_EMAIL"))%>" style="width: 100%;" maxlength="100" placeholder=" ex. jntis@jntis.kr" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>

			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('editProc')"/>
			<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('view')"/>
		</div>
		<!--// bo_btn -->
	</div>
</form>

<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	$(document).ready(function(){

		$("#reqStDt, #reqEdDt, #eventStDt, #eventEdDt").datepicker({
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

		// ????????? ?????? ?????? ????????? ?????? ??? ??????
	    $('#reqStDt').datepicker("option", "maxDate", $("#reqEdDt").val());
	    $('#reqStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#reqEdDt").datepicker( "option", "minDate", selectedDate );
	    });
		// ????????? ?????? ?????? ????????? ?????? ??? ??????
	    $('#reqEdDt').datepicker("option", "minDate", $("#reqStDt").val());
	    $('#reqEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#reqStDt").datepicker( "option", "maxDate", selectedDate );
		});

	 	// ????????? ?????? ?????? ????????? ?????? ??? ??????
	    $('#eventStDt').datepicker("option", "maxDate", $("#eventEdDt").val());
	    $('#eventStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#eventEdDt").datepicker( "option", "minDate", selectedDate );
	    });
	 	// ????????? ?????? ?????? ????????? ?????? ??? ??????
	    $('#eventEdDt').datepicker("option", "minDate", $("#eventStDt").val());
	    $('#eventEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#eventStDt").datepicker( "option", "maxDate", selectedDate );
		});

	});

	function goSubmit(mode){

		//?????? ?????????(mode = writeProc??????) ????????? ??????
		if(mode == "writeProc"){
			if($('#eventNm').val() == ""){
				alert("???????????? ??????????????????");
				$("#eventNm").focus();
				return false;
			}
			if($('#eventAuspicesNm').val() == ""){
				alert("??????????????? ??????????????????");
				$("#eventAuspicesNm").focus();
				return false;
			}
			if($('#eventManageOrgNm').val() == ""){
				alert("???????????? ???????????? ??????????????????");
				$("#eventManageOrgNm").focus();
				return false;
			}
			if($('#eventManageOrgSubNm').val() == ""){
				alert("???????????? ???????????? ??????????????????");
				$("#eventManageOrgSubNm").focus();
				return false;
			}
			if($('#reqStDt').val() == "" || $('#reqEdDt').val() == ""){
				alert("????????????????????? ??????????????????");
				$("#reqStDt").focus();
				return false;
			}
			if($('#eventStDt').val() == "" || $('#eventEdDt').val() == ""){
				alert("??????????????? ??????????????????");
				$("#eventStDt").focus();
				return false;
			}
			if($('#eventPlace').val() == ""){
				alert("??????????????? ??????????????????");
				$("#eventPlace").focus();
				return false;
			}
			if($('#mapX').val() == "" || $('#mapY').val() == ""){
				alert("???????????? ????????? ??????????????????");
				return false;
			}
			if($('#eventTarget').val() == ""){
				alert("??????????????? ??????????????????");
				$("#eventTarget").focus();
				return false;
			}
			if($('#eventPeople').val() == ""){
				alert("??????????????? ??????????????????");
				$("#eventPeople").focus();
				return false;
			}
			if($('#eventFree_Y:checked').val() == 'Y') {
				if($('#eventPay').val() == ""){
				alert("?????????????????? ??????????????????");
				$("#eventPay").focus();
				return false;
				}
			}
			if($('#referenceOrgNm').val() == ""){
				alert("????????? ???????????? ??????????????????");
				$("#referenceOrgNm").focus();
				return false;
			}
			if($('#referenceOrgSubNm').val() == ""){
				alert("????????? ???????????? ??????????????????");
				$("#referenceOrgSubNm").focus();
				return false;
			}
			if($('#referenceCharger').val() == ""){
				alert("????????? ??????????????? ??????????????????");
				$("#referenceCharger").focus();
				return false;
			}
			if($('#referencePhone').val() == ""){
				alert("????????? ??????????????? ??????????????????");
				$("#referencePhone").focus();
				return false;
			}
			if($('#referenceEmail').val() == ""){
				alert("????????? ???????????? ??????????????????");
				$("#referenceEmail").focus();
				return false;
			}

			oEditors.getById["eventContents"].exec("UPDATE_CONTENTS_FIELD", []);

            if((oEditors[0].getIR()).length < 15){
         	  alert("??????????????? ?????? ??????????????????");
         	  return false;
            }


           //?????????????????? ?????? ??????
    	   if($('#reqStDt').val() == $('#reqEdDt').val()){
    			if($('#reqSt').val() >= $('#reqEt').val()){
    		    	alert("????????????????????? ????????? ?????? ?????????????????????.");
    		    	$("#reqEt").focus();
    		    	return false;
    		    }
    	   }
    	   //???????????? ?????? ??????
    	   if($('#eventStDt').val() == $('#eventEdDt').val()){
    			if($('#eventSt').val() >= $('#eventEt').val()){
    		    	alert("??????????????? ????????? ?????? ?????????????????????.");
    		    	$("#eventEt").focus();
    		    	return false;
    		    }
    	   }

		}else if(mode == "editProc"){
			oEditors.getById["eventContents"].exec("UPDATE_CONTENTS_FIELD", []);

            if((oEditors[0].getIR()).length < 15){
         	  alert("??????????????? ?????? ??????????????????");
         	  return false;
            }
		}

        $('#mode').val(mode);
        $('#fwrite').submit();
     }

	 //Editor
	 var oEditors = [];
	 $(function(){
		//?????? ?????? ??????
		//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "eventContents",
			sSkinURI: "/js/webeditor_nhn/SmartEditor2Skin.html",
			htParams : {
				bUseToolbar : true,				// ?????? ?????? ?????? (true:??????/ false:???????????? ??????)
				bUseVerticalResizer : true,		// ????????? ?????? ????????? ?????? ?????? (true:??????/ false:???????????? ??????)
				bUseModeChanger : true,			// ?????? ???(Editor | HTML | TEXT) ?????? ?????? (true:??????/ false:???????????? ??????)
				//aAdditionalFontList : aAdditionalFontSet,		// ?????? ?????? ??????
			},  //boolean
			fCreator : "createSEditor2"
		});
	 });

	//??????????????? checkBox
 	function check_only(chk){
        var obj = document.getElementsByName("eventFreeYn");
        for(var i=0; i<obj.length; i++){
            if(obj[i] != chk){
                obj[i].checked = false;
            }
        }

        if($('#eventFree_Y:checked').val() == 'Y') {

        	$('#eventPay_box').show();

        }else {

        	$('#eventPay_box').hide();
        	$('#eventPay').val('');

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
	function orgInfo(orgGrpCd, orgSubNm){
		var orgGrpCd = orgGrpCd;
		var orgSubNm = orgSubNm;
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

			if(data.totalCount > 0){

				$("#eventManageOrgSubNm").remove();

				result += "<select id=\"eventManageOrgSubNm\" name=\"eventManageOrgSubNm\" style=\"width: 49%; height:24px;\" >";
				for(i=0; i<data.totalCount; i++){
					if(orgSubNm == data.dataList[i].ORG_GRP_SUB_NM){
						result += "<option value=\""+data.dataList[i].ORG_GRP_SUB_NM+"\" \"selected='selected'\" >"+data.dataList[i].ORG_GRP_SUB_NM+"</option>";
					}else{
						result += "<option value=\""+data.dataList[i].ORG_GRP_SUB_NM+"\" >"+data.dataList[i].ORG_GRP_SUB_NM+"</option>";
					}
				}
				result += "</select>";
				$("#eventManageOrgSubTd").append(result);

			}else{

				$("#eventManageOrgSubNm").remove();

				result = "<input id=\"eventManageOrgSubNm\" name=\"eventManageOrgSubNm\" style=\"width: 70%;\" maxlength=\"30\" value=\""+orgSubNm+"\" >";
				$("#eventManageOrgSubTd").append(result)
			}
		});
	}
	/*---------???????????? E----------*/

	$(document).ready(function() {
		var orgCd = $("#eventManageOrgCd").val();
		var orgSubNm = $("#eventManageOrgSubNm_ex").val();
		if(orgCd !=null && orgCd !=""){
			orgInfo(orgCd,orgSubNm);
		}

		

	});


	/*---------?????? S-----------*/
		var korPattern = /[???-???]/;
		var onlyKorPattern = /[^???-???]/;
		var engPattern = /[a-zA-Z]/;
		var numPattern = /[\d]/;
		var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
		var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
		var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;
		var mapX = $("#mapX").val(); //????????? ????????????
		var mapY = $("#mapY").val(); //????????? ????????????

		

			//????????????
			function eduPost(){
				new daum.Postcode({
					oncomplete: function(data) {

						 //$("#zipcode").val(data.zonecode);
						 $("#eventPlace").val(data.address);
						 $("#eventPlaceDetail").focus();

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
			//??????

			var mapContainer = document.getElementById('map'), // ????????? ????????? div
				mapOption = {
					center: new kakao.maps.LatLng(mapX, mapY),
					level: 5 // ????????? ?????? ??????
				};

			//????????? ?????? ??????
			var map = new kakao.maps.Map(mapContainer, mapOption);
			//??????-?????? ?????? ????????? ??????
			var geocoder = new kakao.maps.services.Geocoder();
			//????????? ?????? ??????
			var marker = new kakao.maps.Marker({
				position: new kakao.maps.LatLng(mapX, mapY),
				map: map
			});

			kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
				   searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
						if (status === kakao.maps.services.Status.OK) {

							  // ????????? ??????, ?????? ????????? ???????????????
							  var latlng = mouseEvent.latLng;
							  // ?????? ????????? ????????? ????????? ????????????
							  marker.setPosition(latlng);

							  // ???????????? ??? ????????????(????????????, X??????, Y??????)
						   	  // $("#location").val(result[0].jibunAddress.name);
							  $("#mapX").val(latlng.getLat());
						   	  $("#mapY").val(latlng.getLng());
							  marker.setMap(map);
						}
				   });
			 });

			 // ?????? ????????? ?????? ????????? ???????????? ??? ?????? ?????? ????????? ?????? ?????? ????????? ??????????????? ???????????? ???????????????
			 kakao.maps.event.addListener(map, 'idle', function() {
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
				   if (status === kakao.maps.services.Status.OK) {
						$("#centerAddr").html(result[0].fullName);
				   }
			 }
			 /*---------?????? E-----------*/

</script>