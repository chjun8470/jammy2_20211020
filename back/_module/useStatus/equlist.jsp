<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
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
%>

<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css" />

<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/board.js"></script>

<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>

<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" value="equPop"/>
			<input type="hidden" name = "rndEquIdx" id = "rndEquIdx" />
			<input type="hidden" name = "tmenu" id = "tmenu" value="2"/>
			<input type="hidden" name = "equipCd" id = "equipCd" value = "<%=util.getStr(paramMap.get("equipCd"))%>" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<%-- <label for="" >시설장비분류 : </label>
							<select name="equipCd" id="equipCd" class="select" style="height: 24px">
								<option value="" >선택</option>
								<option value="1" <%if("1".equals(util.getStr(paramMap.get("equipCd")))) {%> selected="selected" <%}%>>연구장비</option>
								<option value="2" <%if("2".equals(util.getStr(paramMap.get("equipCd")))) {%> selected="selected" <%}%>>연구시설</option>
							</select> --%>

							<label for="searchType" class="hide">검색종류선택</label>
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="equipNm" <%if("equipNm".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>장비/시설명</option>
								<option value="manufacture" <%if("manufacture".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>모델명</option>
								<option value="keyWord" <%if("keyWord".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>키워드</option>
							</select>
							<!-- 키워드 -->
							<label for="keyword" class="hide">키워드</label>
							<input type="text" name="searchWord" id="searchWord" class="board-input" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
							<!-- 검색버튼 -->
							<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" />
						</div>
						<!-- board-search e -->
					</div>
				</div>
			<!-- bbs-top e -->
</form>
			<div class="total">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>


	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 20%;" />
				<col style="width: 25%;" />
				<col style="width: 20%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">장비등록번호</th>
					<th scope="col">시설장비분류</th>
					<th scope="col">NTIS 장비등록번호</th>
					<th scope="col">장비/시설명</th>
					<th scope="col">모델명</th>
					<th scope="col">선택</th>
				</tr>
			</thead>
			<tbody>
				<tr>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			if(dataList.size()>0){
				for(HashMap rs:dataList) {
					String name = "";
					name = util.getStr(rs.get("KOR_NM")) + " (" + util.getStr(rs.get("ENG_NM")) + ")"; %>
					<tr>
						<td><%=util.getStr(rs.get("RND_EQU_IDX"))%></td>
						<td><%=util.getStr(rs.get("EQUIP_CD")).equals("1")?"연구장비":"연구시설"%></td>
						<td><%=util.getStr(rs.get("NTIS_EQUIP_INFO"))%></td>
						<td><%=util.getStr(rs.get("KOR_NM"))%><br/>(<%=util.getStr(rs.get("ENG_NM"))%>)</td>
						<td><%=util.getStr(rs.get("MODEL_NM")).equals("") ? "모델명 없음":util.getStr(rs.get("MODEL_NM"))%></td>
						<td><button type="button" onclick="clickToBtn('<%=util.getStr(rs.get("RND_EQU_IDX"))%>', '<%=util.getStr(rs.get("NTIS_EQUIP_INFO"))%>')">선택</button></td>
					</tr>
				<%
				cont--;
				}
			}else{out.println("<tr><td colspan='5'>조회된 결과가 없습니다.</td></tr>");}
			%>
			</tbody>
		</table>
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
			$('#searchForm').attr('action','./equOperDiary.do?mode=equPop');
		$('#searchForm').submit();
	}

	function clickToBtn(val, val2){
		var obj = new Object();
		obj['equ_idx'] = val;
		obj['ntis_no'] = val2;
		opener.setPopup(obj);
		window.close();
	}
</script>


<!--// bo_btn -->
