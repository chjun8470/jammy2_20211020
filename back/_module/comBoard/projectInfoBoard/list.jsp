<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> supportTypeList = request.getAttribute("supportTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("supportTypeList");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String siteId = loginVO.getLogSiteInfo();
	

	if((util.getBbsAuth(loginVO,boardMap,"LIST")).equals(false)){
%>
	<script type="text/javascript" >
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
	</script>
<%
		return;
	}
%>

<div class="skin_list">
	<div>
		<form action="./<%=myPage%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />


			<div class="bbs-top">
			<div class="basic_grid">
			<div class="search_box" style="padding:10px">
				<div class="board-search" style="line-height:27px;">
					<h4 style="">지원유형 </h4>
					<div style="position:relative;">
						    	<%
									int cnt = 1;
									for(HashMap rs:supportTypeList) {

										String ckChecked = "NO";
										if(request.getParameterValues("searchSupportType[]") != null){
											String[] ckTp = request.getParameterValues("searchSupportType[]");

											for(int i =0;  i < ckTp.length ; i++){
												if(util.getStr(rs.get("CODE_CD")).equals(ckTp[i])){
													ckChecked = "YES";
												}
											}
										}

								%>
								<span style="float:left; padding:0px 5px;"><input type="checkbox" name="searchSupportType[]" id="sstp<%=cnt%>" value="<%=util.getStr(rs.get("CODE_CD"))%>" <%if("YES".equals(ckChecked)) {%> checked="checked" <%}%>>
									  <label for="sstp<%=cnt%>"><%=util.getStr(rs.get("CODE_NM"))%></label>
								</span>
								<%
									cnt++;
									}
								%>
					</div>
					<div style="position:relative;clear:both;">
					<label  for="searchReceipt" >접수상태 :</label>
					<select class="select" name="searchReceipt" id="searchReceipt" style="width: 85px; height: 24px;">
						<option value="">전체</option>
						<option value="접수전" <%if("접수전".equals(util.getStr(paramMap.get("searchReceipt")))) {%> selected="selected" <%}%>>접수전</option>
						<option value="접수중" <%if("접수중".equals(util.getStr(paramMap.get("searchReceipt")))) {%> selected="selected" <%}%>>접수중</option>
						<option value="접수마감" <%if("접수마감".equals(util.getStr(paramMap.get("searchReceipt")))) {%> selected="selected" <%}%>>접수마감</option>
					</select>
					<label  for="searchState" >승인상태 :</label>
					<select class="select" name="searchState" id="searchState" style="width: 85px; height: 24px;">
						<option value="">전체</option>
						<option value="승인요청" <%if("승인요청".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>승인요청</option>
						<option value="승인" <%if("승인".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>승인</option>
						<option value="반려" <%if("반려".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>반려</option>
					</select><br/>

					<!-- 검색필드 -->
					검색필드 :
					<label class="hide" for="searchType">검색종류선택</label>
					<select class="select" name="searchType" id="searchType" style="height: 24px">
						<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>사업명</option>						
						<option value="PROCHARGE" <%if("PROCHARGE".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>사업담당자</option>
					</select>
					<!-- 키워드 -->
					<label class="hide" for="keyword">키워드</label>
					<input class="board-input" type="text" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:750px; height:20px" />

					<!-- 검색버튼 -->
					<input type="button" class="btn_inp_g_01" value="검색" onclick="goSubmit('list')" />
					</div>
				</div>
				<!-- board-search e -->
				</div>
				</div>
			</div>
			<!-- bbs-top e -->

			<div class="total" style="float:left; text-align:left; vertical-align:middle; margin:10px; padding:2px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>

		</form>
		<!-- searchForm e -->

		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 6%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
				<col style="width: 20%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 10%;" />
			</colgroup>
			<!-- colgroup e -->
			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">지원유형</th>
					<th scope="col">사업명</th>
					<th scope="col">공고/접수기간</th>					
					<th scope="col">사업담당자</th>					
					<th scope="col">접수상태</th>
					<th scope="col">승인여부</th>
				</tr>
			</thead>
			<!-- thead s -->
			<!-- tbody s -->
			<tbody>
				<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
							for(HashMap rs:dataList) {

							/* 접수전, 접수중, 접수마감 색상코드*/
							String bgColor = "";
							if(util.getStr(rs.get("RECEIPT_NM")).equals("접수전")){
								bgColor = "#FFBB00";
							}else if(util.getStr(rs.get("RECEIPT_NM")).equals("접수중")){
								bgColor = "#FFBC9B";
							}else{
								bgColor = "#FAED7D";
							}
							/* 승인요청, 승인, 반려 색상코드*/
							String bgColor1 = "";
							String state = "";
							if(util.getStr(rs.get("DATA15")).equals("20")){
								bgColor1 = "#73bb1e";
								state ="승인";
							}else if(util.getStr(rs.get("DATA15")).equals("30")){
								bgColor1 = "#FFBC9B";
								state ="반려";
							}else{
								bgColor1 = "#FAED7D";
								state ="승인요청";
							}
				%>
				<tr>
					<td><%=cont%></td>
					<td>
						<%=util.getStr(rs.get("CODE_NM"))%>
					</td>
					<td class="subject">
						<a href="#" onclick="goSubmit('view','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>')">
						<u>
						<%if(util.getStr(rs.get("SUBJECT")).length()>15){%>
						<%=util.getStr(rs.get("SUBJECT")).substring(0, 15)+" · · · "%>
					<%}else{%>
						<%=util.getStr(rs.get("SUBJECT"))%>
					<%}%>
						
						</u></a>
					</td>
					<td>
						<%=util.getStr(rs.get("DATA03"))%>&nbsp; ~ &nbsp;<%=util.getStr(rs.get("DATA04"))%>
					</td>
					<td>
					<%if(util.getStr(rs.get("DATA10")).length()>7){%>
						<%=util.getStr(rs.get("DATA10")).substring(0, 7)+" · · · "%>
					<%}else{%>
						<%=util.getStr(rs.get("DATA10"))%>
					<%}%>					
					</td>					
					<td>
						<span class="btn_y_01" style="cursor:default; background-color:<%=bgColor%>;"><%=util.getStr(rs.get("RECEIPT_NM")) %></span>
					</td>
					<td>
						<span class="btn_y_01" style="cursor:default; background-color:<%=bgColor1%>;"><%=state%></span>
					</td>
				</tr>
				<% cont--; } %>
				<% if(staticVO.getTotalCount() == 0){ %>
				
					<tr>
						<td colspan="7">데이터가 없습니다.</td>
					</tr>
				
				<% } %>
			</tbody>
		</table>

		<div class="btn_box">
			&nbsp;
			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
			<div class="btn_right_box">
				<input type="button" class="btn_inp_b_01" value="글쓰기" onclick="goSubmit('write')"/>
			</div>
			<% } %>
		</div>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">

	function goSubmit(mode,boardIdx){
		$('#boardIdx').val(boardIdx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
</script>
