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
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String menu = util.getStr(request.getParameter("m"));
	String siteComIdx = util.getStr(String.valueOf(paramMap.get("siteComIdx")));
	String boardComIdx = util.getStr(String.valueOf(paramMap.get("boardComIdx")));

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getIntStr(paramMap.get("m"));
	String boardIdx = util.getIntStr(String.valueOf(paramMap.get("boardIdx")));
	String tab = util.getStr(paramMap.get("tab"));
	String tabApp = util.getStr(paramMap.get("tabApp"));
	String auth_lv = util.getStr(String.valueOf(userMap.get("AUTH_LV")));
	String userId = util.getStr(String.valueOf(userMap.get("USER_ID")));
	String noticeYn = util.getStr(boardMap.get("PERM_NOTICE"));
	String searchType = util.getStr(paramMap.get("searchType"));
	String siteId = util.getStr(paramMap.get("siteId")); //사이트구분
	/* if(searchType == null){
		searchType = "SUBJECT";
	}
	 */

	if((util.getBbsAuth(loginVO,boardMap,"LIST")).equals(false)){
%>
	<script type="text/javascript" >
	//<![CDATA[
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
	//]]>	
	</script>
<%
		return;
	}
%>
<div class="tabBox">
		<%if(menu.equals("98") || menu.equals("99")){ %>
	<ul>
			<li class="<%if(menu.equals("98")){ %>on<%}%>"><a href="/jeinet/sub.do?m=98" >장비구축</a></li>
			<li class="<%if(menu.equals("99")){ %>on<%}%>"><a href="/jeinet/sub.do?m=99" >장비활용</a></li>
	</ul>
		<%} %>
		<%if(menu.equals("100") || menu.equals("101")){ %>
	<ul>
			<li class="<%if(menu.equals("100")){ %>on<%}%>"><a href="/jeinet/sub.do?m=100" >사이트이용자</a></li>
			<li class="<%if(menu.equals("101")){ %>on<%}%>"><a href="/jeinet/sub.do?m=101" >연구장비이용자</a></li>
	</ul>
		<%} %>
</div>


<div class="list_top">
            <form action="./sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="siteComIdx" id="siteComIdx" value="<%=siteComIdx%>" />
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="tab" id="tab" value="<%=tab%>" />
			<input type="hidden" name="auth_lv" id="auth_lv" value="<%=auth_lv%>" />
			<input type="hidden" name="userId" id="userId" value="<%=userId%>" />
			<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="" />
			<input type="hidden" name="tabApp" id="tabApp" value="<%=tabApp%>" />

		<div class="board_count">전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건</div>
        
		<div class="b_srchBox srch_box" style="width:390px; margin-bottom:15px">
        
            <select name="searchType" id="searchType" class="b_select" title="검색조건 선택">
				<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
				<option value="WRITER_ID" <%if("WRITER_ID".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>글쓴이</option>
			</select>
			
			<div class="b_srch wrt_box">
                <label class="hide" for="searchWord">검색어를 입력하세요</label>
				<input type="text" name="searchWord" id="searchWord" class="b_srch_txt" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
				<input type="image" class="b_go_btn" alt="검색" src="../img/board/btn_ico_srch.png" onclick="goSubmit('list')" />
			</div>
            
			
		</div>


</form>
</div>


		<!-- skin_basic_list s -->
		<table class="skin_list" summary="수요/만족도 조사 게시글 목록으로 글번호, 제목, 글쓴이, 작성일, 조회수, 파일로 구성되어 있습니다.">
        <caption>수요/만족도 조사 게시글 목록</caption>
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 6%;" />
				<col style="width: 46%;" />
				<col style="width: 12%;" />
				<col style="width: 12%;" />
				<col style="width: 8%;" />
				<col style="width: 6%;" />
			</colgroup>
			<!-- colgroup e -->

			<!-- thead s -->
			<thead>
				<tr>
					<th scope="col" class="number">번호</th>
					<th scope="col">제목</th>
					<th scope="col" class="r_line_none2">글쓴이</th>
					<th scope="col" class="r_line_none2">작성일</th>
					<th scope="col" class="lookup">조회수</th>
					<th scope="col" class="r_line_none file">파일</th>
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
						<td class="number img_size_cs"><img src="/img/board/ico_notice.png" alt="공지 아이콘" /></td>
						
						<td class="b_notice" >
						<a href="?m=<%=m%>&amp;mode=noticeView&amp;boardIdx=<%=util.getIntStr(rs.get("ARTICLE_ID"))%>&amp;beforeBoardComIdx=<%=util.getStr(rs.get("BOARD_ID"))%>" title="<%=util.getStr(rs.get("SUBJECT"))%>" >
								<span class="notice_blue">[<%=util.getStr(rs.get("SITE_NM"))%>]</span>
								<%if(util.getStr(rs.get("SUBJECT")).length()>12){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 12)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
						</a>
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
						<td class="r_line_none file cen_cs_style" >
						<%if(!(util.getStr(rs.get("FILE_ID"))).equals(null) && !(util.getStr(rs.get("FILE_ID"))).equals("")){
							String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
												+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
												+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
							%>
	                    	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="첨부파일 다운로드"><img src="/img/board/ico_file.png" alt="첨부파일 아이콘" /></a>
	                    <%}%>
						</td>
					</tr>
					<%
							}
						}
					%>


			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:dataList) {
				if(util.getStr(String.valueOf(rs.get("ARTICLE_PARNTS_ID"))).equals("0")){%>
				<tr style="cursor:pointer;" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'">
					<td class="number">
						<%=cont%>
					</td>
					<td class="b_notice">
						<a href="?m=<%=m%>&amp;mode=view&amp;boardIdx=<%=util.getIntStr(rs.get("ARTICLE_ID"))%>" title="<%=util.getStr(rs.get("SUBJECT"))%> 상세보기" >
						<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
						</a>
					</td>
					<td class="r_line_none2">
						<%=util.getStr(String.valueOf(rs.get("WRITER_ID")))%>
					</td>
					<td class="lookup">
						<%=util.getStr(String.valueOf(rs.get("FRST_REGIST_PNTTM")))%>
					</td>
					 <td class="r_line_none2">
						<%=util.getStr(String.valueOf(rs.get("HITS")))%>
					</td>
					<td class="r_line_none file">
						<%if( !"".equals(util.getStr(rs.get("FILE_CAT"))) ){

							String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
												+"&amp;fileId="+util.getStr(String.valueOf(rs.get("FILE_ID")))
												+"&amp;dataIdx="+util.getStr(String.valueOf(rs.get("DATA_IDX")));
							%>
							<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="첨부파일 다운로드"><img src="/img/board/ico_file.png" alt="첨부파일 아이콘" /></a>

						<%} %>
					</td>
				</tr>

			<%
					cont--;
				}
			}
			%>
			<% 
				if( dataList.size() <= 0){
			%>
				<tr>
					<td colspan="6" class="r_line_none" >등록된 자료가 없습니다.</td>
				</tr>
			<%
				}
			%>
			</tbody>
		</table>

		<div class="btn_box">
			&nbsp;

			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>

			<div class="b_btn_area">
				<input type="button" class="btn_rgt" value="등록" onclick="goSubmit('write')"/>
			</div>
			<%}%>
		</div>


