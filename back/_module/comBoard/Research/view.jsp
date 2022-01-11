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
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String tab = util.getStr(paramMap.get("tab"));
	String auth_lv = util.getStr(paramMap.get("auth_lv"));
	String userId = util.getStr(paramMap.get("userId"));
	String sttus = util.getStr(paramMap.get("sttus"));


	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);
%>
<style type="text/css" scoped>
      a:link {color: blue; text-decoration: none;}
      a:visited {color: purple; text-decoration: none;}
      a:hover {color: red; text-decoration: underline;}
      a:active {color: white; background-color: green;}
</style>
<%
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

	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="boardIdx" id="boardIdx"  value="<%=boardIdx%>" />
	  	<input type="hidden" name="boardComIdx" id="boardComIdx"  value="<%=boardComIdx%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>?boardComIdx=<%=boardComIdx%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="searchType" id="searchType" value="<%=util.getStr(paramMap.get("searchType")) %>" />
		<input type="hidden" name="searchWold" id="searchWold" value="<%=util.getStr(paramMap.get("searchWold")) %>" />
		<input type="hidden" name="tab" id="tab"  value="<%=tab%>" />
		<input type="hidden" name="auth_lv" id="auth_lv"  value="<%=auth_lv%>" />
		<input type="hidden" name="userId" id="userId"  value="<%=userId%>" />
		<input type="hidden" name="sttus" id="sttus" value="<%=sttus%>" />
	<input type="hidden" name="searchType" id="searchType" value="<%=searchType%>" />
	<input type="hidden" name="searchWord" id="searchWord" value="<%=searchWord%>" />


	<div class="skin_bbs_veiw" style="margin-top:30px;">

		<div class="bbs_head">

			<h3 class="title"><%=util.getStr(dataMap.get("SUBJECT")) %></h3>
			<div class="head_text">
			글쓴이 :  <%=util.getStr(dataMap.get("WRITER_ID")) %>
			 | <%=String.valueOf(dataMap.get("FRST_REGIST_PNTTM")).split(" ")[0] %>
			 | 조회 : <%=util.getIntStr(dataMap.get("HITS")) %>
			 | 승인 상태 : <%if(util.getStr(dataMap.get("DATA15")).equals("1")){%>
						요청
						<%}else if(util.getStr(dataMap.get("DATA15")).equals("2")){ %>
						승인
						<%}else if(util.getStr(dataMap.get("DATA15")).equals("3")){ %>
						반려
						<%} %>
			</div>
		</div>
