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
	ArrayList<HashMap<String, String>> userDataList = request.getAttribute("userDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("userDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));
	String userAppState = util.getStr(paramMap.get("userAppState"));
%>
<style type="text/css" 	scoped>

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

	<form id = "searchForm" name = "searchForm" method="post" action="/sys/sys_user.do">
		<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="reURl" id="reURl" value="<%=myPage%>" />
		<input type="hidden" name = "userIdx" id = "userIdx" />
		<input type="hidden" name="userAppState" id="userAppState" value="<%=userAppState%>" />
		<div class="tabbox">
			<div class="tabBtn<%if("1".equals(userAppState)||"".equals(userAppState)){out.print("_on");} %>" onclick="tabGoLink(1)" >전체</div>
			<div class="tabBtn<%if("20".equals(userAppState)){out.print("_on");} %>" onclick="tabGoLink(20)" >승인</div>
			<div class="tabBtn<%if("10".equals(userAppState)){out.print("_on");} %>" onclick="tabGoLink(10)" >요청</div>
			<div class="tabBtn<%if("30".equals(userAppState)){out.print("_on");} %>" onclick="tabGoLink(30)" >반려</div>
		</div>
		<div class="bbs-top">
		<div class="basic_grid">
		<div class="search_box" style="padding:10px">
			<div class="board-search">
				<label for="searchType" class="hide">검색종류선택</label>
				<select name="userType" id="userType" class="select" style="height: 29px">
					<option value="ALL">전체</option>
					<option value="01" <%if("01".equals(util.getStr(paramMap.get("userType")))) {%>selected="selected"<%} %>>일반회원</option>
					<option value="10" <%if("10".equals(util.getStr(paramMap.get("userType")))) {%>selected="selected"<%} %>>기업회원</option>
					<option value="70" <%if("70".equals(util.getStr(paramMap.get("userType")))) {%>selected="selected"<%} %>>기관담당자</option>
					<%-- <option value="80" <%if("80".equals(util.getStr(paramMap.get("userType")))) {%>selected="selected"<%} %>>기관관리자</option>
					<option value="99" <%if("99".equals(util.getStr(paramMap.get("userType")))) {%>selected="selected"<%} %>>최고관리자</option> --%>
				</select>
				<select name="searchType" id="searchType" class="select" style="height: 29px">
					<option value="ORG_NAME" <%if("ORG_NAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>기관명</option>
					<option value="ID" <%if("ID".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>아이디</option>
					<option value="NAME" <%if("NAME".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>이름</option>
				</select>
				<!-- 키워드 -->
				<input type="text" name="searchWord" id="searchWord" class="board-input"style="height: 25px" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
				<!-- 검색버튼 -->
				<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('list')" />
			</div>
			<!-- board-search e -->
			</div>
			</div>
		</div>
		<!-- bbs-top e -->
		<div class="total">
			[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			<span style="float:right"><input type="button" class="btn_inp_b_01"  value="엑셀저장" onclick="excelDown()"></span>
		</div>

		<!-- skin_basic_list s -->
		<table class="skin_basic_list">
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 20%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">회원구분</th>
					<th scope="col">기관</th>
					<th scope="col">ID</th>
					<th scope="col">요청자</th>
					<th scope="col">요청날짜</th>
					<th scope="col">메일확인여부</th>
					<th scope="col">상태</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:userDataList) {%>
				<tr onclick="location.href='./<%=myPage%>?mode=view&amp;userIdx=<%=util.getStr(rs.get("USER_IDX"))%>'" style="cursor:pointer;" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='#ffffff'">
					<td><%=cont%></td>
					<td><%=util.getStr(rs.get("AUTH_LV_NAME"))%></td>
					<td><%=util.getStr(rs.get("ORG_GRP_NM"))%></td>
					<td><%=util.getStr(rs.get("USER_ID"))%></td>
					<td><%=util.getStr(rs.get("PSN_NM"))%></td>
					<td><%=util.getStr(rs.get("REG_DT"))%></td>
					<td><%=util.getStr(rs.get("EMAIL_CHECK_YN"))%></td>
					<td>
						<%if(util.getStr(rs.get("USER_APP_STATE")).equals("승인")){%>
							<font color="#0000ff"><%=util.getStr(rs.get("USER_APP_STATE"))%></font>
						<%}else if(util.getStr(rs.get("USER_APP_STATE")).equals("반려")){%>
							<font color="#ff0000"><%=util.getStr(rs.get("USER_APP_STATE"))%></font>
						<%}else{%>
							<%=util.getStr(rs.get("USER_APP_STATE"))%>
						<%} %>
					</td>
				</tr>
			<%
			cont--;
			} 
			
			if(userDataList.size() == 0){
			%>
				<tr>
					<td colspan="8" >데이터가 없습니다.</td>
				</tr>
			<% } %>
			</tbody>
		</table>
	</form>
	<%=util.getPaging(staticVO, nowPage) %>
	<div class="btn_box">
		<div class="btn_right_box">
			<input type="button" onclick="location.href='./<%=myPage%>?mode=write'" value="등록" class="btn_inp_b_01" />
		</div>
	</div>





<script type="text/javascript">
	function excelDown(){
		$('#searchForm').attr('action','/sys/userExcelDown.do');
		$('#searchForm').attr('target','_blank');
		$('#searchForm').submit();
		$('#searchForm').attr('action','./<%=myPage %>');
		$('#searchForm').attr('target','');
	}

	function goSubmit(mode,idx){
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#userIdx').val(idx);
		$('#searchForm').submit();
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
		location.href = "/sys/sys_user.do?userAppState="+no;
	}
</script>


<!--// bo_btn -->
