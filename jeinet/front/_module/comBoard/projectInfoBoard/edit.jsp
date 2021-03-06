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

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	ArrayList<HashMap<String, String>> supportTypeList = request.getAttribute("supportTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportTypeList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String searchReceipt = util.getStr(paramMap.get("searchReceipt"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId")); //???????????????

	if("".equals(mode)) mode = "edit";

%>
<form name="fedit" id="fedit" action="sub.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="m" id="m" value="<%=m%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>&boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<input type="hidden" name="searchReceipt" id="searchReceipt" value="<%=searchReceipt%>" />
	
	<div class="basic_writeWrap">
		<span style="color:red; font-size:10pt;"> * ?????? ?????????????????????.</span>
		<table class="skin_write" style="margin: 10px;">
			<caption>????????????</caption>
			<colgroup>
				<col width="180px" />
				<col width="*" />
			</colgroup>
			<tbody>
			<%if(siteId.equals("jntis")){ %>
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> ??????????????????
					</th>
					<td class="r_line_none p_top_btm_6">
						<select name="supportType" id="supportType" class="b_select2" style="width: 31%;">
						<%for(HashMap rs:supportTypeList){%>
							<option
								value="<%=util.getStr(rs.get("CODE_CD")) %>"
		              			<%if(util.getStr(rs.get("CODE_CD")).equals(util.getStr(dataMap.get("DATA01")))) {%>
		              			selected="selected"
		              			<%}%>
		              		><%=util.getStr(rs.get("CODE_NM")) %></option>
						<%}%>
	              		</select>
					</td>
				</tr>
			<%} %>	
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> ?????????
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="subject" id="subject" class="b_txtbox1" value="<%=util.getStr(dataMap.get("SUBJECT"))%>"/>
					</td>
				</tr>
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> ?????????
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="proExpense" id="proExpense" class="b_txtbox1" value="<%=util.getStr(dataMap.get("DATA02"))%>" maxlength="10"/>
					</td>
				</tr>
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> ????????????
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="recStDt" id="recStDt" class="b_txtbox3" value="<%=util.getStr(dataMap.get("DATA03"))%>" style="width:13%;" /> ~
						<input type="text" name="recEdDt" id="recEdDt" class="b_txtbox3" value="<%=util.getStr(dataMap.get("DATA04"))%>" style="width:13%;" />
					</td>
				</tr>
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> ????????????
					</th>
					<td class="r_line_none p_top_btm_6" >
						<input type="text" name="proStDt" id="proStDt" class="b_txtbox3" value="<%=util.getStr(dataMap.get("DATA05"))%>" style="width:13%;" /> ~
						<input type="text" name="proEdDt" id="proEdDt" class="b_txtbox3" value="<%=util.getStr(dataMap.get("DATA06"))%>" style="width:13%;" />
					</td>
				</tr>
				<tr>
					<th class="col">
						 ????????????
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="supportPlace" id="supportPlace" class="b_txtbox1" value="<%=util.getStr(dataMap.get("DATA09"))%>" />
					</td>
				</tr>
				<tr>
					<th class="col"> ????????????/??????</th>
					<td class="r_line_none p_top_btm_6">
						<span id="orgGroupTd">
							<input type="text" name="OwnOrgNm" id="OwnOrgNm" value="<%=util.getStr(dataMap.get("DATA07"))%>" class="b_txtbox1" style="padding-left:2px; font-size:12px" placeholder=" ????????????????????? ??????????????????."/>&nbsp;
							<input type="hidden" name="OwnOrg" id="OwnOrg" value=""/>
							<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="b_btn_01" onclick="popupWindow('registrationOrgList')" >
						</span>
						<span>
							<input type="text" name="OwnDeptNm" id="OwnDeptNm" value="<%=util.getStr(dataMap.get("DATA08"))%>" class="b_txtbox1" style="padding-left:2px; font-size:12px" placeholder=" ????????????????????? ??????????????????."/>&nbsp;
							<input type="button" name="blngOrgSubNm" value="????????????" id="blngOrgSubNm" class="b_btn_02" onclick="popupWindow('registrationOrgSubList')" >
						</span>
					</td>
				</tr>
				
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> ???????????????
					</th>
					<td class="r_line_none p_top_btm_6">
						<table>
						<tr><th>???       ???</th><td><input type="text" name="proChargeNm" id="proChargeNm" value="<%=util.getStr(dataMap.get("DATA10"))%>" class="b_txtbox1" /></td></tr>
						<tr><th>???       ???</th><td><input type="text" name="proChargePosition" id="proChargePosition" value="<%=util.getStr(dataMap.get("DATA11"))%>" class="b_txtbox1" /></td></tr>						
						<tr><th>???       ???</th><td><input type="text" name="proChargeTel" id="proChargeTel" value="<%=util.getStr(dataMap.get("DATA12"))%>" class="b_txtbox1" maxlength="11"/></td></tr>
						<tr><th>???  ???  ???</th><td><input type="text" name="proChargeEmail" id="proChargeEmail" value="<%=util.getStr(dataMap.get("DATA13"))%>" class="b_txtbox1" /></td></tr>
						</table>						
					</td>
				</tr>
				<tr>
					<th class="col">
						<span style="color:red; font-size:11pt;">*</span> ????????????
					</th>
					<td class="r_line_none p_top_btm_6">
						<textarea rows="5" cols="110" name="proPurpose" id="proPurpose" class="b_txtbox1" style="height:90px; font-size:16px;"><%=util.getStr(dataMap.get("DATA14"))%></textarea>
					</td>
				</tr>
				<tr>
					<th class="col"> ????????????</th>
					<td class="r_line_none p_top_btm_6">
						<textarea name="content" id="contents" class="b_txtbox4" style="width:98%;"><%=dataMap.get("CONTENT")%></textarea>
					</td>
				</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th class="col"> ????????????</th>
					<td class="r_line_none p_top_btm_6">
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
		 					</li>
							<% fileCnt++; }%>
						</ul>

						<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" style="height:37px;" title="????????????" />
							</div>
						</div>

						<div style="display: inline-block; vertical-align: bottom;">
							<button class="addImageBtn b_btn_03" type="button" onclick="addRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_plus.gif" alt="???????????? ?????? ??????" /></button>
							<button class="delImageBtn b_btn_03" type="button" onclick="delRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_del.gif" alt="???????????? ?????? ??????" /></button>
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
						          	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 0){
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
						<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
		              		<div style="padding-bottom:5px;">
		              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1" style="height:37px;" title="????????????" />
							</div>
	              		</div>

		              	<div style="display:inline-block;vertical-align:bottom;padding-bottom:5px;">
		              		<button class="addImageBtn b_btn_03" type="button" onclick="addRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_plus.gif" alt="???????????? ?????? ??????" /></button>
							<button class="delImageBtn b_btn_03" type="button" onclick="delRowFile('<%=fileFullGrp%>');"><img src="/img/board/btn_del.gif" alt="???????????? ?????? ??????" /></button>
		              		<%-- <input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
							<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" /> --%>
		              	</div>
	              		<br/> * 300kb????????? ?????????????????? ????????? ???????????????.
						<br/> * ????????? ???????????? ??????????????????.

				        <script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = 2;
					            function addRowFile(fileGrpnm){
				            		var fileHtml = "<div style='padding-bottom:5px;'>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"' style='height:37px;' title='????????????' />";
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
			<%} %>
			</tbody>
		</table>

		<!-- bo_btn  -->
		<div class="b_btn_area">
			<input type="button" class="btn_rgt" value="??????" onclick="goSubmit('editProc')"/>
			<input type="button" class="btn_lft2" value="??????" onclick="goSubmit('view')"/>
		</div>
		<!--// bo_btn -->

	</div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	$(document).ready(function(){

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
			var match = pattern.exec(value);

			if(match == null){
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
	  var oEditors = [];
		 var permEditor = $('#permEditor').val();
		 
		function htmlEditor(){
			if(permEditor=="Y"){
			   
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
		}
		$(document).ready(function() {
			var win_w = $(window).width();
			if(win_w >= 768){
				if(permEditor=="Y"){
					$('#contents').hide();
					htmlEditor();
				}
			}
			$(window).resize(function(){
				winResize();
			});
			winResize();
		});

		
		function winResize(){
			var win_w = $(window).width();
			
			if(win_w < 1198 && win_w >= 768){ //????????? 1198 , 768 ???????????? 100%
				
					if(permEditor=="Y"){
						if($('#contents').css("display")!='none'){
							htmlEditor();
							$('#contents').hide();
						}
						
					}
			}else if(win_w < 768){ //????????? 769 ???????????? 100%
				if(permEditor=="Y"){
					if($('#contents').css("display")=='none'){
						oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
						$('.r_line_none iframe').remove();
						$('#contents').show();
					}
				}
				
			}else{ //???????????????
			}
			
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

	/*---------???????????? S----------*/
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
			//orgGrpCd = data.dataMap.ORG_GRP_CD; //????????????
			$("#orgGroupNm").val(orgGrpNm);
			//$("#eventManageOrgCd").val(orgGrpCd);

			$("#orgGroupDeptNm").val('');
		});
	}
	/*---------???????????? E----------*/

</script>