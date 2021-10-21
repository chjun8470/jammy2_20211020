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
<%@ page import="egovframework.jammy2.site.service.SiteInfoVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
    String siteId = siteInfoVO.getSiteId();

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
	String listMode = util.getStr(paramMap.get("listMode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));

	if("".equals(mode)) mode = "edit";

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>

<style type="text/css">
	.imageMain {display: none;}
</style>


<form name="fedit" id="fedit" action="/web/comBoard.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="m" id="m" value="<%=m%>" />
	<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="/<%=siteId%>/sub.do?m=<%=m%>&amp;mode=view&amp;boardIdx=<%=boardIdx%>&amp;boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<div class="basic_writeWrap">
		<font color="red">* 필수 입력사항입니다.</font>
		<table class="skin_write" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
			<caption>작성하기</caption>
			<colgroup>
				<col width="15%" />
				<col width="35%" />
				<col width="25%" />
				<col width="25%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="col">
						제목
					</th>
					<td class="r_line_none p_top_btm_6" colspan="3">
						<input type="text" name="subject" id="subject" class="b_txtbox2" value="<%=util.getStr(dataMap.get("SUBJECT"))%>" />
					</td>
				</tr>
				<tr>
					<th scope="col">
						내용
					</th>
					<td class="r_line_none p_top_btm_6" colspan="3">
						<textarea name="content" id="contents" class="b_txtbox4 table_box_vr"><%=dataMap.get("CONTENT")%></textarea>
					</td>
				</tr>
			<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th scope="col">
						첨부파일
					</th>
							<td class="r_line_none p_top_btm_6" colspan="3">
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
										value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" />&nbsp;
								<label for="fileFlog_<%=fileCnt%>">파일삭제</label>&nbsp;&nbsp;
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" class="img-view" style="width: auto; vertical-align: middle; max-width: 30px;"/>
								<%=util.deStr(rs.get("TITLE_ORG"))%>(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)<br/>
								<div id="mainLine<%=fileCnt %>" style="display: none;">
								<input type="file" name="<%=fileFullGrp%>File<%=fileCnt %>" id="<%=fileFullGrp%>File<%=fileCnt %>" />
								<%if(util.getStr(rs.get("MAIN_YN")).equals("Y")) { %>
									<input type="checkbox" name="<%=fileFullGrp%>MainYN<%=fileCnt %>" id="<%=fileFullGrp%>MainYN<%=fileCnt %>" value="Y" class="imageMain" checked="checked" />
									<label for="<%=fileFullGrp%>MainYN<%=fileCnt %>">대표이미지</label>
								<% } else { %>
									<input type="checkbox" name="<%=fileFullGrp%>MainYN<%=fileCnt %>" id="<%=fileFullGrp%>MainYN<%=fileCnt %>" value="N" class="imageMain" checked="checked" />
								<% } %>
								</div>
								<%--<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:200px;padding:10px"/>--%>
								<%--<%=util.deStr(rs.get("FILE_ORGN_NM")) (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
								<script type="text/javascript">
								//<![CDATA[
									$("#fileFlog_<%=fileCnt %>").click(function() {
										$("#mainLine<%=fileCnt %>").toggle();
									});
								//]]>	
								</script>
							</li>
						<% fileCnt++; }%>
						</ul>
						<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File<%=fileCnt %>" id="<%=fileFullGrp%>File<%=fileCnt %>" title="파일첨부"  accept="image/*"/>
								<input type="checkbox" name="<%=fileFullGrp%>MainYN<%=fileCnt %>" id="<%=fileFullGrp%>MainYN<%=fileCnt %>" value="N" class="imageMain" checked="checked" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<button class="addImageBtn b_btn_03" type="button" onclick="addRowFile('<%=fileFullGrp%>');" title="첨부파일 추가"><img src="/img/board/btn_plus.gif"/></button>
							<button class="delImageBtn b_btn_03" type="button" onclick="delRowFile('<%=fileFullGrp%>');" title="첨부파일 삭제"><img src="/img/board/btn_del.gif"/></button>
						</div>
							<script type="text/javascript">
							//<![CDATA[
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
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

								function fileSet(fileCnt){
									if($('#fileFlog_'+fileCnt).is(':checked')){
										$('#fileBox_'+fileCnt).show();
									}else{
										$('#fileBox_'+fileCnt).hide();
									}
								}
							//]]>	
				            </script>

	            <% }else{ %>
						<div style="display: inline-block;" id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" class="size_box_new" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" style="height:37px;" title="파일첨부" />
								<input type="checkbox" name="<%=fileFullGrp %>MainYN1" id="<%=fileFullGrp %>MainYN1" class="imageMain" value="Y" checked="checked"/>
	                            <label for="<%=fileFullGrp %>MainYN1">대표이미지</label>
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<button class="addImageBtn b_btn_03" type="button" onclick="addRowFile('<%=fileFullGrp%>');" title="첨부파일 추가"><img src="/img/board/btn_plus.gif"/></button>
							<button class="delImageBtn b_btn_03" type="button" onclick="delRowFile('<%=fileFullGrp%>');" title="첨부파일 삭제"><img src="/img/board/btn_del.gif"/></button>
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
				            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
				            		return;
				            	}
				            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
				            	arrfileCnt[fileGrpnm]--;
				            }
				        //]]>    
			            </script>
			      <% } %>
						      <br/> * 300kb이상의 실사이미지만 등록이 가능합니다.
							  <br/> * 가로형 이미지만 등록해주세요.
					      </td>
				</tr>
			<%} %>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="b_btn_area">
			<button type="button" class="btn_rgt" onclick="goSubmit('editProc')">수정</button>
			<button type="button" class="btn_lft2" onclick="goSubmit('view')">취소</button>
		</div>
		<!--// bo_btn -->
	</div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//<![CDATA[
		function goSubmit(mode){
			if(mode=="editProc"&&permEditor=="Y"){
				oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
			}
			if(mode == "view"){
			$('#fedit').attr('action','sub.do');
			}
			$('#mode').val(mode);
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
			if(win_w > 768){
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

			if(win_w < 1198 && win_w > 768){ //테블릿 1198 , 768 이하일때 100%

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
//]]>
</script>