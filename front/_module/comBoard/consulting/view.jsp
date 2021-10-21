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

	String pageMode = util.getStr(paramMap.get("pageMode"));

	String actionString = "sub.do";
	if( pageMode.matches(".*advice_.*") ){
		actionString = pageMode+".do";
	}
%>

<form name="fview" id="fview" action="<%=actionString %>" method="post" >

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

	<div class="basic_viewWrap">

		<div class="mp_bbsTop">
	
			<h3 class="title"><%=util.getStr(dataMap.get("SUBJECT")) %></h3>
			<div class="mp_bbsTxt">
				<% if( util.loginCheck() && loginVO.getUserId().equals(dataMap.get("WRITER_ID")) 
					||  util.getStr(loginVO.getProJeinet()).equals("Y") 
					||  util.getStr(loginVO.getProJipbank()).equals("Y") 
					|| util.getInt(loginVO.getAuthLv()) >= 70 ) { %>
					<div class="mp_bTBox"><b>소속</b>&nbsp;&nbsp;<%=util.getStr(dataMap.get("ORG_GRP_NM")) %></div>
					<div class="mp_bTBox"><b>직위</b>&nbsp;&nbsp;<%=util.getStr(dataMap.get("POSITION_NM")) %></div>
					<div class="mp_bTBox"><b>전화번호</b>&nbsp;&nbsp;<%=util.getStr(dataMap.get("TEL_NO")) %></div>
					<div class="mp_bTBox"><b>이메일</b>&nbsp;&nbsp;<%=util.getStr(dataMap.get("EMAIL")) %></div>
				<% } %>
					<div class="mp_bTBox"><b>작성자</b>&nbsp;&nbsp;<%=util.getStr(dataMap.get("PSN_NM")) %></div>
			 		<div class="mp_bTBox"><b>작성일</b>&nbsp;&nbsp;<%=util.getStr(dataMap.get("FRST_REGIST_PNTTM"))%></div>
			</div>
			
			<%if(boardComIdx.equals("00011")|| boardComIdx.equals("00026")) { %>
			<div class="head_text" style="border-top: 1px solid #cccccc; width:97%;">
				<%=util.getStr(dataMap.get("NAME01")) %> > <%=util.getStr(dataMap.get("NAME02")) %> > <%=util.getStr(dataMap.get("NAME03")) %>
			</div>
			<% } %>
		
		</div>

		<div class="mp_bbsCont">
			<div class="mp_bCInfo">상담내용</div>
			<%=dataMap.get("CONTENT").replaceAll("<br>", "<br/>")%>
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
						<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="첨부파일 다운로드"><img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="max-width:450px;padding:10px"/>
							(<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)
						</a>
					</li>
				<% fileCnt++; }%>
			</ul>
			<%} %>
		</div>
		
		<div class="basic_viewWrap MAT10">
		
		
			<div class="mp_replBox">
				<%if(cmtMap.size() > 0) {%>
				
					<%
					int no = 0;
					for(HashMap rs:cmtMap) {
					%>
						<div class="replTxtBox01">
							<div class="name"><%=util.getStr(rs.get("REG_USER_NM")) %></div>
							<div class="date"><%=datef.format(rs.get("REG_DT")) %></div>
						</div>
						
						<div class="replTxtBox02 MAT20" id="commentDiv">
						
							<span id="comment<%=no%>"><%=util.getStr(rs.get("CMT_CONTENT")).replaceAll("\n", "<br/>") %></span>
							
							<textarea title="의견 내용 입력창" id="editComment" name="editComment" style="display:none;"></textarea>
							<textarea title="의견 내용 입력창" id="commentUdtInput<%=no%>" name="commentUdtInput<%=no%>" style="display:none"><%=util.getStr(rs.get("CMT_CONTENT")) %></textarea>
							<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
							<div class="edt_btn_box MAT10" style="float: right;">
								<%if(util.loginCheck() && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
								( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(rs.get("ORG_GRP_CD"))) )||
								loginVO.getUserId().equals(rs.get("REG_ID"))   ) ){ %>
									<a id="udtTag<%=no%>" onclick="editCmt('<%=no%>')" style="cursor:pointer; display:">수정</a>
									<a id="udtTag<%=no%>" onclick="editCmt('<%=no%>')" style="cursor:pointer; display:">수정</a>
								<%}%>
								<%
								int cmtDelLv = Integer.parseInt(util.getStr(boardMap.get("PERM_LVL_CMT_DEL")));
								if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= cmtDelLv && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
								( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(rs.get("ORG_GRP_CD"))) )||
								loginVO.getUserId().equals(rs.get("REG_ID"))   ) ){ %>
								<a id="delTag<%=no%>" href="#" style="cursor:pointer; display:" onclick="delCmt('<%=util.getStr(rs.get("CMT_IDX")) %>')" >삭제</a>						
								<%}%>
								<a id="saveTag<%=no%>" href="#" style="display:none" onclick="editCmtProc('<%=util.getStr(rs.get("CMT_IDX")) %>',<%=no%>)" >저장</a>
								<a id="cancleTag<%=no%>" style="cursor:pointer; display:none" onclick="cancleEdit('<%=no%>')" >취소</a>
							</div>
							<%} %>
							
						</div>
					<%
					no++;
					} %>
					
				<% } %>
			</div>
			
			
			
			<%if( util.loginCheck() && loginVO.getUserId().equals(dataMap.get("WRITER_ID")) ||  util.getStr(loginVO.getProJeinet()).equals("Y") ||  util.getStr(loginVO.getProJipbank()).equals("Y") || util.getInt(loginVO.getAuthLv()) >= 70 ) { %>
					
			<tr>
				<td class="r_line_none" colspan="2">
					<%if(util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { %>
					<div class="mp_replBox">
						<textarea title="의견 내용 입력창" rows="5" name="comment" cols="1"></textarea>
						<%if(util.loginCheck() && loginVO.getUserId().equals(dataMap.get("WRITER_ID")) || util.getInt(loginVO.getAuthLv()) >= 70) { %>
						<button type="button" id="inpCmt" class="btn_add">등록</button>
						<% } else { %>
						<button type="button" id="inpCmtNot" class="btn_add">등록</button>
						<% } %>
					</div>
					<% } %>
				</td>
			</tr>
			
			<% } %>
			
			

			<div class="MPBtnWrap MAT10">
				<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
					( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(dataMap.get("ORG_GRP_CD"))) )||
					loginVO.getUserId().equals(dataMap.get("WRITER_ID"))   ) ){ %>
					<input type="button" class="btn_inp_b_01 FloatR" value="수정" onclick="goSubmit('edit')"/>
				<%}%>
				<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL") && ( util.getStr(loginVO.getAuthLv()).equals("99") ||
					( util.getStr(loginVO.getAuthLv()).equals("80") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(dataMap.get("ORG_GRP_CD"))) )||
					loginVO.getUserId().equals(dataMap.get("WRITER_ID"))   ) ){ %>
					<input type="button" class="btn_inp_w_01 FloatR" value="삭제" onclick="goSubmit('del')" />
				<%}%>
					<input type="button" class="btn_inp_b_01 FloatL" value="목록" onclick="goSubmit('list')"/> 
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
			
			<% if( !pageMode.matches(".*advice_.*") ){ %>
			$('.b_txtbox4').css('width','630px');	
			<% }else{ %>
			$('.b_txtbox4').css('width','500px');
			<% } %>
			
		}else if(win_w < 768){ //모바일 769 이하일때 100% 
			$('.b_txtbox4').css('width','65%');

			
		}else{ //기본사이즈
			//
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');	

		
		}
		
	}
//]]>


</script>