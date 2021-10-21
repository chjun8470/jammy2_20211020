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

	String m = util.getStr(request.getQueryString());
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String dataIdx = util.getStr(paramMap.get("dataIdx"));
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
		<input type="hidden" name="dataIdx" id="dataIdx" value="<%=dataIdx%>" />
		<input type="hidden" name="state" id="state" value="<%=state%>" />
		<!--검색조건-->
		<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
		<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
		<input type="hidden" name="searchState" id="searchState" value="<%=searchState%>" />
		<input type="hidden" name="ArrayCheck" id="ArrayCheck" value="<%=ArrayCheck%>" />

<div class="b_ContBox">

	<%
		if(dataMap.size() > 0){
			String fileParam = "?dataGrp="+util.getStr(dataMap.get("DATA_GRP"))
					+"&amp;fileId="+util.getIntStr(dataMap.get("FILE_ID"))
					+"&amp;dataIdx="+util.getStr(dataMap.get("DATA_IDX"));

	%>
	<div class="PubCont">

		<p class="TitPubView"><%=util.getStr(dataMap.get("SUBJECT")) %></p>
		<div class="PubimgBox" style="margin-top:30px;"><iframe src = "/file/<%=fileGrp+"/"+dataMap.get("TITLE")%>" width="677px;" height="562px;" style="max-width:700px;"/></iframe></div>

			<p class="TxtPubView2">
			발행기관(출처) : <%=util.getStr(String.valueOf(dataMap.get("DATA04")))%>
			&nbsp;/&nbsp;발행 : <%=util.getStr(String.valueOf(dataMap.get("DATA05")))%><br/>
			<%if("SCIENCE".equals(util.getStr(dataMap.get("DATA03")))) {%>
			분류 : 과학기술동향
			<% }else if("LAWORD".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류 : 관련법령
			<% }else if("TECHNOLOGY".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 기술자료
			<% }else if("ETC".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 발간물
			<% }else if("INDUSTRIAL".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 산업기술자료
			<% }else if("MENUAL".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 연구장비메뉴얼
			<% }else if("BROCHURE".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 연구장비브로슈어
			<% }else if("POLICY".equals(util.getStr(dataMap.get("DATA03")))) { %>
			분류: 정책이슈
			<% }else { %>
			분류: 통계자료
			<% } %>
			&nbsp;/&nbsp;조회 : <%=util.getIntStr(dataMap.get("HITS"))%>
			</p>
			<p class="down_publist"><a href="/cmm/fms/ComFileDown.do<%=fileParam%>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','/img/board/btn_down3_ovr.gif',1)"><img src="/img/board/btn_down3.gif" alt="2" width="213" height="50" id="Image4" /></a></p>
	</div>

	<div class="basic_pubviewWrap2">
		<div class="h4_tit">주요정보</div>
		<div class="pubview_text">
			<%=dataMap.get("CONTENT").replaceAll("<br>", "<br/>")%>
		</div>
		<%--
			<div class="h4_tit">목차</div>
			<div class="pubview_text">
				<%=util.getStr(dataMap.get("DATA02"))%>
			</div>
		--%>
	</div>
	<div class="update" style="float:right;">
		[최종수정일:
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


		<div>
			<%if(cmtMap.size() > 0) {%>
			<input type="hidden" name="cmtIdx" id="cmtIdx">
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
						<td style="text-align: center;"><%=util.getStr(String.valueOf(rs.get("REG_DT"))) %></td>
						<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
						<td>
							<button type="button" class="btn_inp_w_01" onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>, '<%=util.getStr(rs.get("CMT_CONTENT")) %>')">수정</button>
							<button type="button" class="btn_inp_w_01" onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %>)">삭제</button>
							<%-- <a href="#" onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>, '<%=util.getStr(rs.get("CMT_CONTENT")) %>')">수정</a>
							<a href="#" style="margin-left:5px;" onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %>)">삭제</a> --%>
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
			<div style="margin-bottom:20px;">
				<textarea rows="5" name="comment" class="b_txtbox4" style="width:88%;min-height:20px;"></textarea>
				<span><button type="button" id="inpCmt" class="btn_inp_w_01" style="float:right;width:80px;height:80px">등록</button></span>
			</div>
		<% } %>

		<div class="bbs_btn">
		<%if(util.loginCheck()){ %>

			<%-- <%if(util.getStr(dataMap.get("DATA06")).equals("10")){ //승인요청일때%>
				<input type="button" class="btn_inp_b_01" value="승인" onclick="goSubmit('apvProc','<%=dataIdx%>','승인')" style="float:left;"/>
				<input type="button" class="btn_inp_b_01" value="반려" onclick="goSubmit('companionProc','<%=dataIdx%>','반려')" style="float:left;"/>
			<%}%>
			<%if(util.getStr(dataMap.get("DATA06")).equals("20")){ //승인일때%>
				<input type="button" class="btn_inp_b_01" value="승인반려" onclick="goSubmit('companionProc','<%=dataIdx%>','반려')" style="float:left;"/>
			<%}%> --%>

			<button type="button" class="btn_inp_w_01" style="float:right;" onclick="goSubmit('list')">목록</button>
			<%if(util.getBbsAuth(loginVO,boardMap,"DEL")) {%>
				<button type="button" class="btn_inp_b_01" style="float:right;" onclick="goSubmit('del')">삭제</button>
			<%}%>
			<%if(util.getBbsAuth(loginVO,boardMap,"EDITOR")) {%>
				<button type="button" class="btn_inp_b_01" style="float:right;" onclick="goSubmit('edit')">수정</button>
			<%}%>

		<%}%>
		</div>
</form>

<script type="text/javascript">
	function goSubmit(mode,dataIdx){

		$('#mode').val(mode);

		if(mode == 'apvProc'){
			$('#dataIdx').val(dataIdx);
			$('#state').val('20');
		}
		if(mode == 'companionProc'){
			$('#dataIdx').val(dataIdx);
			$('#state').val('30');
		}

		if(mode == 'list'){
			$('#dataIdx').val('');
		}

		$('#fview').submit();
	}

	function more_view(data, btn){
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
	}

	function editCmt(no, idx, cmt) {
		$("#cmt"+no).hide();
		var tag = "<tr id='editcmt"+no+"'>";
		tag += "<td colspan='2'><textarea name='editComment'id='editComment' style='resize:none; width:100%; height:45px;'>"+ cmt +"</textarea></td>";
		tag += "<td colspan='2' style='padding-left:30px;'><button type='button' class='btn_inp_w_01' style='width:50px; height:25px; margin-left:10px;' onclick='editCmtProc("+idx+")'>수정</button>"
		tag += "<button type='button' class='btn_inp_w_01' style='width:50px; height:25px; margin-left:10px;' onclick='cancleEdit("+ no +","+ idx +")'>취소</button></td>";
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