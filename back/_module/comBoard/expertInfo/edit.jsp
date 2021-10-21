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

	String siteComIdx = util.getStr(paramMap.get("siteComIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	if("".equals(mode)) mode = "edit";
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>
<form name="fedit" id="fedit" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="siteComIdx" id="siteComIdx" value="<%=siteComIdx%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	 </div> <div class="skin_bbs_write" style="margin-top: 30px">
	 		<font color="red">* 필수 입력사항입니다.</font>
	 		<table class="skin_basic_write" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
	 			<caption>전문가등록</caption>
	                  <colgroup>
	                        <col width="140px" />
	                        <col width="*" />
	                  </colgroup>
	                  <tbody>
	                  	   <tr>
	                        		<th scope="row" class="tit" colspan="2">
	                        			<label for="userInfo">기본정보</label>
	                        		</th>
	                        	</tr>
	                        	<tr>
	                        		<th scope="row" class="tit">
	                        			<label for="name">이름</label>
	                        		</th>
	                        		<td>
	                        			<input type="text" name="data01" id="name"  value="<%=util.getStr(dataMap.get("DATA01")) %>"  style="width:100%; border:0;" maxlength="100" readOnly >
	                        		</td>
	                        	</tr>
	                        	<tr>
	                        		<th scope="row" class="tit">
	                        			<label for="birthday">출생연도</label>
	                        		</th>
	                        		<td>
	                        			<input type="text" name="data02" id="birthday"  value="<%=util.getStr(dataMap.get("DATA02")) %>" style="width:100%;" maxlength="100">
	                        		</td>
	                        	</tr>
	                        	<tr>
	                        		<th scope="row" class="tit">
	                        			<label for="nationality">국적</label>
	                        		</th>
	                        		<td>
	                        			<input type="text" name="data03" id="nationality"  value="<%=util.getStr(dataMap.get("DATA03")) %>" style="width:100%;" maxlength="100">
	                        		</td>
	                        	</tr>
	                        	<tr>
	                        		<th scope="row" class="tit">
	                        			<label for="homePage">홈페이지</label>
	                        		</th>
	                        		<td>
	                        			<input type="text" name="data04" id="homePage"  value="<%=util.getStr(dataMap.get("DATA04")) %>"  style="width:100%;" maxlength="100">
	                        		</td>
	                        	</tr>
	                        	<tr>
	                        		<th scope="row" class="tit">
	                        			<label for="affiliation">소속</label>
	                        		</th>
	                        		<td>
	                        				<input type="text" name="data05" id="affiliation"  value="<%=util.getStr(dataMap.get("DATA05")) %>"  style="width:100%;" maxlength="100">
	                        		</td>
	                        	</tr>
	                        	<tr>
	                        		<th scope="row" class="tit">
	                        			<label for="major">전공</label>
	                        		</th>
	                        		<td>
	                        				<input type="text" name="data06" id="major"  value="<%=util.getStr(dataMap.get("DATA06")) %>"  style="width:100%;" maxlength="100">
	                        		</td>
	                        	</tr>
	                        	<tr>
	                        		<th scope="row" class="tit">
	                        			<label for="position">직급</label>
	                        		</th>
	                        		<td>
	                        				<input type="text" name="data07" id="position" value="<%=util.getStr(dataMap.get("DATA07")) %>"  style="width:100%;" maxlength="100">
	                        		</td>
	                        	</tr>
	                        	<tr>
	                        		<th scope="row" class="tit">
	                        			<label for="position_field">전문분야</label>
	                        		</th>
	                        		<td>
	                        			<input type="text" name="data08" id="position_field" value="<%=util.getStr(dataMap.get("DATA08")) %>" style="width:100%;" maxlength="100">
	                        		</td>
	                        	</tr>

	                        	<tr>
	                        		<th scope="row" class="tit" colspan="2">
	                        			<label for="academic_career">학력</label>
	                        		</th>
	                        	</tr>
	                        	<tr>
	                        		<td class="con-txt" colspan="2">
	                             	<textarea name="text1" id="academic_career" style="width: 100%; height: 200px;"><%=util.getStr(dataMap.get("TEXT1")) %></textarea>
	                             </td>
	                        	</tr>
	                        	<tr>
	                        		<th scope="row" class="tit" colspan="2">
	                        			<label for="career">경력</label>
	                        		</th>
	                        	</tr>
	                        	<tr>
	                        		<td class="con-txt" colspan="2">
	                             	<textarea name="text2" id="career" style="width: 100%; height: 200px;"><%=util.getStr(dataMap.get("TEXT2")) %></textarea>
	                             </td>
	                        	</tr>
	                  </tbody>
	 		</table>
	 </div>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<input type="button" class="btn_inp_b_01" value="수정" onclick="goSubmit('editProc')"/>
			<input type="button" class="btn_inp_w_01" value="취소" onclick="goSubmit('view')"/>
		</div>
		<!--// bo_btn -->
	</div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fedit').submit();
	}
$( document ).ready(function() {
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

});

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

</script>