<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
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

	String siteId = util.getStr(paramMap.get("siteId")); //사이트구분
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String beforeBoardComIdx = util.getStr(paramMap.get("beforeBoardComIdx"));
	String afterBoardComIdx = util.getStr(paramMap.get("afterBoardComIdx"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	if("".equals(mode)) mode = "edit";

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>
<form name="fedit" id="fedit" action="./changeboard.do" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="./changeboard.do?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="noticeCheck" id="noticeCheck" value="<%=util.getStr(dataMap.get("NOTICE_AT"))%>" />
	<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="<%=beforeBoardComIdx%>" />
	<input type="hidden" name="afterBoardComIdx" id="afterBoardComIdx" value="<%=afterBoardComIdx%>" />
	<input type="hidden" name="m" value="<%=m%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<div class="basic_writeWrap">

		<span style="color:red; font-size:12px;"> * 필수 입력사항입니다.</span>
		
		<table class="skin_write01 MAT10">
			<caption>작성하기</caption>
			<colgroup>
		      <col style="width:30%;" />
				<col style="width:70%;" />
		    </colgroup>

		   <thead>
              	<tr>
			    	<th scope="col" class="alnC">제목 <span style="color:red; font-size:12px;">*</span></th>
			    	<td class="r_line_none p_top_btm_6">
			    		<input type="text" name="subject" id="subject" value="<%=util.getStr(dataMap.get("SUBJECT"))%>" style="width:100%; height:20px; font-size:9pt;" maxlength="100" />
                    </td>
				</tr>
			</thead>
			<tbody>
			  	<tr>
			    	<th scope="col" class="alnC">내용</th>
			    	<td class="r_line_none p_top_btm_6 con-txt">
			    		<textarea name="content" id="contents" style="width:100%; height:350px; font-size:10pt;"><%=dataMap.get("CONTENT")%></textarea>
			    	</td>
				</tr>

				<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ //파일첨부여부가 Y이면%>
				<tr>
			  		<th scope="row" class="tit">
					<label for="extfile">첨부파일</label>
					</th>


				  	<% if(fileList.size() > 0){%>
				  	<td>
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
								<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:100px;padding:10px;vertical-align:middle;"/>
								<%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
								<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
							</li>

					<% fileCnt++; }%>
					</ul>

						<div style="display: inline-block;"	id="<%=fileFullGrp%>fileGrpBox">
							<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" style="height:37px;"/>
							<button class="b_btn_03" type="button" onclick="addRowFile('<%=fileFullGrp%>');" title="첨부파일 추가"><img src="/img/board/btn_plus.gif"/></button>
							<button class="b_btn_03" type="button" onclick="delRowFile('<%=fileFullGrp%>');" title="첨부파일 삭제"><img src="/img/board/btn_del.gif"/></button>
							<br/> * 300kb이상의 실사이미지만 등록이 가능합니다.
							<br/> * 가로형 이미지만 등록해주세요.
						</div>

						<script type="text/javascript">
						//<![CDATA[
							var arrfileCnt = new Array();
							arrfileCnt['<%=fileFullGrp%>'] = '<%=(fileCnt + 1)%>';
					           function addRowFile(fileGrpnm){
				           		var fileHtml = "<div>";
				           		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"' title='파일첨부' style='height:37px;' />";
				           		fileHtml += "</div>";
			            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
		            			arrfileCnt[fileGrpnm]++;
			            	}
					            function delRowFile(fileGrpnm){
				            	if($('#'+fileGrpnm+'fileGrpBox > div').size() < 1){
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
			        </td>

					<% }else{ %>

					<td id="<%=fileFullGrp%>fileGrpBox" class="r_line_none p_top_btm_6">
				    	<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" style="height:37px;"/>
						<button class="b_btn_03" type="button" onclick="addRowFile('<%=fileFullGrp%>');" title="첨부파일 추가"><img src="/img/board/btn_plus.gif"/></button>
						<button class="b_btn_03" type="button" onclick="delRowFile('<%=fileFullGrp%>');" title="첨부파일 삭제"><img src="/img/board/btn_del.gif"/></button>

						<br/> * 300kb이상의 실사이미지만 등록이 가능합니다.
						<br/> * 가로형 이미지만 등록해주세요.

					    <script type="text/javascript">
						//<![CDATA[
							var arrfileCnt = new Array();
							arrfileCnt['<%=fileFullGrp%>'] = 2;
						      function addRowFile(fileGrpnm){
					       		var fileHtml = "<div>";
					      		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' style='height:37px;' />";
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
					 <% } %>


				</tr>
				<% } %>

			</tbody>
		</table>

	</div>
	<!--basic_listWrap E-->

	<!--b_btn_area S-->
	<div class="MPBtnWrap MAT10">
		<button class="btn_inp_w_01 FloatL" onclick="goSubmit('view')">취소</button>
		<button class="btn_inp_b_01 FloatR" onclick="goSubmit('editProc')">수정</button>
	</div>
	<!--b_btn_area E-->


</form>

<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode){

		if(mode=="editProc"){

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
        	$('#fedit').attr("action", "sub.do");
        }

		$('#mode').val(mode);
		$('#fedit').submit();
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


	var fileCount = $("input[type=file]").length;
		for(i = 1; i <= fileCount; i++) {
			$('#jnsptotalFile'+fileCount).bind('change', function(){
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
			$('#jnsptotalFile'+fileCount).bind('change', function(){
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


	 	function check_only(chk){
           var obj = document.getElementsByName("noticeAt");
           for(var i=0; i<obj.length; i++){
               if(obj[i] != chk){
                   obj[i].checked = false;
               }
           }
     	}


	 	$( document ).ready(function() {
			var cb;
			cb = $('#noticeCheck').val();
			$('input:checkbox[name="noticeAt"]').each(function() {

		    	if(this.value == cb){ //값 비교
		        	this.checked = true; //checked 처리
		      	}
			 });
	 	});
//]]>
</script>