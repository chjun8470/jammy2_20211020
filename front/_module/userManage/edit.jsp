<%@page import="org.apache.ibatis.binding.MapperMethod.ParamMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="org.springframework.web.util.CookieGenerator"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
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
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));
	if("".equals(mode)) mode = "write";
	String manageIdx = util.getStr(paramMap.get("manageIdx"));
%>
<script type="text/javascript">
//<![CDATA[
	function submitGo(){
		if($('#subject').val() == ''){
			alert("제목을 입력 해주세요");
			return false;
		}

		if($('#contents').val() == ""){
			alert("내용을 입력 해주세요");
			return false;
		}

		return true;
	}
	//]]>
</script>
	  <form name="fwrite" id="fwrite" action="/m/manageProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="manageIdx" id="manageIdx"  value="<%=manageIdx%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

		<div class="skin_bbs_write" style="margin-top:30px">
			<font color="red">* 필수 입력사항입니다.</font>
	        <table class="skin_basic_write" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
	          <caption>
	          작성하기
	          </caption>
	          <colgroup>
	          <col width="140px" />
	          <col width="*" />
	          </colgroup>
	          <tbody>
	            <tr>
	              <th scope="row" class="tit"><label for="subject">제목</label></th>
	              <td>
	              <input type="text" name="subject" id="subject" value="<%=util.getStr(dataMap.get("SUBJECT")) %>"style="width:100%;maxlength:100;" /></td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="contents">내용</label></th>
	              <td>
	              	<textarea name="contents" id="contents" style="width:100%;height:350px;"><%=util.getStr(dataMap.get("CONTENTS")) %></textarea>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="extfile">첨부파일</label></th>
	              <td>
	              <%
					String fileGrp = "manage";
					String fileSubGrp = "";
					String fileFullGrp =fileGrp+fileSubGrp;
	              	if(fileList.size() > 0){
	              	%>
	               <ul class="file" style="line-height:22px;">
					<%
					int fileCnt = 1;
					for(HashMap rs:fileList){ %>
						<%String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
												+"&amp;dataSubGrp="+util.getStr(rs.get("DATA_SUB_GRP"))
												+"&amp;fileIdx="+util.getStr(rs.get("FILE_IDX"))
												+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));%>
                  		<li class="text">
                  			<input type="checkbox" name="fileFlog" id="fileFlog_<%=fileCnt%>" value="<%=util.getStr(rs.get("FILE_IDX"))%>" onclick="fileSet('<%=fileCnt%>')" />
                  			&nbsp;<label for="fileFlog_<%=fileCnt%>">파일삭제</label>&nbsp;&nbsp;&nbsp;&nbsp;
                  			<a href="/biz/cmm/fms/ComFileDown.do<%=fileParam%>" title="첨부파일 다운로드"><%=util.deStr(rs.get("FILE_ORGN_NM")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>


                  			 <div style="padding-top:10px;display:none;" id="fileBox_<%=fileCnt%>">
                  			 	<input type="file" name="<%=fileFullGrp%>File<%=fileCnt%>"  id="<%=fileFullGrp%>File<%=fileCnt%>"  title="파일첨부" />
                  			 	<input type="hidden" name="fileSn"  value="<%=util.getStr(rs.get("FILE_SN"))%>" />
                  			 </div>
                  		</li>
					<%
						fileCnt++;
					}

					%>
  					</ul>


					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div >
	              			<input type="file" name="<%=fileFullGrp%>File<%=fileCnt %>"  id="<%=fileFullGrp%>File<%=fileCnt %>"  title="파일첨부" />
						</div>
	              	</div>


	              	<div style="display:inline-block;vertical-align:bottom;">
	              		<input type="button" value="+" style="width:30px;height:20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
	              		<input type="button" value="-" style="width:30px;height:20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
	              	<div>



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


	              	<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div >
	              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
						</div>
	              	</div>

	              	<div style="display:inline-block;vertical-align:bottom;">
	              		<input type="button" value="+" style="width:30px;height:20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
	              		<input type="button" value="-" style="width:30px;height:20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
	              	<div>

	            <script type="text/javascript">
	          //<![CDATA[
					var arrfileCnt = new Array();
					arrfileCnt['<%=fileFullGrp%>'] = 2;
		            function addRowFile(fileGrpnm){
	            		var fileHtml = "<div>";
	            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
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
              <%} %>

	              	</td>
	            </tr>
	          </tbody>
	        </table>

	        <!-- bo_btn  -->
	        <div class="bo_btn_box textC">

	        	<input type="submit"class="btn_b_01"   value="작성완료" id="btn_submit"  class="btn_submit" />

	        	<span class="btn_w_01" style = "min-width:40px;height: 18px; vertical-align: middle;"><a href="./<%=myPage%>">취소</a></span>

	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>


<script type="text/javascript">
//<![CDATA[

$(function(){
	var oEditors = [];
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
				fOnBeforeUnload : function(){
					//alert("완료!");
				}
			}, //boolean
			fOnAppLoad : function(){
				oEditors.getById["contents"].exec("PASTE_HTML", ["<%=util.getStr(dataMap.get("CONTENTS")) %>"]);
			},
			fCreator: "createSEditor2"
		});
	});
	
//]]>	
</script>