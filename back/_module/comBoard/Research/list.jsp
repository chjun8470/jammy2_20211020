<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	
	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("userMap");
	ArrayList<HashMap<String, String>> noticeList = request.getAttribute("noticeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("noticeList");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");	
	//LoginVO loginVO = request.getAttribute("PmsLoginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("PmsLoginVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	
	String siteComIdx = util.getStr(paramMap.get("siteComIdx"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String tab = util.getStr(paramMap.get("tab"));
	String auth_lv = util.getStr(userMap.get("AUTH_LV"));
	String userId = util.getStr(userMap.get("USER_ID"));
	String tabApp = util.getStr(paramMap.get("tabApp"));
	String noticeYn = util.getStr(boardMap.get("PERM_NOTICE"));
	
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
<%

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
	<div style="position:relative;">
		<form action="./<%=myPage %>" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="siteComIdx" id="siteComIdx" value="<%=siteComIdx%>" />
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="tab" id="tab" value="<%=tab%>" />
			<input type="hidden" name="auth_lv" id="auth_lv" value="<%=auth_lv%>" />
			<input type="hidden" name="userId" id="userId" value="<%=userId%>" />
			<input type="hidden" name="afterBoardComIdx" id="afterBoardComIdx" value="" />
			<input type="hidden" name="tabApp" id="tabApp" value="<%=tabApp%>" />
			
			<div class="tabbox">
				<div class="tabBtn<%if("".equals(tabApp)){out.print("_on");} %>" onclick="tabGoLink('')" >전체</div>
				<div class="tabBtn<%if("2".equals(tabApp)){out.print("_on");} %>" onclick="tabGoLink(2)" >승인</div>
				<div class="tabBtn<%if("1".equals(tabApp)){out.print("_on");} %>" onclick="tabGoLink(1)" >요청</div>
				<div class="tabBtn<%if("3".equals(tabApp)){out.print("_on");} %>" onclick="tabGoLink(3)" >반려</div>
			</div>
			
			<div class="basic_grid">
				<div class="search_box" style='height:35px; padding: 10px 10px 8px 10px;'>
					<label for="searchType" class="hide">검색종류선택</label>
					<!-- searchCnd s -->
						<select name="searchType" id="searchType" class="select" style="height: 24px">
							<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>제목</option>
							<option value="WRITER_ID" <%if("WRITER_ID".equals(util.getStr(paramMap.get("searchType")))) {%>selected="selected"<%} %>>글쓴이</option>
						</select>
					<!-- searchCnd e -->

					<label for="searchWord" class="hide">키워드</label>
					<input type="text" name="searchWord" id="searchWord" class="board-input" style="height:20px;" value="<%=util.getStr(paramMap.get("searchWord"))%>" />

					<!-- 검색버튼 s -->
					
						<input type="image" style="float: right;" class="input_submit" src='/imgs/board/btn_search.gif' alt="검색"/>
					
					<!-- 검색버튼 e -->
				</div>
				<!-- search_box e -->
			</div>
			<!-- basic_grid e -->
		

		<br/>
		<div class="tabBox" style="margin-top:10px;">
			<ul id =tabul style="width:100%;">
			<%if(boardComIdx.equals("00009")){ %>
				<li class="<%if(tab.equals("build") || tab.equals("")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('build')">장비구축 수요조사</a></li>
				<li class="<%if(tab.equals("uses")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('uses')">장비활용 수요조사</a></li>
				<li class="<%if(tab.equals("trans")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('trans')">사이트이용 만족도조사</a></li>
				<li class="<%if(tab.equals("rese")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('rese')">장비이용자 만족도조사</a></li>
			<%}else if(boardComIdx.equals("00035")){ %>	
				<li class="<%if(tab.equals("dem") || tab.equals("")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('dem')">수요조사</a></li>
				<li class="<%if(tab.equals("csn")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('csn')">만족도조사</a></li>
			<%}else if(boardComIdx.equals("00039")){ %>
				<li class="<%if(tab.equals("dem") || tab.equals("")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('dem')">수요조사</a></li>
				<li class="<%if(tab.equals("chartr")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('chartr')">연구조직 특성조사</a></li>
				<li class="<%if(tab.equals("ability")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('ability')">연구역량조사</a></li>
				<li class="<%if(tab.equals("etc")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('etc')">기타특성조사</a></li>
				<li class="<%if(tab.equals("csn")){ %>on<%}%>" style="float:left;margin-left:10px;"><a href="#" onclick="goPage('csn')">만족도조사</a></li>
			<%} %>
			</ul>
		</div>
			[전체 <span><%=staticVO.getTotalCount() %></span>건, <span><%=staticVO.getNowPage() %></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" style="margin-top: 10px ;width: 100%;" >
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 6%;" />
				<col style="width: 6%;" />
				<col style="width: 40%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 6%;" />
				<col style="width: 6%;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">사이트 ID</th>
					<th scope="col">제목</th>
					<th scope="col">글쓴이</th>
					<th scope="col">작성일</th>
					<th scope="col">조회수</th>
					<th scope="col">파일</th>
					<th scope="col">상태</th>
				</tr>
			</thead>
			<!-- thead s -->

			<!-- tbody s -->
			<tbody>
			<%
				if(noticeYn.equals("Y")){
					for(HashMap rs:noticeList) {
				%>
				<tr>
					<td>공지</td>
					<td>
						<%=util.getStr(rs.get("SITE_ID"))%>
					</td>
					<td class="subject">
						<a href="javascript:void(0);" onclick="location.href='?mode=noticeView&amp;boardIdx=<%=util.getIntStr(rs.get("ARTICLE_ID"))%>&amp;afterBoardComIdx=<%=util.getStr(rs.get("BOARD_ID"))%>&amp;boardComIdx=<%=boardComIdx%>'"><%=util.getStr(rs.get("SUBJECT"))%></a>
					</td>
					<td>
						<%=util.getStr(rs.get("WRITER_ID"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("HITS"))%>
					</td>
					<td class="r_line_none file">
					<%if(!(util.getStr(rs.get("FILE_ID"))).equals(null) && !(util.getStr(rs.get("FILE_ID"))).equals("")){
						String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
											+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
											+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
                    	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src="/img/board/ico_file.png" alt="첨부파일 아이콘" /></a>
                    <%}%>
					</td>
					<td>
					</td>
				</tr>
				<%
					}
				}
				%>
			
			
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {
				if(util.getStr(rs.get("ARTICLE_PARNTS_ID")).equals("0")){%>
				<tr style="cursor:pointer;" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'" onclick="location.href='?mode=view&amp;boardIdx=<%=util.getIntStr(rs.get("ARTICLE_ID"))%>&amp;boardComIdx=<%=boardComIdx%>'">
					
					<td>
						<%=cont%>
					</td>
					<td>
						<%=util.getStr(rs.get("SITE_ID"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("SUBJECT"))%>
					</td>
					<td><%=util.getStr(rs.get("WRITER_ID"))%></td>
					<td>
						<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
					</td>
					<td>
						<%=util.getStr(rs.get("HITS"))%>
					</td>
					<td>
						<%if( !"".equals(util.getStr(rs.get("FILE_CAT"))) ){
							String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
												+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
												+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
							%>
	                    	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src="/img/board/ico_file.png" alt="첨부파일 아이콘" /></a>
			    		<%} %>
					</td>
					<td>
						<%if(util.getStr(rs.get("DATA15")).equals("1")){%>
						요청
						<%}else if(util.getStr(rs.get("DATA15")).equals("2")){ %>
						승인
						<%}else if(util.getStr(rs.get("DATA15")).equals("3")){ %>
						반려
						<%} %>
					</td>	
				</tr>
				
			<%
					cont--;
				}
			}
			%>

			</tbody>
		</table>

		<div class="btn_box">
			&nbsp;

			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
			<div class="btn_right_box">
				<input type="button" class="btn_inp_b_01" value="등록" onclick="goSubmit('write')"/>
			</div>
			<%
			}
			%>
		</div>

		</form>
		<!-- searchForm e -->
	</div>

</div>

<%=util.getPaging(staticVO, nowPage) %>

<!--// bo_btn -->
<script type="text/javascript">
	function goSubmit(mode,boardIdx,replyIdx,auth,data){
		$('#mode').val(mode);
		$('#boardIdx').val(boardIdx);
		$('#replyIdx').val(replyIdx);
		$('#searchForm').submit();
	}
	function goPage(tab){
		$('#tab').val(tab);
		$('#searchForm').submit();
	}
	function goNo(mode,boardIdx,afterBoardComIdx){
		$('#afterBoardComIdx').val(afterBoardComIdx);
		$('#boardIdx').val(boardIdx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}
	function tabGoLink(no){
		$('#tabApp').val(no);
		$('#searchForm').submit();
	}
</script>