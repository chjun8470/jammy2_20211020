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
	ArrayList<HashMap<String, String>> moduleDataList = request.getAttribute("moduleDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("moduleDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>
<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post" action="/sys/sys_module.do">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "moduleInfoIdx" id = "moduleInfoIdx" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="name" <%if(util.getStr(paramMap.get("searchType")).equals("name")) { %> selected="selected" <% } %> >모듈명</option>
								<option value="url" <%if(util.getStr(paramMap.get("searchType")).equals("url")) { %> selected="selected" <% } %>>페이지 코드</option>
							</select>
							<!-- 키워드 -->
							 <label for="keyword" class="hide">키워드</label>
							<input type="text" name="searchWord" id="searchWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
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
				<col style="width: 10%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">모듈명</th>
					<th scope="col">페이지코드</th>
					<th scope="col">작성자</th>
					<th scope="col">등록일</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:moduleDataList) {%>
				<tr style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("MODULE_INFO_IDX")%>');">
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("MB_NM"))%></td>
					<td><%=util.getStr(rs.get("PAGE_CD"))%></td>
					<td><%=util.getStr(rs.get("PSN_NM"))%></td>
					<td><%=format.format(rs.get("REG_DT"))%></td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<div class="bbs_btn">
			<input class="btn_inp_b_01" type="button" onclick="location.href='/sys/sys_module.do?mode=write'" value="등록" />
		</div>
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#moduleInfoIdx').val(idx);
		$('#searchForm').submit();
	}
</script>


<!--// bo_btn -->
