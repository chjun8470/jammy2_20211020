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
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));


	if((util.getBbsAuth(loginVO,boardMap,"READ")).equals(false)){
%>
		<script type="text/javascript" >
			alert("????????? ???????????????.");
			history.back(-1); //??????????????????
		</script>
<%
		return;
	}
%>


<form name="fview" id="fview" action="<%=myPage%>" method="post">
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="noticeCheck" id="noticeCheck" value="<%=util.getStr(dataMap.get("NOTICE_AT"))%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<table class="skin_basic_write" >
			<caption>???????????????</caption>
			<colgroup>
				<col style="width:15%" />
			    <col style="width:35%" />
			    <col style="width:15%" />
			    <col style="width:35%" />
			</colgroup>
			<tbody>
				<tr>
			  		<th scope="row" class="tit">?????????</th>
			  		<td><%=util.getStr(dataMap.get("ORG_GRP_NM")) %></td>
			  		<th scope="row" class="tit">?????????</th>
			  		<td><%=util.getStr(dataMap.get("DATA02")) %></td>
		     	</tr>
		     	<tr>
			  		<th scope="row" class="tit">??????</th>
			  		<td><%=util.getStr(dataMap.get("DATA03")) %></td>
			  		<th scope="row" class="tit">??????</th>
			  		<td><%=util.getStr(dataMap.get("DATA04")) %></td>
		     	</tr>
		     	<tr>
			  		<th scope="row" class="tit">??????</th>
			  		<td><%=util.getStr(dataMap.get("DATA05")) %></td>
			  		<th scope="row" class="tit">??????</th>
			  		<td><%=util.getStr(dataMap.get("DATA06")) %></td>
		     	</tr>
		     	<tr>
			  		<%-- <th scope="row" class="tit">????????????</th>
			  		<td><%=util.getStr(dataMap.get("DATA07")) %></td> --%>
			  		<th scope="row" class="tit" >????????????</th>
			  		<td colspan="3" ><%=util.getStr(dataMap.get("DATA08"))%>-<%=util.getStr(dataMap.get("DATA09")) %>-<%=util.getStr(dataMap.get("DATA10")) %></td>
		     	</tr>
		     	<tr>
			  		<th scope="row" class="tit">????????????</th>
			  		<td><%=util.getStr(dataMap.get("DATA11")) %>-<%=util.getStr(dataMap.get("DATA12")) %>-<%=util.getStr(dataMap.get("DATA13")) %></td>
		     		<th scope="row" class="tit">?????????</th>
			  		<td><%=util.getStr(dataMap.get("DATA14")) %>@<%=util.getStr(dataMap.get("DATA15")) %></td>
		     	</tr>
		     	<tr>
			  		<th scope="row" class="tit" rowspan="2">????????????</th>
			  		<td colspan="3"><%=util.getStr(dataMap.get("TEXT1")) %></td>
		     	</tr>
		     	<tr>
			  		<td colspan="3">
	                    <%
                          	String data16Str = util.getStr(dataMap.get("DATA16"));
                          	String[] data16 = null;
                          	String[] data16Check = {"N","N","N","N"};
                          	if(!data16Str.equals("")){
                          		data16 = data16Str.split("[,]");
                          	}
                          	for(int as = 0;as < data16.length;as++){
                          		int tmpInt = Integer.parseInt(data16[as]);
                          		tmpInt--;
                          		data16Check[tmpInt] = "Y"; 
                          	}
			  			%>
			  			<% if(data16Check[0].equals("Y")){ %><span style="padding-right: 20px;" >R&D/????????????/??????</span><% } %>
			  			<% if(data16Check[1].equals("Y")){ %><span style="padding-right: 20px;" >??????/??????/??????</span><% } %>
			  			<% if(data16Check[2].equals("Y")){ %><span style="padding-right: 20px;" >????????????</span><% } %>
			  			<% if(data16Check[3].equals("Y")){ %><span style="padding-right: 20px;" >????????????</span><% } %>
			  		</td>
		     	</tr>
			</tbody>
		</table>
		<div class="btn_box" style="text-align: right;">
			<% HashMap<String, String> aticleDataMap = request.getAttribute("aticleDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("aticleDataMap"); %>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && util.getStr(loginVO.getAuthLv()).equals("99")
				|| util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(aticleDataMap.get("ORG_GRP_CD")))
				|| util.loginCheck() && util.getStr(loginVO.getUserId()).equals(util.getStr(dataMap.get("WRITER_ID"))) ){ %>
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('edit')"/>
			<%}%>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")  && util.getStr(loginVO.getAuthLv()).equals("99")
				|| util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(aticleDataMap.get("ORG_GRP_CD")))
				|| util.loginCheck() && util.getStr(loginVO.getUserId()).equals(util.getStr(dataMap.get("WRITER_ID"))) ){ %>
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('del')"/>
			<%} %>
				<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
		</div>
</form>

<script type="text/javascript">
	function goSubmit(mode){

		//???????????? ???????????? ??????
		if(mode == 'del'){

			if (confirm("?????? ??????????????????????????") == true){ //??????
				$('#mode').val(mode);
				$('#fview').submit();
			}else{ //??????
			    return;
			}

		}

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