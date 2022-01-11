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

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String m = util.getStr(paramMap.get("m"));
	String mode = util.getStr(paramMap.get("mode"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode")); //정렬(최신순, 인기순, 다운로드순)
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = util.getStr(paramMap.get("siteId")); //사이트구분

	//String sclas = util.getStr(paramMap.get("sclas")); //게시판 구분1
	//String allYN = util.getStr(paramMap.get("allYN")); //게시판 구분2

%>
	<!--list_top S-->
	<div class="list_top013">
	<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
		<input type="hidden" name="m" id="m" value="<%=m%>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
		<input type="hidden" name="sortMode" id="sortMode" value="<%=sortMode%>" />
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />

		<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />
		<%-- <input type="hidden" name="sclas" id="sclas" value="<%=sclas%>" />
		<input type="hidden" name="allYN" id="allYN" value="<%=allYN%>" /> --%>


		<div class="board_count013">전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건</div>


			<div class="b_srchBox013">
                <label class="hide" for="searchType">검색조건</label>
				<select name="searchType" id="searchType" class="b_select013">
					<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
					<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
					<option value="GROUP" <%if("GROUP".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>발행기관</option>
				</select>

				<div class="b_srch013">
                    <label class="hide" for="searchWord">검색어</label>
					<input type="text" class="b_srch_txt013" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
					<input type="image" class="b_go_btn013" alt="검색" src="/img/board/btn_ico_srch.png" onclick="goSubmit('list','image')" />
				</div>
			</div>

			<div class="list_sort">
				<% if("new_list".equals(util.getStr(paramMap.get("sortMode")))) { %>
					<button class="sort01_over" id="pcont_block01_over" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"><img src="/img/board/btn_order_new_ovr.gif" alt="최신순" /></button>
					<button class="sort02" id="pcont_block02" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"><img src="/img/board/btn_order_popularity.gif" alt="인기순" /></button>
					<button class="sort03" id="pcont_block03" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"><img src="/img/board/btn_order_down.gif" alt="다운로드순" /></button>
				<% } else if("popular_list".equals(util.getStr(paramMap.get("sortMode")))) { %>
					<button class="sort01" id="pcont_block01" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"><img src="/img/board/btn_order_new.gif" alt="최신순" /></button>
					<button class="sort02_over" id="pcont_block02_over" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"><img src="/img/board/btn_order_popularity_ovr.gif" alt="인기순" /></button>
					<button class="sort03" id="pcont_block03" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"><img src="/img/board/btn_order_down.gif" alt="다운로드순" /></button>
				<% } else { %>
					<button class="sort01" id="pcont_block01" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"><img src="/img/board/btn_order_new.gif" alt="최신순" /></button>
					<button class="sort02" id="pcont_block02" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"><img src="/img/board/btn_order_popularity.gif" alt="인기순" /></button>
					<button class="sort03_over" id="pcont_block03_over" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"><img src="/img/board/btn_order_down_ovr.gif" alt="다운로드순" /></button>
				<% } %>
			</div>

			<div class="b_srchBox_gap013"><img src="/img/board/srch_box_gap.gif" alt="srch_box_gap"/></div>
			<div class="b_btn_listBox013">
				<button type="button" class="b_btn_block013" onclick="goSubmit('list','image')"><img src="/img/board/btn_block.png" alt="이미지리스트" /></button>
				<button type="button" class="b_btn_blog013" onclick="goSubmit('list','bloglist')"><img src="/img/board/btn_blog.png" alt="블러그리스트" /></button>
				<button type="button" class="b_btn_list013" onclick="goSubmit('list','list')"><img src="/img/board/btn_list_ovr.png" alt="리스트" /></button>
			</div>

	</form>
	</div>
	<!--list_top E-->

<!--cont_block S-->
<div id="cont_block">
<!--basic_listWrap S-->
<div class="basic_listWrap">

	<!-- skin_basic_list s -->
	<table class="skin_list" summary="게시판 목록을 나타내는 표입니다..">
		<!-- colgroup s -->
		<colgroup>
			<col style="width: 10%;" />
			<col style="width: 55%;" />
			<col style="width: 15%;" />
			<col style="width: 10%;" />
			<col style="width: 10%;" />
		</colgroup>
		<!-- colgroup e -->
		<!-- thead s -->
		<thead>
			<tr>
				<th scope="col" class="number">번호</th>
				<th scope="col">제목</th>
				<th scope="col" class="r_line_none2">글쓴이</th>
				<th scope="col" class="lookup">작성일</th>
				<th scope="col" class="r_line_none file">조회수</th>
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
				<td class="number"><%=cont%></td>
				<td class="b_notice">
					<a href="#" onclick="goSubmit('view','<%=listMode %>', '<%=sortMode%>', '<%=util.getStr(rs.get("ARTICLE_ID"))%>')"><%=util.getStr(rs.get("SUBJECT"))%></a>
				</td>
				<td class="r_line_none2">
					<%=util.getStr(rs.get("WRITER_ID"))%>
				</td>
				<td class="number">
					<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
				</td>
				<td class="r_line_none file">
					<%=util.getStr(rs.get("HITS"))%>
				</td>
			</tr>
			<% cont--; }
					if(dataList.size() == 0){
				%>
					<tr><td colspan="5" class="r_line_none" >데이터가 존재하지 않습니다</td></tr>
				<%
					}
				%>
		</tbody>
	</table>

	<div class="b_btn_area">
	&nbsp;
	<%--
	<% if(util.loginCheck()) { %>
		<div class="btn_right_box">
			<input type="button" class="btn_rgt" value="글쓰기" onclick="goSubmit('write')"/>
		</div>
	<% } %>
	--%>
	</div>
</div>
<!--basic_listWrap E-->
</div>
<!--cont_block E-->

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,listMode,sortMode,boardIdx){
		$('#boardIdx').val(boardIdx);
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		$('#mode').val(mode);
		if(mode == "list" || mode == "view"){
	           $('#searchForm').attr('method','get');
	     }
		$('#searchForm').submit();
	}

	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});

</script>