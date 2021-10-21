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
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String tab = util.getStr(paramMap.get("tab"));
	String auth_lv = util.getStr(paramMap.get("auth_lv"));
	String tabApp = util.getStr(paramMap.get("tabApp"));
	String sttus = util.getStr(paramMap.get("sttus"));
	String userId = util.getStr(paramMap.get("userId"));
	String siteId = util.getStr(paramMap.get("siteId"));
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
	  <form name="fview" id="fview" action="./sub.do" method="post" >

	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="m" value="<%=m%>" />
	  	<input type="hidden" name="tab" id="tab"  value="<%=tab%>" />
	  	<input type="hidden" name="boardIdx" id="boardIdx"  value="<%=boardIdx%>" />
	  	<input type="hidden" name="boardComIdx" id="boardComIdx"  value="<%=boardComIdx%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="/<%=siteId%>/sub.do?m=<%=m%>&boardComIdx=<%=boardComIdx%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="searchType" id="searchType" value="<%=util.getStr(paramMap.get("searchType")) %>" />
		<input type="hidden" name="searchWold" id="searchWold" value="<%=util.getStr(paramMap.get("searchWold")) %>" />
		<input type="hidden" name="auth_lv" id="auth_lv"  value="<%=auth_lv%>" />
		<input type="hidden" name="tabApp" id="tabApp" value="<%=tabApp%>" />
		<input type="hidden" name="sttus" id="sttus" value="<%=sttus%>" />
		<input type="hidden" name="userId" id="userId" value="<%=userId%>" />
		<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
		<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />

<div class="basic_viewWrap">

<table class="skin_view" summary="일반게시판의 게시글 보기로 제목, 등록일, 조회, 첨부파일으로 구성되어 있습니다.">
  <caption>제목, 등록일, 조회, 첨부파일로 구성된 표입니다.</caption>
    <colgroup>
      <col style="width:15%;" />
      <col style="width:35%;" />
      <col style="width:15%;" />
      <col style="width:35%;" />
    </colgroup>

<thead>
  <tr>
    <th scope="col">제목</th>
    <td class="r_line_none b_notice" colspan="3"><%=util.getStr(dataMap.get("SUBJECT")) %></td>
  </tr>
