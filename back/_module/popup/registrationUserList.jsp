<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.Set,java.util.regex.*,java.text.*,java.net.*" %>
<%@include file="/back/_temple/popup/t_top.jsp" %>
<%
	ComUtil util = new ComUtil();
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");

	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	String listMode = paramMap.get("listMode");
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String orgGrpNm = util.getStr(paramMap.get("orgGrpNm"));
%>
<div class="popup_style">
	<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="banner_search">
				<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
				<input type="hidden" name="myPage" id="myPage" value="<%=myPage%>" />
				<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
				<input type="hidden" name="name" id="name" value="" />
				<input type="hidden" name="birthday" id=birthday value="" />
				<input type="hidden" name="nationality" id="nationality" value="" />

	<div class="bbs-top">
		<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<select id="searchType" name="searchType">
					<option value="ID" <%if("ID".equals(searchType)) {%>selected="selected"<%} %>>??????ID</option>
					<option value="NAME" <%if("NAME".equals(searchType)) {%>selected="selected"<%} %>>?????????</option>
					<%if(loginVO.getAuthLv().equals("99")){%>
					<option value="ORG_NAME" <%if("ORG_NAME".equals(searchType)) {%>selected="selected"<%} %>>?????????</option>
					<%}%>
				</select>
				<input type="text" id="searchWord" name="searchWord" value="<%=searchWord %>" class="inp_txt" />
					<input type="button" onclick="submitGo()" value="??????" class="btn_g_01" />
			</div>
		</div>
	</div>

	</form>
	<div class="contents_box">

		<table class="skin_basic_list">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 40%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">ID</th>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<tr>
					<td><%=cont%></td>
					<td class="subject"><%=util.getStr(rs.get("ORG_GRP_NM"))%></td>
					<td><%=util.getStr(rs.get("USER_ID"))%></td>
					<td><%=util.getStr(rs.get("PSN_NM"))%></td>
					<td>
						<button id = "bu" class="btn_inp_w_01"  onclick="clickToBtn('<%=util.getStr(rs.get("ORG_GRP_NM"))%>','<%=util.getStr(rs.get("DEPT_NM"))%>','<%=util.getStr(rs.get("PSN_NM"))%>','<%=util.getStr(rs.get("POSITION_NM"))%>','<%=util.getStr(rs.get("TEL_NO"))%>','<%=util.getStr(rs.get("EMAIL"))%>','<%=util.getStr(rs.get("USER_IDX"))%>')">??????</button>
					</td>
				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<div>
				<%=util.getPaging(staticVO, nowPage) %>
		</div>
			<div>
				<div class="btn_box">
					<div class="btn_right_box">
						<input type="button" value="??????" class="btn_b_01" onclick="pageClose()"/>
					</div>
				</div>
			</div>
	</div>
</div>

<!--????????? ?????? ??????????????? ?????? -->
<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
<script type="text/javascript">


	function clickToBtn(orgNm,deptNm,psnNm,position,tel,email,idx){

			$(opener.document).find("input[name=ManagerIdx]").val(idx);
			$(opener.document).find("input[name=ManagerOrgNm]").val(orgNm);
			$(opener.document).find("input[name=ManagerDeptNm]").val(deptNm);
			$(opener.document).find("input[name=ManagerPsnNm]").val(psnNm);
			$(opener.document).find("input[name=ManagerPosition]").val(position);
			$(opener.document).find("input[name=ManagerTel]").val(tel);
			$(opener.document).find("input[name=ManagerEmail]").val(email);

			window.close();


	}
	function pageClose(){
		window.close();
	}
	function submitGo(){
		searchForm.submit();
	}
</script>

<%@include file="/back/_temple/popup/t_footer.jsp" %>