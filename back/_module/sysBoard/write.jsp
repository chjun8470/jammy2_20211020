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
		<span style="color:red; font-size:10pt;">* ?????? ?????????????????????.</span>
	        <table class="skin_basic_write">
	          <caption>????????????</caption>
	          <colgroup>
	          <col style="width: 15%;" />
	          <col style="width: 35%;" />
	          <col style="width: 15%;" />
	          <col style="width: 35%;" />
	          </colgroup>
	          <tbody>
	            <tr>
	            	<th scope="row" class="tit">
	            		<span style="color:red; font-size:11pt;">*</span><label for="boardId"> ?????????ID</label></th>
	            	<td>
	              		<input type="hidden" name="boardIdCheck" id="boardIdCheck" value="N">
		            	<input type="text" name="boardId" id="boardId" value="" style="width:50%;" maxlength="100" class="inp_txt"/>
		            	<span id="boardIdCheckMsg" ></span>
	                </td>
	                <th scope="row" class="tit" style="height: 24px"><span style="color:red; font-size:11pt;">*</span> ?????????</th>
	            	<td>
	            		<select name="siteType" id="siteType" class="select_box" style="width: 310px; height: 40px">
							<option value="jeinet" selected="selected">?????????????????????</option>
							<option value="jntis">?????????????????????????????????</option>
							<option value="jipbank">????????????????????????</option>
							<option value="smbrnd">??????????????????R&D?????????</option>
							<option value="sample">sample</option>
						</select>
	                </td>
                </tr>
                <tr>
	              <th scope="row" class="tit">
	              	<span style="color:red; font-size:11pt;">*</span><label for="boardNm"> ????????????</label>
	              </th>
	              <td colspan="3">
	              	<input type="text" name="boardNm" id="boardNm" value="" style="width:97%;" maxlength="100" class="inp_txt"/>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">
	              	<span style="color:red; font-size:11pt;">*</span> ???????????????</th>
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
	              	<span style="color:red; font-size:11pt;">*</span><label for="boardSummary"> ???????????????</label>
	              </th>
	              <td colspan="3">
	              	<input type="text" name="boardSummary" id="boardSummary" value="" style="width:97%;" maxlength="100" class="inp_txt"/>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="blockPage">????????? ???</label></th>
	              <td colspan="3">
	              	<input type="text" name="blockPage" id="blockPage" value="10" style="width:5%;" maxlength="100" class="inp_txt"/>???  &nbsp;&nbsp;(??? ???????????? ????????? ????????? ???)
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="listSize">????????? ??????</label></th>
	              <td colspan="3">
	              	<input type="text" name="listSize" id="listSize" value="10" style="width:5%;" maxlength="100" class="inp_txt"/>???  &nbsp;&nbsp;(??? ???????????? ????????? ????????? ??? ???)
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="permNotice">???????????? ??????</label></th>
	              <td>
	              	?????? : <input type="radio" value="Y" id="permNotice" name="permNotice"/>
	              	????????? : <input type="radio" value="N" id="permNotice_N" name="permNotice" checked="checked"/>
	              </td>
	              <th scope="row" class="tit"><label for="permCmt">???????????? ??????</label></th>
	              <td>
	              	?????? : <input type="radio" value="Y" id="permCmt" name="permCmt"/>
	              	????????? : <input type="radio" value="N" id="permCmt_N" name="permCmt" checked="checked"/>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit"><label for="permEditor">??????????????? ??????</label></th>
	              <td>
	              	?????? : <input type="radio" value="Y" id="permEditor" name="permEditor"/>
	              	????????? : <input type="radio" value="N" id="permEditor_N" name="permEditor" checked="checked"/>
	              </td>
	              <th scope="row" class="tit">???????????????  ??????</th>
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
	              <th scope="row" class="tit"><label for="permHtml">HTML?????? ??????</label></th>
	              <td>
	              	?????? : <input type="radio" value="Y" id="permHtml" name="permHtml"/>
	              	????????? : <input type="radio" value="N" id="permHtml_N" name="permHtml" checked="checked"/>
	              </td>
	              <th scope="row" class="tit">????????????  ??????</th>
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
	              <th scope="row" class="tit"><label for="permFile">???????????? ??????</label></th>
	              <td>
	              	?????? : <input type="radio" value="Y" id="permFile" name="permFile"/>
	              	????????? : <input type="radio" value="N" id="permFile_N" name="permFile" checked="checked"/>
	              </td>
	              <th scope="row" class="tit">????????????  ??????</th>
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
	              <th scope="row" class="tit">????????? ??????</th>
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
	              <th scope="row" class="tit">?????? ??????</th>
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
	              <th scope="row" class="tit">?????? ??????</th>
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
	              <th scope="row" class="tit">?????? ??????</th>
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
	              <th scope="row" class="tit">?????? ??????</th>
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
					<input type="button" class="btn_inp_b_01" value="??????" onclick="check('writeProc')"/>
					<%}%>
					<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
		        </div>

        	</div>


        </div>

      </form>

<script type="text/javascript">
	function goSubmit(mode){
		if(mode=='writeProc'){
			if (confirm("??????????????????????????") == true){ //??????
				$('#mode').val(mode);
				$('#fedit').submit();
			}else{ //??????
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
				alert("1~5????????? ??????????????????.");
				return false;
			}
		}else{
			alert("ID??? ??????????????????");
			return false;
		}
		if(boardNm == null || boardNm == "" || boardNm == " " ){
			alert("??????????????? ??????????????????");
			return false;
		}
		if(boardSummary ==null || boardSummary == "" || boardSummary == " "){
			alert("?????????????????? ??????????????????");
			return false;
		}

		var boardIdCheck = $('#boardIdCheck').val();
		if(boardIdCheck==("N")){
			alert('????????? ????????? ????????? ?????????.');
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
					$('#boardIdCheckMsg').text('?????????????????????.');
					$('#boardIdCheck').val("Y");
				}else if(dataVal == 1){
					$('#boardIdCheckMsg').css("color", "red")
					$('#boardIdCheckMsg').css("margin-left", "10px")
					$('#boardIdCheckMsg').text('????????? ?????? ????????????.');
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
				alert("?????????????????? ?????? ????????????");
				return false;
			}
			if($('#board_nm').val() == ''){
				alert("??????????????? ?????? ????????????");
				return false;
			}
			if($('#board_skin').val() == ''){
				alert("?????????????????? ?????? ????????????");
				return false;
			}
			if($('#boardCodeCheck').val() == 'Y'){
				alert("????????? ????????? ?????? ?????????");
				return false;
			}
			return true;
	*/

</script>


