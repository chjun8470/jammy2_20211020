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
	String searchReceipt = util.getStr(paramMap.get("searchReceipt"));
	
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	if("".equals(mode)) mode = "write";

%>
<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
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
						<font color="red">*</font><label for="supportType"> ??????????????????</label>
					</th>
					<td>
						<select name="supportType" id="supportType" style="width:30%;">
						<%for(HashMap rs:supportTypeList){%>
							<option value="<%=util.getStr(rs.get("CODE_CD")) %>"><%=util.getStr(rs.get("CODE_NM")) %></option>
						<%}%>
	              		</select>
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="subject"> ?????????</label>
					</th>
					<td>
						<input type="text" name="subject" id="subject" value="" style="width: 95%;" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proExpense"> ?????????</label>
					</th>
					<td>
						<input type="text" name="proExpense" id="proExpense" value="" style="width: 95%;" maxlength="10" />
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="recDt"> ????????????</label>
					</th>
					<td>
						<input type="text" name="recStDt" id="recStDt" value="" /> ~
						<input type="text" name="recEdDt" id="recEdDt" value="" />
					</td>
				</tr>
				
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proDt"> ????????????</label>
					</th>
					<td>
						<input type="text" name="proStDt" id="proStDt" value="" /> ~
						<input type="text" name="proEdDt" id="proEdDt" value="" />
					</td>
				</tr>
				<tr>
					<th class="col">
						 ????????????
					</th>
					<td class="r_line_none p_top_btm_6">
						<input type="text" name="supportPlace" id="supportPlace" value="" class="b_txtbox1" />
					</td>
				</tr>
				<tr>
					<th class="col"> ????????????/??????</th>
					<td class="r_line_none p_top_btm_6">
						<span id="orgGroupTd">
							<input type="text" name="OwnOrgNm" id="OwnOrgNm" value="" class="b_txtbox1" style="width:30%;" placeholder=" ????????????????????? ??????????????????."/>&nbsp;
							<input type="hidden" name="OwnOrg" id="OwnOrg" value=""/>
							<input type="button" name="blngOrgNm" value="????????????" id="blngOrgNm" class="b_btn_01" onclick="popupWindow('registrationOrgList')" >
						</span>
						<span>
							<input type="text" name="OwnDeptNm" id="OwnDeptNm" value="" class="b_txtbox1" style="width:30%;" placeholder=" ????????????????????? ??????????????????."/>&nbsp;
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
						<tr><th>???       ???</th><td><input type="text" name="proChargeNm" id="proChargeNm" value="" class="b_txtbox1" /></td></tr>
						<tr><th>???       ???</th><td><input type="text" name="proChargePosition" id="proChargePosition" value="" class="b_txtbox1" /></td></tr>
						<tr><th>???  ???  ???</th><td><input type="text" name="proChargeEmail" id="proChargeEmail" value="" class="b_txtbox1" /></td></tr>
						<tr><th>???       ???</th><td><input type="text" name="proChargeTel" id="proChargeTel" value="" class="b_txtbox1" maxlength="11"/></td></tr>
						</table>						
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="proPurpose"> ????????????</label>
					</th>
					<td>
						<textarea rows="5" cols="111" name="proPurpose" id="proPurpose"></textarea>
					</td>
				</tr>
				<tr>
					<th class="tit">
						<font color="red">*</font><label for="contents"> ????????????</label>
					</th>
					<td class="con-txt">
						<textarea name="content" id="contents" style="width: 100%; height: 350px;"></textarea>
					</td>
				</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th class="tit">
						<label for="extfile"> ????????????</label>
					</th>
					<td>
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div >
	              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="????????????" />
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
					</td>
				</tr>
			<%} %>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('writeProc')"/>
			<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
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

		//?????? ?????????(mode = writeProc??????) ????????? ??????
		if(mode == 'writeProc'){
			if($('#subject').val() == ""){
				alert("???????????? ??????????????????");
				return false;
			}
			if($('#proExpense').val() == ""){
				alert("???????????? ??????????????????");
				return false;
			}
			if($('#recStDt').val() == "" || $('#recEdDt').val() == ""){
				alert("??????????????? ??????????????????");
				return false;
			}
			if($('#proStDt').val() == "" || $('#proEdDt').val() == ""){
				alert("??????????????? ??????????????????");
				return false;
			}
			
			if($('#proChargeNm').val() == ""){
				alert("??????????????? ????????? ??????????????????");
				return false;
			}
			if($('#proPurpose').val() == ""){
				alert("??????????????? ??????????????????");
				return false;
			}
			if($('#content').val() == ""){
				alert("??????????????? ??????????????????");
				return false;
			}
			
		}



        if(mode=="writeProc" && permEditor=="Y"){
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
        $('#fwrite').submit();
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
				},  //boolean
				fCreator : "createSEditor2"
			});
		});
	}
	
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

</script>