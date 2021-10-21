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

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> noticeList = request.getAttribute("noticeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("noticeList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String m = util.getStr(paramMap.get("m"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String noticeYn = util.getStr(boardMap.get("PERM_NOTICE")); //공지여부
	String siteId = util.getStr(paramMap.get("siteId")); //사이트구분

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

	<div class="list_top006">
		<form class="boardSearch" name="searchForm" id="searchForm" action="sub.do"  method="post">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />

		<div class="board_count006">
			전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
		</div>

		<div class="b_srchBox006">

			<!-- 검색종류선택 -->

			<div class="b_srch006">
				<!-- 키워드 -->
				<input class="b_srch_txt006" title="검색단어입력" type="text" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
				<!-- 검색버튼 -->
				<input type="image" class="b_go_btn006" value="검색" src="/img/board/btn_ico_srch.png" alt="검색버튼 아이콘" onclick="goSubmit('list')" />
			</div>

			<select name="searchType" id="searchType" class="b_select006">
				<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
				<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
				<option value="WRITER" <%if("WRITER".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>등록자</option>
			</select>

		</div>

		</form>
	</div>

	<!--cont_block S-->
	<div id="cont_block" style="margin-top: 20px">

			<table class="skin_list">
				<!-- colgroup s -->
			    <colgroup>
			      <col style="width:10%;" />
			      <col style="width:45%;" />
			      <col style="width:15%;" />
			      <col style="width:10%;" />
			      <col style="width:10%;" />
			      <col style="width:10%;" />
			    </colgroup>
				<!-- colgroup e -->

				<!-- thead s -->
				<thead>
				  <tr>
				    <th scope="col" class="number">순번</th>
				    <th scope="col" class="b_notice">제목</th>
				    <th scope="col" class="r_line_none2">등록자</th>
				    <th scope="col" class="r_line_none2">등록일</th>
				    <th scope="col" class="lookup">조회</th>
				    <th scope="col" class="r_line_none file">첨부</th>
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
						<td class="number ico_size_cs"><img src="/img/board/ico_notice.png" alt="공지 아이콘" /></td>
						<td class="b_notice" onclick="goSubmit('noticeView','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>','<%=util.getStr(rs.get("BOARD_ID"))%>')" >
								<span class="notice_blue">[<%=util.getStr(rs.get("SITE_NM"))%>]</span>
								<%if(util.getStr(rs.get("SUBJECT")).length()>15){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 15)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>


							<%-- <a href="/<%=util.getStr(String.valueOf(rs.get("SITE_ID")))%>/sub.do?m=71&mode=noticeView&boardComIdx=<%=util.getStr(rs.get("BOARD_ID"))%>&boardIdx=<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>">
								<span class="notice_blue">[<%=util.getStr(rs.get("SITE_NM"))%>]</span>
								<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
							</a> --%>

						</td>
						<td class="r_line_none2">
							<%=util.getStr(rs.get("WRITER_NM"))%>(<%=util.getStr(rs.get("WRITER_ID"))%>)
						</td>
						<td class="r_line_none2">
							<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
						</td>
						<td class="lookup">
							<%=util.getStr(String.valueOf(rs.get("HITS")))%>
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
					</tr>
					<%
							}
						}
					%>

					<%
					int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

						if(dataList.size() == 0){
					%>
						<tr><td class="r_line_none" colspan="6">데이터가 존재하지 않습니다</td></tr>
					<%
						}

						for(HashMap rs:dataList) {
					%>
					<tr>
						<td class="number"><%=cont%></td>
						<td class="b_notice line_new_reg ico_box_cs">

							<%if(util.getStr(rs.get("SECRET_AT")).equals("Y")){ //비밀글 일때

								if(util.getStr(rs.get("WRITER_ID")).equals(loginVO.getUserId()) || util.getBbsAuth(loginVO,boardMap,"READ")){ //권한이 있을때
							%>
									<p style="cursor:pointer;">
									<a href="sub.do?m=<%=m %>&amp;boardComIdx=<%=util.getStr(rs.get("BOARD_ID"))%>&amp;mode=view&amp;boardIdx=<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>&amp;nowPage=<%=nowPage%>&amp;siteId=<%=siteId%>">
									<%-- <p style="cursor:pointer;" onclick="goSubmit('view','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>','<%=util.getStr(rs.get("BOARD_ID"))%>')"> --%>
										<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
									</a>
									</p>
									<img src="/img/board/ico_lock.png" alt="비밀글 아이콘" style="vertical-align: middle;" />
							<%
							  	}else{ //권한이 없을때
							%>
									<span onclick="sCheck()"><%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%></span>
									<img src="/img/board/ico_lock.png" alt="비밀글 아이콘" style="vertical-align: middle;" />
							<%
							  	}

							}else{ //비밀글 아닐때
							%>
								<p style="cursor:pointer;">
									<a href="sub.do?m=<%=m %>&amp;boardComIdx=<%=util.getStr(rs.get("BOARD_ID"))%>&amp;mode=view&amp;boardIdx=<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>&amp;nowPage=<%=nowPage%>&amp;siteId=<%=siteId%>">
								<%-- <p  style="cursor:pointer;" onclick="goSubmit('view','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>','<%=util.getStr(rs.get("BOARD_ID"))%>')"> --%>
									<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
									</a>
								</p>
							<%}%>


						</td>
						<td class="r_line_none2">
							<%=util.getStr(rs.get("WRITER_NM"))%>(<%=util.getStr(rs.get("WRITER_ID"))%>)
						</td>
						<td class="r_line_none2" >
							<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
						</td>
						<td class="lookup">
							<%=util.getStr(String.valueOf(rs.get("HITS")))%>
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
					</tr>
					<% cont--; } %>
				</tbody>
			</table>

	</div>
	<!--cont_block E-->


	<!--b_btn_area S-->
	<div class="btn_box">
		&nbsp;
		<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
		<div class="b_btn_area">
			<input type="button" class="btn_rgt" value="글쓰기" onclick="goSubmit('write')"/>
		</div>
		<% } %>
	</div>


<%=util.getPaging(staticVO, nowPage)%>


<script type="text/javascript">

	function goSubmit(mode,boardIdx,beforeBoardComIdx){

		//alert("mode: "+mode+"  boardIdx: "+boardIdx+"  boardComIdx:: "+beforeBoardComIdx);
		if(mode == 'view'){
			$('#searchForm').attr('method','get');
		}

		if(mode == 'noticeView'){
			$('#beforeBoardComIdx').val(beforeBoardComIdx);
		}


		$('#boardIdx').val(boardIdx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}

	function sCheck(){
		alert("이 글은 비밀글입니다.");
	}

	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});

	function winResize(){
		var win_w = $(window).width();

		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
			if($('#cont_block .skin_list colgroup col').size()<4){
				$('#cont_block .skin_list').find('col:eq(2)').after("<col style='width: 10%'>");
				$('#cont_block .skin_list').find('col:eq(3)').after("<col style='width: 10%'>");
			}
			$('#cont_block .skin_list tr').find('th:eq(2)').show();
			$('#cont_block .skin_list tr').find('th:eq(3)').show();
			$('#cont_block .skin_list tr').find('td:eq(2)').show();
			$('#cont_block .skin_list tr').find('td:eq(3)').show();
			$('#cont_block .skin_list tr td[colspan=4]').attr("colspan","6");


		}else if(win_w < 768){ //모바일 769 이하일때 100%
			if($('#cont_block .skin_list colgroup col').size()>=4){
				$('#cont_block .skin_list').find('col:eq(3)').remove();
				$('#cont_block .skin_list').find('col:eq(3)').remove();
			}
			$('#cont_block .skin_list tr').find('td:eq(2)').hide();
			$('#cont_block .skin_list tr').find('td:eq(3)').hide();
			$('#cont_block .skin_list tr').find('th:eq(2)').hide();
			$('#cont_block .skin_list tr').find('th:eq(3)').hide();
			$('#cont_block .skin_list tr td[colspan=6]').attr("colspan","4");

		}else{ //기본사이즈
			//$('.basic_listWrap .skin_list tr').find('td:eq(3)').remove(); //네번째 td 없애기
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');

		}

	}

	$(".paging").children().click(function() {
		$("#mode").val("list");
		$("#searchForm").submit();
	});

</script>