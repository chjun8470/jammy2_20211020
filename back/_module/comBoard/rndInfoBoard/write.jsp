<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page
	import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null
			? new HashMap()
			: (HashMap<String, String>) request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null
			? new HashMap<String, String>()
			: (HashMap<String, String>) request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null
			? new HashMap<String, String>()
			: (HashMap<String, String>) request.getAttribute("boardMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null
			? new StaticVO()
			: (StaticVO) request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null
			? new LoginVO()
			: (LoginVO) request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null
			? new ArrayList<HashMap<String, String>>()
			: (ArrayList<HashMap<String, String>>) request.getAttribute("fileList");

	String siteId = "smbrnd";
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	
	ArrayList<HashMap<String, String>> teamType = request.getAttribute("teamType") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("teamType");
	ArrayList<HashMap<String, String>> helpType = request.getAttribute("helpType") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("helpType");

	if ("".equals(mode))
		mode = "write";

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp = fileGrp + fileSubGrp;
%>

<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post"
	enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor"	value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" /> 
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" /> 
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage"	id="nowPage" value="<%=staticVO.getNowPage()%>" /> 
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" /> 
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />


	<div class="skin_bbs_write" style="margin-top: 30px">
		<span style="color: red; font-size: 10pt;"> * ?????? ?????????????????????.</span>
		<table class="skin_basic_write">
			<caption>????????????</caption>
			<colgroup>
				<col style="width: 15%;" />
				<col style="width: 85%;" />
			</colgroup>
			<tbody>
				<%
					if (util.getStr(boardMap.get("BOARD_ID")).equals("00053")
							|| util.getStr(boardMap.get("BOARD_ID")).equals("00032")
							|| util.getStr(boardMap.get("BOARD_ID")).equals("00005")
							|| util.getStr(boardMap.get("BOARD_ID")).equals("00001")) {
				%>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span><label for="noticeAt">
							???????????????</label></th>
					<td>?????? <input type="checkbox" name="noticeAt" id="noticeAt"
						value="Y" onclick="check_only(this)" /> ????????? <input
						type="checkbox" name="noticeAt" id="noticeAt_N" value="N"
						checked="checked" onclick="check_only(this)" />
					</td>
				</tr>
				<%
					}
				%>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="subject">????????????</label>
					</th>
					<td>
						<label><input type="radio" name="b_type" id="b_type1" value="1" checked />??????R&D</label>
						<label><input type="radio" name="b_type" id="b_type2" value="2" />??????R&D</label>
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span><label for="subject">
							?????????</label></th>
					<td><input type="text" name="subject" id="subject" value=""
						style="width: 80%; font-size: 10pt;" maxlength="100" class="inp_text" /></td>
				</tr>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="sdate">????????????</label>
					</th>
					<td>
						<label for="">?????????</label><input type="text" name="sdate" id="sdate" value="" class="inp_text" autocomplete="off" />
						<label for="">?????????</label><input type="text" name="edate" id="edate" value="" class="inp_text" autocomplete="off" />
					</td>
				</tr>
				<tr class="hidetr hide1">
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="b_center">????????????</label>
					</th>
					<td>
						<select name="b_center" id="b_center" class="select_box">
							<option value="">??????????????????</option>
						<% for(HashMap te:teamType) { %>
							<option value="<%=util.getStr(te.get("CODE_CD"))%>"><%=util.getStr(te.get("CODE_NM"))%></option>
						<% } %>
						</select>
					</td>
				</tr>
				<tr class="hidetr hide2" style="display:none;">
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="b_part">????????????</label>
					</th>
					<td>
						<select name="b_part" id="b_part" class="select_box">
							<option value="">??????????????????</option>
						<% for(HashMap he:helpType) { %>
							<option value="<%=util.getStr(he.get("CODE_CD"))%>"><%=util.getStr(he.get("CODE_NM"))%></option>
						<% } %>
						</select>					
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="subject">????????????</label>
					</th>
					<td>
						<input type="text" name="b_tel" id="b_tel" value="" class="inp_text" />						
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><label for="contents"> ????????????</label>
					</th>
					<td class="con-txt"><textarea name="content" id="contents"
							style="width: 100%; height: 350px; font-size: 10pt;"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="padding:0;">
						<table class="skin_basic_write">
							<thead>
								<tr>
									<th>????????????</th>
									<th>????????????</th>
									<th>????????????</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="text-align:center;"><input type="text" name="b_help_type" id="b_help_type" value="" class="inp_text"/></td>
									<td style="text-align:center;"><input type="text" name="b_help_opp" id="b_help_opp" value="" class="inp_text"/></td>
									<td style="text-align:center;"><input type="text" name="b_help_bug" id="b_help_bug" value="" class="inp_text"/></td>
								</tr>
							</tbody>
						</table>
					</td>					
				</tr>
				<tr>
					<th scope="row" class="tit"><label for="subject">???????????? ????????????</label>
					</th>
					<td>
						<input type="text" name="b_comp1" id="b_comp1" value="" class="inp_text" style="width:60%" />						
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><label for="subject">???????????? ????????????</label>
					</th>
					<td>
						<input type="text" name="b_comp2" id="b_comp2" value="" class="inp_text" style="width:60%" />						
					</td>
				</tr>
				<%
					if (util.getStr(boardMap.get("PERM_FILE")).equals("Y")) {
				%>
				<tr>
					<th scope="row" class="tit">????????????</th>
					<td>
						<div style="display: inline-block;"
							id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1"
									id="<%=fileFullGrp%>File1" title="????????????" />
							</div>
						</div>

						<div style="display: inline-block; vertical-align: bottom;">
							<input class="addImageBtn" type="button" value="+"
								style="width: 30px; height: 20px;"
								onclick="addRowFile('<%=fileFullGrp%>');" /> <input
								class="delImageBtn" type="button" value="-"
								style="width: 30px; height: 20px;"
								onclick="delRowFile('<%=fileFullGrp%>');" />
						</div> <script type="text/javascript">
                    	var arrfileCnt = new Array();
                        arrfileCnt['<%=fileFullGrp%>'] = 2;

							function addRowFile(fileGrpnm) {
								var fileHtml = "<div>";
								fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='????????????' />";
								fileHtml += "</div>";

								$('#' + fileGrpnm + 'fileGrpBox').append(
										fileHtml);
								arrfileCnt[fileGrpnm]++;
							}

							function delRowFile(fileGrpnm) {
								if ($('#' + fileGrpnm + 'fileGrpBox > div')
										.size() <= 1) {
									return;
								}
								$('#' + fileGrpnm + 'fileGrpBox > div').eq(
										$('#' + fileGrpnm + 'fileGrpBox > div')
												.size() - 1).remove();
								arrfileCnt[fileGrpnm]--;
							}
						</script>
					</td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<input type="button" class="btn_inp_b_01" value="??????"
				onclick="goSubmit('writeProc')" /> <input type="button"
				class="btn_inp_w_01" value="??????" onclick="goSubmit('list')" />
		</div>
		<!--// bo_btn -->
	</div>
</form>
<script type="text/javascript"
	src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	function goSubmit(mode) {

		if (mode == "writeProc") {

			if ($('#subject').val() == "") {
				alert("????????? ??????????????????");
				return false;
			}

			if (confirm("??????????????????????????") == true) { //??????

				if (permEditor == "Y") {
					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD",
							[]);
				}

			} else { //??????
				return;
			}
		}

		$('#mode').val(mode);
		$('#fwrite').submit();
	}
	
	
	$("#sdate, #edate").datepicker({
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
		monthNamesShort : [ '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12' ]
	});

	// ????????? ?????? ?????? ????????? ?????? ??? ??????
    $('#sdate').datepicker("option", "maxDate", $("#edate").val());
    $('#sdate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#edate").datepicker( "option", "minDate", selectedDate );
    });
	// ????????? ?????? ?????? ????????? ?????? ??? ??????
    $('#edate').datepicker("option", "minDate", $("#sdate").val());
    $('#edate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#sdate").datepicker( "option", "maxDate", selectedDate );
	});

	var permEditor = $('#permEditor').val();
	if (permEditor == "Y") {
		var oEditors = [];
		$(function() {
			//?????? ?????? ??????
			//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "contents",
				sSkinURI : "/js/webeditor_nhn/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true, // ?????? ?????? ?????? (true:??????/ false:???????????? ??????)
					bUseVerticalResizer : true, // ????????? ?????? ????????? ?????? ?????? (true:??????/ false:???????????? ??????)
					bUseModeChanger : true, // ?????? ???(Editor | HTML | TEXT) ?????? ?????? (true:??????/ false:???????????? ??????)
				//aAdditionalFontList : aAdditionalFontSet,              // ?????? ?????? ??????
				}, //boolean
				fCreator : "createSEditor2"
			});
		});
	}
	function check_only(chk) {
		var obj = document.getElementsByName("noticeAt");
		for (var i = 0; i < obj.length; i++) {
			if (obj[i] != chk) {
				obj[i].checked = false;
			}
		}
	}
	
	$("input[name='b_type']").on("click",function(){
		var tval = $(this).val();
		
		$(".hidetr").css("display","none");
		$(".hide"+tval).css("display","contents");
		
	});
</script>