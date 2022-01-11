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
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));

	if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) < 99){
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
		 <form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="reURl" id="reURl" value="<%=myPage%>" />
			<input type="hidden" name="dataIdx" id="dataIdx" value="" />

			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<!-- 사이트 -->
					<select name="siteType" id="siteType" class="select" style="height: 29px">
						<option value="ALL">전체</option>
						<option value="JEINET" <%if("JEINET".equals(util.getStr(paramMap.get("siteType")))) {%>selected="selected"<%} %>>연구장비정보망</option>
						<option value="JNTIS" <%if("JNTIS".equals(util.getStr(paramMap.get("siteType")))) {%>selected="selected"<%} %>>전남과학기술정보시스템</option>
						<option value="JIPBANK" <%if("JIPBANK".equals(util.getStr(paramMap.get("siteType")))) {%>selected="selected"<%} %>>지식재산정보은행</option>
						<option value="SMBRND" <%if("SMBRND".equals(util.getStr(paramMap.get("siteType")))) {%>selected="selected"<%} %>>전남중소기업R&D시스템</option>
						<option value="SAMPLE" <%if("SAMPLE".equals(util.getStr(paramMap.get("siteType")))) {%>selected="selected"<%} %>>기타</option>
					</select>

					<!-- 검색종류선택 -->
					<select name="searchType" id="searchType" class="select" style="height: 29px">
						<option value="ALL">전체</option>
						<option value="BOARD_ID" <%if("BOARD_ID".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>게시판ID</option>
						<option value="BOARD_NM" <%if("BOARD_NM".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>게시판명</option>
						<option value="BOARD_SUMMARY" <%if("BOARD_SUMMARY".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>게시판요약</option>
					</select>
					<!-- 키워드 -->
					<input class="board-input" type="text" title="검색단어입력" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:300px; height:25px" />

					<!-- 검색버튼 -->
					<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('')" style="float:right"/>
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
				<col style="width: 15%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
				<col style="width: 15%;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">게시판ID</th>
					<th scope="col">게시판명</th>
					<th scope="col">게시판스킨</th>
					<th scope="col">게시판요약</th>
					<th scope="col">사이트</th>
				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
				int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
				for(HashMap rs:dataList) {
			%>
				<tr  onclick="goSubmit('view','<%=util.getStr(rs.get("BOARD_ID"))%>')" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'">
					<td>
						<%=cont%>
					</td>
					<td>
						<%=util.getStr(rs.get("BOARD_ID"))%>
					</td>
					<td>
						<%if(util.getStr(rs.get("BOARD_NM")).length()>20){%><%=util.getStr(rs.get("BOARD_NM")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("BOARD_NM"))%><%}%>
					</td>
					<td>
						<%=util.getStr(rs.get("SKIN_NM"))%>
					</td>
					<td>
						<%if(util.getStr(rs.get("BOARD_SUMMARY")).length()>20){%><%=util.getStr(rs.get("BOARD_SUMMARY")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("BOARD_SUMMARY"))%><%}%>
					</td>
					<td>
						<%=util.getStr(rs.get("SITE_NM"))%>
					</td>
				</tr>
			<%
				cont--;
				}
			%>
			</tbody>
		</table>

		<div class="btn_box">
			&nbsp;
			<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 99){%>
			<div class="btn_right_box">
				<input type="button" class="btn_inp_b_01" value="게시판등록" onclick="goSubmit('write')"/>
			</div>
			<%}%>
		</div>

	</div>
</div>

<%=util.getPaging(staticVO, nowPage) %>

<script type="text/javascript">
	function goSubmit(mode,idx){
		$('#dataIdx').val(idx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
</script>

