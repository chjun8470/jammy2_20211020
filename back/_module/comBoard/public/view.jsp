<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
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

	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String searchState = util.getStr(paramMap.get("searchState"));
	String ArrayCheck = util.getStr(paramMap.get("ArrayCheck"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));

	String m = util.getStr(request.getQueryString());
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId"));
	String state = util.getStr(paramMap.get("state"));
	LoginVO loginVO = util.getLoginInfo(request);

	SimpleDateFormat date_format = new SimpleDateFormat("YYYY-mm-dd");
%>


<!--b_ContBox S-->
<form name="fview" id="fview" action="?<%=myPage%>" method="post" >
		<input type="hidden" name="reUrl" id="reUrl" value="?<%=m%>&amp;boardComIdx=<%=boardComIdx%>" />
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
		<input type="hidden" name="state" id="state" value="<%=state%>" />
		<!--????????????-->
		<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
		<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
		<input type="hidden" name="searchState" id="searchState" value="<%=searchState%>" />
		<input type="hidden" name="ArrayCheck" id="ArrayCheck" value="<%=ArrayCheck%>" />
		<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
		<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />


	<div class="b_ContBox">
		<%
			if(dataMap.size() > 0){
				String fileParam = "?dataGrp="+util.getStr(dataMap.get("DATA_GRP"))
						+"&amp;fileId="+util.getIntStr(dataMap.get("FILE_ID"))
						+"&amp;dataIdx="+util.getStr(dataMap.get("DATA_IDX"));

		%>
		<div class="PubCont">

			<p class="TitPubView"><%=util.getStr(dataMap.get("SUBJECT")) %></p>

			<div class="PubimgBox" style="margin-top:30px;">
				<iframe src = "/file/<%=fileGrp+"/"+dataMap.get("TITLE")%>" width="677px;" height="562px;" style="max-width:700px;"/></iframe>
			</div>

			<p class="TxtPubView2">
				????????????(??????) : <%=util.getStr(String.valueOf(dataMap.get("DATA04")))%>
				&nbsp;/&nbsp;?????? : <%=util.getStr(String.valueOf(dataMap.get("DATA05")))%><br/>
				<%if("SCIENCE".equals(util.getStr(dataMap.get("DATA03")))) {%>
				?????? : ??????????????????
				<% }else if("LAWORD".equals(util.getStr(dataMap.get("DATA03")))) { %>
				?????? : ????????????
				<% }else if("TECHNOLOGY".equals(util.getStr(dataMap.get("DATA03")))) { %>
				??????: ????????????
				<% }else if("ETC".equals(util.getStr(dataMap.get("DATA03")))) { %>
				??????: ?????????
				<% }else if("INDUSTRIAL".equals(util.getStr(dataMap.get("DATA03")))) { %>
				??????: ??????????????????
				<% }else if("MENUAL".equals(util.getStr(dataMap.get("DATA03")))) { %>
				??????: ?????????????????????
				<% }else if("BROCHURE".equals(util.getStr(dataMap.get("DATA03")))) { %>
				??????: ????????????????????????
				<% }else if("POLICY".equals(util.getStr(dataMap.get("DATA03")))) { %>
				??????: ????????????
				<% }else if("EXCELLENCE".equals(util.getStr(dataMap.get("DATA03")))) { %>
				??????: ????????????
				<% }else if("KICT".equals(util.getStr(dataMap.get("DATA03")))) { %>
				??????: KICT????????????
				<% }else { %>
				??????: ????????????
				<% } %>
				&nbsp;/&nbsp;?????? : <%=util.getIntStr(dataMap.get("HITS"))%>
			</p>

			<p class="down_publist">
				<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','/img/board/btn_down3_ovr.gif',1)"><img src="/img/board/btn_down3.gif" alt="2" width="213" height="50" id="Image4" /></a>
			</p>
		</div>

		<div class="basic_pubviewWrap2">
			<div class="h4_tit">????????????</div>
			<div class="pubview_text">
				<%=dataMap.get("CONTENT").replaceAll("<br>", "<br/>")%>
			</div>
			<%--
				<div class="h4_tit">??????</div>
				<div class="pubview_text">
					<%=util.getStr(dataMap.get("DATA02"))%>
				</div>
			--%>
		</div>
		<div class="update" style="float:right;">
			[???????????????:
			<%if(util.getStr(dataMap.get("LAST_UPDT_PNTTM_DT")).equals("")){%>
				<%=util.getStr(dataMap.get("FRST_REGIST_PNTTM_DT"))%>
			<%}else{%>
				<%=util.getStr(dataMap.get("LAST_UPDT_PNTTM_DT"))%>
			<%}%>
			]
		</div>
		<br/>
		<% } %>

	</div>
	<!--b_ContBox E-->


	<!-- ??????????????? -->
	<%if(util.loginCheck() && util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { //????????????%>
		<div>
			<%if(cmtMap.size() > 0) {%>
			<input type="hidden" name="cmtIdx" id="cmtIdx" />
			<table class="skin_basic_write">
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: 60%;" />
					<col style="width: 15%;" />
					<col style="width: 15%;" />
				</colgroup>
				<!-- colgroup e -->
				<!-- thead s -->
				<tbody>
				<%
					int no = 0;
					for(HashMap rs:cmtMap) {
				%>
					<tr id="cmt<%=no%>" name="cmt<%=no %>">
						<th><%=util.getStr(rs.get("REG_USER_NM")) %></th>
						<td><%=util.getStr(rs.get("CMT_CONTENT")) %></td>
						<td style="text-align: center;"><%=util.getStr(rs.get("REG_DT")) %></td>
						<td>
							<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
							<button type="button" class="btn_inp_b_01" onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>, '<%=util.getStr(rs.get("CMT_CONTENT")) %>')">??????</button>
							<%}%>
							<%
								int cmtDelLv = Integer.parseInt(util.getStr(boardMap.get("PERM_LVL_CMT_DEL")));
							    if(util.getInt(loginVO.getAuthLv()) >= cmtDelLv){ //??????????????????
							%>
							<button type="button" class="btn_inp_b_01" onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %>)">??????</button>
							<%}%>
							<%--<a href="#" onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>, '<%=util.getStr(rs.get("CMT_CONTENT")) %>')">??????</a>
							<a href="#" style="margin-left:5px;" onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %>)">??????</a> --%>
						</td>
					</tr>
				<%
					no++;
					}
				%>
				</tbody>
			</table>
            <%} %>
		</div>
		<%}%>

		<!-- ???????????? -->
		<%if(util.loginCheck() && util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { //????????????%>
		<div style="margin-top:5px;">
			<%
				int cmtWriteLv = Integer.parseInt(util.getStr(boardMap.get("PERM_LVL_CMT_WRITE")));
				if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= cmtWriteLv){ //??????????????????
			%>
			<textarea rows="5" name="comment" class="b_txtbox4" style="width:88%;min-height:20px;"></textarea>
			<span><button type="button" id="inpCmt" class="btn_inp_w_01" style="float:right;width:80px;height:80px">??????</button></span>
			<%}%>
		</div>
		<%}%>

		<div class="btn_box" style="text-align: right; margin-top:10px;">

			<%-- <%if(util.getStr(dataMap.get("DATA06")).equals("10")){ //??????????????????%>
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('apvProc','<%=boardIdx%>','??????')" style="float:left;"/>
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('companionProc','<%=boardIdx%>','??????')" style="float:left;"/>
			<%}%>
			<%if(util.getStr(dataMap.get("DATA06")).equals("20")){ //????????????%>
				<input type="button" class="btn_inp_b_01" value="????????????" onclick="goSubmit('companionProc','<%=boardIdx%>','??????')" style="float:left;"/>
			<%}%> --%>

			<%if(util.getBbsAuth(loginVO,boardMap,"EDITOR")) {%>
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('edit')"/>
			<%}%>
			<%if(util.getBbsAuth(loginVO,boardMap,"DEL")) {%>
				<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('del')"/>
			<%}%>
				<input type="button" class="btn_inp_w_01" value="??????" onclick="goSubmit('list')"/>
		</div>