<%=util.getPaging(staticVO, nowPage) %>

		</form>

<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,boardIdx,replyIdx,sttus){
		$('#mode').val(mode);
		if(mode == "view"){
			$('#searchForm').attr("method","get");
		}
		$('#boardIdx').val(boardIdx);
		$('#replyIdx').val(replyIdx);
		$('#searchForm').submit();
	}
	function goNo(mode,boardIdx,boardComIdx){
		$('#beforeBoardComIdx').val(boardComIdx);
		$('#boardIdx').val(boardIdx);
		$('#mode').val(mode);
		if(mode == "noticeView"){
			$('#searchForm').attr("method","get");
		}
		$('#searchForm').submit();
	}
/* 	function sele(){
		$('.cpress_lst').show();
	}
$(document).ready(function() {

	$("#seleMenu li a").click(function(){
		$("#sele").text($(this).text());
		$("#seleMenu li").removeClass();
		$(this).parent().addClass("on");
		$('.cpress_lst').hide();
		if($(this).parent().text()=="제목"){
			$('#searchType').val('SUBJECT');
		console.log($(this).parent().text());
		}if($(this).parent().text()=="글쓴이"){
			$('#searchType').val('WRITER_ID');
		}

	})
});	 */
	
	$(document).ready(function() {
		$(window).resize(function(){
			winResize();
		});
		winResize();
	});
	
	function winResize(){
		var win_w = $(window).width();
		
		if(win_w < 1198 && win_w >= 768){ //테블릿 1198 , 768 이하일때 100%
			if($('.skin_list colgroup col').size()<5){
				$('.skin_list').find('col:eq(2)').after("<col style='width: 12%'>");
				$('.skin_list').find('col:eq(3)').after("<col style='width: 12%'>");
			}
			$('.skin_list tr').find('th:eq(2)').show();
			$('.skin_list tr').find('th:eq(3)').show();
			$('.skin_list tr').find('td:eq(2)').show();
			$('.skin_list tr').find('td:eq(3)').show();
			$('.tabBox ul li').css('width','147px');
			
		}else if(win_w < 768){ //모바일 769 이하일때 100%
			if($('.skin_list colgroup col').size()>=5){
				$('.skin_list').find('col:eq(3)').remove();
				$('.skin_list').find('col:eq(3)').remove();
			}
			$('.skin_list tr').find('td:eq(2)').hide();
			$('.skin_list tr').find('td:eq(3)').hide();
			$('.skin_list tr').find('th:eq(2)').hide();
			$('.skin_list tr').find('th:eq(3)').hide();
			$('.tabBox ul li').css('width','6%');
		}else{ //기본사이즈
			//$('.skin_list tr').find('td:eq(3)').remove(); //네번째 td 없애기
			//$('#cont_block > .pub_list03_blog > ul').css('float','none');	
			
		}
		
	}
//]]>
</script>