<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@include file="/front/_temple/popup/t_top.jsp" %>
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
	String userTp = util.getStr(paramMap.get("userTp"));

%>

<div class="popup_style">

	<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="banner_search">
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="myPage" id="myPage" value="<%=myPage%>" />
		<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
		<input type="hidden" name="orgType" id="orgType" value="<%=orgType%>" />
		<input type="hidden" name="userTp" id="userTp" value="<%=userTp%>" />


	<div class="search_p" style="margin:10px;">
		<div class="search_box">
			<div class="search_row">
				<!-- <select id="searchType" name="searchType">
					<option value="ORG" <%if("ORG".equals(searchType)) {%>selected="selected"<%} %>>기관명</option>
				</select>

				<input type="text" id="searchWord" name="searchWord" value="<%=searchWord %>" class="inp_txt" />
				-->
				<%if(orgType.equals("1")||userTp.equals("1")){ %>
				<label for="orgGrpNm">기업명 : </label>
                <input type="text" id="orgGrpNm" name="orgGrpNm" value="<%=orgGrpNm%>" class="inp_txt" />
				<%}else if(orgType.equals("2")||userTp.equals("2")){ %>
				<label for="orgGrpNm">기관명 : </label>
                <input type="text" id="orgGrpNm" name="orgGrpNm" value="<%=orgGrpNm%>" class="inp_txt" />
				<%} %>

				<input type="button" onclick="submitGo()" value="검색" class="btn_g_01" />
				<%if(orgType.equals("1")||userTp.equals("1")){ %>
					<input type="button" onclick="writeCompanyPop()" style="float: right;" value="기업등록" class="btn_b_01" />
				<% } %>
				<p style="color:#ff0000;" >※ 검색어를 입력해 검색해주세요.</p>
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
					<%if(orgType.equals("1")||userTp.equals("1")){ %>
					<th scope="col">기업명</th>
					<%}else if(orgType.equals("2")||userTp.equals("2")){ %>
					<th scope="col">기관명</th>
					<%} %>
					<th scope="col">선택</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {%>

				<tr>
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM"))%></td>
					<td class="name">
						<button class="btn_inp_w_01"  onclick="clickToBtn('<%=util.getStr(rs.get("ORG_GRP_CD"))%>')">선택</button>
					</td>
				</tr>
			<%
			cont--;
			}
				if(dataList.size() <= 0){
			%>
				<tr>
					<td colspan="3" >검색된 결과가 없습니다. 검색해 주시기 바랍니다.</td>
				</tr>

			<% } %>
			</tbody>
		</table>
		<div>
				<%=util.getPaging(staticVO, nowPage) %>
		</div>
			<div>
				<div class="btn_box">
					<div class="btn_left_box" style="float:left">
					<%if(!util.getStr(paramMap.get("orgGrpNm")).equals("") && false){ %>
						<input type="button" value="기업/기관 등록신청" class="btn_b_01" onclick="popupWindow('orgResvPop')"/>
					<%}%>
					</div>
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
function clickToBtn(idx){
	var orgGrpCd = idx;
		opener.orgInfo(orgGrpCd);
		window.close();
}

function popupWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

	var popUrl="/web/popup/"+listMode+".do";
	var popOption="width=817, height=700, resizable=no, scrollbars=yes, status=no;";
	window.open(popUrl,"orgResv",popOption);
}

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

//기업등록
function writeCompanyPop(){
	var popUrl="/web/popup/orgResvPop.do?orgType=1";
	var popOption="width=817, height=650, resizable=no, scrollbars=yes, status=no;";
	window.open(popUrl,"",popOption);
}
//]]>
</script>
<%@include file="/front/_temple/popup/t_footer.jsp" %>