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
	List<HashMap<String, String>> userDataList = request.getAttribute("userDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("userDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));

	String nowPage = util.getStr(paramMap.get("nowPage"));

%>

<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css" />

<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/board.js"></script>

<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>

<form id = "searchForm" name = "searchForm" method="post">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" value="list" />
			<input type="hidden" name = "orgGrpCd" id = "orgGrpCd"  />
			<div class="bbs-top">
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<!-- <label for="searchType" class="hide">검색종류선택</label>
							<select name="searchType" id="searchType" class="select" style="height: 24px">
								<option value="SUBJECT">제목</option>
								<option value="CONTENT">내용</option>
							</select> -->
							<!-- 키워드 -->
							<!-- <label for="keyword" class="hide">키워드</label>
							<input type="text" name="searchWord" id="searchWord" class="board-input" value=""> -->
							<!-- 검색버튼 -->
							기관명 : <input type="text" name="orgGrpNm" id="orgGrpNm" class="board-input" value="<%=util.getStr(paramMap.get("orgGrpNm"))%>">
							<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()">
						</div>
						<!-- board-search e -->
					</div>
				</div>
			</div>
</form>

		<div class="total">
				[전체 <span><c:out value="${totalCount}"/></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 25%;" />
				<col style="width: 20%;" />
				<col style="width: 25%;" />
				<col style="width: 20%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">기관명</th>
					<th scope="col">구분</th>
					<th scope="col">주소</th>
					<th scope="col">선택</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${totalCount ne 0}">
						<c:forEach var="data" items="${dataMap}" varStatus="status">
						<tr>
							<td>${totalCount-(((staticVO.nowPage-1)*staticVO.pageSize)+status.index)}</td>
							<td>${data.ORG_GRP_NM}</td>
							<td>
							<c:choose>
								<c:when test="${data.ORG_TYPE eq '1'}">기업</c:when>
								<c:when test="${data.ORG_TYPE eq '2'}">기관/센터</c:when>
								<c:otherwise>알수없음</c:otherwise>
							</c:choose>
							</td>
							<td>${data.ADDR1} ${data.ADDR2}</td>
							<td><button type="button" onclick="clickToBtn('${data.ORG_GRP_CD}','${data.ORG_GRP_NM }')">선택</button></td>
						</tr>
						</c:forEach>
					</c:when>
					<c:when test="${totalCount eq 0}">
						<tr><td colspan='5'>조회된 결과가 없습니다.</td></tr>
					</c:when>
					<c:otherwise>
						<tr><td colspan='5'>조회된 결과가 없습니다.</td></tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	<%=util.getPaging(staticVO, nowPage) %>

<script type="text/javascript">
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}

	function clickToBtn(val,val2){
		var obj = new Object();
		obj['org_grp_cd'] = val;
		obj['org_grp_nm'] = val2;
		obj['pop_mode'] = "org";
		opener.setPopup(obj);
		window.close();
	}
</script>
