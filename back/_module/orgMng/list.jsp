<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>


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

<form id="searchForm" name="searchForm" method="post" action="/sys/sys_org_manage.do">
	<input type="hidden" name="nowPage" id="nowPage" />
	<input type="hidden" name="mode" id= "mode" value="list" />
	<input type="hidden" name="orgGrpCd" id="orgGrpCd"  />
	<input type="hidden" name="areaCd" id="areaCd" />


	<div class="bbs-top">
	<div class="basic_grid">
		<div class="search_box" style="padding:10px">

			<label for="searchType1">?????? :</label>
			<select name="orgType" id="orgType" class="search_box_dn">
				<option value="" <%if("".equals(util.getStr(paramMap.get("orgType")))) {%>selected="selected"<%} %>>??????</option>
				<option value="1" <%if("1".equals(util.getStr(paramMap.get("orgType")))) {%>selected="selected"<%} %>>??????</option>
				<option value="2" <%if("2".equals(util.getStr(paramMap.get("orgType")))) {%>selected="selected"<%} %>>??????/??????</option>
			</select>

			<label for="searchType2" style="padding-left:15px;">?????? :</label>
			<select name="applyCd" id="applyCd" class="search_box_dn">
				<option value="" <%if("".equals(util.getStr(paramMap.get("applyCd")))) {%>selected="selected"<%} %>>??????</option>
				<option value="10" <%if("10".equals(util.getStr(paramMap.get("applyCd")))) {%>selected="selected"<%} %>>??????</option>
				<option value="20" <%if("20".equals(util.getStr(paramMap.get("applyCd")))) {%>selected="selected"<%} %>>??????</option>
				<option value="30" <%if("30".equals(util.getStr(paramMap.get("applyCd")))) {%>selected="selected"<%} %>>??????</option>
			</select>

			<label for="searchType3" style="padding-left:20px;">??????/????????? :</label>
			&nbsp;<input type="text" name="orgGrpNm" id="orgGrpNm" class="inp_text" value="<%=util.getStr(paramMap.get("orgGrpNm"))%>" style="width:200px; height:24px;" />

			<!-- ????????? -->
			<!--<label for="keyword" class="hide">?????????</label>
			<input type="text" name="searchWord" id="searchWord" class="board-input" value=""> -->

			<!-- ???????????? -->
			<input type="button" class="btn_inp_g_01" value="??????" onclick="pageSearchGo()" />

		</div>
	</div>
	</div>
</form>

		<div class="total">
			[?????? <span><c:out value="${totalCount}"/></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
		</div>

		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="????????? ????????? ???????????? ????????????..">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 35%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">??????/?????????</th>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
				</tr>
			</thead>
			<tbody>
				<c:choose>
					<c:when test="${totalCount ne 0}">
						<c:forEach var="data" items="${dataMap}" varStatus="status">
						<tr style="cursor:pointer" onclick="pageViewGo('${data.ORG_GRP_CD}', '${data.AREA_CD}');">
							<td>${totalCount-(((staticVO.nowPage-1)*staticVO.pageSize)+status.index)}</td>
							<td>${data.ORG_GRP_NM}</td>
							<td>
							<c:choose>
								<c:when test="${data.ORG_TYPE eq '1'}">??????</c:when>
								<c:when test="${data.ORG_TYPE eq '2'}">??????/??????</c:when>
								<c:otherwise>????????????</c:otherwise>
							</c:choose>
							 </td>
							 <td>
								<c:choose>
									<c:when test="${data.APPLY_CD eq '10'}">??????</c:when>
									<c:when test="${data.APPLY_CD eq '20'}">??????</c:when>
									<c:when test="${data.APPLY_CD eq '30'}">??????</c:when>
									<c:otherwise>????????????</c:otherwise>
								</c:choose>
							</td>
							<td>${data.REG_DT}</td>
						</tr>
						</c:forEach>
					</c:when>
					<c:when test="${totalCount eq 0}">
						<tr><td colspan='5'>????????? ????????? ????????????.</td></tr>
					</c:when>
					<c:otherwise>
						<tr><td colspan='5'>????????? ????????? ????????????.</td></tr>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
		<%=util.getPaging(staticVO, nowPage) %>

		<div class="btn_box">
			<div class = "btn_right_box">
				<input type="button" class="btn_inp_b_01" value="??????/?????? ??????" onclick="pageWriteGo()">
			</div>
		</div>

<script type="text/javascript">
	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});

	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx, areaCd){
		$('#mode').val('view');
 		$('#orgGrpCd').val(idx);
 		$('#areaCd').val(areaCd);
		$('#searchForm').submit();
	}
	function pageWriteGo(){
		$('#mode').val('write');
		$('#searchForm').submit();
	}
</script>
