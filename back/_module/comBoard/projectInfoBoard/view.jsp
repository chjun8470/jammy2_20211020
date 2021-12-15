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
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	ArrayList<HashMap<String, String>> cmtMap = request.getAttribute("cmtMap") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("cmtMap");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "board";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request);
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String searchReceipt = util.getStr(paramMap.get("searchReceipt"));
	
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));

	/* 접수전, 접수중, 접수마감 색상코드*/
	String bgColor = "";
	if(util.getStr(dataMap.get("RECEIPT_NM")).equals("접수전")){
		bgColor = "#FFBB00";
	}else if(util.getStr(dataMap.get("RECEIPT_NM")).equals("접수중")){
		bgColor = "#FFBC9B";
	}else{
		bgColor = "#FAED7D";
	}
	
	/* 승인요청, 승인, 반려 색상코드*/
	String bgColor1 = "";
	String state = "";
	if(util.getStr(dataMap.get("DATA15")).equals("20")){
		bgColor1 = "#73bb1e";
		state ="승인";
	}else if(util.getStr(dataMap.get("DATA15")).equals("30")){
		bgColor1 = "#FFBC9B";
		state ="반려";
	}else{
		bgColor1 = "#FAED7D";
		state ="승인요청";
	}

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

<style>
      a:link {color: blue; text-decoration: none;}
      a:visited {color: purple; text-decoration: none;}
      a:hover {color: red; text-decoration: underline;}
      a:active {color: white; background-color: green;}
</style>

<form name="fview" id="fview" action="<%=myPage%>" method="post" >
	<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />
	<input type="hidden" name="searchReceipt" id="searchReceipt" value="<%=searchReceipt%>" />
	
	<div class="skin_bbs_veiw" style="position:relative; margin-top:30px; width: 1000px;">

		<table class="skin_basic_write">
			<!-- colgroup s -->
			<colgroup>
				<col width="150px" />
				<col width="*" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col" colspan="2">
						<h3 class="title"><%=util.getStr(dataMap.get("SUBJECT")) %></h3>
					</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<tr>
					<th class="tit"><label for="supportType"> 지원사업유형</label></th>
					<td><%=util.getStr(dataMap.get("CODE_NM")) %></td>
				</tr>
				<tr>
					<th class="tit"><label for="state"> 승인상태</label></th>
					<td><span class="btn_y_01" style="cursor:default; background-color:<%=bgColor1%>;"><%=state%></span></td>
					<%-- <td><%=util.setFormatNum(util.getStr(dataMap.get("DATA02")),"comma")%> 원</td> --%>
				</tr>
				<%if(state.equals("반려")){%>				
				<tr>
					<th class="tit"><label for="reason">반려사유</label></th>
					<td><%=util.getStr(dataMap.get("DATA16")) %></td>
					
				</tr>
				<%} %>
				<tr>
					<th class="tit"><label for="proExpense"> 사업비</label></th>
					<td><%=util.getStr(dataMap.get("DATA02")) %>원</td>
					<%-- <td><%=util.setFormatNum(util.getStr(dataMap.get("DATA02")),"comma")%> 원</td> --%>
				</tr>
				<tr>
					<th class="tit"><label for="recDt"> 접수기간</label></th>
					<td>
						<%=util.getStr(dataMap.get("DATA03")) %>&nbsp;~&nbsp;<%=util.getStr(dataMap.get("DATA04")) %>
						<span class="btn_y_01" style="cursor:default; background-color:<%=bgColor%>;"><%=util.getStr(dataMap.get("RECEIPT_NM")) %></span>
						</td>
				</tr>
				<tr>
					<th class="tit"><label for="proDt"> 사업기간</label></th>
					<td>
						<%=util.getStr(dataMap.get("DATA05")) %>&nbsp;~&nbsp;<%=util.getStr(dataMap.get("DATA06")) %>
					</td>
				</tr>
				<tr>
					<th scope="col"> 담당기관/부서</th>
					<td class="r_line_none">
						<%=util.getStr(dataMap.get("DATA07")) %>
					 	<%if(!util.getStr(dataMap.get("DATA08")).equals("")){%>
					 	/ <%=util.getStr(dataMap.get("DATA08")) %></td>
					 	<%}%>
				</tr>
				<tr>
					<th scope="col"> 지원부처</th>
					<td class="r_line_none"><%=util.getStr(dataMap.get("DATA09")) %></td>
				</tr>
				<tr>
					<th class="tit"><label for="proCharge"> 사업담당자</label></th>
					<td class="r_line_none">
					<table style="width: 100%">
					<tr><th>성  명</th><td> <%=util.getStr(dataMap.get("DATA10")) %></td><tr>
					<tr><th>직  위</th><td> <%=util.getStr(dataMap.get("DATA11")) %></td><tr>
					<tr><th>전  화</th><td> <%=util.getStr(dataMap.get("DATA12")) %></td><tr>
					<tr><th>이메일</th><td> <%=util.getStr(dataMap.get("DATA13")) %></td><tr>
					
					</table>
					</td>
				</tr>
				<tr>
					<th class="tit"><label for="proPurpose"> 사업목적</label></th>
					<td><%=util.getStr(dataMap.get("DATA14")) %></td>
				</tr>
				<tr>
					<th class="tit"><label for="contents"> 사업내용</label></th>
						<td>
							<div class="style-init" style="word-break:break-all;">
							<%for(HashMap rs:fileList){
								String ext = util.getStr(rs.get("FILE_EXT")).toLowerCase();
								if("jpg".equals(ext) || "gif".equals(ext) || "png".equals(ext) || "bmp".equals(ext)){
							%>
								<img src="<%=(util.getStr(rs.get("FILE_PATH"))+util.getStr(rs.get("FILE_NM"))) %>" class="img-view" style="max-width:700px;"/>
							<%
								}
							  }
							%>
								<pre><%=dataMap.get("CONTENT").replaceAll("<br>", "<br/>")%></pre>
							</div>
						</td>
				</tr>
			</tbody>
		</table>

		<!-- 첨부파일 -->
		<div style="clear:both;">
			<%if(fileList.size() > 0){%>
				<ul class="file" style="line-height: 22px;">
					<%
						int fileCnt = 1;
						for(HashMap rs:fileList){
						String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
											+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
											+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
					%>
						<li class="text"> 첨부파일 :
                        	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
         					<%--<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte)--%>
                        </li>
					<% fileCnt++; }%>
				</ul>
			<%} %>
		</div>
		<br/>

		<!-- 댓글 -->
		<div class="skin_bbs_veiw">
			<%if(cmtMap.size() > 0) {%>
			<input type="hidden" name="cmtIdx" id="cmtIdx" />
			<table class="skin_basic_write">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: 65%;" />
					<col style="width: 15%;" />
					<col style="width: 10%;" />
				</colgroup>
				<!-- colgroup e -->
				<!-- thead s -->
				<tbody>
				<%
					int no = 0;
					for(HashMap rs:cmtMap) {
				%>
					<tr id="cmt<%=no%>" name="cmt<%=no %>">
						<td><b><%=util.getStr(rs.get("REG_USER_NM")) %></b></td>
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
					}
				%>
				</tbody>
			</table>
            <%} %>
        </div>
        <%if(util.loginCheck() && util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { %>
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
				alert("댓글이 수정되었습니다.");
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
					alert("댓글이 삭제되었습니다.");
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
					alert("댓글이 등록되었습니다.");
					window.location.reload();
				}
			});
		});
	});
</script>