<table class="skin_basic_write">
	          <caption>
	          작성하기
	          </caption>
	          <colgroup>
	          <col style="width:140px;" />
	          <col style="width:*;" />
	          </colgroup>
	          <tbody>
	            <tr>
	              <th scope="row" class="tit">사이트</th>
	              <td>
	              		<%=util.getStr(dataMap.get("SITE_ID")) %>
	              </td>
	            </tr>
			<tr>
	              <th scope="row" class="tit">구글 설문조사 URL</th>
	              <td>
	              	<a href="<%=util.getStr(dataMap.get("DATA01")) %>" target="_blank" style="active=color : blue; font-size: 9pt};" ><%=util.getStr(dataMap.get("DATA01")) %></a>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">회신처</th>
	              <td>
	              	FAX : <%=util.getStr(dataMap.get("DATA03")) %><br/>
	              	EMAIL : <%=util.getStr(dataMap.get("DATA02")) %>

	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">기간</th>
	              <td>
	              	<%=util.getStr(dataMap.get("DATA04")) %> ~ <%=util.getStr(dataMap.get("DATA05")) %>
	              </td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">기관명</th>
	              <td><%=util.getStr(dataMap.get("DATA06")) %></td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">응답대상자</th>
	              <td><%=util.getStr(dataMap.get("DATA07")) %></td>
	            </tr>
	            <tr>
	              <th scope="row" class="tit">내용</th>
	              <td style="height:300px;">
					<%=dataMap.get("CONTENT")%>
	              </td>
	            </tr>
	            <%if((util.getStr(dataMap.get("DATA15"))).equals("3")){%>
	            <tr>
	              <th scope="row" class="tit">반려 사유</th>
	              <td style="height:100px;">
					<%=util.getStr(dataMap.get("DATA16")) %>
	              </td>
	            </tr>
	            <%} %>
		</tbody>
	        </table>


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
										<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.getStr(rs.get("TITLE")) %> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte) </a>
		<%-- 									<%=util.deStr(rs.get("FILE_ORGN_NM"))%> (<%=util.getStr(rs.get("FILE_SIZE"))%> Byte) --%>
									</li>
								<% fileCnt++; }%>
								</ul>
							<%} %>

		</div>
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
					<tr id="cmt<%=no%>">
						<th><%=util.getStr(rs.get("REG_USER_NM")) %></th>
						<td><%=util.getStr(rs.get("CMT_CONTENT")) %></td>
						<td style="text-align: center;"><%=util.getStr(rs.get("REG_DT")) %></td>
						<%if(util.getStr(rs.get("REG_ID")).equals(loginVO.getUserId())) { %>
						<td>
							<input type="button" value="수정" style="width:30%; height:30px; margin-left:10px;" onclick="editCmt(<%=no%>, <%=util.getStr(rs.get("CMT_IDX"))%>, '<%=util.getStr(rs.get("CMT_CONTENT")) %>')" >
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
		<%if(util.getStr(boardMap.get("PERM_CMT")).equals("Y")) { %>
			<div style="margin-top:5px;">
				<textarea rows="5" cols="10" name="comment" style="resize:none; width:88%;"></textarea>
				<span><button type="button" id="inpCmt" style="float:right;width:80px;height:80px">등록</button></span>
			</div>
		<% } %>
		<!--댓글 end  -->

		<div class="btn_box">
			<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99 && Integer.parseInt(util.getStr(dataMap.get("DATA15"))) == 1){%>
					<input type="button" class="btn_inp_g_01" value="승인" onclick="goSubmit('2','apvProc')"/>
					<input type="button" class="btn_inp_g_01" value="반려" onclick="goPopup()"/>
			<%}%>
				<div class="btn_right_box" style="text-align: right;">
			<% HashMap<String, String> aticleDataMap = request.getAttribute("aticleDataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("aticleDataMap"); %>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && util.getStr(loginVO.getAuthLv()).equals("99")
				|| util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"EDITOR") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(aticleDataMap.get("ORG_GRP_CD")))
				|| util.loginCheck() && util.getStr(loginVO.getUserId()).equals(util.getStr(dataMap.get("WRITER_ID"))) ){ %>
					<input type="button" class="btn_inp_b_01" value="수정" onclick="pageEditGo()"/>
			<%}%>
			<%if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL")  && util.getStr(loginVO.getAuthLv()).equals("99")
				|| util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"DEL") && util.getStr(loginVO.getOrgGrpCd()).equals(util.getStr(aticleDataMap.get("ORG_GRP_CD")))
				|| util.loginCheck() && util.getStr(loginVO.getUserId()).equals(util.getStr(dataMap.get("WRITER_ID"))) ){ %>
					<input type="button" class="btn_inp_b_01" value="삭제" onclick="pageDelGo()"/>
			<%} %>
					<input type="button" class="btn_inp_w_01" value="목록" onclick="pageListGo()"/>
				</div>
		</div>
	</div>
	<!-- 반려 사유 입력 레이어 팝업 S -->
		<div id="ligth_box" style="filter: alpha; opacity: 0.5; -moz-opacity: 0.75; background-color: black; position: fixed; top: 0; left: 0; width: 100%; height: 100%; z-index: 200; display: none;"></div>
		<div id="reject_input" style="position:fixed; top:50%; left:30%; height:250px; width:500px; background-color:lightblue; display: none; text-align: center; ">
			<h2 >반려사유</h2>
			<textarea class="inp_tarea" id="returnCn" name="returnCn" rows=9 style="width: 95%;"></textarea>
			<input type="button" class="btn_inp_b_01" id="reject_inp_btn" name="reject_inp_btn" value="입력" onclick="goReturn('companionProc','3')" />
			<input type="button" class="btn_inp_w_01" value="취소"  onclick="lightBoxClose('reject_input')" />
		</div>
	<!-- 반려 사유 입력 레이어 팝업 E -->

</form>

<script type="text/javascript">
	function goSubmit(no,mode){
		$('#sttus').val(no);
		$('#mode').val(mode);
		$('#fview').submit();
	}
	function goPopup(){
		lightBoxShow('reject_input');
	}
	function goReturn(mode,no){
		$('#sttus').val(no);
		$('#mode').val(mode);
		$('#fview').submit();
	}
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
				url:"/sys/comBoard.do",
				data:formData,
				type:"POST",
				success:function(data){
					alert("등록되었습니다");
					window.location.reload();
				}
			});
		});
	}); //댓글 end

</script>