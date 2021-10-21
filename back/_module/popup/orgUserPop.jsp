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
						<option value="ID" <%if("ID".equals(searchType)) {%>selected="selected"<%} %>>담당자ID</option>
						<option value="NAME" <%if("NAME".equals(searchType)) {%>selected="selected"<%} %>>담당자명</option>
						<%if(loginVO.getAuthLv().equals("99")){%>
						<option value="ORG_NAME" <%if("ORG_NAME".equals(searchType)) {%>selected="selected"<%} %>>기관명</option>
						<%}%>
						<option value="DEPT_NAME" <%if("DEPT_NAME".equals(searchType)) {%>selected="selected"<%} %>>부서명</option>
					</select>
					<input type="text" id="searchWord" name="searchWord" value="<%=searchWord %>" class="inp_txt" />
						<input type="button" onclick="submitGo()" value="검색" class="btn_g_01" />
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
						<th scope="col">번호</th>
						<th scope="col">기관명</th>
						<th scope="col">ID</th>
						<th scope="col">이름</th>
						<th scope="col">선택</th>
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
							<button id = "bu" class="btn_inp_w_01"  onclick="clickToBtn('<%=util.getStr(rs.get("USER_IDX"))%>')">선택</button>
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
							<input type="button" value="닫기" class="btn_b_01" onclick="pageClose()"/>
						</div>
					</div>
				</div>
		</div>
	</div>

</body>
</html>

<!--팝업창 내용 적용시키는 부분 -->
<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
<script type="text/javascript">


	function clickToBtn(idx){

		var userIdx = idx;
		var name;
		var birthday;
		var nationality;
		var num1;
		var params = {
				"userIdx": userIdx
		};
		$.post("/sys/getUser.do",$.param(params),
		function(data){
			psnNm = data.dataMap.PSN_NM;
			telNo = data.dataMap.TEL_NO;
			faxNo = data.dataMap.FAX_NO;
			positionNm = data.dataMap.POSITION_NM;
			email = data.dataMap.EMAIL;
			dept = data.dataMap.DEPT_NM;
			orgGrpNm = data.dataMap.ORG_GRP_NM;

			if(nationality=="N"){
				nationality = "대한민국";
			}else{
				nationality = "";
			}

			$(opener.document).find("#equUserIdx").val(idx);
			$(opener.document).find("#operPsnNm").val(psnNm);
			$(opener.document).find("#operChargerTd").text(psnNm);
			$(opener.document).find("#operPositionTd").text(positionNm);
			$(opener.document).find("#operTelTd").text(telNo);
			$(opener.document).find("#operEmailTd").text(email);
			$(opener.document).find("#operOrgGrp").text(orgGrpNm);
			$(opener.document).find("#operDeptTd").text(dept);
			
			$(opener.document).find("#operChargerTd").val(psnNm);
			$(opener.document).find("#operPositionTd").val(positionNm);
			$(opener.document).find("#operTelTd").val(telNo);
			$(opener.document).find("#operEmailTd").val(email);
			$(opener.document).find("#operOrgGrp").val(orgGrpNm);
			$(opener.document).find("#operDeptTd").val(dept);
			
			$(opener.document).find("#operFaxTd").val(faxNo);

			window.close();
		});



	}
	function pageClose(){
		window.close();
	}
	function submitGo(){
		searchForm.submit();
	}
</script>

<%@include file="/back/_temple/popup/t_footer.jsp" %>