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
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String beforeBoardComIdx = util.getStr(paramMap.get("beforeBoardComIdx"));
	String afterBoardComIdx = util.getStr(paramMap.get("afterBoardComIdx"));
	//String siteId = util.getStr(paramMap.get("siteId")); //사이트구분(필요없음)
	SimpleDateFormat datef = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	if((util.getBbsAuth(loginVO,boardMap,"READ")).equals(false)){
%>
		<script type="text/javascript" >
		//<![CDATA[
			alert("권한이 부족합니다.");
			history.back(-1); //이전화면으로
		//]]>	
		</script>
<%
		return;
	}
%>
<form name="fview" id="fview" action="./changeboard.do" method="post" >
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="sub.do?m=<%=m%>" />
	<input type="hidden" name="noticeCheck" id="noticeCheck" value="<%=util.getStr(dataMap.get("NOTICE_AT"))%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="<%=beforeBoardComIdx%>" />
	<input type="hidden" name="afterBoardComIdx" id="afterBoardComIdx" value="<%=afterBoardComIdx%>" />
	<input type="hidden" name="m"  value="<%=m%>" />
	<input type="hidden" name="cmtIdx" id="cmtIdx" />
	<%-- <input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" /> --%>
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

	<div class="MPTit">담당자게시글 상세</div>

	<div class="basic_viewWrap MAT10">

		<table class="skin_view01">
		    <colgroup>
				<col style="width:15%;" />
				<col style="width:35%;" />
				<col style="width:15%;" />
				<col style="width:35%;" />
			</colgroup>
		
			<thead>
				<tr>
					<th scope="col" class="alnC">제목</th>
					<td class="r_line_none" colspan="3">
			    		<%=util.getStr(dataMap.get("SUBJECT"))%>
					</td>
				</tr>
			</thead>
			
			<tbody>
			
				<tr>
					<th scope="col" class="alnC">등록자</th>
					<td>
						<%=util.getStr(dataMap.get("WRITER_NM"))%>(<%=util.getStr(dataMap.get("WRITER_ID"))%>)
					</td>
					<th scope="col" class="alnC">등록일</th>
					<td class="r_line_none">
						<%=util.getStr(dataMap.get("FRST_REGIST_PNTTM"))%>
					</td>
				</tr>
				
				<tr>
					<th scope="col" class="alnC">조회</th>
					<td class="r_line_none" colspan="3"><%=util.getIntStr(dataMap.get("HITS"))%></td>
				</tr>
				
				<tr>
					<td class="r_line_none view_cont alnC" colspan="4" style="word-break:break-all; overflow:hidden;">
						<div class="cont">
							<%=dataMap.get("CONTENT").trim().replaceAll("<br>", "<br/>")%>
						</div>
				
						<!-- 파일첨부 이미지일 경우 화면에 출력  -->
						<%
						int imgCnt = 1;
						for(HashMap rs:fileList){
							String ext = util.getStr(rs.get("FILE_CAT")).toLowerCase();
						
							if("jpeg".equals(ext) || "jpg".equals(ext) || "gif".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){
						%>
						<div>
							&#60; File_Image <%=imgCnt%> &#62;<br/>
							<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:500px; vertical-align:middle "/>
						</div>
						<%
								imgCnt++;
						
							}
						}
						%>
					</td>
				</tr>
				
			</tbody>
			
		</table>

		<div class="mp_replBox">
		
			<%if(util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { %>
			<textarea rows="5" name="comment" cols="1"></textarea>
				
			<%if(util.loginCheck() && loginVO.getUserId().equals(dataMap.get("WRITER_ID")) || util.getInt(loginVO.getAuthLv()) >= 70) { %>
			<button type="button" id="inpCmt" class="btn_add">등록</button>
			<% } else { %>
			<button type="button" id="inpCmtNot" class="btn_add">등록</button>
			<% } %>
				
			<% } %>
			
		</div>

		<div class="MPBtnWrap MAT10">

			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR")){ %>
				<input type="button" class="btn_inp_b_01 FloatR" value="수정" onclick="goSubmit('edit')"/>
			<%}%>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")){ %>
				<input type="button" class="btn_inp_w_01 FloatR" value="삭제" onclick="goSubmit('del')"/>
			<%} %>
				<input type="button" class="btn_inp_b_01 FloatL" value="목록" onclick="goSubmit('list')"/>

		</div>
		
	</div>
	<!--basic_viewWrap E-->

</form>




<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode){
		//삭제버튼 클릭할때 실행
		if(mode == 'del'){

			if (confirm("정말 삭제하시겠습니까??") == true){ //확인
				$('#mode').val(mode);
				$('#fview').submit();
			}else{ //취소
			    return;
			}

		}

		$('#mode').val(mode);
		$('#fview').submit();
	}

	function editCmt(no) {
		$("#comment"+no).hide();
		$("#udtTag"+no).hide();
		$("#delTag"+no).hide();
		$("#saveTag"+no).show();
		$("#cancleTag"+no).show();
		$("#commentUdtInput"+no).show()
	}

	function editCmtProc(idx, no) {
		$("#mode").val("editcmt");
		$("#cmtIdx").val(idx);
		$("#editComment").val($("#commentUdtInput"+no).val());
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

	function cancleEdit(no) {
		$("#saveTag"+no).hide();
		$("#cancleTag"+no).hide();
		$("#commentUdtInput"+no).hide()
		$("#udtTag"+no).show();
		$("#delTag"+no).show();
		$("#comment"+no).show();
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

	$(document).ready(function() {
		$("#inpCmtNot").click(function() {
			alert("등록 권한이 부족합니다.");
			return false;
		});
	});
//]]>	
</script>