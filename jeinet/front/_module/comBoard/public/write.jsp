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
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String m = util.getStr(paramMap.get("m"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	if("".equals(mode)) mode = "write";

	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

%>
<form name="fwrite" id="fwrite" action="sub.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
	<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="?m=<%=m%>&amp;boardComIdx=<%=boardComIdx%>&amp;sclas=<%=util.getStr(paramMap.get("sclas"))%>" />
	<input type="hidden" name="regId" id="regId" value="<%=util.getStr(loginVO.getUserId())%>" />
	<input type="hidden" name="regNm" id="regNm" value="<%=util.getStr(loginVO.getPsnNm())%>" />
	<input type="hidden" name="regIp" id="regIp" value="<%=util.getStr(request.getRemoteAddr())%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId %>" />
	<input type="hidden" name="sclas" id="sclas" value="<%=util.getStr(paramMap.get("sclas")) %>" />
	<input type="hidden" name="m" value="<%=m%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<div class="basic_writeWrap003">
		<div class="redTxt" style="margin-bottom:10px">* ?????? ?????????????????????.</div>
		<table class="skin_write003" summary="???????????????  ??????, ??????, ????????????, ???????????????(??????)??? ???????????????.">
			<caption>????????????</caption>
			<colgroup>
		      <col style="width:15%;" />
		      <col style="width:35%;" />
		      <col style="width:15%;" />
		      <col style="width:35%;" />
		    </colgroup>
			<tbody>
				<%-- <tr>
					<th scope="col">
					<label for="subject">?????????</label>
					</th>
					<td class="r_line_none p_top_btm_6">
					<select name="lclas" id="lclas" class="b_select2" style="height: 24px">
						<option value="" <%if("".equals(util.getStr(dataMap.get("SITE_ID")))) {%> selected="selected" <%}%>>??????</option>
						<option value="jeinet" <%if("JEINET".equals(util.getStr(dataMap.get("SITE_ID")))) {%> selected="selected" <%}%>>?????????????????????</option>
						<option value="jipbank" <%if("JIPBANK".equals(util.getStr(dataMap.get("SITE_ID")))) {%> selected="selected" <%}%>>????????????????????????</option>
						<option value="jntis" <%if("JNTIS".equals(util.getStr(dataMap.get("SITE_ID")))) {%> selected="selected" <%}%>>???????????????????????????</option>
					</select>
					</td>
				</tr> --%>
				<%if(!"jntis".equals(siteId)) { %>

				<tr>
					<th scope="col"><font color="red">*</font>?????????</th>
					<td colspan="3" class="r_line_none">
					<select name="sclas" class="select00301" >
						<option value="" <%if("".equals(util.getStr(paramMap.get("sclas")))) {%> selected="selected" <%}%>>??????</option>
						<option value="POLICY" <%if("POLICY".equals(util.getStr(paramMap.get("sclas")))) {%> selected="selected" <%}%>>????????????</option>
						<option value="LAWORD" <%if("LAWORD".equals(util.getStr(paramMap.get("sclas")))) {%> selected="selected" <%}%>>????????????</option>
						<option value="STATS" <%if("STATS".equals(util.getStr(paramMap.get("sclas")))) {%> selected="selected" <%}%>>????????????</option>
						<option value="ETC" <%if("ETC".equals(util.getStr(paramMap.get("sclas")))) {%> selected="selected" <%}%>>???????????????</option>
					</select>
					</td>
				</tr>

				<% } %>

				<tr>
					<th scope="col">
						<font color="red">*</font>??????
					</th>
					<td colspan="3" class="r_line_none">
						<input type="text" name="subject" id="subject" value="" class="input_txt00301" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="col">
						<font color="red">*</font>????????????(??????)
					</th>
					<td class="line_color_1">
						<input type="text" name="publiccationOrg" id="publiccationOrg" value="" class="input_txt00301" maxlength="100" style="width: 85%;"/>
					</td>
					<th class="line_edt_reg" scope="col">
						<font color="red">*</font>?????????
					</th>
					<td class="r_line_none">
						<input type="text" name="publiccationDt" id="publiccationDt" value="" class="input_txt00301" maxlength="100"  style="width: 85%;"/>
					</td>
				</tr>
				<!-- <tr>
					<th scope="col">
						??????<br /><font color="red" size="1">(200?????????)</font>
					</th>
					<td colspan="3" class="r_line_none">
					<textarea name="summary" id="summary" class="input_txtBox00301" rows="5" cols="20" onkeyup="checkLength(this);"></textarea>
					</td>
				</tr> -->
				<tr>
					<th scope="col">
						????????????
					</th>
					<td colspan="3" class="r_line_none">
						<textarea name="content" id="contents" rows="5" cols="20"></textarea>
					</td>
				</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th scope="col">
						???????????????<br /><font color="red" size="1">(???????????????)</font>
					</th>
					<td colspan="3" class="r_line_none">
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div >
	              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1" title="????????????" />
						</div>
	              	</div>

					</td>
				</tr>
				<tr>
					<th scope="col">
						????????????<br /><font color="red" size="1">(PDF)</font>
					</th>
					<td colspan="3" class="r_line_none">
					<div style="display:inline-block;">
	              		<div>
	              			<input type="file" name="<%=fileFullGrp%>File2"  id="<%=fileFullGrp%>File2" title="????????????" />
						</div>
	              	</div>

					</td>
				</tr>
			<%} %>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="b_btn_area">
			<button type="button" class="btn_lft2" onclick="goSubmit('list', '<%=listMode%>', '<%=sortMode%>')">??????</button>
			<button type="button" class="btn_rgt" onclick="goSubmit('writeProc')">??????</button>
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
        alert('200??? ????????? ??????');
        comment.focus();
        return false;
    }
}

function goSubmit(mode){
	if(mode=="writeProc" && permEditor=="Y"){
		<%if(!"jntis".equals(siteId)){ %>
		var sclas = $("select[name=sclas]").val().trim();
		if(sclas == "" || sclas == null){
			alert("???????????? ????????? ?????????.")
			return false;
		}else {
			$("#sclas").val(sclas);
		}
		<% } %>
		oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		var ext1 = $("#"+"<%=fileFullGrp%>"+"File1").val().split('.').pop().toLowerCase();
		var ext2 = $("#"+"<%=fileFullGrp%>"+"File2").val().split('.').pop().toLowerCase();
		//if(ext1 != "gif" || ext1 != "png" || ext1 != "jpg" || ext1 != "jpeg"){
		if(ext1 != 'jpeg' && ext1 != 'jpg' && ext1 != 'gif' && ext1 != 'png'){
			alert('?????????????????? gif,png,jpg,jpeg ????????? ????????? ?????? ????????????.');
			return false;
		}
		if(ext2 != 'pdf'){
			alert('??????????????? pdf ????????? ????????? ?????? ????????????.');
			return false;
		}

	}
	$('#mode').val(mode);
	$('#fwrite').attr("action","sub.do");
	$('#fwrite').submit();
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

 $("#publiccationDt").datepicker({
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
</script>
