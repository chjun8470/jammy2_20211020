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
<%@ page import="egovframework.jammy2.site.service.SiteInfoVO;"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
    String siteId = siteInfoVO.getSiteId();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	if("".equals(mode)) mode = "write";

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

%>

<style type="text/css">
	.imageMain {display: none;}
</style>

<!--Contents S-->
<div class="Contents">


<!--basic_listWrap S-->
<div class="basic_writeWrap002">
<form name="fwrite" id="fwrite" action="/web/comBoard.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="m" id="m" value="<%=m%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="/<%=siteId%>/sub.do?m=<%=m%>&amp;mode=list&amp;boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

<table class="skin_write002">
  <caption></caption>
    <colgroup>
      <col style="width:14%;" />
      <col style="width:80%;" />
    </colgroup>
<tbody>
  <tr>
    <th scope="col">제목</th>
    <td class="r_line_none"><input type="text" class="input_txt00201" name="subject" id="subject" value=""/></td>
  </tr>
  <tr>
    <th scope="col">내용</th>
    <td class="r_line_none"><textarea name="content" class="b_txtbox4 box_size_cs" id="contents" style="width: 98%;"></textarea></td>
  </tr>
  <%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>


	              	<tr>
					<th scope="row" class="tit">
						첨부파일
					</th>
					<td class="r_line_none p_top_btm_6">
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">

	              		<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1" class="select_file00201" title="파일첨부"/>
	              		<input type="checkbox" name="<%=fileFullGrp %>MainYN1" id="<%=fileFullGrp %>MainYN1" class="imageMain" value="Y" checked="checked"/>
	                    <label for="<%=fileFullGrp %>MainYN1">대표이미지</label>

						<button class="addImageBtn b_btn_00201" type="button" onclick="addRowFile('<%=fileFullGrp%>');" title="첨부파일 추가"><img src="/img/board/btn_plus.gif"/></button>
						<button class="delImageBtn b_btn_00201" type="button" onclick="delRowFile('<%=fileFullGrp%>');" title="첨부파일 삭제"><img src="/img/board/btn_del.gif"/></button>

	              	</div>

	        <script type="text/javascript">
	        	//<![CDATA[
					var arrfileCnt = new Array();
					arrfileCnt['<%=fileFullGrp%>'] = 2;
		            function addRowFile(fileGrpnm){
	            		var fileHtml = "<div style='padding-bottom:10px;'>";
	            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
	            		fileHtml += "<input type='checkbox' name='"+fileGrpnm+"MainYN"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"MainYN"+arrfileCnt[fileGrpnm]+"' class='imageMain' value='N' checked='checked' />";
	            		fileHtml += "<label for='"+fileGrpnm+"MainYN"+arrfileCnt[fileGrpnm]+"'></label>";
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
		    	//]]>
	        </script>
					</td>
				</tr>
			<%} %>

</tbody>
</table>
</form>
</div>
<!--basic_listWrap E-->

<!--b_btn_area S-->
<div class="b_btn_area">
<button class="btn_rgt" onclick="goSubmit('writeProc')">작성</button>
<button class="btn_lft2" onclick="goSubmit('list')">목록</button>
</div>
<!--b_btn_area E-->


</div>
<!--Contents E-->

<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode){
		if(mode=="writeProc" && permEditor=="Y"){
			oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);

			if($('#subject').val() == ""){
	     				alert("제목을 입력해주세요");
	     				return false;
	   			}

	   			var imgFormat = "\.(bmp|gif|jpg|JPG|jpeg|png|pdf)$";
            	var fileCount = $("input[type=file]").length;

            	for(i=1;i<=fileCount;i++){
            		if((new RegExp(imgFormat)).test($('#<%=fileFullGrp%>File'+i).val()) && $('#<%=fileFullGrp%>File'+i).val() != ""){

            		}else if($('#<%=fileFullGrp%>File'+i).val() == ""){
            			alert("파일을 첨부하세요.");
            			return false;
            		}else{
            			alert("이미지 파일과 PDF만 첨부하실 수 있습니다.");
            			return false;
            		}
            	}

	   			if (confirm("저장하시겠습니까??") == true){ //확인

	   				if(permEditor=="Y"){
	   					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
	   				}

	   			}else{ //취소
	   			    return;
	   			}
		}
		if(mode == "list"){
			$('#fwrite').attr('action','sub.do');
		}
		$('#mode').val(mode);
		$('#fwrite').submit();
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

		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%

				if(permEditor=="Y"){
					if($('#contents').css("display")!='none'){
						htmlEditor();
						$('#contents').hide();
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
//]]>	
</script>