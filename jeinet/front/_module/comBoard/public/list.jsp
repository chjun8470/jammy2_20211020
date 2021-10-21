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

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, Object> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, Object>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String fileGrp = "public";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	String m = util.getStr(paramMap.get("m"));
	String listMode = util.getStr(paramMap.get("listMode"));
	String sortMode = util.getStr(paramMap.get("sortMode"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));

%>
		<!-- <div class="tabBox" style="margin-top:30px;">
			<ul>
				<li class="on" style="float:left;margin-left:10px;"><a href="/jeinet/sub.do?m=54" onclick="tapMenu()">정책이슈</a></li>
				<li class="" style="float:left;margin-left:10px;"><a href="/jeinet/sub.do?m=73" onclick="tapMenu()">관련법령</a></li>
				<li class="" style="float:left;margin-left:10px;"><a href="/jeinet/sub.do?m=74" onclick="tapMenu()">통계자료</a></li>
				<li class="" style="float:left;margin-left:10px;"><a href="/jeinet/sub.do?m=75" onclick="tapMenu()">기타발간물</a></li>
			</ul>
		</div>
		<div class="skin_line" style="display:block;height:10px;">

		</div>-->

	<!--list_top S-->
<div class="list_top013">
<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="m" id="m" value="<%=m%>" />

<div class="board_count013">전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건</div>


<div class="b_srchBox013">

<select name="searchType" id="searchType" class="b_select013">
<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
</select>
	
<div class="b_srch013">
<input type="text" name="searchWord" title="텍스트입력 박스" id="searchWord" class="b_srch_txt013" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
<input type="image" class="b_go_btn013" alt="돋보기 검색 아이콘" src="/img/board/btn_ico_srch.png" onclick="goSubmit('list','image')" />
</div>

				<div class="board_count">
					전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
				</div>
				<div class="b_btn_listBox">
					<button class="b_btn_block" onclick="goSubmit('list','imagelist', '<%=sortMode%>')"><img src="../img/board/btn_block_ovr.png" /></button>
					<button class="b_btn_block" style="display:none;" onclick="goSubmit('list','imagelist', '<%=sortMode%>')"><img src="../img/board/btn_block.png" /></button>
					<button class="b_btn_list" style="display:none;" onclick="goSubmit('list','bloglist', '<%=sortMode%>')"><img src="../img/board/btn_list_ovr.png" /></button>
					<button class="b_btn_list" onclick="goSubmit('list','bloglist', '<%=sortMode%>')"><img src="../img/board/btn_list.png" /></button>
				</div>

				<div class="b_srchBox_gap"><img src="../img/board/srch_box_gap.gif" /></div>

				<div class="b_btn_sortlistBox" style="float:right;">
						<input type="button" class="btn_inp_w_01" value="최신순" onclick="goSubmit('list', '<%=listMode%>', 'new_list')"/>
						<input type="button" class="btn_inp_w_01" value="인기순" onclick="goSubmit('list', '<%=listMode%>', 'popular_list')"/>
						<input type="button" class="btn_inp_w_01" value="다운로드순" onclick="goSubmit('list', '<%=listMode%>', 'down_list')"/>
				</div>

				<div class="b_srchBox" style="padding-bottom:10px;">
					<select name="searchType" id="searchType" class="b_select">
						<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
						<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
					</select>
					<div class="b_srch">
						<input type="text" name="searchWord" title="검색단어입력" id="searchWord" class="b_srch_txt" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
						<input type="image" class="b_go_btn" alt="검색" src="../img/board/btn_ico_srch.png" onclick="goSubmit('list')" />
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
	<button type="button" class="b_btn_block013" onclick="goSubmit('list','imagelist')"><img src="/img/board/btn_block.png" alt="이미지리스트" /></button>
	<button type="button" class="b_btn_blog013" onclick="goSubmit('list','bloglist')"><img src="/img/board/btn_blog.png" alt="블러그리스트" /></button>
</div>

</form>
</div>
<!--list_top E-->

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
				<% cont--; } %>
			</tbody>
		</table>
</form>
		<div class="b_btn_area">
			&nbsp;
			<% if(util.loginCheck()) { %>
			<div class="btn_right_box">
					<input type="button" class="btn_rgt" value="글쓰기" onclick="goSubmit('write')"/>
			</div>
			<% } %>
		</div>

</div>

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