</thead>
<tbody>
  <tr>
    <th scope="col">등록일</th>
    <td><%=String.valueOf(dataMap.get("FRST_REGIST_PNTTM")).split(" ")[0] %></td>
				<th scope="col" class="lft_line">조회</th>
				<td class="r_line_none"><%=util.getIntStr(dataMap.get("HITS")) %></td>
			</tr>
			<tr>
				<th scope="col">첨부파일</th>
				<td class="r_line_none" colspan="3">
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
									<li class="text" >
										<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte) </a>
		<%-- 									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
									</li>
								<% fileCnt++; }%>
								</ul>
							<%} %>

				</td>
			</tr>
			<tr>
	              <th scope="col">구글 설문조사 URL</th>
	              <td  class="r_line_none" colspan="3">
	              	<a href="<%=util.getStr(dataMap.get("DATA01")) %>" target="_blank" ><%=util.getStr(dataMap.get("DATA01")) %></a>
	              </td>
	            </tr>
	            <tr>
	              <th scope="col">회신처</th>
	              <td  class="r_line_none" colspan="3">
	              	FAX : <%=util.getStr(dataMap.get("DATA03")) %><br/>
	              	EMAIL : <%=util.getStr(dataMap.get("DATA02")) %>

	              </td>
	            </tr>
	            <tr>
	              <th scope="col">기간</th>
	              <td  class="r_line_none" colspan="3">
	              	<%=util.getStr(dataMap.get("DATA04")) %> ~ <%=util.getStr(dataMap.get("DATA05")) %>
	              </td>
	            </tr>
	            <tr>
	              <th scope="col">기관명</th>
	              <td  class="r_line_none" colspan="3"><%=util.getStr(dataMap.get("DATA06")) %></td>
	            </tr>
	            <tr>
	              <th scope="col">응답대상자</th>
	              <td  class="r_line_none" colspan="3"><%=util.getStr(dataMap.get("DATA07")) %></td>
	            </tr>
	            <tr>
	              <th scope="col">내용</th>
	              <td class="r_line_none view_cont" colspan="4" style="height:300px;">
					<%=dataMap.get("CONTENT") %>
	              </td>
	            </tr>

		</tbody>
	        </table>

		<br/>
		<!--댓글  -->
		<div>
			<%if(cmtMap.size() > 0) {%>
			<input type="hidden" name="cmtIdx" id="cmtIdx"/>
			<table style="width:100%;">
				<colgroup>
					<col style="width:15%;" />
					<col style="width:55%;" />
					<col style="width:15%;" />
					<col style="width:15%;" />
				</colgroup>
				<%
					int no = 0;
					for(HashMap rs:cmtMap) {
				%>
					<tr id="cmt<%=no%>" >
						<th><%=util.getStr(rs.get("REG_USER_NM")) %></th>
						<td><%=util.getStr(rs.get("CMT_CONTENT")) %></td>
						<td style="text-align: center;"><%=util.getStr(rs.get("REG_DT")) %></td>
						<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
						<td>
							<input type="button" value="삭제" style="width:30%; height:30px; margin-left:10px;" onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %>)">
						</td>
						<% } %>
					</tr>
				<%
					no++;
					} %>
			</table>
			<%} %>
		</div>
		<div class="b_btn_area">
		<%if(util.getStr(boardMap.get("PERM_CMT")).equals("Y") && loginVO.getUserIdx()!=null){ %>
			<textarea rows="5" name="comment" class="b_txtbox4" style="width:88%;min-height:20px; height:78px;"></textarea>
			<button type="button" id="inpCmt" class="btn_rgt2" style="float:right;width:80px;height:80px">등록</button>
		<% }%>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR")){ %>
				<input type="button" class="btn_rgt" value="수정" onclick="pageEditGo()"/>
			<% }%>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")){ %>
			<span>
				<input type="button" class="btn_rgt" value="삭제" onclick="pageDelGo()"/>
			</span>
			<% }  %>
			<input type="button" class="btn_lft2" value="목록" onclick="pageListGo()"/>
		</div>
	</div>
</form>

<script type="text/javascript">
//<![CDATA[
	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}
	function pageDelGo(){
		$('#mode').val('del');
		$('#fview').submit();
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}
	//댓글
	function editCmt(no, idx, cmt) {
		$("#cmt"+no).hide();
		var tag = "<tr id='editcmt"+no+"'>";
		tag += "<td colspan='3'><textarea rows='5' cols='10' name='editComment'id='editComment' style='resize:none; width:100%; height:45px;'>"+ cmt +"</textarea></td>";
		tag += "<td colspan='1' style='padding-left:30px;'><button type='button' style='width:40%; height:50px; margin-left:10px;' onclick='editCmtProc("+idx+")'>수정</button>"
		tag += "<button type='button' style='width:40%; height:50px; margin-left:10px;' onclick='cancleEdit("+ no +","+ idx +")'>취소</button></td>";
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
				url:"/web/comBoard.do",
				data:formData,
				type:"POST",
				success:function(data){
					alert("등록되었습니다");
					window.location.reload();
				}
			});
		});
	}); //댓글 end
	

	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});

	function winResize(){
		var win_w = $(window).width();
		
		
		//$('.view_cont img').css("width","100%");
		$('.b_btn_area .btn_lft2').css("margin-top","10px");
		$('.b_btn_area .btn_rgt2').css("margin-top","10px");
		$('.b_btn_area .btn_rgt').css("margin-top","10px");
		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
//			$('.tabBox_pub ul li').css("width","22%");
			$('.b_btn_area .b_txtbox4').css("width","85%");
			$('#inpCmt').css("width","80px");
			$('#inpCmt').css("height","80px");
			$('.b_btn_area').css("height","31px");
			$('#inpCmt').css("margin-top","");
		}else if(win_w < 768){ //모바일 769 이하일때 100%
			$('.b_btn_area .b_txtbox4').css("width","100%");
			$('#inpCmt').css("width","50px");
			$('#inpCmt').css("height","30px");
			$('.b_btn_area').css("height","100px");
			
		}else{ //기본사이즈
			$('.b_btn_area .b_txtbox4').css("width","88%");
			$('#inpCmt').css("margin-top","");
		}
		
	}
//]]>
</script>