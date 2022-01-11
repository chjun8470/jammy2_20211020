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
			<table class="skin_basic_write" summary="작성하기로  제목, 태그, 첨부파일, 시스템설명(툴팁)을 제공합니다.">
				<caption>전문가등록</caption>
                     <colgroup>
                           <col width="14%" />
                           <col width="36%" />
                            <col width="14%" />
                           <col width="36%" />
                     </colgroup>
                     <tbody>
                     	<tr>
                    		<th scope="row" class="tit" colspan="4">
                    			<label for="userInfo">기본정보</label>
                    		</th>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit">
                    			<label for="name">이름</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA01")) %>
                    		</td>
                    		<th scope="row" class="tit">
                    			<label for="birthday">출생연도</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA02")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit">
                    			<label for="nationality">국적</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA03")) %>
                    		</td>
                    		<th scope="row" class="tit">
                    			<label for="homePage">홈페이지</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA04")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit">
                    			<label for="affiliation">소속</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA05")) %> <%=util.getStr(dataMap.get("DATA06")) %>
                    		</td>
                    		<th scope="row" class="tit">
                    			<label for="position">직급</label>
                    		</th>
                    		<td>
                    			<%=util.getStr(dataMap.get("DATA07")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit">
                    			<label for="position_field">전문분야</label>
                    		</th>
                    		<td colspan="3">
                    			<%=util.getStr(dataMap.get("DATA08")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit" colspan="4">
                    			<label for="academic_career">학력</label>
                    		</th>
                    	</tr>
  						<tr>
                    		<td colspan="4">
                    			<%=util.getStr(dataMap.get("TEXT1")) %>
                    		</td>
                    	</tr>
                    	<tr>
                    		<th scope="row" class="tit" colspan="4">
                    			<label for="career">경력</label>
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
			<%} %>
					<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
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