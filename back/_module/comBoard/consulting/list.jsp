<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String tabApp = util.getStr(paramMap.get("tabApp"));
%>
<style type="text/css" scoped>

	.tabbox{
		position:relative;
		border-bottom:1px solid #cccccc;
		margin-top:10px;
		margin-bottom:10px;
		padding-left:20px;
	}
	.tabbox .tabBtn {
		position:relative;
		display:inline-block;
		height:30px;
		line-height:30px;
		width:100px;
		background-color:#d0d0d0;
		color:#ffffff;
		border-top:1px solid #cccccc;
		border-left:1px solid #cccccc;
		border-right:1px solid #cccccc;
		text-align:center;
		margin-right:10px;
		top:1px;
		cursor:pointer;
	}

	.tabbox .tabBtn_on{
		position:relative;
		display:inline-block;
		height:30px;
		line-height:30px;
		width:100px;
		color:#fffff;
		border-top:1px solid #cccccc;
		border-left:1px solid #cccccc;
		border-right:1px solid #cccccc;
		border-bottom:1px solid #ffffff;
		text-align:center;
		margin-right:10px;
		background-color:#ffffff;
		top:1px;
		color:#fffff;
		cursor:pointer;
	}

</style>

<div class="skin_list">
	<div>
		<form action="./<%=myPage%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="tabApp" id="tabApp" value="<%=tabApp%>" />

			<div class="tabbox">
				<div class="tabBtn<%if("".equals(tabApp)){out.print("_on");} %>" onclick="tabGoLink('')" >전체</div>
				<div class="tabBtn<%if("2".equals(tabApp)){out.print("_on");} %>" onclick="tabGoLink(2)" >승인</div>
				<div class="tabBtn<%if("1".equals(tabApp)){out.print("_on");} %>" onclick="tabGoLink(1)" >요청</div>
				<div class="tabBtn<%if("3".equals(tabApp)){out.print("_on");} %>" onclick="tabGoLink(3)" >반려</div>
			</div>

			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<label for="searchType" class="hide">검색종류선택</label>
					<select name="searchType" id="searchType" class="select" style="height: 24px">
						<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
						<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
					</select>
					<!-- 키워드 -->
					<label for="keyword" class="hide">키워드</label>
					<input type="text" name="searchWord" id="searchWord" class="board-input" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
					<!-- 검색버튼 -->
					<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('list')" />
				</div>
				<!-- board-search e -->
				</div>
				</div>
			</div>
			<!-- bbs-top e -->

			<div class="total">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>

		<!-- searchForm e -->

		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 12%;" />
				<col style="width: 40%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">제목</th>
					<th scope="col">글쓴이</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
					<th scope="col">상태</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
							for(HashMap rs:dataList) {
				%>
				<tr>
					<td><%=cont%></td>
					<td class="subject">
						<a href="#" onclick="goSubmit('view','<%=util.getStr(rs.get("ARTICLE_ID"))%>')"><%=util.getStr(rs.get("SUBJECT"))%></a>
					</td>
					<td>
						<%=util.getStr(rs.get("WRITER_ID"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("HITS"))%>
					</td>
					<td>
						<%if(util.getStr(rs.get("DATA04")).equals("1")){%>
						요청
						<%}else if(util.getStr(rs.get("DATA04")).equals("2")){ %>
						승인
						<%}else if(util.getStr(rs.get("DATA04")).equals("3")){ %>
						반려
						<%} %>
					</td>
				</tr>
				<% cont--; } %>
			</tbody>
		</table>
</form>
		<div class="btn_box">
			&nbsp;
			<% if(util.loginCheck()) { %>
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
	function goSubmit(mode,boardIdx){
		$('#boardIdx').val(boardIdx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
	function tabGoLink(no){
		$('#tabApp').val(no);
		$('#searchForm').submit();
	}



</script>