<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@page import="org.apache.ibatis.binding.MapperMethod.ParamMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="org.springframework.web.util.CookieGenerator"%><%@ page
	import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>

<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="java.util.Calendar"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	String deth1 = "6";
	String deth2 = "3";
	ComUtil util = new ComUtil();
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("PmsLoginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("PmsLoginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));
	if("".equals(mode)) mode = "write";
	String manageIdx = util.getStr(paramMap.get("manageIdx"));
%>
<script type="text/javascript">
//<![CDATA[
	function submitGo(){
		if($('#subject').val() == ''){
			alert("????????? ?????? ????????????");
			return false;
		}

		if($('#contents').val() == ""){
			alert("????????? ?????? ????????????");
			return false;
		}

		return true;
	}
//]]>	
</script>
<form name="fwrite" id="fwrite" action="/m/manageProc.do" method="post"
	enctype="multipart/form-data" onsubmit="return submitGo();">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" /> <input
		type="hidden" name="manageIdx" id="manageIdx" value="<%=manageIdx%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" /> <input
		type="hidden" name="nowPage" id="nowPage"
		value="<%=staticVO.getNowPage()%>" /> <input type="hidden"
		name="regIp" id="regIp" value="<%=request.getRemoteAddr()%>" /> <input
		type="hidden" name="regId" id="regId" value="<%=loginVO.getId()%>" />
	<input type="hidden" name="state" id="regId" value="?????????" />

	<div class="skin_bbs_write" style="margin-top: 30px">
		<font color="red">* ?????? ?????????????????????.</font>
		<table class="skin_basic_write"
			summary="???????????????  ??????, ??????, ????????????, ???????????????(??????)??? ???????????????.">
			<caption>????????????</caption>
			<colgroup>
				<col width="140px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" class="tit"><label for="subject">??????</label></th>
					<td><input type="text" name="subject" id="subject"
						style="width: 100%;" maxlength="100" /></td>
				</tr>
				<tr>
					<th scope="row" class="tit"><label for="contents">??????</label></th>
					<td><textarea name="contents" id="contents"
							style="width: 100%; height: 350px;"></textarea></td>
				</tr>
				<tr>
					<th scope="row" class="tit"><label for="extfile">????????????</label></th>
					<td>
						<%
							String fileGrp = "manage";
																			String fileSubGrp = "";
																			String fileFullGrp =fileGrp+fileSubGrp;
																			if(fileList.size() > 0){
						%>
						<ul class="file" style="line-height: 22px;">
							<%
								int fileCnt = 1;
																						for(HashMap rs:fileList){
							%>
							<%
								String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
																													+"&amp;dataSubGrp="+util.getStr(rs.get("DATA_SUB_GRP"))
																													+"&amp;fileIdx="+util.getStr(rs.get("FILE_IDX"))
																													+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
							%>
							<li class="text"><input type="checkbox" name="fileFlog"
								id="fileFlog_<%=fileCnt%>"
								value="<%=util.getStr(rs.get("FILE_IDX"))%>"
								onclick="fileSet('<%=fileCnt%>')" /> &nbsp;<label
								for="fileFlog_<%=fileCnt%>">????????????</label>&nbsp;&nbsp;&nbsp;&nbsp;
								<a href="/biz/cmm/fms/ComFileDown.do<%=fileParam%>" title="???????????? ????????????"><%=util.deStr(rs.get("FILE_ORGN_NM"))%>
									(<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)</a>


								<div style="padding-top: 10px; display: none;"
									id="fileBox_<%=fileCnt%>">
									<input type="file" name="<%=fileFullGrp%>File<%=fileCnt%>"
										id="<%=fileFullGrp%>File<%=fileCnt%>" title="????????????" /> <input
										type="hidden" name="fileSn"
										value="<%=util.getStr(rs.get("FILE_SN"))%>" />
								</div></li>
							<%
								fileCnt++;
																				}
							%>
						</ul>


						<div style="display: inline-block;"
							id="<%=fileFullGrp%>fileGrpBox">
							<div>
								<input type="file" name="<%=fileFullGrp%>File<%=fileCnt%>"
									id="<%=fileFullGrp%>File<%=fileCnt%>" title="????????????" />
							</div>
						</div>


						<div style="display: inline-block; vertical-align: bottom;">
							<input type="button" value="+" style="width: 30px; height: 20px;"
								onclick="addRowFile('<%=fileFullGrp%>');" /> <input
								type="button" value="-" style="width: 30px; height: 20px;"
								onclick="delRowFile('<%=fileFullGrp%>');" />
							<div>



				<script type="text/javascript">
				//<![CDATA[
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
				//]]>	
	            </script>

								<%
									}else{
								%>


								<div style="display: inline-block;"
									id="<%=fileFullGrp%>fileGrpBox">
									<div>
										<input type="file" name="<%=fileFullGrp%>File1"
											id="<%=fileFullGrp%>File1" title="????????????" />
									</div>
								</div>

								<div style="display: inline-block; vertical-align: bottom;">
									<input type="button" value="+"
										style="width: 30px; height: 20px;"
										onclick="addRowFile('<%=fileFullGrp%>');" /> <input
										type="button" value="-" style="width: 30px; height: 20px;"
										onclick="delRowFile('<%=fileFullGrp%>');" />
									<div>

				<script type="text/javascript">
				//<![CDATA[
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
		           //]]> 
	            </script>
										<%
											}
										%>

					</td>
				</tr>
			</tbody>
		</table>

		<!-- bo_btn  -->
		<div class="bo_btn_box textC">
			<input type="submit" class="btn_b_01" value="????????????" id="btn_submit"
				class="btn_submit" /> <span class="btn_w_01"
				style="min-width: 40px; height: 18px; vertical-align: middle;"><a
				href="./<%=myPage%>">??????</a></span>

		</div>
		<!--// bo_btn -->

	</div>
</form>


<script type="text/javascript">
//<![CDATA[
$(function(){
	var oEditors = [];
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
				fOnBeforeUnload : function(){
					//alert("??????!");
				}
			}, //boolean
			fOnAppLoad : function(){
				oEditors.getById["contents"].exec("PASTE_HTML", ["<%=util.getStr(dataMap.get("CONTENTS"))%>
	" ]);
			},
			fCreator : "createSEditor2"
		});
	});
//]]>	
</script>