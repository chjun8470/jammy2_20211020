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

	String siteId = util.getStr(paramMap.get("siteId"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));

	if ("".equals(mode))
		mode = "write";

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp = fileGrp + fileSubGrp;
%>

<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post"
	enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor"
		value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" /> <input
		type="hidden" name="siteId" id="siteId" value="<%=siteId%>" /> <input
		type="hidden" name="boardComIdx" id="boardComIdx"
		value="<%=boardComIdx%>" /> <input type="hidden" name="mode"
		id="mode" value="<%=mode%>" /> <input type="hidden" name="nowPage"
		id="nowPage" value="<%=staticVO.getNowPage()%>" /> <input
		type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId"
		value="0" /> <input type="hidden" name="reUrl" id="reUrl"
		value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" /> <input
		type="hidden" name="searchType" id="searchType"
		value="<%=searchType%>" /> <input type="hidden" name="searchWord"
		id="searchWord" value="<%=searchWord%>" />


	<div class="skin_bbs_write" style="margin-top: 30px">
		<span style="color: red; font-size: 10pt;"> * 필수 입력사항입니다.</span>
		<table class="skin_basic_write">
			<caption>작성하기</caption>
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
							공지글여부</label></th>
					<td>사용 <input type="checkbox" name="noticeAt" id="noticeAt"
						value="Y" onclick="check_only(this)" /> 미사용 <input
						type="checkbox" name="noticeAt" id="noticeAt_N" value="N"
						checked="checked" onclick="check_only(this)" />
					</td>
				</tr>
				<%
					}
				%>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="subject">사업구분</label>
					</th>
					<td>
						<label><input type="radio" name="b_type" value="1" />정부R&D</label>
						<label><input type="radio" name="b_type" value="2" />전남R&D</label>
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span><label for="subject">
							사업명</label></th>
					<td><input type="text" name="subject" id="subject" value=""
						style="width: 80%; font-size: 10pt;" maxlength="100" class="inp_text" /> 비밀글 <input
						type="checkbox" name="secretAt" id="secretAt" value="Y" /></td>
				</tr>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="subject">접수일정</label>
					</th>
					<td>
						<label for="">시작일</label><input type="text" name="sdate" id="sdate" value="" class="inp_text" autocomplete="off" />
						<label for="">종료일</label><input type="text" name="edate" id="edate" value="" class="inp_text" autocomplete="off" />
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="subject">시행부처</label>
					</th>
					<td>
						<input type="text" name="b_center" id="b_center" value="" class="inp_text" />
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="subject">지원기관</label>
					</th>
					<td>
						<input type="text" name="b_part" id="b_part" value="" class="inp_text"/>						
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><span
						style="color: red; font-size: 11pt;">*</span> <label for="subject">문의번호</label>
					</th>
					<td>
						<input type="text" name="b_tel" id="b_tel" value="" class="inp_text" />						
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><label for="contents"> 사업개요</label>
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
									<th>지원유형</th>
									<th>지원대상</th>
									<th>지원예산</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td style="text-align:center;"><input type="text" name="b_tel" id="b_tel" value="" class="inp_text"/></td>
									<td style="text-align:center;"><input type="text" name="b_tel" id="b_tel" value="" class="inp_text"/></td>
									<td style="text-align:center;"><input type="text" name="b_tel" id="b_tel" value="" class="inp_text"/></td>
								</tr>
							</tbody>
						</table>
					</td>					
				</tr>
				<tr>
					<th scope="row" class="tit"><label for="subject">지원대상 기업입력</label>
					</th>
					<td>
						<input type="text" name="b_comp1" id="b_comp1" value="" class="inp_text" style="width:60%" />						
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit"><label for="subject">지원대상 기업규모</label>
					</th>
					<td>
						<input type="text" name="b_comp2" id="b_comp2" value="" class="inp_text" style="width:60%" />						
					</td>
				</tr>
				<%
					if (util.getStr(boardMap.get("PERM_FILE")).equals("Y")) {
				%>
				<tr>
					<th scope="row" class="tit">첨부파일</th>
					<td>
						<div style="display: inline-block;"
							id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1"
									id="<%=fileFullGrp%>File1" title="파일첨부" />
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
                        arrfileCnt['<%=fileFullGrp%>
							'] = 2;

							function addRowFile(fileGrpnm) {
								var fileHtml = "<div>";
								fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
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
			<input type="button" class="btn_inp_b_01" value="작성"
				onclick="goSubmit('writeProc')" /> <input type="button"
				class="btn_inp_w_01" value="목록" onclick="goSubmit('list')" />
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
				alert("제목을 입력해주세요");
				return false;
			}

			if (confirm("저장하시겠습니까??") == true) { //확인

				if (permEditor == "Y") {
					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD",
							[]);
				}

			} else { //취소
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
		nextText : '다음 달',
		prevText : '이전 달',
		currentText : '오늘 날짜',
		closeText : '닫기',
		dateFormat : "yy-mm-dd",
		dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일' ],
		dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
		monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
		monthNamesShort : [ '01', '02', '03', '04', '05', '06', '07', '08', '09', '10', '11', '12' ]
	});

	// 시작일 값에 따른 종료일 선택 값 제한
    $('#sdate').datepicker("option", "maxDate", $("#edate").val());
    $('#sdate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#edate").datepicker( "option", "minDate", selectedDate );
    });
	// 종료일 값에 따른 시작일 선택 값 제한
    $('#edate').datepicker("option", "minDate", $("#sdate").val());
    $('#edate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#sdate").datepicker( "option", "maxDate", selectedDate );
	});

	var permEditor = $('#permEditor').val();
	if (permEditor == "Y") {
		var oEditors = [];
		$(function() {
			//추가 글꼴 목록
			//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors,
				elPlaceHolder : "contents",
				sSkinURI : "/js/webeditor_nhn/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true, // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : true, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true, // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//aAdditionalFontList : aAdditionalFontSet,              // 추가 글꼴 목록
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
</script>