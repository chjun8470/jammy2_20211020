<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");

	ArrayList<HashMap<String, String>> supportTypeList = request.getAttribute("supportTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportTypeList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String searchReceipt = util.getStr(paramMap.get("searchReceipt"));
	if("".equals(mode)) mode = "edit";
	
	String state = util.getStr(dataMap.get("DATA15"));

%>
<form name="fedit" id="fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<input type="hidden" name="searchReceipt" id="searchReceipt" value="<%=searchReceipt%>" />

	<div class="skin_bbs_write" style="margin-top: 30px; width: 1000px;">
		<font color="red">* ?????? ?????????????????????.</font>
		<table class="skin_basic_write" summary="???????????????  ??????, ??????, ????????????, ???????????????(??????)??? ???????????????.">
			<caption>????????????</caption>
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th class="tit">
						<font color="red">*</font>??????????????????
					</th>
					<td>
						<%for(HashMap rs:supportTypeList){%>
							<label>
							<input type="radio" name="supportType" id="supportType_<%=util.getStr(rs.get("CODE_CD")) %>" 
								value="<%=util.getStr(rs.get("CODE_CD")) %>"
		              			<%if(util.getStr(rs.get("CODE_CD")).equals(util.getStr(dataMap.get("DATA01")))) {%>
		              				checked="checked"
		              			<%}%>
		              		><%=util.getStr(rs.get("CODE_NM")) %></label>
						<%}%>
					</td>
				</tr>
				<%if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99 ){%>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="state10"> ????????????</label>
					</th>
					<td>
						<label><input type="radio" onchange="reason1(this.value)" name="state" id="state10" value="10" <%if("10".equals(util.getStr(dataMap.get("DATA15")))) {%> checked="checked" <%}%>><span class="btn_y_01" style="cursor:pointer; background-color:#FAED7D;">????????????</span></label>
						<label><input type="radio" onchange="reason1(this.value)" name="state" id="state20" value="20" <%if("20".equals(util.getStr(dataMap.get("DATA15")))) {%> checked="checked" <%}%>><span class="btn_y_01" style="cursor:pointer; background-color:#73bb1e;">??????</span></label>
						<label><input type="radio" onchange="reason1(this.value)" name="state" id="state30" value="30" <%if("30".equals(util.getStr(dataMap.get("DATA15")))) {%> checked="checked" <%}%>><span class="btn_y_01" style="cursor:pointer; background-color:#FFBC9B;">??????</span></label>
					</td>
				</tr>				
				<tr class="reasonInput"  style="display:none;">
					<th class="tit">
						<label for="state">????????????</label>
					</th>
					<td>
					<textarea rows="5" cols="111" name="reason" id="reason"><%=util.getStr(dataMap.get("DATA16"))%></textarea>
					</td>
				</tr>					
				<% 
				}%>
				
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="subject"> ?????????</label>
					</th>
					<td>
						<input type="text" name="subject" id="subject" value="<%=util.getStr(dataMap.get("SUBJECT"))%>" class="inp_text" style="width: 95%;" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proExpense"> ?????????</label>
					</th>
					<td>
						<input type="text" name="proExpense" id="proExpense" value="<%=util.getStr(dataMap.get("DATA02"))%>" class="inp_text" style="width: 95%;" maxlength="10" />
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="recDt"> ????????????</label>
					</th>
					<td>
						<input type="text" name="recStDt" id="recStDt" class="inp_text" value="<%=util.getStr(dataMap.get("DATA03"))%>" /> ~
						<input type="text" name="recEdDt" id="recEdDt" class="inp_text" value="<%=util.getStr(dataMap.get("DATA04"))%>" />
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proDt"> ????????????</label>
					</th>
					<td>
						<input type="text" name="proStDt" id="proStDt" class="inp_text" value="<%=util.getStr(dataMap.get("DATA05"))%>" /> ~
						<input type="text" name="proEdDt" id="proEdDt" class="inp_text" value="<%=util.getStr(dataMap.get("DATA06"))%>" />
					</td>
				</tr>
				<tr>
					<th class="col">
						 ????????????
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="supportPlace" id="supportPlace" class="inp_text b_txtbox1" value="<%=util.getStr(dataMap.get("DATA09"))%>" />
					</td>
				</tr>
				<tr>
					<th class="col"> ????????????/??????</th>
					<td class="r_line_none p_top_btm_6">
						<span id="orgGroupTd">
							<input type="text" name="OwnOrgNm" id="OwnOrgNm" value="<%=util.getStr(dataMap.get("DATA07"))%>" class="inp_text b_txtbox1" style="padding-left:2px; font-size:12px" placeholder=" ????????????????????? ??????????????????."/>&nbsp;
							<input type="hidden" name="OwnOrg" id="OwnOrg" value="<%=util.getStr(dataMap.get("DATA17"))%>"/>
							<% if( util.getStr(loginVO.getAuthLv()).equals("99") ){ %>
								<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="btn_inp_b_01" onclick="popupWindow('registrationOrgList')" >
							<% } %>
						</span>
						<span>
							<input type="text" name="OwnDeptNm" id="OwnDeptNm" value="<%=util.getStr(dataMap.get("DATA08"))%>" class="inp_text b_txtbox1" style="padding-left:2px; font-size:12px" placeholder=" ????????????????????? ??????????????????."/>&nbsp;
							<input type="button" name="blngOrgSubNm" value="????????????" id="blngOrgSubNm" class="btn_inp_b_01" onclick="popupWindow('registrationOrgSubList')" >
						</span>
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proCharge"> ???????????????</label>
					</th>
					<td class="r_line_none p_top_btm_6">
						<table>
						<tr><th>???       ???</th><td><input type="text" name="proChargeNm" id="proChargeNm" value="<%=util.getStr(dataMap.get("DATA10"))%>" class="inp_text b_txtbox1" /></td></tr>
						<tr><th>???       ???</th><td><input type="text" name="proChargePosition" id="proChargePosition" value="<%=util.getStr(dataMap.get("DATA11"))%>" class="inp_text b_txtbox1" /></td></tr>						
						<tr><th>???       ???</th><td><input type="text" name="proChargeTel" id="proChargeTel" value="<%=util.getStr(dataMap.get("DATA12"))%>" class="inp_text b_txtbox1" maxlength="11"/></td></tr>
						<tr><th>???  ???  ???</th><td><input type="text" name="proChargeEmail" id="proChargeEmail" value="<%=util.getStr(dataMap.get("DATA13"))%>" class="inp_text b_txtbox1" /></td></tr>
						</table>						
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proPurpose"> ????????????</label>
					</th>
					<td>
						<textarea rows="5" cols="111" name="proPurpose" id="proPurpose"><%=util.getStr(dataMap.get("DATA14"))%></textarea>
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="contents"> ????????????</label>
					</th>
					<td class="con-txt">
						<textarea name="content" id="contents" style="width: 100%; height: 350px;"><%=dataMap.get("CONTENT")%></textarea>
					</td>
				</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th class="tit">
						<label for="extfile">????????????</label>
					</th>
					<td>
					<%
						if(fileList.size() > 0){
					%>
							<ul class="file" style="line-height: 22px;">
							<%
								int fileCnt = 1;
								for(HashMap rs:fileList){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
														+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
														+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
							%>
								<li class="text">
									<input type="checkbox" name="fileFlog" id="fileFlog_<%=fileCnt%>"
											value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" /> &nbsp;
									<label for="fileFlog_<%=fileCnt%>">????????????</label>&nbsp;&nbsp;&nbsp;&nbsp;
									<%=util.deStr(rs.get("TITLE_ORG"))%>
									<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:200px;padding:10px"/>
		 							<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
		 						</li>
							<% fileCnt++; }%>
							</ul>
							<div style="display: inline-block;"
								id="<%=fileFullGrp%>fileGrpBox">
								<div>
									<input type="file" class="inp_text" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
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
								<input type="file" class="inp_text" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
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
						      <br/> * 300kb????????? ?????????????????? ????????? ???????????????.
							  <br/> * ????????? ???????????? ??????????????????.
					</td>
				</tr>
				<%} %>
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
		reason1(<%=state%>);

		$("#recStDt, #recEdDt, #proStDt, #proEdDt").datepicker({
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
	    $('#recStDt').datepicker("option", "maxDate", $("#recEdDt").val());
	    $('#recStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#recEdDt").datepicker( "option", "minDate", selectedDate );
	    });
		// ????????? ?????? ?????? ????????? ?????? ??? ??????
	    $('#recEdDt').datepicker("option", "minDate", $("#recStDt").val());
	    $('#recEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#recStDt").datepicker( "option", "maxDate", selectedDate );
		});

	 	// ????????? ?????? ?????? ????????? ?????? ??? ??????
	    $('#proStDt').datepicker("option", "maxDate", $("#proEdDt").val());
	    $('#proStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#proEdDt").datepicker( "option", "minDate", selectedDate );
	    });
	 	// ????????? ?????? ?????? ????????? ?????? ??? ??????
	    $('#proEdDt').datepicker("option", "minDate", $("#proStDt").val());
	    $('#proEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	    $("#proStDt").datepicker( "option", "maxDate", selectedDate );
		});

		//????????? ??????
		$("#proExpense").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^0-9]/gi,''));
            }
        });
		$("#proChargeTel").keyup(function(event){
            if (!(event.keyCode >=37 && event.keyCode<=40)) {
                var inputVal = $(this).val();
                $(this).val(inputVal.replace(/[^0-9]/gi,''));
            }
        });
		
		//?????? ??????
		$('#proChargeNm').change(function(){
				var value = $('#proChargeNm').val();
				var pattern = /^[???-???]{2,5}$/;
				var match = pattern.exec(value);

				if(match == null || value.length < 2 || value.length > 5){
					alert("????????? ?????? 2????????? 5??? ????????? ???????????? ?????????.");
					$('#proChargeNm').val('').focus();
					return;
				}
		});
		
		//????????? ??????
		$('#proChargeEmail').change(function(){
			var value = $('#proChargeEmail').val();
			var pattern = /^[_0-9a-zA-Z-.]+@[0-9a-zA-Z]+(.[_0-9a-zA-Z-]+)$/;
			var pattern1 = /^[_0-9a-zA-Z-.]+@[0-9a-zA-Z]+(.[_0-9a-zA-Z-]+)+(.[_0-9a-zA-Z-]+)$/;
			var match = pattern.exec(value);
			var match1 = pattern1.exec(value);

			if(match == null && match1 == null){
				alert("email ???????????? ???????????? ?????????.");
				$('#proChargeEmail').val('').focus();
				return;
			};
		 });

	});
	

	function goSubmit(mode){

		//?????? ?????????(mode = editProc??????) ????????? ??????
		if(mode == 'editProc'){
			if($('#subject').val() == ""){
				alert("???????????? ?????? ????????????");
				return false;
			}
			if($('#proExpense').val() == ""){
				alert("???????????? ?????? ????????????");
				return false;
			}
			if($('#recStDt').val() == "" || $('#recEdDt').val() == ""){
				alert("??????????????? ?????? ????????????");
				return false;
			}
			if($('#proStDt').val() == "" || $('#proEdDt').val() == ""){
				alert("??????????????? ?????? ????????????");
				return false;
			}			
			if($('#proChargeNm').val() == ""){
				alert("??????????????? ????????? ??????????????????");
				return false;
			}
			if($('#proPurpose').val() == ""){
				alert("??????????????? ?????? ????????????");
				return false;
			}
			if($('#content').val() == ""){
				alert("??????????????? ?????? ????????????");
				return false;
			}
		}

		if(mode=="editProc"&&permEditor=="Y"){
			oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

			if((oEditors[0].getIR()).length < 15){
          	  alert("??????????????? ?????? ??????????????????");
          	  return false;
             }
             //alert( oEditors[0].getIR() );
             //alert( document.getElementById("contents").value );
             //alert((oEditors[0].getIR()).length);
		}
		$('#mode').val(mode);
		$('#fedit').submit();
	}


	var fileCount = $("input[type=file]").length;
	  for(i = 1; i <= fileCount; i++) {
		$('#jnsptotalFile'+fileCount).bind('change', function() {
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


	$(".addImageBtn,.delImageBtn").bind('click', function(){
		var fileCount = $("input[type=file]").length;
		$('#jnsptotalFile'+fileCount).bind('change', function() {
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
				}
			}
		});
	});
	//???????????? ??????
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="";
		
		if(listMode == 'registrationOrgSubList'){
			popUrl="/sys/popup/"+listMode+".do?orgGrpCd="+$('input[name=OwnOrg]').val();
		}else{
			popUrl="/sys/popup/"+listMode+".do";
		}
		var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}
	
	//???????????? ???????????? ??????????????? ?????????
	function reason1(state){	
		if(state == "30"){
			$('.reasonInput').show();	
		}else{
			$('.reasonInput').hide();
		}
	}
</script>