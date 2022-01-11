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
	HashMap<String, String> expert = request.getAttribute("expert") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("expert");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	
	String m = util.getStr(request.getParameter("m"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String boardIdx = util.getStr(paramMap.get("boardIdx"));
	String state = util.getStr(paramMap.get("DATA04"));
	String pageMode = util.getStr(paramMap.get("pageMode"));
	String actionString = "sub.do";
	if( pageMode.matches(".*advice_.*") ){
		actionString = pageMode+".do";
	}
	
%>



<div class="list_top004">

        <div class="board_count004">
			[전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
		</div>

	<form action="<%=actionString%>" name="searchForm" id="searchForm" method="post" class="boardSearch">
		<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
		<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
		<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
		<input type="hidden" name="m" id="m" value="<%=m%>" />
		

		<div class="b_srchBox004">
			
			<div class="b_srch004">
				<input type="text" name="searchWord" id="searchWord" class="b_srch_txt004" value="<%=util.getStr(paramMap.get("searchWord"))%>" title="검색어 입력박스" />
				<input type="image" class="b_go_btn004" alt="검색" src="../img/board/btn_ico_srch.png"/>
			</div>
			
			<select name="searchType" id="searchType" class="b_select004">
				<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
				<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
			</select>
			
		</div>
	</form>
		
</div>

		<!-- searchForm e -->

		<!-- skin_basic_list s -->
		<div class="basic_listWrap">
			<table class="skin_list" summary="게시판 목록을 나타내는 표입니다..">
				<!-- colgroup s -->
				<%

				if( !pageMode.matches(".*advice_.*") ){
				%>
				<colgroup>
					<col style="width: 12%;" class="number" />
					<col style="width: 40%;" class="b_notice" />
					<col style="width: 12%;" />
					<col style="width: 12%;" />
					<col style="width: 12%;" />
				</colgroup>
				<% } %>
				<!-- colgroup e -->
				<!-- thead s -->
				<thead>
					<tr>
						<th scope="col" class="number" >번호</th>
						<th scope="col" class="b_notice" >제목</th>
						<th scope="col">글쓴이</th>
						<th scope="col">작성일</th>
						<th scope="col" class="r_line_none">조회수</th>
					</tr>
				</thead>
				<!-- thead s -->
				<!-- tbody s -->
				<tbody>
					<%
						int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
								for(HashMap rs:dataList) {
					%>
					<tr>
						<td class="number"><%=cont%></td>
						<td class="b_notice">
							
							<%if( util.loginCheck() && loginVO.getUserId().equals(rs.get("WRITER_ID")) ||  util.getStr(loginVO.getProJeinet()).equals("Y") ||  util.getStr(loginVO.getProJipbank()).equals("Y") || util.getInt(loginVO.getAuthLv()) >= 70 || !util.getStr(rs.get("SECRET_AT")).equals("Y") ) { %>
								<a href="<%=actionString%>?m=<%=m %>&amp;boardComIdx=<%=boardComIdx %>&amp;mode=view&amp;boardIdx=<%=util.getStr(rs.get("ARTICLE_ID"))%>&amp;nowPage=<%=nowPage%>">
							<%-- <a href="#" onclick="goSubmit('view','<%=util.getStr(rs.get("ARTICLE_ID"))%>')"> --%>
							<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
							</a>
							<%} else { %>
							<a href="#"><span class="notice_lock"><%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%></span></a>
							<% } %>
						</td>
						<td>
							<%=util.getStr(rs.get("PSN_NM"))%>
						</td>
						<td>
							<%=util.getStr(rs.get("FRST_REGIST_PNTTM"))%>
						</td>
						<td class="r_line_none">
							<%=util.getStr(rs.get("HITS"))%>
						</td>
					</tr>
					<% cont--; }
					if(dataList.size() == 0){
				%>
					<tr><td colspan="5" class="r_line_none" >데이터가 존재하지 않습니다</td></tr>
				<%
					}
				%>
				</tbody>
			</table>
		</div>
 
		<div class="b_btn_area">
			<%-- <% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE") && util.getInt(loginVO.getAuthLv()) > 80) {%> --%>
			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE") ) {%>
					<input type="button" class="btn_rgt" value="글쓰기" onclick="goSubmit('write')"/>
			<% } %>
		</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,boardIdx){
		if(mode == 'view'){
			$('#searchForm').attr('method','get');
		}
		$('#boardIdx').val(boardIdx);
		$('#mode').val(mode);
		$('#searchForm').submit();
	}

	$(document).ready(function() {
		$(".notice_lock").click(function() {
			alert("권한이 부족합니다.");
		});
	});

	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});
	
	function winResize(){
		var win_w = $(window).width();
		
		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
			if($('.basic_listWrap .skin_list colgroup col').size()<4){
				$('.basic_listWrap .skin_list').find('col:eq(2)').after("<col style='width: 12%'>");
				$('.basic_listWrap .skin_list').find('col:eq(3)').after("<col style='width: 12%'>");
			}
			$('.basic_listWrap .skin_list tr').find('th:eq(2)').show();
			$('.basic_listWrap .skin_list tr').find('th:eq(3)').show();
			$('.basic_listWrap .skin_list tr').find('td:eq(2)').show();
			$('.basic_listWrap .skin_list tr').find('td:eq(3)').show();
			
			
		}else if(win_w < 768){ //모바일 769 이하일때 100%
			if($('.basic_listWrap .skin_list colgroup col').size()>=4){
				$('.basic_listWrap .skin_list').find('col:eq(3)').remove();
				$('.basic_listWrap .skin_list').find('col:eq(3)').remove();
			}
			$('.basic_listWrap .skin_list tr').find('td:eq(2)').hide();
			$('.basic_listWrap .skin_list tr').find('td:eq(3)').hide();
			$('.basic_listWrap .skin_list tr').find('th:eq(2)').hide();
			$('.basic_listWrap .skin_list tr').find('th:eq(3)').hide();
			
		}else{ //기본사이즈
			//$('.basic_listWrap .skin_list tr').find('td:eq(3)').remove(); //네번째 td 없애기
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');	
			
		}
		
	}
//]]>

</script>