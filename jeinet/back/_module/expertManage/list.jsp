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

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String proStateTap = util.getStr(paramMap.get("proStateTap"));

	String fileGrp = "expertManage";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>
<style type="text/css" scoped>

	.tabbox{
		position:relative;
		border-bottom:1px solid #cccccc;
		margin-top:10px;
		margin-bottom:10px;
		padding-left:20px;
	}
	.tabbox .tabBtn {
		position:relative;
		display:inline-block;
		height:30px;
		line-height:30px;
		width:100px;
		background-color:#d0d0d0;
		color:#ffffff;
		border-top:1px solid #cccccc;
		border-left:1px solid #cccccc;
		border-right:1px solid #cccccc;
		text-align:center;
		margin-right:10px;
		top:1px;
		cursor:pointer;
	}

	.tabbox .tabBtn_on{
		position:relative;
		display:inline-block;
		height:30px;
		line-height:30px;
		width:100px;
		color:#fffff;
		border-top:1px solid #cccccc;
		border-left:1px solid #cccccc;
		border-right:1px solid #cccccc;
		border-bottom:1px solid #ffffff;
		text-align:center;
		margin-right:10px;
		background-color:#ffffff;
		top:1px;
		color:#fffff;
		cursor:pointer;
	}

</style>

<div class="skin_list">
	<div>
		<form action="./<%=myPage%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="userIdx" id="userIdx" value="" />

			<div class="tabbox">
				<div class="tabBtn<%if("1".equals(proStateTap)||"".equals(proStateTap)){out.print("_on");} %>" onclick="tabGoLink(1)" >??????</div>
				<div class="tabBtn<%if("20".equals(proStateTap)){out.print("_on");} %>" onclick="tabGoLink(20)" >??????</div>
				<div class="tabBtn<%if("10".equals(proStateTap)){out.print("_on");} %>" onclick="tabGoLink(10)" >??????</div>
				<div class="tabBtn<%if("30".equals(proStateTap)){out.print("_on");} %>" onclick="tabGoLink(30)" >??????</div>
			</div>

			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search">
					<select name="searchType" id="searchType" class="select" style="height: 24px">
						<option value="ORG" <%if("ORG".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
						<option value="DEPT" <%if("DEPT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
						<option value="NAME" <%if("NAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>??????</option>
						<option value="MAJOR" <%if("MAJOR".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>????????????</option>
						<option value="AREA" <%if("AREA".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>????????????</option>
						<%-- <option value="SCHOOL" <%if("SCHOOL".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>?????????</option>
						<option value="LASTSCHOOL" <%if("LASTSCHOOL".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>????????????</option> --%>
					</select>
					<!-- ????????? -->
					<input type="text" name="searchWord" id="searchWord" class="board-input" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
					<!-- ???????????? -->
					<input type="button" class="btn_inp_g_01" value="??????" onclick="goSubmit('list')" />
				</div>
				<!-- board-search e -->
				</div>
				</div>
			</div>
			<!-- bbs-top e -->

			<div class="total" style="margin-top: 10px;">
				[?????? <span><%=staticVO.getTotalCount()%></span>???, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
				<span style="float:right"><input type="button" class="btn_inp_b_01"  value="????????????" onclick="excelDown()"></span>
			</div>

		<!-- searchForm e -->

		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">?????????</th>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">??????</th>
					<th scope="col">????????????</th>
					<th scope="col">????????????</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
				for(HashMap rs:dataList) {
				%>
				<tr onclick="location.href='./<%=myPage%>?mode=view&amp;userIdx=<%=util.getStr(rs.get("USER_IDX"))%>'" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'">
					<td><%=cont%></td>
					<td>
						<%if(util.getStr(rs.get("FILE_ID")).equals("") || util.getStr(rs.get("FILE_ID")).equals(null)){ %>
							<img  style="width:90px; height: 100px;" src="/img/main/no_image01.gif" alt="???????????????" />
						<%}else{%>
							<img src = "/file/<%=fileGrp+"/"+rs.get("TITLE")%>" style="width:90px; height: 100px;" alt="???????????????" />
						<%}%>

					</td>
					<td>
						<%=util.getStr(rs.get("ORG_GRP_NM"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("PSN_NM"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("DEPT_NM"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("GENDER_TYPE_CD"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("TEL_NO"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("PRO_STATE"))%>
					</td>
				</tr>
				<% cont--; } %>
			</tbody>
		</table>
</form>
	<%=util.getPaging(staticVO, nowPage)%>
		<div class="btn_box">
			&nbsp;
			<% if(util.loginCheck()) { %>
			<div class="btn_right_box">
					<input type="button" class="btn_inp_b_01" value="????????????" onclick="location.href='./<%=myPage%>?mode=write'"/>
			</div>
			<% } %>
		</div>
	</div>
</div>


<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,userIdx){
		$('#userIdx').val(userIdx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}

	function excelDown(){
		$('#searchForm').attr('action','/sys/expertExcelDown.do');
		$('#searchForm').attr('target','_blank');
		$('#searchForm').submit();
		$('#searchForm').attr('action','./<%=myPage %>');
		$('#searchForm').attr('target','');
	}

	$(function(){
		$('.menuRows').mouseover(function(){
			$('.menuRows').css('background-color','#fffff');
			$(this).css('background-color','#80c5fd');
		});
		$('.menuRows').mouseout(function(){
			$('.menuRows').css('background-color','#fffff');
		});
	});
	function tabGoLink(no){
		location.href = "/sys/sys_expert_manage.do?proStateTap="+no;
	}


</script>