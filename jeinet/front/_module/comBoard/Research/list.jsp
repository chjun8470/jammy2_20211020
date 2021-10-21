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
		alert("권한이 부족합니다.");
		history.back(-1); //이전화면으로
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

<form action="./sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
<div class="list_top009">
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

		<div class="board_count009">
					전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
		</div>


	<%-- <div class="b_srchBox">
		<input type="text" id="searchType" name="searchType" value="<%=searchType%>"/>
		<div class="nctg" data-mode="press" ><a href="#" class="btn_nctg" onclick="sele(); return false;" id="sele">제목</a>
			<ul class="cpress_lst" id="seleMenu" style="display:none" >
				<li class="on" value="ss"><a href="#" onclick="return false;">제목</a></li>
				<li><a href="#" onclick="return false;">글쓴이</a></li>
			</ul>
		</div>
		<div class="b_srch">
			<input id="srch_txt" class="b_srch_txt" name="searchWord" type="text" value="<%=util.getStr(paramMap.get("searchWord"))%>" title="검색단어입력" />
			<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn" onclick="goSubmit('list')" alt="바로가기" />
		</div>
</div> --%>





		<div class="b_srchBox009">
			
			<div class="b_srch009">
				<input type="text" title="검색단어입력" name="searchWord" id="searchWord" class="b_srch_txt009" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
				<input type="image" class="b_go_btn009" alt="검색" src="../img/board/btn_ico_srch.png" onclick="goSubmit('list')" />
			</div>
			
			<select name="searchType" id="searchType" class="b_select009">
				<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
				<option value="WRITER_ID" <%if("WRITER_ID".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>글쓴이</option>
			</select>
		</div>



</div>


		<!-- skin_basic_list s -->
		<table class="skin_list" summary="게시판 목록을 나타내는 표입니다..">
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
						
						<td class="b_notice" style="cursor:pointer;" onclick="location.href='?m=<%=m%>&amp;mode=noticeView&amp;boardIdx=<%=util.getIntStr(rs.get("ARTICLE_ID"))%>&amp;beforeBoardComIdx=<%=util.getStr(rs.get("BOARD_ID"))%>'">
								<span class="notice_blue">[<%=util.getStr(rs.get("SITE_NM"))%>]</span>
								<%if(util.getStr(rs.get("SUBJECT")).length()>12){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 12)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>

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
			for(HashMap rs:dataList) {
				if(util.getStr(String.valueOf(rs.get("ARTICLE_PARNTS_ID"))).equals("0")){%>
				<tr style="cursor:pointer;" onclick="location.href='?m=<%=m%>&amp;mode=view&amp;boardIdx=<%=util.getIntStr(rs.get("ARTICLE_ID"))%>'" onmouseover="this.style.background='#f3f3f3'" onmouseout="this.style.background='white'">
					<td class="number">
						<%=cont%>
					</td>
					<td class="b_notice">
						<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>

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
							<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><img src="/img/board/ico_file.png" alt="첨부파일 아이콘" /></a>

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

			<div class="b_btn_area">
				<input type="button" class="btn_rgt" value="글쓰기" onclick="goSubmit('write')"/>
			</div>
			<%}%>
		</div>


<%=util.getPaging(staticVO, nowPage) %>

		</form>

<!--// bo_btn -->
<script type="text/javascript">
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
</script>