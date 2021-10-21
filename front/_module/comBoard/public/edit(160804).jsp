<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
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
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String m = util.getStr(paramMap.get("m"));
	String siteComIdx = util.getStr(paramMap.get("siteComIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId"));
	if("".equals(mode)) mode = "edit";
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>

<form name="fedit" id="fedit" action="/web/comBoard.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="siteComIdx" id="siteComIdx" value="<%=siteComIdx%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>&amp;boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="regId" id="regId" value="<%=util.getStr(loginVO.getUserId())%>" />
	<input type="hidden" name="regNm" id="regNm" value="<%=util.getStr(loginVO.getPsnNm())%>" />
	<input type="hidden" name="regIp" id="regIp" value="<%=util.getStr(request.getRemoteAddr())%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId %>" />
	<input type="hidden" name="m" value="<%=m%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<div class="skin_bbs_write" >
	<font color="red">* 필수 입력사항입니다.</font>
		<table class="skin_write" style="width:100%" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
			<caption>작성하기</caption>
			<colgroup>
		      <col style="width:15%;" />
		      <col style="width:35%;" />
		      <col style="width:15%;" />
		      <col style="width:35%;" />
		    </colgroup>
			<tbody>
				<%-- <tr>
					<th scope="col">
					<label for="subject">사이트</label>
					</th>
					<td class="r_line_none p_top_btm_6">
					<select name="lclas" id="lclas" class="b_select2" style="height: 24px">
						<option value="" <%if("".equals(util.getStr(dataMap.get("DATA01")))) {%> selected="selected" <%}%>>선택</option>
						<option value="JEINET" <%if("JEINET".equals(util.getStr(dataMap.get("DATA01")))) {%> selected="selected" <%}%>>연구장비정보망</option>
						<option value="JIPBANK" <%if("JIPBANK".equals(util.getStr(dataMap.get("DATA01")))) {%> selected="selected" <%}%>>지식재산정보은행</option>
						<option value="JNTIS" <%if("JNTIS".equals(util.getStr(dataMap.get("DATA01")))) {%> selected="selected" <%}%>>과학기술정보시스템</option>
					</select>
					</td>
				</tr> --%>
				<tr>
					<th scope="col">
					<font color="red">*</font>게시판
					</th>
					<td colspan="3" class="r_line_none p_top_btm_6">
					<select name="sclas" id="sclas" class="b_select2" style="height: 24px">
						<option value="" <%if("".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>선택</option>
						<option value="POLICY" <%if("POLICY".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>정책이슈</option>
						<option value="LAWORD" <%if("LAWORD".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>관련법령</option>
						<option value="STATS" <%if("STATS".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>통계자료</option>
						<option value="ETC" <%if("ETC".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>기타발간물</option>
					</select>
					</td>
				</tr>
				<tr>
					<th scope="col">
						<font color="red">*</font>제목
					</th>
					<td colspan="3" class="r_line_none p_top_btm_6">
						<input type="text" name="subject" id="subject" class="b_txtbox1" value="<%=util.getStr(dataMap.get("SUBJECT"))%>" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="col">
						<font color="red">*</font>발행기관(출처)
					</th>
					<td>
						<input type="text" name="publiccationOrg" id="publiccationOrg" value="<%=util.getStr(dataMap.get("DATA04"))%>" class="input_txt00301" maxlength="100" style="width: 85%;"/>
					</td>
					<th scope="col">
						<font color="red">*</font>발행일
					</th>
					<td class="r_line_none">
						<input type="text" name="publiccationDt" id="publiccationDt" value="<%=util.getStr(dataMap.get("DATA05"))%>" class="input_txt00301" maxlength="100"  style="width: 85%;"/>
					</td>
				</tr>
				<%-- <tr>
					<th scope="col">
						목차<br /><font color="red">(200자내외)</font>
					</th>
					<td colspan="3" class="r_line_none p_top_btm_6">
						<textarea name="summary" id="summary" class="b_txtbox4" rows="5" cols="20" onkeyup="checkLength(this);" ><%=util.getStr(dataMap.get("DATA02"))%></textarea>
					</td>
				</tr> --%>
				<tr>
					<th scope="col">
						주요정보
					</th>
					<td colspan="3" class="r_line_none p_top_btm_6">
						<textarea name="content" id="contents" rows="5" cols="20" style="width: 100%; height: 350px;"><%=dataMap.get("CONTENT")%></textarea>
					</td>
				</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th scope="row" class="tit">
						대표이미지<br /><font color="red">(이미지파일)</font>
					</th>
					<td  colspan="3">
					<%
					if(fileList.size() > 0){
				%>
						<ul class="file" style="line-height: 22px;">
						<%
							int fileCnt = 1;
							for(HashMap rs:fileList){
									if(!"pdf".equals(util.getStr(rs.get("FILE_CAT")))){
										if(!"PDF".equals(util.getStr(rs.get("FILE_CAT")))){
										String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
													+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
													+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
							<li class="text">
								<input type="checkbox" name="fileFlog" value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" /> &nbsp;
								파일삭제&nbsp;&nbsp;&nbsp;&nbsp;
								<%=util.deStr(rs.get("TITLE_ORG"))%>
							</li>
						<% fileCnt++; } } }%>
						</ul>
						<div style="display: inline-block;">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" style="height:37px;" title="파일첨부" />
							</div>
						</div>

							<script type="text/javascript">
								function fileSet(fileCnt){
									if($('#fileFlog_'+fileCnt).is(':checked')){
										$('#fileBox_'+fileCnt).show();
									}else{
										$('#fileBox_'+fileCnt).hide();
									}
								}
				            </script>

	            <% } %>
					</td>
				</tr>

				<tr>
					<th scope="row" class="tit">
						첨부파일<br /><font color="red">(PDF)</font>
					</th>
				<td colspan="3">
				<%
					if(fileList.size() > 0){
				%>
						<ul class="file" style="line-height: 22px;">

						<%
							int fileCnt = 1;
							for(HashMap rs:fileList){
								if("pdf".equals(util.getStr(rs.get("FILE_CAT"))) || "PDF".equals(util.getStr(rs.get("FILE_CAT")))){
									String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
													+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
													+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
							<li class="text">
								<input type="checkbox" name="fileFlog" value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" /> &nbsp;
								파일삭제&nbsp;&nbsp;&nbsp;&nbsp;
								<%=util.deStr(rs.get("TITLE_ORG"))%>
							</li>
						<% fileCnt++; } }%>
						</ul>
						<div style="display: inline-block;">
							<div>
								<input type="file" name="<%=fileFullGrp%>File2" id="<%=fileFullGrp%>File2" style="height:37px;" title="파일첨부" />
							</div>
						</div>

							<script type="text/javascript">
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
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" style="height:37px;" title="파일첨부" />
							</div>
						</div>
						<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File2" id="<%=fileFullGrp%>File2" style="height:37px;" title="파일첨부" />
							</div>
						</div>

			      <% } %>
						      <br/>
							  <br/>
					      </td>
				</tr>
				<%} %>
			</tbody>
		</table>

		<div class="b_btn_area">
			<button type="button" class="btn_rgt" value="수정" onclick="goSubmit('editProc')">수정</button>
			<button type="button" class="btn_lft2" value="취소" onclick="goSubmit('view')">취소</button>
		</div>

		<!--// bo_btn -->
	</div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
function checkLength(comment) {
    if (comment.value.length > 200 ) {
	  	comment.blur();
        comment.value = comment.value.substring(0, 200);
        alert('200자 이내로 입력');
        comment.focus();
        return false;
    }
}

function goSubmit(mode){
	if(mode=="editProc" && permEditor=="Y"){
		oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		var sclas = $("select[name=sclas]").val().trim();
		if(sclas == "" || sclas == null){
			alert("게시판을 선택해 주세요.")
			return false;
		}

		oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		var ext1 = $("#"+"<%=fileFullGrp%>"+"File1").val().split('.').pop().toLowerCase();
		var ext2 = $("#"+"<%=fileFullGrp%>"+"File2").val().split('.').pop().toLowerCase();
		if(ext1 != "" && ext1 != null){
		if(ext1 != 'jpeg' && ext1 != 'jpg' && ext1 != 'gif' && ext1 != 'png'){
			alert('대표이미지는 gif,png,jpg,jpeg 파일만 업로드 할수 있습니다.');
			return false;
			}
		}
		if(ext2 != "" && ext2 != null){
		if(ext2 != 'pdf'){
			alert('첨부파일은 pdf 파일만 업로드 할수 있습니다.');
			return false;
			}
		}
	}
	$('#mode').val(mode);
	if(mode == "view"){
		$('#fedit').attr("action","sub.do");
		$('#fedit').attr('method','get');
	}
	if(mode == "editProc"){
		$('#fedit').attr("action","sub.do");
	}
	$('#fedit').submit();
}

var oEditors = [];
var permEditor = $('#permEditor').val();

function htmlEditor(){
	if(permEditor=="Y"){

		$(function(){
			// 추가 글꼴 목록
			//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "contents",
				sSkinURI: "/js/webeditor_nhn/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
				}, //boolean
				fCreator : "createSEditor2"
			});
		});
	}
}
$(document).ready(function() {
	var win_w = $(window).width();
	if(win_w >= 768){
		$('#contents').hide();
		htmlEditor();
	}
	$(window).resize(function(){
		winResize();
	});
	winResize();
});


function winResize(){
	var win_w = $(window).width();

	if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%

			if(permEditor=="Y"){
				if($('#contents').css("display")!='none'){
					if(permEditor=="Y"){
						$('#contents').hide();
						htmlEditor();
					}
				}

			}
	}else if(win_w < 768){ //모바일 769 이하일때 100%
		if(permEditor=="Y"){
			if($('#contents').css("display")=='none'){
				oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				$('.r_line_none iframe').remove();
				$('#contents').show();
			}
		}

	}else{ //기본사이즈
	}

}

	   	var fileCount = $("input[type=file]").length;
	     for(i = 1; i <= fileCount; i++) {
				$('#jnsptotalFile'+fileCount).bind('change', function() {
					var fileName = $('#jnsptotalFile'+fileCount).val();
					if(fileName != "" || fileName != null){
						fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
						if(imgPattern.indexOf(fileName)==-1){
							alert("첨부파일은 bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다.");
							$('#jnsptotalFile'+fileCount).val("");
							return false;
						}else if(this.files[0].size<300000){
							alert("300kb 이상의 이미지를 등록해주세요.");
							$('#jnsptotalFile'+fileCount).val("");
							return false;
						}
					}
				});
		}

		$(".addImageBtn,.delImageBtn").bind('click', function(){
		var fileCount = $("input[type=file]").length;
				$('#jnsptotalFile'+fileCount).bind('change', function() {
					var fileName = $('#jnsptotalFile'+fileCount).val();

					if(fileName != "" || fileName != null){
						fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
						if(imgPattern.indexOf(fileName)==-1){
							alert("첨부파일은 bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다.");
							$('#jnsptotalFile'+fileCount).val("");
							return false;
						}else if(this.files[0].size<300000){
							alert("300kb 이상의 이미지를 등록해주세요.");
							$('#jnsptotalFile'+fileCount).val("");
							return false;
						}
					}
				});
		});

		 $("#publiccationDt").datepicker({
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
			monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
       });

</script>