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

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
	ArrayList<HashMap<String, String>> standardList2 = request.getAttribute("standardList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList2");
	ArrayList<HashMap<String, String>> standardList3 = request.getAttribute("standardList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList3");

	String siteId = util.getStr(paramMap.get("siteId")); //사이트구분
	String siteComIdx = util.getStr(paramMap.get("siteComIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String m = util.getStr(paramMap.get("m"));
	String state = util.getStr(dataMap.get("DATA04"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	
	if("".equals(mode)) mode = "edit";

	String fileGrp = "consulting";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String pageMode = util.getStr(paramMap.get("pageMode"));
	String actionString = "sub.do";
	if( pageMode.matches(".*advice_.*") ){
		siteId = "sso";
		actionString = pageMode+".do";
	}
%>
<form name="fedit" id="fedit" action="<%=actionString%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="siteComIdx" id="siteComIdx" value="<%=siteComIdx%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="/<%=siteId%>/<%=actionString%>?m=<%=m%>&boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="regId" id="regId" value="<%=util.getStr(loginVO.getUserId())%>" />
	<input type="hidden" name="regNm" id="regNm" value="<%=util.getStr(loginVO.getPsnNm())%>" />
	<input type="hidden" name="regIp" id="regIp" value="<%=util.getStr(request.getRemoteAddr())%>" />
	<input type="hidden" name="m" value="<%=m%>" />
	<input type="hidden" name="state" id="state" value="<%=state%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	
	<div class="basic_writeWrap">
	
		<table class="skin_write01" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
		
			<caption>작성하기</caption>
			<colgroup>
				<col width="30%" />
				<col width="70%" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" class="tit alnC">
						<label for="subject">제목</label>
					</th>
					<td class="r_line_none">
						<input type="text" name="subject" id="subject" value="<%=util.getStr(dataMap.get("SUBJECT"))%>" class="input_txt00401" maxlength="100" />
						<div class="checkBox00401">
                        <input type="checkbox" name="secretAt" id="secretAt" value="Y" <%if( util.getStr(dataMap.get("SECRET_AT")).equals("Y") ){out.println(" checked='checked' ");}%> />&nbsp;비밀글
                        </div>
					</td>
				</tr>
				<%if(boardComIdx.equals("00011") || boardComIdx.equals("00026")) { %>
				<tr>
					<th class="alnC">상담분야</th>
					<td class="r_line_none">
						<label for="reDeth1" style="display:none;">대</label>
						<select name="reDeth1" id="reDeth1" onchange="standardDeth1('reDeth2')">
						<%for(HashMap rs:standardList) {%>
							<option value="<%=util.getStr(rs.get("CODE"))%>" <%if(util.getStr(dataMap.get("DATA01")).equals(util.getStr(rs.get("CODE")))) { %> selected="selected" <% } %>><%=util.getStr(rs.get("NAME"))%></option>
						<%}%>
						</select>
						<label for="reDeth2" style="display:none;">중</label>
						<select name="reDeth2" id="reDeth2" onchange="standardDeth2('reDeth3')">
						<%if(util.getStr(dataMap.get("DATA02")) != null || util.getStr(dataMap.get("DATA02")) != "") {
							for(HashMap rs:standardList2) {%>
							<option value="<%=util.getStr(rs.get("CODE"))%>" <%if(util.getStr(dataMap.get("DATA02")).equals(util.getStr(rs.get("CODE")))) { %> selected="selected" <% } %>><%=util.getStr(rs.get("NAME"))%></option>
						<%		}
							}%>
						</select>
						<label for="reDeth3" style="display:none;">소</label>
						<select name="reDeth3" id="reDeth3">
						<%if(util.getStr(dataMap.get("DATA03")) != null || util.getStr(dataMap.get("DATA03")) != "") {
							for(HashMap rs:standardList3) {%>
							<option value="<%=util.getStr(rs.get("CODE"))%>" <%if(util.getStr(dataMap.get("DATA03")).equals(util.getStr(rs.get("CODE")))) { %> selected="selected" <% } %>><%=util.getStr(rs.get("NAME"))%></option>
						<%		}
							}%>
						</select>
					</td>
				</tr>
				<% } %>
				<tr>
					<th scope="row" class="tit alnC">
						<label for="content">내용</label>
					</th>
					<td class="con-txt r_line_none">
						<textarea name="content" id="contents" style="width: 100%; height: 350px;"><%=dataMap.get("CONTENT")%></textarea>
					</td>
				</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th scope="row" class="tit alnC">
						<label for="extfile">첨부파일</label>
					</th>
				<td class="r_line_none">
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
								<label for="fileFlog_<%=fileCnt%>">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<%=util.deStr(rs.get("TITLE_ORG"))%>
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:200px;padding:10px"/>
<%-- 									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>

							</li>
						<% fileCnt++; }%>
						</ul>
						<div style="display: inline-block;"
							id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" style="height:37px;" title="파일첨부" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<button class="addImageBtn b_btn_03" type="button" onclick="addRowFile('<%=fileFullGrp%>');" title="첨부파일 추가"><img src="/img/board/btn_plus.gif"/></button>
							<button class="delImageBtn b_btn_03" type="button" onclick="delRowFile('<%=fileFullGrp%>');" title="첨부파일 삭제"><img src="/img/board/btn_del.gif"/></button>
							<%-- <input class="addImageBtn" type="button" onclick="addRowFile('<%=fileFullGrp%>');" />
							<input class="delImageBtn" type="button" onclick="delRowFile('<%=fileFullGrp%>');" /> --%>
						</div>
							<script type="text/javascript">
							//<![CDATA[
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					            function addRowFile(fileGrpnm){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
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
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" style="height:37px;" title="파일첨부" />
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
			            		var fileHtml = "<div>";
			            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'class='b_txtbox5 b_w100' title='파일첨부' />";
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
					      </td>
				</tr>
				<%} %>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="MPBtnWrap MAT10">
			<input type="button" class="btn_inp_w_01 FloatL" value="취소" onclick="goSubmit('view')"/>
			<input type="button" class="btn_inp_b_01 FloatR" value="수정" onclick="goSubmit('editProc')"/>
		</div>
		<!--// bo_btn -->
	</div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//<![CDATA[
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
				$('.con-txt iframe').remove();
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

		function standardDeth1(mode){
			var result = "";
			var mode = mode;
			var name = mode.substr(0,2);
			var name2 = mode.substring(7,8)
			if(name == "re"){
				var deth3 = $('#reDeth1'+name2).val();
			}else if(name == "ev"){
				var deth3 = $('#evDeth1'+name2).val();
			}else if(name == "co"){
				var deth3 = $('#coDeth1'+name2).val();
			}
			$("#" + mode).find("option").remove();
			$("#reDeth3").find("option").remove();
		 	$.ajax({
	             type: "POST",
	             data : {
	            	 deth3 : deth3
	             },
	             url : '/sys/dethCheck.do',
	             dataType : 'json',
	             success : function(data){
	            	 $('#'+mode).val("");
	            	result += "<option value=''>선택하세요.</option>";
	            	for(i=0; i<data.cnt; i++){
						result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
					}
	            	$('#'+mode).append(result);
	             }
	    	});
		}

		function standardDeth2(mode){
			var result = "";
			var mode = mode;
			var name = mode.substr(0,2);
			var name2 = mode.substring(7,8);
			if(name == "re"){
				var deth4 = $('#reDeth2'+name2).val();
			}else if(name == "ev"){
				var deth4 = $('#evDeth2'+name2).val();
			}else if(name == "co"){
				var deth4 = $('#coDeth2'+name2).val();
			}
		 	$.ajax({
	             type: "POST",
	             data : {
	            	 deth4 : deth4
	             },
	             url : '/sys/dethCheck.do',
	             dataType : 'json',
	             success : function(data){
	            	 $('#'+mode).html("");
	            	result += "<option value=''>선택하세요.</option>";

	            	for(i=0; i<data.cnt; i++){
	            		result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
					}
	            	$('#'+mode).append(result);
	             }
	    	});
		}
		
		function goSubmit(mode){
			if(mode=="editProc"){
				//var oEditors = [];
				//var permEditor = $('#permEditor').val();
				//비밀글 여부
			    if($("#secretAt").is(":checked") == false){
			    	$("#secretAt").val('N');
			    }
				if($('#subject').val() == ""){
						alert("제목을 입력해주세요");
						return false;
				}
				if (confirm("수정하시겠습니까??") == true){ //확인
					if(permEditor=="Y"){
						oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
					}
				}else{ //취소
				    return;
				}
			}
			if(mode == "view"){
		    	$('#fedit').attr("action", "<%=actionString%>");
		    }
			$('#mode').val(mode);
			$('#fedit').submit();
		}
//]]>		
</script>