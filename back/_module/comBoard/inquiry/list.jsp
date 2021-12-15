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
	//ArrayList<HashMap<String, String>> noticeList = request.getAttribute("noticeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("noticeList");
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
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
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
					<!-- 검색종류선택 -->
					<select name="searchType" id="searchType" class="select" style="height: 24px">
						<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
						<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
						<option value="WRITER" <%if("WRITER".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>등록자</option>
					</select>

					<!-- 키워드 -->
					<input class="board-input" type="text" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:300px; height:20px" />

					<!-- 검색버튼 -->
					<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('list')" style="float:right"/>
				</div>
				<!-- board-search e -->
				</div>
				</div>
			</div>
			<!-- bbs-top e -->

			<div class="total" style="float:left; text-align:left; vertical-align:middle; margin:10px; padding:2px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
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
					<th scope="col">순번</th>
					<th scope="col">제목</th>
					<th scope="col">등록자</th>
					<th scope="col">등록일</th>
					<th scope="col">조회</th>
					<th scope="col">첨부</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>

				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

					if(dataList.size() == 0){
				%>
					<tr><td colspan="6">데이터가 존재하지 않습니다</td></tr>
				<%
					}

					for(HashMap rs:dataList) {
				%>
				<tr>
					<td><%=cont%></td>
					<td class="subject">

						<%if(util.getStr(rs.get("SECRET_AT")).equals("Y")){ //비밀글 일때

							if(util.getStr(rs.get("WRITER_ID")).equals(loginVO.getUserId()) || util.getBbsAuth(loginVO,boardMap,"READ")){ //권한이 있을때
						%>
								<a href="#" onclick="goSubmit('view','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>')">
									<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
								</a>
								<img src="/img/board/ico_lock.png" alt="비밀글 아이콘" style="vertical-align: middle;" />
						<%
						  	}else{ //권한이 없을때
						%>
								<span onclick="sCheck()"><%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%></span>
								<img src="/img/board/ico_lock.png" alt="비밀글 아이콘" style="vertical-align: middle;" />
						<%
						  	}

						}else{ //비밀글 아닐때
							if(util.getStr(rs.get("WRITER_ID")).equals(loginVO.getUserId()) || (loginVO.getAuthLv()).equals("99")){ //권한이 있을때
						%>
							<a href="#" onclick="goSubmit('view','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>')">
								<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
							</a>
						<%
						  	}else{ //권한이 없을때
						%>
								<span onclick="aCheck()"><%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%></span>
						<%
						  	}

						}
						%>

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
					<td class="r_line_none file new_file_hr">
						<%if(!(util.getStr(rs.get("FILE_ID"))).equals(null) && !(util.getStr(rs.get("FILE_ID"))).equals("")){
						String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
											+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
											+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
                    	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src="/img/board/ico_file.png" alt="첨부파일 아이콘" /></a>
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
					<input type="button" class="btn_inp_b_01" value="글쓰기" onclick="goSubmit('write')"/>
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
		alert("이 글은 비밀글입니다.");
	}

	function aCheck(){
		alert("본인이 작성한 글만 볼 수 있습니다.");
	}

</script>