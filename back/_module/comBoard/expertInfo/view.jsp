<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
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
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));

	LoginVO loginVO = util.getLoginInfo(request);

%>

	<form name="fview" id="fview" action="<%=myPage%>" method="post" >
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

		<div class="skin_bbs_write" style="margin-top: 30px">
			<table class="skin_basic_write" summary="???????????????  ??????, ??????, ????????????, ???????????????(??????)??? ???????????????.">
				<caption>???????????????</caption>
                     <colgroup>
                           <col width="14%" />
                           <col width="36%" />
                            <col width="14%" />
                           <col width="36%" />
                     </colgroup>
                     <tbody>
                     	<tr>
                    		<th scope="row" class="tit" colspan="4">
                    			<label for="userInfo">????????????</label>
                    		</th>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit">
                    			<label for="name">??????</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA01")) %>
                    		</td>
                    		<th scope="row" class="tit">
                    			<label for="birthday">????????????</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA02")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit">
                    			<label for="nationality">??????</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA03")) %>
                    		</td>
                    		<th scope="row" class="tit">
                    			<label for="homePage">????????????</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA04")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit">
                    			<label for="affiliation">??????</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA05")) %> <%=util.getStr(dataMap.get("DATA06")) %>
                    		</td>
                    		<th scope="row" class="tit">
                    			<label for="position">??????</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA07")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit">
                    			<label for="position_field">????????????</label>
                    		</th>
                    		<td colspan="3">
                    			<%=util.getStr(dataMap.get("DATA08")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit" colspan="4">
                    			<label for="academic_career">??????</label>
                    		</th>
                    	</tr>
  						<tr>
                    		<td colspan="4">
                    			<%=util.getStr(dataMap.get("TEXT1")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit" colspan="4">
                    			<label for="career">??????</label>
                    		</th>
                    	</tr>
  						<tr>
                    		<td colspan="4">
                    			<%=util.getStr(dataMap.get("TEXT2")) %>
                    		</td>
                    	</tr>

                     </tbody>
			</table>
		</div>
		<div class="btn_box">
			<%if(util.loginCheck()){ %>
				<div class="btn_right_box">
					<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('edit')"/>
					<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('del')"/>
			<%} %>
					<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
				</div>
		</div>
	</div>
</form>

<script type="text/javascript">
	function goSubmit(mode){
		$('#mode').val(mode);
		$('#fview').submit();
	}

	function editCmt(no, idx, cmt) {
		$("#cmt"+no).hide();
		var tag = "<tr id='editcmt"+no+"'>";
		tag += "<td colspan='2'><textarea name='editComment'id='editComment' style='resize:none; width:100%; height:45px;'>"+ cmt +"</textarea></td>";
		tag += "<td colspan='2' style='padding-left:30px;'><button type='button' style='width:50px; height:50px; margin-left:10px;' onclick='editCmtProc("+idx+")'>??????</button>"
		tag += "<button type='button' style='width:50px; height:50px; margin-left:10px;' onclick='cancleEdit("+ no +","+ idx +")'>??????</button></td>";
		tag += "</tr>";
		$("#cmt"+no).after(tag);
	}

	function editCmtProc(idx) {
		$("#mode").val("editcmt");
		$("#cmtIdx").val(idx);
		var formData = $("#fview").serialize();
		$.ajax({
			url:"/sys/comBoard.do",
			data:formData,
			type:"POST",
			success:function() {
				alert("?????????????????????");
				window.location.reload();
			}
		});
	}

	function cancleEdit(no, idx) {
		$("#editcmt"+no).remove();
		$("#cmtIdx").val("");
		$("#cmt"+no).show();
	}

	function delCmt(cmt) {
		if(confirm("????????? ?????????????????????????")) {
			$("#cmtIdx").val(cmt);
			$("#mode").val("delComment");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/sys/comBoard.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("?????????????????????");
					window.location.reload();
				}
			});
		}
	}

	$(document).ready(function() {
		$("#inpCmt").click(function() {
			$("#mode").val("comment");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/sys/comBoard.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("?????????????????????");
					window.location.reload();
				}
			});
		});
	});
</script>