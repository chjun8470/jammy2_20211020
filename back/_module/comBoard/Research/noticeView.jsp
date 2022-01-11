<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
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
	String afterBoardComIdx = util.getStr(paramMap.get("afterBoardComIdx"));
	String tab = util.getStr(paramMap.get("tab"));

	LoginVO loginVO = util.getLoginInfo(request);


	if((util.getBbsAuth(loginVO,boardMap,"READ")).equals(false)){
%>
		<script type="text/javascript" >
			alert("권한이 부족합니다.");
			history.back(-1); //이전화면으로
		</script>
<%
		return;
	}
%>

	<form name="fview" id="fview" action="<%=myPage%>" method="post" >
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="00009" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
		<input type="hidden" name="afterBoardComIdx" id="afterBoardComIdx" value="" />
		<input type="hidden" name="tab" id="tab" value="<%=tab%>" />
		<input type="text" name="beforeBoardComIdx" id="beforeBoardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />


	<div class="skin_bbs_veiw" style="margin-top:30px;">

		<div class="bbs_head">

			<h3 class="title"><%=util.getStr(dataMap.get("SUBJECT")) %></h3>
			<div class="head_text" style="text-align: right; width: 950px;">
		<!-- 	<p  style="text-align: right;" > -->
			작성자 :  <%=util.getStr(dataMap.get("WRITER_ID")) %>
			 | 작성일 : <%=util.getStr(dataMap.get("FRST_REGIST_PNTTM"))%>
			</div>
		</div>



		<div style="text-align: left; widht: 100%;" class="bbs_cont">
			<div class="style-init" style="word-break:break-all;">
			<%for(HashMap rs:fileList){
				String ext = util.getStr(rs.get("FILE_EXT")).toLowerCase();
						if("jpg".equals(ext) || "gif".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){
							%>
								<img src="<%=(util.getStr(rs.get("FILE_PATH"))+util.getStr(rs.get("FILE_NM"))) %>" class="img-view" style="max-width:700px;"/>
							<%
						}
				}%>


				<pre><%=dataMap.get("CONTENT")%></pre>
			</div>
		</div>
		<div  style="clear:both;">
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
									<li class="text" >첨부파일 :
										<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px;padding:10px"/> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte) </a>
		<%-- 									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
									</li>
								<% fileCnt++; }%>
								</ul>
							<%} %>

		</div>
		<div>
			<%if(cmtMap.size() > 0) {%>
			<input type="hidden" name="cmtIdx" id="cmtIdx" />
			<table style="width:100%;">
				<colgroup>
					<col width="15%" />
					<col width="60%" />
					<col width="15%" />
					<col width="10%" />
				</colgroup>
				<%
					int no = 0;
					for(HashMap rs:cmtMap) {
				%>
					<tr id="cmt<%=no%>" name="cmt<%=no %>">
						<th><%=util.getStr(rs.get("REG_USER_NM")) %></th>
						<td><%=util.getStr(rs.get("CMT_CONTENT")) %></td>
						<td style="text-align: center;"><%=util.getStr(rs.get("REG_DT")) %></td>
						<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
						<td>
							<a href="#" onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>, '<%=util.getStr(rs.get("CMT_CONTENT")) %>')">수정</a>
							<a href="#" style="margin-left:5px;" onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %>)">삭제</a>
						</td>
						<% } %>
					</tr>
				<%
					no++;
					} %>
			</table>
			<%} %>
		</div>
		<%if(util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { %>
			<div style="margin-top:5px;">
				<textarea rows="5" name="comment" style="resize:none; width:88%;"></textarea>
				<span><button type="button" id="inpCmt" style="float:right;width:80px;height:80px">등록</button></span>
			</div>
		<% } %>

		<div class="btn_box" style="text-align: right;">
			<% HashMap<String, String> aticleDataMap = request.getAttribute("aticleDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("aticleDataMap"); %>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && util.getStr(loginVO.getAuthLv()).equals("99")
				|| util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(aticleDataMap.get("ORG_GRP_CD")))
				|| util.loginCheck() && util.getStr(loginVO.getUserId()).equals(util.getStr(dataMap.get("WRITER_ID"))) ){ %>
				<input type="button" class="btn_inp_b_01" value="수정" onclick="goSubmit('edit')"/>
			<%}%>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")  && util.getStr(loginVO.getAuthLv()).equals("99")
				|| util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(aticleDataMap.get("ORG_GRP_CD")))
				|| util.loginCheck() && util.getStr(loginVO.getUserId()).equals(util.getStr(dataMap.get("WRITER_ID"))) ){ %>
				<input type="button" class="btn_inp_b_01" value="삭제" onclick="goSubmit('del')"/>
			<%} %>
			<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
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
		tag += "<td colspan='2' style='padding-left:30px;'><button type='button' style='width:50px; height:50px; margin-left:10px;' onclick='editCmtProc("+idx+")'>수정</button>"
		tag += "<button type='button' style='width:50px; height:50px; margin-left:10px;' onclick='cancleEdit("+ no +","+ idx +")'>취소</button></td>";
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
				alert("수정되었습니다");
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
		if(confirm("댓글을 삭제하시겠습니까?")) {
			$("#cmtIdx").val(cmt);
			$("#mode").val("delComment");
			var formData = $("#fview").serialize();
			$.ajax({
				url:"/sys/comBoard.do",
				data:formData,
				type:"POST",
				success:function(){
					alert("삭제되었습니다");
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
					alert("등록되었습니다");
					window.location.reload();
				}
			});
		});
	});
</script>