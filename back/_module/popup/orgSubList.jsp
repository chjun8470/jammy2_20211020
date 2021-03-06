<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.Set,java.util.regex.*,java.text.*,java.net.*" %>
<%@include file="/back/_temple/popup/t_top.jsp" %>
<%
	ComUtil util = new ComUtil();
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	String listMode = paramMap.get("listMode");
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String searchWord = util.getStr(paramMap.get("searchWord"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String orgGrpCd = util.getStr(paramMap.get("orgGrpCd"));
	String mode = util.getStr(paramMap.get("mode"));
%>
<div class="popup_style">
	<div class="title_bar">
		:: ๋ถ์์กฐํ ::
	</div>
	<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="banner_search">
				<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
				<input type="hidden" name="myPage" id="myPage" value="<%=myPage%>" />
				<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
				<input type="hidden" name="orgGrpCd" id="orgGrpCd" value="<%=orgGrpCd%>" />
				<input type="hidden" name="mode" id="mode" value="<%=mode%>" />

	<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
				<select name="searchType" id="searchType" class="select" style="height: 24px">
					<option value="SUB_NAME" <%if("SUB_NAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>๋ถ์/์ผํฐ ๋ช</option>
				</select>
				<input type="text" id="searchWord" name="searchWord" value="<%=searchWord %>" class="inp_txt" />
					<input type="button" onclick="submitGo()" value="๊ฒ์" class="btn_g_01" />
			</div>
		</div>
	</div>
	</div>
	</form>
	<div class="contents_box">

		<table class="skin_basic_list">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 3%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">๋ฒํธ</th>
					<th scope="col">๋ถ์/์ผํฐ ๋ช</th>
					<th scope="col">์?ํ</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>
				<tr>
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%></td>
					<td class="name">
						<button id = "bu" class="btn_inp_w_01"  onclick="clickToBtn('<%=util.getStr(rs.get("ORG_GRP_SUB_CD"))%>','<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>')">์?ํ</button>
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
						<input type="button" value="๋ซ๊ธฐ" class="btn_b_01" onclick="pageClose()"/>
					</div>
				</div>
			</div>
	</div>
</div>

<!--ํ์์ฐฝ ๋ด์ฉ ์?์ฉ์ํค๋ ๋ถ๋ถ -->
<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/js/cms/back/func_sys.js"></script>
<script type="text/javascript" src="/js/board.js"></script>
<script type="text/javascript">

	function clickToBtn(orgGrpCd,orgNm){
		<% if( mode.equals("total") ){%>
			$(opener.document).find("#orgSubGrpCd").val(orgGrpCd);
			$(opener.document).find("#orgSubNm").val(orgNm);
		<% }else{ %>
			$(opener.document).find("#deptNm").val(orgNm);
		<% } %>
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