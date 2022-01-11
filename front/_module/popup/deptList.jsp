<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
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
	String orgGrpNm = util.getStr(paramMap.get("orgGrpNm"));
	String orgType = util.getStr(paramMap.get("orgType"));
	
	
%>
<link href="/css/cms/front/board_3.css" media="all" rel="stylesheet" type="text/css">
<link href="/css/cms/front/base.css" media="all" rel="stylesheet" type="text/css">
<link href="/css/cms/front/my_page.css" media="all" rel="stylesheet" type="text/css">
<link href="/css/cms/front/media_960.css" media="all" rel="stylesheet" type="text/css">
<link href="/css/cms/front/media_480.css" media="all" rel="stylesheet" type="text/css">
<link href="/css/cms/front/login.css" media="all" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="/css/cms/back/board.css">
<link rel="stylesheet" type="text/css" href="/css/cms/front/sso_grid.css">


<div class="popup_style">
	<div class="MPTop">
		<h1 class="ci" style="left:190px">전남과학기술진흥센터</h1>
	</div>
	<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="banner_search">
				<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
				<input type="hidden" name="myPage" id="myPage" value="<%=myPage%>" />
				<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
				<input type="hidden" name="orgType" id="orgType" value="<%=orgType%>" />
				

	<div class="search_p" style="margin:10px;">
		<div class="search_box">
			<div class="search_row">
				부서명 : <input type="text" id="deptGrpNm" name="deptGrpNm" value="" class="inp_txt" />
				<input type="button" onclick="submitGo()" value="검색" class="btn_g_01" />
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
					<th scope="col">번호</th>
					<th scope="col">부서명</th>
					<th scope="col">선택</th>
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
						<button class="btn_inp_w_01"  onclick="clickToBtn('<%=util.getStr(rs.get("ORG_GRP_SUB_NM"))%>')">선택</button>
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
<!-- 					<div class="btn_left_box" style="float:left"> -->
<%-- 					<%if(!util.getStr(paramMap.get("orgGrpNm")).equals("")){ %> --%>
<!-- 						<input type="button" value="기업/기관 등록신청" class="btn_b_01" onclick="popupWindow('orgResvPop')"/> -->
<%-- 					<%}%> --%>
<!-- 					</div> -->
					<div class="btn_right_box" style="float:right">
						<input type="button" value="닫기" class="btn_b_01" onclick="pageClose()"/>
					</div>
				</div>
			</div>
	</div>
</div>
<!--팝업창 내용 적용시키는 부분 -->
<script type="text/javascript">
//<![CDATA[
function clickToBtn(deptSubNm){
	var deptSubNm = deptSubNm;
		$(opener.document).find("#deptNm").val(deptSubNm);
		window.close();
}

// function popupWindow(listMode){
// 	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

// 	var popUrl="/web/popup/"+listMode+".do";
// 	var popOption="width=800, height=650, resizable=no, scrollbars=no, status=no;";
// 	window.open(popUrl,"orgResv",popOption);
// }

function pageClose(){
	window.close();
}
function submitGo(){
	searchForm.submit();
}

	function pageClose(){
		window.close();
	}
	function submitGo(){
		searchForm.submit();
	}
//]]>	
</script>