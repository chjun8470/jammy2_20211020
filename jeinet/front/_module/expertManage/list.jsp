<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();


	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));

	String fileGrp = "expertManage";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	int authLv = 0;
	if(loginVO.getAuthLv() != null) {
		authLv = Integer.parseInt(loginVO.getAuthLv());
	}
	int writeAuth = util.getInt(loginVO.getAuthLv());
%>

<div class="list_top007">
	<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="m" id="m" value="<%=m%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="userIdx" id="userIdx" value="" />


		<div class="board_count007">
			[전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건]
			<%-- [전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page] --%>
		</div>
		<div class="b_srchBox007">

			<div class="b_srch007">
				<input class="b_srch_txt007" name="searchWord" id="searchWord" type="text" title="검색단어입력" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
				<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn007" alt="바로가기" value="검색" onclick="goSubmit('list')" />
			</div>

			<select name="searchType" id="searchType" class="b_select007">
				<option value="ORG" <%if("ORG".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>기관명</option>
				<option value="DEPT" <%if("DEPT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>부서명</option>
				<option value="NAME" <%if("NAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>이름</option>
				<option value="MAJOR" <%if("MAJOR".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>전공분야</option>
				<option value="AREA" <%if("AREA".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>출신지역</option>
				<%-- <option value="SCHOOL" <%if("SCHOOL".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>학교명</option>
				<option value="LASTSCHOOL" <%if("LASTSCHOOL".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>최종학위</option> --%>
			</select>

		</div>
	</form>
</div>

<!-- skin_basic_list s -->
<div class="pub_list03" id="cont_block">
	<ul class="pub_list03_blog">
	<%
		int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
		int num = 1;
		if(dataList.size()>0){
			for(HashMap rs:dataList) {

				String fileParam = "/img/main/no_image01.gif";
				if(!util.getStr(rs.get("FILE_ID")).equals("") && !util.getStr(rs.get("FILE_ID")).equals(null)){
					fileParam = "/file/"+fileGrp+"/"+rs.get("TITLE");
				}
		%>
		<li>
			<p class="img_publist03_blog" style="width: 150px;height: 180px; cursor: pointer;" onclick="goSubmit('view','<%=util.getStr(rs.get("USER_IDX"))%>')">
				<img src = "<%=fileParam%>" style="width: 150px;height: 180px; cursor: pointer;" alt="img<%=num%>" />
			</p>
			<div class="explanation">
				<p class="tit_publist03_blog01"  style="cursor: pointer;" onclick="goSubmit('view','<%=util.getStr(rs.get("USER_IDX"))%>')"><%=util.getStr(rs.get("PSN_NM"))%></p>
				<p class="txt_publist03_blog01" style="cursor: pointer;" onclick="goSubmit('view','<%=util.getStr(rs.get("USER_IDX"))%>')">
					직위 : <%=util.getStr(rs.get("POSITION_NM"))%> &nbsp;/&nbsp;&nbsp;
					기관명 : <%=util.getStr(rs.get("ORG_GRP_NM"))%> &nbsp;/&nbsp;&nbsp;
					 부서명 : <%=util.getStr(rs.get("DEPT_NM"))%>
				</p>
				<p class="txt_publist03_blog02" style="overflow: hidden; cursor: pointer;" onclick="goSubmit('view','<%=util.getStr(rs.get("USER_IDX"))%>')">
					- 주전공</br>
					&nbsp;&nbsp;<%=util.getStr(rs.get("EX_MAJOR_NAME"))%>
					</br>
					<%if(!(util.getStr(rs.get("EX_MAJOR_PLURAL_NAME"))).equals(null) || !(util.getStr(rs.get("EX_MAJOR_PLURAL_NAME"))).equals("")){ %>
					- 복수전공</br>
					&nbsp;&nbsp;<%=util.getStr(rs.get("EX_MAJOR_PLURAL_NAME"))%>
					<%} %>
					</br>
					- 관심분야</br>
					&nbsp;&nbsp;<%=util.getStr(rs.get("PRO_USER_INTEREST_WORLD"))%>
				</p>

			</div>
		</li>

			<% cont--;  }
	}else{%>
			 <li style="text-align: center;">데이터가 없습니다.</li>
	<%}%>
	</ul>

	<div class="b_btn_area">
		<% if(util.loginCheck() && authLv >= writeAuth) { %>
			<button class="btn_rgt" onclick="goSubmit('write')">등록</button>
		<% } else { %>
			<button class="btn_rgt" onclick="goLogin()">등록</button>
		<% } %>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>
<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,userIdx){
		$('#userIdx').val(userIdx);
		$('#mode').val(mode);
		if(mode == "view"){
			$('#searchForm').attr('method','get');
		}
		$('#searchForm').submit();
	}
	function goLogin() {
		alert("로그인이 필요합니다.");
		javascript:ssoPopupShow('login');
	}

	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});
</script>