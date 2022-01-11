<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> codeList = request.getAttribute("codeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("codeList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	if("".equals(mode)) mode = "write";
%>
	  <form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

		<div class="skin_bbs_write" style="margin-top:30px">
		<span style="color:red; font-size:10pt;">* 필수 입력사항입니다.</span>
	        <table class="skin_basic_write">
	          <caption>작성하기</caption>
	          <colgroup>
	          <col style="width: 15%;" />
	          <col style="width: 35%;" />
	          <col style="width: 15%;" />
	          <col style="width: 35%;" />
	          </colgroup>
	          <tbody>
	            <tr>
	            	<th scope="row" class="tit">
	            		<span style="color:red; font-size:11pt;">*</span><label for="boardId"> 게시판ID</label></th>
	            	<td>
	              		<input type="hidden" name="boardIdCheck" id="boardIdCheck" value="N">
		            	<input type="text" name="boardId" id="boardId" value="" style="width:50%;" maxlength="100" class="inp_txt"/>
		            	<span id="boardIdCheckMsg" ></span>
	                </td>
	                <th scope="row" class="tit" style="height: 24px"><span style="color:red; font-size:11pt;">*</span> 사이트</th>
	            	<td>
	            		<select name="siteType" id="siteType" class="select_box" style="width: 310px; height: 40px">
							<option value="jeinet" selected="selected">연구장비정보망</option>
							<option value="jntis">전남과학기술정보시스템</option>
							<option value="jipbank">지식재산정보은행</option>
							<option value="sample">sample</option>
						</select>
	                </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">
	              	<span style="color:red; font-size:11pt;">*</span><label for="boardNm"> 게시판명</label>
	              </th>
	              <td colspan="3">
	              	<input type="text" name="boardNm" id="boardNm" value="" style="width:97%;" maxlength="100" class="inp_txt"/>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">
	              	<span style="color:red; font-size:11pt;">*</span> 게시판스킨</th>
	              <td colspan="3">
	              	<select name="skinNm" id="skinNm" class="select_box" style="width: 340px; height: 40px">
	              	  <%
			             for(HashMap rs:codeList) {
			             String CODE_NM = util.getStr(rs.get("CODE_NM"));
			             String CMT = util.getStr(rs.get("CMT"));
			             %>
	              	   <option value="<%=CODE_NM%>"><%=CODE_NM%>(<%=CMT%>)</option>
	              	   <%} %>
	              	</select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">
	              	<span style="color:red; font-size:11pt;">*</span><label for="boardSummary"> 게시판요약</label>
	              </th>
	              <td colspan="3">
	              	<input type="text" name="boardSummary" id="boardSummary" value="" style="width:97%;" maxlength="100" class="inp_txt"/>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="blockPage">페이지 수</label></th>
	              <td colspan="3">
	              	<input type="text" name="blockPage" id="blockPage" value="10" style="width:5%;" maxlength="100" class="inp_txt"/>개  &nbsp;&nbsp;(한 페이지에 나타낼 페이지 수)
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="listSize">게시물 건수</label></th>
	              <td colspan="3">
	              	<input type="text" name="listSize" id="listSize" value="10" style="width:5%;" maxlength="100" class="inp_txt"/>개  &nbsp;&nbsp;(한 페이지에 나타낼 게시물 건 수)
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="permNotice">공지사용 여부</label></th>
	              <td>
	              	가능 : <input type="radio" value="Y" id="permNotice" name="permNotice"/>
	              	불가능 : <input type="radio" value="N" id="permNotice_N" name="permNotice" checked="checked"/>
	              </td>
	              <th scope="row" class="tit"><label for="permCmt">댓글가능 여부</label></th>
	              <td>
	              	가능 : <input type="radio" value="Y" id="permCmt" name="permCmt"/>
	              	불가능 : <input type="radio" value="N" id="permCmt_N" name="permCmt" checked="checked"/>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="permEditor">에디터사용 여부</label></th>
	              <td>
	              	가능 : <input type="radio" value="Y" id="permEditor" name="permEditor"/>
	              	불가능 : <input type="radio" value="N" id="permEditor_N" name="permEditor" checked="checked"/>
	              </td>
	              <th scope="row" class="tit">댓글리스트  권한</th>
	              <td>
		             <select name="auth_cmt_list" id="auth_cmt_list"  class="select_box">
		             	 <%
			             for(HashMap rs:dataList) {
			             String CODE_NM = util.getStr(rs.get("CODE_NM"));
			             String CODE_CD = util.getStr(rs.get("CODE_CD"));
			             %>
			             <option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			             <%} %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="permHtml">HTML사용 여부</label></th>
	              <td>
	              	가능 : <input type="radio" value="Y" id="permHtml" name="permHtml"/>
	              	불가능 : <input type="radio" value="N" id="permHtml_N" name="permHtml" checked="checked"/>
	              </td>
	              <th scope="row" class="tit">댓글등록  권한</th>
	              <td>
		             <select name="auth_cmt_write" id="auth_cmt_write"  class="select_box">
		             	 <%
			             for(HashMap rs:dataList) {
			             String CODE_NM = util.getStr(rs.get("CODE_NM"));
			             String CODE_CD = util.getStr(rs.get("CODE_CD"));
			             %>
			             <option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			             <%} %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="permFile">파일첨부 여부</label></th>
	              <td>
	              	가능 : <input type="radio" value="Y" id="permFile" name="permFile"/>
	              	불가능 : <input type="radio" value="N" id="permFile_N" name="permFile" checked="checked"/>
	              </td>
	              <th scope="row" class="tit">댓글삭제  권한</th>
	              <td>
		             <select name="auth_cmt_del" id="auth_cmt_del" class="select_box">
		             	 <%
			             for(HashMap rs:dataList) {
			             String CODE_NM = util.getStr(rs.get("CODE_NM"));
			             String CODE_CD = util.getStr(rs.get("CODE_CD"));
			             %>
			             <option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			             <%} %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">리스트 권한</th>
	              <td colspan="3">
		             <select name="auth_list" id="auth_list" class="select_box">
			             <%
			             for(HashMap rs:dataList) {
			             String CODE_NM = util.getStr(rs.get("CODE_NM"));
			             String CODE_CD = util.getStr(rs.get("CODE_CD"));
			             %>
			             <option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			             <%} %>
		             </select>
	              </td>
	            </tr>
	             <tr>
	              <th scope="row" class="tit">읽기 권한</th>
	              <td colspan="3">
		             <select name="auth_read" id="auth_read" class="select_box">
			            <%
			             for(HashMap rs:dataList) {
			             String CODE_NM = util.getStr(rs.get("CODE_NM"));
			             String CODE_CD = util.getStr(rs.get("CODE_CD"));
			             %>
			             <option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			             <%} %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">등록 권한</th>
	              <td colspan="3">
		             <select name="auth_write" id="auth_write" class="select_box">
			            <%
			             for(HashMap rs:dataList) {
			             String CODE_NM = util.getStr(rs.get("CODE_NM"));
			             String CODE_CD = util.getStr(rs.get("CODE_CD"));
			             %>
			             <option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			             <%} %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">수정 권한</th>
	              <td colspan="3">
		             <select name="auth_modify" id="auth_modify" class="select_box">
		             	 <%
			             for(HashMap rs:dataList) {
			             String CODE_NM = util.getStr(rs.get("CODE_NM"));
			             String CODE_CD = util.getStr(rs.get("CODE_CD"));
			             %>
			             <option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			             <%} %>
		             </select>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">삭제 권한</th>
	              <td colspan="3">
		             <select name="auth_del" id="auth_del" class="select_box">
		             	 <%
			             for(HashMap rs:dataList) {
			             String CODE_NM = util.getStr(rs.get("CODE_NM"));
			             String CODE_CD = util.getStr(rs.get("CODE_CD"));
			             %>
			             <option value="<%=CODE_CD%>"><%=CODE_CD%>(<%=CODE_NM%>)</option>
			             <%} %>
		             </select>
	              </td>
	            </tr>
	          </tbody>
	        </table>

	        <!-- bo_btn  -->
	        <div class="btn_box">
				&nbsp;
				<div class="btn_right_box">
					<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99){%>
					<input type="button" class="btn_inp_b_01" value="작성" onclick="check('writeProc')"/>
					<%}%>
					<input type="button" class="btn_inp_w_01" value="취소" onclick="goSubmit('list')"/>
		        </div>

        	</div>


        </div>

      </form>

