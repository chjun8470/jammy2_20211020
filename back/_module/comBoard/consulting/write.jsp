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
	ArrayList<HashMap<String, String>> standardList = request.getAttribute("standardList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("standardList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = boardMap.get("SITE_ID");
	if("".equals(mode)) mode = "write";
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	
	String fileGrp = "consulting";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

%>
<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="permEditor" id="permEditor" value="<%=util.getStr(boardMap.get("PERM_EDITOR"))%>" />
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="siteId" id="siteId" value="<%=siteId %>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="articleParentsId" id="articleParentsId" value="0" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />


	<div class="skin_bbs_write" style="margin-top: 30px">
		<font color="red">* 필수 입력사항입니다.</font>
		<table class="skin_basic_write" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
			<caption>작성하기</caption>
			<colgroup>
				<col width="140px" />
				<col width="*" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="col" class="tit">
						<label for="subject">제목</label>
					</th>
					<td>
						<input type="text" name="subject" id="subject" value="" style="width: 100%;" maxlength="100" />
					</td>
				</tr>
			<%if(boardComIdx.equals("00011") || boardComIdx.equals("00026")) { %>
				<tr>
					<th>상담분야</th>
					<td>
						<label for="reDeth1" class="hide">대</label>
						<select name="reDeth1" id="reDeth1" onchange="standardDeth1('reDeth2')">
						<% for(HashMap rs:standardList) {%>
							<option value="<%=util.getStr(rs.get("CODE"))%>"><%=util.getStr(rs.get("NAME"))%></option>
						<%}%>
						</select>
						<label for="reDeth2" class="hide">중</label>
						<select name="reDeth2" id="reDeth2" onchange="standardDeth2('reDeth3')">

						</select>
						<label for="reDeth3" class="hide">소</label>
						<select name="reDeth3" id="reDeth3">

						</select>
					</td>
				</tr>
			<% } %>
				<tr>
					<th scope="col" class="tit">
						<label for="contents">내용</label>
					</th>
					<td class="con-txt">
						<textarea name="content" id="contents" style="width: 100%; height: 350px;"></textarea>
					</td>
				</tr>
			<%if(util.getStr(boardMap.get("PERM_FILE")).equals("Y")){ %>
				<tr>
					<th scope="col" class="tit">
						<label for="extfile">첨부파일</label>
					</th>
					<td>
					<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
	              		<div >
	              			<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
						</div>
	              	</div>

					</td>
				</tr>
			<%} %>
			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<input type="button" class="btn_inp_b_01" value="작성" onclick="goSubmit('writeProc')"/>
			<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
		</div>
		<!--// bo_btn -->
	</div>
</form>
<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">
	var permEditor = $('#permEditor').val();

	function goSubmit(mode){

		if(mode=="writeProc" && permEditor=="Y"){
			oEditors.getById["contents"].exec("UPDATE_CONTENTS_FIELD", []);
		}
		$('#mode').val(mode);
		$('#fwrite').submit();
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

</script>