</form>

<script type="text/javascript">
	function goSubmit(mode,boardIdx){

		$('#mode').val(mode);

		if(mode == 'apvProc'){
			$('#boardIdx').val(boardIdx);
			$('#state').val('20');
		}
		if(mode == 'companionProc'){
			$('#boardIdx').val(boardIdx);
			$('#state').val('30');
		}

		if(mode == 'list'){
			$('#boardIdx').val('');
		}

		$('#fview').submit();
	}

	/* function more_view(data, btn){
		var content_data = data;
		var btn = btn;
		console.info(data);
		console.info(btn);
		$('#'+content_data).css("display", "block");
		$('#'+btn).css("display", "block");


	}
	function more_close(data, btn){
		alert(data);
		alert(btn);
	} */

	function editCmt(no, idx, cmt) {
		$("#cmt"+no).hide();
		var tag = "<tr id='editcmt"+no+"'>";
		tag += "<td colspan='2'><textarea name='editComment'id='editComment' style='resize:none; width:100%; height:45px;'>"+ cmt +"</textarea></td>";
		tag += "<td colspan='2' style='padding-left:30px;'><button type='button' class='btn_inp_w_01' style='width:50px; height:25px; margin-left:10px;' onclick='editCmtProc("+idx+")'>??????</button>"
		tag += "<button type='button' class='btn_inp_w_01' style='width:50px; height:25px; margin-left:10px;' onclick='cancleEdit("+ no +","+ idx +")'>??????</button></td>";
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