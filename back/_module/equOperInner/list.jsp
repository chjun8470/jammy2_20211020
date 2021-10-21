<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");

	String display = "sub";
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

%>
<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post" action="./<%=myPage %>">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "equOperDiaryIdx" id = "equOperDiaryIdx" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<select name="searchType" id="searchType" class="select">
								<option value="00">선택</option>
								<option value="type1" <%if(util.getStr(paramMap.get("searchType")).equals("type1")) { %> selected="selected" <% } %>>사용자</option>
								<option value="type2" <%if(util.getStr(paramMap.get("searchType")).equals("type2")) { %> selected="selected" <% } %>>사용기관</option>
								<option value="type3" <%if(util.getStr(paramMap.get("searchType")).equals("type3")) { %> selected="selected" <% } %>>등록자</option>
								<option value="type4" <%if(util.getStr(paramMap.get("searchType")).equals("type4")) { %> selected="selected" <% } %>>등록기관</option>
								<option value="type5" <%if(util.getStr(paramMap.get("searchType")).equals("type5")) { %> selected="selected" <% } %>>등록부서</option>
							</select>
							<!-- 키워드 -->
							 <label for="keyword" class="hide">키워드</label>
							<input type="text" name="searchWord" id="searchWord" class="inp_txt" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
							<!-- 검색버튼 -->
						<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" style="float: right;" />
						</div>
						<!-- board-search -->
					 </div>
				</div>
			<!-- bbs-top e -->
</form>
			<div class="total" style="margin-top: 10px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" rowspan="2">번호</th>
					<th scope="col" rowspan="2">장비</th>
					<th scope="col" rowspan="2">사용일시</th>
					<th scope="col" colspan="3">사용기업/기관</th>
					<th scope="col" rowspan="2">사용자</th>
					<th scope="col" rowspan="2">시료수</th>
					<th scope="col" rowspan="2">사용시간</th>
				</tr>
				<tr>
					<th>구분</th>
					<th>기업/기관명</th>
					<th>부서명</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<tr style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("EQU_OPER_DIARY_IDX")%>');">
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("KOR_NM")) %></td>
					<td><%=util.getStr(rs.get("START_DT"))%>~<%=util.getStr(rs.get("END_DT")) %></td>
					<td>
						<%if(util.getStr(rs.get("ORG_SELECT")).equals("01")) {
							out.println("기관 내 동일부서");
						 }else if(util.getStr(rs.get("ORG_SELECT")).equals("02")) {
							out.println("기관 내 타부서");
						 } else if(util.getStr(rs.get("ORG_SELECT")).equals("03")) {
							out.println("외부기관");
						 }%>
					</td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM"))%></td>
					<td><%=util.getStr(rs.get("DEPT_NM"))%></td>
					<td><%=util.getStr(rs.get("USE_USER_NM"))%></td>
					<td><%=util.getStr(rs.get("SAMPLE_CNT"))%></td>
					<td><%=util.getStr(rs.get("USE_TIME"))%></td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
	<%=util.getPaging(staticVO, nowPage) %>
		<div class="bbs_btn">
			<input class="btn_inp_b_01" type="button" onclick="location.href='/sys/<%=myPage %>?mode=write'" value="등록" />
		</div>

	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#equOperDiaryIdx').val(idx);
		$('#searchForm').submit();
	}
</script>


<!--// bo_btn -->
