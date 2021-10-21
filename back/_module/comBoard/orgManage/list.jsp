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
	String searchType = util.getStr(paramMap.get("searchType"));
	String searchWord = util.getStr(paramMap.get("searchWord"));

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
						<option value="ORG" <%if("ORG".equals(searchType)) {%> selected="selected" <%}%>>기관명</option>
						<option value="ORGSUB" <%if("ORGSUB".equals(searchType)) {%> selected="selected" <%}%>>부서명</option>
						<option value="NAME" <%if("NAME".equals(searchType)) {%> selected="selected" <%}%>>이름</option>
					</select>

					<!-- 키워드 -->
					<input class="board-input" type="text" name="searchWord" id="searchWord" value="<%=searchWord%>" style="width:300px; height:20px" />

					<!-- 검색버튼 -->
					<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('list')" style="float:right"/>
				</div>
				<!-- board-search e -->
				</div>
				</div>
			</div>
			<!-- bbs-top e -->
			<div class="total" style="vertical-align:middle; margin:10px; padding:2px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				<!--
					<button type="button" id="excelUp" onclick="goSubmit('excelUpload')" style="float:right; margin-bottom: 5px;" class="btn_inp_b_01">엑셀업로드</button>
				 -->
				 <span style="float:right"><input type="button" class="btn_inp_b_01"  value="엑셀저장" onclick="excelDown()"></span>
			</div>

		</form>
		<!-- searchForm e -->

		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">연번</th>
					<th scope="col">기관명</th>
					<th scope="col">부서명</th>
					<th scope="col">직위</th>
					<th scope="col">이름</th>
					<th scope="col">전화번호</th>
					<th scope="col">휴대전화</th>
					<th scope="col">이메일</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

					if(dataList.size() == 0){
				%>
					<tr><td colspan="8">데이터가 존재하지 않습니다</td></tr>
				<%
					}

					for(HashMap rs:dataList) {
				%>
				<tr onclick="location.href='./<%=myPage%>?mode=view&amp;boardIdx=<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>&amp;boardComIdx=<%=util.getStr(rs.get("BOARD_ID"))%>&amp;nowPage=<%=staticVO.getNowPage()%>&amp;searchType=<%=searchType%>&amp;searchWord=<%=searchWord %>'" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'">
					<td><%=cont%></td>
					<td>
						<%=util.getStr(rs.get("ORG_GRP_NM"))%>(<%=util.getStr(rs.get("ORG_ENG_NM"))%>)
					</td>

					<td>
						<%=util.getStr(rs.get("DATA02"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("DATA04"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("DATA05"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("DATA08"))%>-<%=util.getStr(rs.get("DATA09"))%>-<%=util.getStr(rs.get("DATA10"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("DATA11"))%>-<%=util.getStr(rs.get("DATA12"))%>-<%=util.getStr(rs.get("DATA13"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("DATA14"))%>@<%=util.getStr(rs.get("DATA15"))%>
					</td>

				</tr>
				<% cont--; } %>
			</tbody>
		</table>

		<div class="btn_box">
			&nbsp;
			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
			<div class="btn_right_box">
				<input type="button" class="btn_inp_b_01" value="등록하기" onclick="goSubmit('write')"/>
			</div>
			<% } %>
		</div>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
	function excelDown(){
		$('#mode').val("excel");
		$('#searchForm').attr('action','/sys/comBoardExcelDown.do');
		$('#searchForm').attr('target','_blank');
		$('#searchForm').submit();
		$('#searchForm').attr('action','./<%=myPage %>');
		$('#searchForm').attr('target','');
	}

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
</script>