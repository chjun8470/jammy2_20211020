<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> noticeList = request.getAttribute("noticeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("noticeList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String noticeYn = util.getStr(boardMap.get("PERM_NOTICE"));

	if((util.getBbsAuth(loginVO,boardMap,"LIST")).equals(false)){
%>
	<script type="text/javascript" >
		alert("????????? ???????????????.");
		history.back(-1); //??????????????????
	</script>
<%
		return;
	}
%>

<div class="skin_list">
	<div>
		<form action="./<%=myPage%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="<%=boardComIdx%>" />


			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<!-- ?????????????????? -->
					<select name="searchType" id="searchType" class="select" style="height: 24px">
						<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
						<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
						<option value="WRITER" <%if("WRITER".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
					</select>

					<!-- ????????? -->
					<input class="board-input" type="text" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:300px; height:20px" />

					<!-- ???????????? -->
					<input type="button" class="btn_inp_g_01" value="??????" onclick="goSubmit('list')" style="float:right"/>
				</div>
				<!-- board-search e -->
				</div>
				</div>
			</div>
			<!-- bbs-top e -->

			<div class="total" style="float:left; text-align:left; vertical-align:middle; margin:10px; padding:2px;">
				[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>

		</form>
		<!-- searchForm e -->

		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 45%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>

				<%
					if(noticeYn.equals("Y")){
					if(noticeList.size() == 0){
				%>
					<tr><td colspan="7">????????? ????????????  ????????????</td></tr>
				<%
					}

						for(HashMap rs:noticeList) {
				%>
				<tr>
					<td><img src="/img/board/ico_notice.png" alt="?????? ?????????" /></td>
					<td class="subject">
						<a href="#" onclick="goSubmit('noticeView','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>','<%=util.getStr(rs.get("BOARD_ID"))%>')">
							<span style="color:red; font-size:10pt;">[<%=util.getStr(rs.get("SITE_NM"))%>]</span>
							<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
						</a>
					</td>
					<td>
						<%=util.getStr(rs.get("WRITER_NM"))%>(<%=util.getStr(rs.get("WRITER_ID"))%>)
					</td>
					<td>
						<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
					</td>
					<td>
						<%=util.getStr(String.valueOf(rs.get("HITS")))%>
					</td>
					<td class="r_line_none file">
					<%if(!(util.getStr(rs.get("FILE_ID"))).equals(null) && !(util.getStr(rs.get("FILE_ID"))).equals("")){
						String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
											+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
											+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
                    	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src="/img/board/ico_file.png" alt="???????????? ?????????" /></a>
                    <%}%>
					</td>
				</tr>
				<%
						}
					}
				%>

				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

					if(dataList.size() == 0){
				%>
					<tr><td colspan="6">???????????? ???????????? ????????????</td></tr>
				<%
					}

					for(HashMap rs:dataList) {
				%>
				<tr>
					<td><%=cont%></td>
					<td class="subject">

						<%if(util.getStr(rs.get("SECRET_AT")).equals("Y")){ //????????? ??????

							if(util.getStr(rs.get("WRITER_ID")).equals(loginVO.getUserId()) || util.getBbsAuth(loginVO,boardMap,"READ")){ //????????? ?????????
						%>
								<a href="#" onclick="goSubmit('view','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>')">
									<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
								</a>
								<img src="/img/board/ico_lock.png" alt="????????? ?????????" style="vertical-align: middle;" />
						<%
						  	}else{ //????????? ?????????
						%>
								<span onclick="sCheck()"><%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%></span>
								<img src="/img/board/ico_lock.png" alt="????????? ?????????" style="vertical-align: middle;" />
						<%
						  	}

						}else{ //????????? ?????????
						%>
							<a href="#" onclick="goSubmit('view','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>')">
								<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" ?? ?? ?? "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
							</a>
						<%}%>

					</td>

					<td>
						<%=util.getStr(rs.get("WRITER_NM"))%>(<%=util.getStr(rs.get("WRITER_ID"))%>)
					</td>
					<td>
						<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
					</td>
					<td>
						<%=util.getStr(String.valueOf(rs.get("HITS")))%>
					</td>
					<td class="r_line_none file">
						<%if(!(util.getStr(rs.get("FILE_ID"))).equals(null) && !(util.getStr(rs.get("FILE_ID"))).equals("")){
						String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
											+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
											+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
                    	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src="/img/board/ico_file.png" alt="???????????? ?????????" /></a>
                    <%}%>
					</td>
				</tr>
				<% cont--; } %>
			</tbody>
		</table>

		<div class="btn_box">
			&nbsp;
			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
			<div class="btn_right_box">
					<input type="button" class="btn_inp_b_01" value="??????" onclick="goSubmit('write')"/>
			</div>
			<% } %>
		</div>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,boardIdx,boardComIdx){


		if(mode == "noticeView"){
			$('#boardComIdx').val(boardComIdx);
		}
		$('#boardIdx').val(boardIdx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}

	function sCheck(){
		alert("??? ?????? ??????????????????.");
	}
</script>