<script type="text/javascript">
	function goSubmit(mode){
		if(mode=='writeProc'){
			if (confirm("저장하시겠습니까??") == true){ //확인
				$('#mode').val(mode);
				$('#fedit').submit();
			}else{ //취소
			    return;
			}
		}

		$('#mode').val(mode);
		$('#fwrite').submit();
	}
	function check(mode){
		var boardId = $("#boardId").val();
		var boardNm = $("#boardNm").val();
		var boardSummary = $("#boardSummary").val();

		if(boardId !=null && boardId != ""){
			if(boardId.length > 6){
				alert("1~5자리를 입력해주세요.");
				return false;
			}
		}else{
			alert("ID를 입력해주세요");
			return false;
		}
		if(boardNm == null || boardNm == "" || boardNm == " " ){
			alert("게시판명을 입력해주세요");
			return false;
		}
		if(boardSummary ==null || boardSummary == "" || boardSummary == " "){
			alert("게시판요약을 입력해주세요");
			return false;
		}

		var boardIdCheck = $('#boardIdCheck').val();
		if(boardIdCheck==("N")){
			alert('게시판 아이디 체크를 하세요.');
			return false;
		}
			goSubmit(mode);

	}
	$(document).ready(function(){
		$("#boardId").blur(function(){
		   	var boardId = $('#boardId').val();
			var params = {
					"boardId": boardId
			};
			$.post("/sys/boardIdCheck.do",$.param(params),
			function(data){
				var dataVal;
				for (var i in data) {
					dataVal = data.check;
				}
				if(dataVal==2){
					$('#boardIdCheckMsg').text('');
					$('#boardIdCheck').val("N");
				}else if(dataVal == 0){
					$('#boardIdCheckMsg').css("color", "green")
					$('#boardIdCheckMsg').css("margin-left", "10px")
					$('#boardIdCheckMsg').text('사용가능합니다.');
					$('#boardIdCheck').val("Y");
				}else if(dataVal == 1){
					$('#boardIdCheckMsg').css("color", "red")
					$('#boardIdCheckMsg').css("margin-left", "10px")
					$('#boardIdCheckMsg').text('중복된 값이 있습니다.');
					$('#boardIdCheck').val("N");
				}
			});

		});
	});

	/*
		function submitGo(){
			var board_cd = jQuery.trim($('#board_cd').val());
			var params = {
				"board_cd":board_cd
				};
			jQuery.post("/m/boardCodeCheck.do",$.param(params) ,
			function(data) {
				var dataVal;
				for (var i in data) {
					dataVal = data.check;
				}
				if(dataVal==1){
					return false;
				}
			});
			if($('#board_cd').val() == ''){
				alert("게시판코드를 입력 해주세요");
				return false;
			}
			if($('#board_nm').val() == ''){
				alert("게시판명을 입력 해주세요");
				return false;
			}
			if($('#board_skin').val() == ''){
				alert("게시판스킨을 입력 해주세요");
				return false;
			}
			if($('#boardCodeCheck').val() == 'Y'){
				alert("중복된 게시판 코드 입니다");
				return false;
			}
			return true;
	*/

</script>


