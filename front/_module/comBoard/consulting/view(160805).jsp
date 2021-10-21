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

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "consulting";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String m = util.getStr(paramMap.get("m"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String state = util.getStr(paramMap.get("DATA04"));
	LoginVO loginVO = util.getLoginInfo(request);

	SimpleDateFormat datef = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

%>

	<form name="fview" id="fview" action="sub.do" method="post" >
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="reUrl" id="reUrl" value="?m=<%=m%>&amp;boardComIdx=<%=boardComIdx%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
		<input type="hidden" name="m"  value="<%=m%>" />
		<input type="hidden" name="cmtIdx" id="cmtIdx" />
		<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
		<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
		<input type="hidden" name="state" id="state" value="<%=state%>" />

	<div class="skin_bbs_veiw" style="margin-top:30px;">

		<div class="bbs_head">

			<h3 class="title"><%=util.getStr(dataMap.get("SUBJECT")) %></h3>
			<div class="head_text" style="text-align: right; width: 97%;">
			작성자 :  <%=util.getStr(dataMap.get("WRITER_ID")) %>
			 | 작성일 : <%=util.getStr(dataMap.get("FRST_REGIST_PNTTM"))%>
			</div>
		<%if(boardComIdx.equals("00011")|| boardComIdx.equals("00026")) { %>
		<div class="head_text" style="border-top: 1px solid #cccccc; width:97%;"><%=util.getStr(dataMap.get("NAME01")) %> > <%=util.getStr(dataMap.get("NAME02")) %> > <%=util.getStr(dataMap.get("NAME03")) %></div>
		<% } %>
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
			<%-- <%if(cmtMap.size() > 0) {%>

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
					<tr id="cmt<%=no%>" >
						<th><%=util.getStr(rs.get("REG_USER_NM")) %></th>
						<td id="comment<%=no %>"><%=util.getStr(rs.get("CMT_CONTENT")).replaceAll("\n", "<br/>") %></td>
						<td style="text-align: center;"><%=datef.format(rs.get("REG_DT")) %></td>
						<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
						<td>
							<a style="cursor: pointer;" onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>)">수정</a>
							<a style="margin-left:5px; cursor: pointer;" onclick="delCmt(<%=util.getStr(rs.get("CMT_IDX")) %>)">삭제</a>
						</td>
						<% } %>
					</tr>
				<%
					no++;
					} %>
			</table>
			<%} %> --%>
	<table class="P_contBox2" summary="특허검색 게시판의 보기 게시판으로 의견남기기, 대표 이미지로 구성되어 있습니다.">
		<caption>의견남기기, 대표 이미지로 구성된 표입니다.</caption>
		<colgroup>
			<col style="width:65%;" />
			<col style="width:35%;" />
		</colgroup>

		<tbody>
			<tr>
				<td class="jip_info2 r_line_none" colspan="2">
				<div class="ideaBox" style="width: 100%;">
					<%if(cmtMap.size() > 0) {%>
					<ul class="idea_list" style="display:">
					<%
					int no = 0;
					for(HashMap rs:cmtMap) {
					%>

						<li>
							<div class="idea_name"><%=util.getStr(rs.get("REG_USER_NM")) %></div>
							<div class="idea_date"><%=datef.format(rs.get("REG_DT")) %></div>
							<div class="idea_txt" id="commentDiv" style="display:"><span id="comment<%=no%>"><%=util.getStr(rs.get("CMT_CONTENT")).replaceAll("\n", "<br/>") %></span>
							<textarea id="editComment" name="editComment" style="display:none;"></textarea>
							<textarea id="commentUdtInput<%=no%>" name="commentUdtInput<%=no%>" style="display:none" class="input_idea"><%=util.getStr(rs.get("CMT_CONTENT")) %></textarea>
								&nbsp;
								<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
								<div style="float: right;">
									<a id="udtTag<%=no%>" onclick="editCmt('<%=no%>')" style="cursor:pointer; display:">수정</a>
									<a id="delTag<%=no%>" href="#" style="cursor:pointer; display:" onclick="delCmt('<%=util.getStr(rs.get("CMT_IDX")) %>')" >삭제</a>
									<a id="saveTag<%=no%>" href="#" style="display:none" onclick="editCmtProc('<%=util.getStr(rs.get("CMT_IDX")) %>',<%=no%>)" >저장</a>
									<a id="cancleTag<%=no%>" style="cursor:pointer; display:none" onclick="cancleEdit('<%=no%>')" >취소</a>
								</div>
								<%} %>
							</div>
						</li>
					<%
					no++;
					} %>
					</ul>
				<% } %>
				</div>
				</td>
			</tr>
			<tr>
				<td class="r_line_none" colspan="2">
				<%if(util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { %>
					<div style="margin-bottom:20px;">
						<textarea rows="5" name="comment" class="b_txtbox4" style="width:88%; min-height:20px; height:78px; resize: none;" cols="1"></textarea>
						<span>
						<%if(util.loginCheck() && loginVO.getUserId().equals(dataMap.get("WRITER_ID")) || util.getInt(loginVO.getAuthLv()) >= 70) { %>
						<button type="button" id="inpCmt" class="btn_rgt" style="float:right;width:80px;height:80px">등록</button>
						<% } else { %>
						<button type="button" id="inpCmtNot" class="btn_rgt" style="float:right;width:80px;height:80px">등록</button>
						<% } %>
						</span>
					</div>
				<% } %>
				
				</td>
			</tr>
		</tbody>
	</table>

		<div class="b_btn_area">
		
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR")){ %>
				<input type="button" class="btn_rgt" value="수정" onclick="goSubmit('edit')"/>
			<%}%>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")){ %>
				<input type="button" class="btn_rgt" value="삭제" onclick="goSubmit('del')"/>
			<%} %>
				<input type="button" class="btn_lft2" value="목록" onclick="goSubmit('list')"/>
		</div>
	</div>
</div>
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
	
	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});
	
	function winResize(){
		var win_w = $(window).width();
		
		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
		
			$('.b_txtbox4').css('width','84%');	

			
		}else if(win_w < 768){ //모바일 769 이하일때 100% 
			$('.b_txtbox4').css('width','84%');

			
		}else{ //기본사이즈
			//
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');	

		
		}
		
	}
//]]>


</script>