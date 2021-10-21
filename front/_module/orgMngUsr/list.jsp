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
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

%>
<form id="searchForm" name="searchForm" method="post" action="/<%=request.getAttribute("SITE_ID") %>/sub.do">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "m" id = "m" value="<%=util.getStr(paramMap.get("m")) %>" />
			<input type="hidden" name = "mode" id = "mode" value="list" />
			<input type="hidden" name = "orgGrpCd" id = "orgGrpCd"  />

			<div class="list_top008">

				<div class="board_count008">
					전체 <span class="blue1">${totalCount}</span>건
				</div>
				<div class="b_srchBox008">
					<div class="b_srch008">
                        <label class="hide" for="orgGrpNm">검색어를 입력하세요</label>
						<input id="orgGrpNm" class="b_srch_txt008" name="orgGrpNm" type="text" />
						<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn008" alt="검색" onclick="pageSearchGo()"/>
					</div>
				</div>
			</div>
</form>
	<!-- skin_basic_list s -->
	<div class="basic_listWrap">
		<table class="skin_list">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
				<col style="width: 13%;" />
				<col style="width: 12%;" />
				<col style="width: 15%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col" class="number">NO</th>
					<th scope="col" class="b_notice">기관명</th>
					<th scope="col" class="b_notice">부서명</th>
					<th scope="col">이름</th>
					<th scope="col">직위</th>
					<th scope="col" class="r_line_none">전화번호</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>

					<c:when test="${totalCount ne 0}">
						<c:forEach var="data" items="${dataMap}" varStatus="status">
							<!-- 기관명-->
							<c:set var="string1" value="${data.ORG_GRP_NM}"/>
							<c:set var="length1" value="${fn:length(string1)}"/>
							<c:set var="string2" value="${fn:substring(string1, 0, 10)} · · · "/>
							<!-- 부서명 -->
							<c:set var="string3" value="${data.DEPT_NM}"/>
							<c:set var="length2" value="${fn:length(string3)}"/>
							<c:set var="string4" value="${fn:substring(string3, 0, 10)} · · · "/>

							<%-- <tr style="cursor:pointer" onclick="pageViewGo('${data.ORG_GRP_CD}');"> --%>
							<tr>
								<td class="number">${totalCount-(((staticVO.nowPage-1)*staticVO.pageSize)+status.index)}</td>
								<td class="b_notice">
									<c:if test="${length1 > 10}" var="result" scope="page">
								      ${string2}
								    </c:if>
								    <c:if test="${length1 <= 10}" var="result" scope="page">
								      ${string1}
								    </c:if>
								</td>

								<td class="b_notice">
									<c:if test="${length2 > 10}" var="result" scope="page">
								      ${string4}
								    </c:if>
								    <c:if test="${length2 <= 10}" var="result" scope="page">
								      ${string3}
								    </c:if>
								</td>
								<td>${data.PSN_NM}</td>
								<td>${data.POSITION_NM}</td>
								<td class="r_line_none">${data.CP_NO}</td>
							</tr>
						</c:forEach>
					</c:when>

					<c:when test="${totalCount eq 0}">
						<tr><td colspan='6'>조회된 결과가 없습니다.</td></tr>
					</c:when>

					<c:otherwise>
						<tr><td colspan='6'>조회된 결과가 없습니다.</td></tr>
					</c:otherwise>

				</c:choose>
			</tbody>
		</table>
	</div>

	<div class="b_btn_area"></div>
	<%=util.getPaging(staticVO, nowPage) %>

<script type="text/javascript">
//<![CDATA[
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	/*
	function pageViewGo(idx){
		$('#mode').val('view');
 		$('#orgGrpCd').val(idx);
		$('#searchForm').submit();
	}
	*/
//]]>	
</script>
