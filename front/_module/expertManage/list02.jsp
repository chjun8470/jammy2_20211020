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
%>

<div class="list_top" style="margin-bottom: 5px;" >
	<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="m" id="m" value="<%=m%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="userIdx" id="userIdx" value="" />


		<div class="board_count">
			[전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건]
			<%-- [전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page] --%>
		</div>
		<div class="b_srchBox">
			<select name="searchType" id="searchType" class="b_select">
				<option value="NAME" <%if("NAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>이름</option>
			</select>
			<div class="b_srch">
				<input class="b_srch_txt" name="searchWord" id="searchWord" type="text" title="검색단어입력" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
				<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn" alt="바로가기" value="검색" onclick="goSubmit('list')" />
			</div>
			<div class="list_sort">
			</div>
			<div class="b_srchBox_gap">
			</div>
			<div class="b_btn_listBox">
			</div>
		</div>
	</form>
</div>

<!-- skin_basic_list s -->
<div class="pub_list" id="cont_block">
	<ul class="pub_list_blog" style="margin-top:0;">
		<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			int num = 1;
			for(HashMap rs:dataList) {

				String fileParam = "/img/main/no_image01.gif";
				if(!util.getStr(rs.get("FILE_ID")).equals("") && !util.getStr(rs.get("FILE_ID")).equals(null)){
					fileParam = "/file/"+fileGrp+"/"+rs.get("TITLE");
				}
		%>
	<li>
		<p class="img_publist_blog"><a href="#" onclick="goSubmit('view','<%=util.getStr(rs.get("USER_IDX"))%>')"><img src = "<%=fileParam%>" width="199" height="281" alt="img<%=num%>" /></a></p>
		<div class="explanation">
			<p class="tit_publist_blog01"><a href="#" onclick="goSubmit('view','<%=util.getStr(rs.get("USER_IDX"))%>')"><%=util.getStr(rs.get("PSN_NM"))%></a></p>
			<p class="txt_publist_blog01"><a href="#" onclick="goSubmit('view','<%=util.getStr(rs.get("USER_IDX"))%>')">
			소속 : <%=util.getStr(rs.get("ORG_GRP_NM"))%><br/>
			 부서 : <%=util.getStr(rs.get("DEPT_NM"))%><br/>
			직급 : <%=util.getStr(rs.get("POSITION_NM"))%> <br/>
			</a></p>
			<p class="txt_publist_blog02" style="overflow: hidden;"><a href="#" onclick="goSubmit('view','<%=util.getStr(rs.get("USER_IDX"))%>')"><%=util.getStr(String.valueOf(rs.get("CONTENT")).replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""))%></a></p>
		</div>
	</li>

			<% cont--;  }%>
	</ul>

	<div class="b_btn_area">
	<% if(util.loginCheck()) { %>
		<button class="btn_rgt" onclick="goSubmit('write')">등록하기</button>
	<% } %>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>
<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,userIdx){
		$('#userIdx').val(userIdx);
		$('#mode').val(mode);
		if(mode == "view"){
			$('#searchForm').attr('method','get');
		}
		$('#searchForm').submit();
	}
//]]>
</script>