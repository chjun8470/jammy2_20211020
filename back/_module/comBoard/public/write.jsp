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
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String m = util.getStr(request.getQueryString());
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String searchState = util.getStr(paramMap.get("searchState"));
	String ArrayCheck = util.getStr(paramMap.get("ArrayCheck"));


	if("".equals(mode)) mode = "write";

	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

%>
<form name="fwrite" id="fwrite" action="?<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="?<%=myPage%>&amp;boardComIdx=<%=boardComIdx%>&amp;sclas=<%=util.getStr(paramMap.get("sclas"))%>" />
	<input type="hidden" name="regId" id="regId" value="<%=util.getStr(loginVO.getUserId())%>" />
	<input type="hidden" name="regNm" id="regNm" value="<%=util.getStr(loginVO.getPsnNm())%>" />
	<input type="hidden" name="regIp" id="regIp" value="<%=util.getStr(request.getRemoteAddr())%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId %>" />
	<!--검색조건-->
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<input type="hidden" name="searchState" id="searchState" value="<%=searchState%>" />
	<input type="hidden" name="ArrayCheck" id="ArrayCheck" value="<%=ArrayCheck%>" />


	<div class="skin_bbs_write">
		<font color="red">* 필수 입력사항입니다.</font>
		<table class="skin_basic_write" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
			<caption>작성하기</caption>
			<colgroup>
		      <col style="width:15%;" />
		      <col style="width:35%;" />
		      <col style="width:15%;" />
		      <col style="width:35%;" />
		    </colgroup>
			<tbody>
			<tr>
				<th scope="col"><font color="red">*</font>게시판</th>
				<td colspan="3">
					<select name="sclas" id="sclas" class="select" style="height: 24px">
							<option value="" <%if("".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>선택</option>

						<%if(siteId.equals("jntis")){ //전남과학기술정보시스템%>
							<option value="SCIENCE" <%if("SCIENCE".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>과학기술정보</option>
							<option value="INDUSTRIAL" <%if("INDUSTRIAL".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>산업기술자료</option>
							<option value="STATS" <%if("STATS".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>통계자료</option>
						<%}else if(siteId.equals("jeinet")){ //전남연구장비정보망%>
							<option value="LAWORD" <%if("LAWORD".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>장비정보</option>
							<option value="BROCHURE" <%if("BROCHURE".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>연구장비브로슈어</option>
						<%}else{ //전남지식재산정보은행%>
							<option value="ETC" <%if("ETC".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>발간물</option>
							<option value="EXCELLENCE" <%if("EXCELLENCE".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>우수기술</option>
							<option value="KICT" <%if("KICT".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>KICT우수기술</option>
							<option value="STATS" <%if("STATS".equals(util.getStr(dataMap.get("DATA03")))) {%> selected="selected" <%}%>>통계자료</option>
						<%}%>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font>제목</th>
				<td colspan="3">
					<input type="text" class="inp_txt" name="subject" id="subject" value="" style="width: 100%;" maxlength="100" />
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font>발행기관(출처)</th>
				<td>
					<input type="text" class="inp_txt" name="publiccationOrg" id="publiccationOrg" value="" style="width: 100%;" maxlength="100" />
				</td>
				<th scope="col"><font color="red">*</font>발행일자</th>
				<td>
					<input type="text" class="inp_txt" name="publiccationDt" id="publiccationDt" value="" style="width: 100%;" maxlength="100" />
				</td>
			</tr>
			<!--
			<tr>
				<th scope="col">
					목차<br/><font color="red">(200자내외)</font>
				</th>
				<td colspan="3" class="r_line_none p_top_btm_6">
					<textarea name="summary" id="summary" onKeyUp="checkLength(this);" style="width:100%; height:50px;"></textarea>
				</td>
			</tr>
			-->
			<tr>
				<th scope="col">주요정보</th>
				<td colspan="3">
					<textarea name="content" id="contents" style="width: 100%; height: 350px;"></textarea>
				</td>
			</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
			<tr>
				<th scope="col"><font color="red">*</font>
					대표이미지<br/>
					<font color="red">(이미지파일)</font>
				</th>
				<td colspan="3">
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div >
	              			<input type="file" class="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
						</div>
	              	</div>
				</td>
			</tr>
			<tr>
				<th scope="col"><font color="red">*</font>
					첨부파일<br/>
					<font color="red">(PDF)</font>
				</th>
				<td colspan="3">
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div>
	              			<input type="file" class="file" name="<%=fileFullGrp%>File2"  id="<%=fileFullGrp%>File2"  title="파일첨부" />
						</div>
	              	</div>
				</td>
			</tr>
			<%}%>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="b_btn_area" style="float:right;">
			<button type="button" class="btn_inp_b_01" onclick="goSubmit('writeProc')">작성</button>
			<button type="button" class="btn_inp_w_01" onclick="goSubmit('list')">목록</button>
		</div>
		<!--// bo_btn -->
	</div>
</form>


<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	/*
	 * 목차funtion
	function checkLength(comment) {
	    if (comment.value.length > 200 ) {
		  	comment.blur();
	        comment.value = comment.value.substring(0, 200);
	        alert('200자 이내로 입력');
	        comment.focus();
	        return false;
	    }
	} */

	function goSubmit(mode){
		if(mode=="writeProc" && permEditor=="Y"){

			var sclas = $("select[name=sclas]").val().trim();
			if(sclas == "" || sclas == null){
				alert("게시판을 선택해 주세요.")
				return false;
			}

			if($('#subject').val() == ""){
 				alert("제목을 입력해주세요");
 				return false;
			}
			if($('#publiccationOrg').val() == ""){
 				alert("발행기관을 입력해주세요");
 				return false;
			}
			if($('#publiccationDt').val() == ""){
 				alert("발행일자를 입력해주세요");
 				return false;
			}
			if($('#'+'<%=fileFullGrp%>'+'File1').val() == ""){
 				alert("대표이미지를 첨부해주세요");
 				return false;
			}
			if($('#'+'<%=fileFullGrp%>'+'File2').val() == ""){
 				alert("첨부파일을 첨부해주세요");
 				return false;
			}


			oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);


			<%--
			var fileName = $("#"+"<%=fileFullGrp%>"+"File1").val();
			var lenthFile = fileName.length;
			alert(fileName.substring(lenthFile - 3).toLowerCase());
			--%>

			//대표이미지
			var ext1 = $("#"+"<%=fileFullGrp%>"+"File1").val().split('.').pop().toLowerCase();
			//첨부파일
			var ext2 = $("#"+"<%=fileFullGrp%>"+"File2").val().split('.').pop().toLowerCase();

			//if(ext1 != "gif" || ext1 != "png" || ext1 != "jpg" || ext1 != "jpeg"){
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
		$('#fwrite').submit();
	}



	var permEditor = $('#permEditor').val();
	if(permEditor=="Y"){
	    var oEditors = [];
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
