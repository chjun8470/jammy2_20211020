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
	ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
	ArrayList<HashMap<String, String>> standardList2 = request.getAttribute("standardList2") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList2");
	ArrayList<HashMap<String, String>> standardList3 = request.getAttribute("standardList3") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList3");

	String siteComIdx = util.getStr(paramMap.get("siteComIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String state = util.getStr(dataMap.get("DATA04"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
		
	if("".equals(mode)) mode = "edit";

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
	<input type="hidden" name="state" id="state" value="<%=state%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<div class="skin_bbs_write" style="margin-top: 30px">
		<font color="red">* ?????? ?????????????????????.</font>
		<table class="skin_basic_write" summary="???????????????  ??????, ??????, ????????????, ???????????????(??????)??? ???????????????.">
			<caption>????????????</caption>
			<colgroup>
				<col width="140px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" class="tit">
						<label for="subject">??????</label>
					</th>
					<td>
						<input type="text" name="subject" id="subject" value="<%=util.getStr(dataMap.get("SUBJECT"))%>" style="width: 100%;" maxlength="100" />
					</td>
				</tr>
				<%if(boardComIdx.equals("00011") || boardComIdx.equals("00026")) { %>
				<tr>
					<th>????????????</th>
					<td>
						<label for="reDeth1" class="hide">???</label>
						<select name="reDeth1" id="reDeth1" onchange="standardDeth1('reDeth2')">
						<%for(HashMap rs:standardList) {%>
							<option value="<%=util.getStr(rs.get("CODE"))%>" <%if(util.getStr(dataMap.get("DATA01")).equals(util.getStr(rs.get("CODE")))) { %> selected="selected" <% } %>><%=util.getStr(rs.get("NAME"))%></option>
						<%}%>
						</select>
						<label for="reDeth2" class="hide">???</label>
						<select name="reDeth2" id="reDeth2" onchange="standardDeth2('reDeth3')">
						<%if(util.getStr(dataMap.get("DATA02")) != null || util.getStr(dataMap.get("DATA02")) != "") {
							for(HashMap rs:standardList2) {%>
							<option value="<%=util.getStr(rs.get("CODE"))%>" <%if(util.getStr(dataMap.get("DATA02")).equals(util.getStr(rs.get("CODE")))) { %> selected="selected" <% } %>><%=util.getStr(rs.get("NAME"))%></option>
						<%		}
							}%>
						</select>
						<label for="reDeth3" class="hide">???</label>
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
					<th scope="row" class="tit">
						<label for="content">??????</label>
					</th>
					<td class="con-txt">
						<textarea name="content" id="contents" style="width: 100%; height: 350px;"><%=dataMap.get("CONTENT")%></textarea>
					</td>
				</tr>
				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th scope="row" class="tit">
						<label for="extfile">????????????</label>
					</th>
				<td>
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
								<label for="fileFlog_<%=fileCnt%>">????????????</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<%=util.deStr(rs.get("TITLE_ORG"))%>
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:200px;padding:10px"/>
<%-- 									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>

							</li>
						<% fileCnt++; }%>
						</ul>
						<div style="display: inline-block;"
							id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
							<input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
						</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
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
								<input type="file" name="<%=fileFullGrp%>File1" id="<%=fileFullGrp%>File1" title="????????????" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
							<input type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
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
			      <% } %>
						      <br/> * 300kb????????? ?????????????????? ????????? ???????????????.
							  <br/> * ????????? ???????????? ??????????????????.
					      </td>
				</tr>
				<%} %>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('editProc')"/>
			<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('view')"/>
		</div>
		<!--// bo_btn -->
	</div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	function goSubmit(mode){
		alert("??????"+mode);
		if(mode=="editProc"){
			//var oEditors = [];
			//var permEditor = $('#permEditor').val();
			//????????? ??????
		    if($("#secretAt").is(":checked") == false){
		    	$("#secretAt").val('N');
		    }
			if($('#subject').val() == ""){
					alert("????????? ??????????????????");
					return false;
			}
			if (confirm("??????????????????????????") == true){ //??????
				if(permEditor=="Y"){
					oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
				} 
			}else{ //??????
			    return;
			}
		} 
		$('#mode').val(mode);
		$('#fedit').submit();
	}

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
            	result += "<option value=''>???????????????.</option>";
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
            	result += "<option value=''>???????????????.</option>";

            	for(i=0; i<data.cnt; i++){
            		result += "<option value=\""+data.dataList[i].CODE+"\">"+data.dataList[i].NAME+"</option>";
				}
            	$('#'+mode).append(result);
             }
    	});
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
				}, //boolean
				fCreator : "createSEditor2"
			});
		});
	}



	   var fileCount = $("input[type=file]").length;
	     for(i = 1; i <= fileCount; i++) {
				$('#jnsptotalFile'+fileCount).bind('change', function() {
					var fileName = $('#jnsptotalFile'+fileCount).val();
					if(fileName != "" || fileName != null){
						fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
						if(imgPattern.indexOf(fileName)==-1){
							alert("??????????????? bmp, gif, jpg, jpeg, png ????????? ????????? ????????????????????????.");
							$('#jnsptotalFile'+fileCount).val("");
							return false;
						}else if(this.files[0].size<300000){
							alert("300kb ????????? ???????????? ??????????????????.");
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
							alert("??????????????? bmp, gif, jpg, jpeg, png ????????? ????????? ????????????????????????.");
							$('#jnsptotalFile'+fileCount).val("");
							return false;
						}else if(this.files[0].size<300000){
							alert("300kb ????????? ???????????? ??????????????????.");
							$('#jnsptotalFile'+fileCount).val("");
							return false;
						}
					}
				});
		});

</script>