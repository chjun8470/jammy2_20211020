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

	HashMap<String, String> boardMap = request.getAttribute("boardMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("boardMap");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	ArrayList<HashMap<String, String>> noticeList = request.getAttribute("noticeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("noticeList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String m = util.getStr(paramMap.get("m"));
	String boardComIdx = util.getStr(paramMap.get("boardComIdx"));
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

<div class="skin_list">
	<div>
		<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="boardComIdx" id="boardComIdx" value="<%=boardComIdx%>" />
			<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
			<input type="hidden" name="boardIdx" id="boardIdx" value="<%=boardIdx%>" />
			<input type="hidden" name="beforeBoardComIdx" id="beforeBoardComIdx" value="" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />

			<div class="basic_grid basic_grid2">

        		<div class="list_top_1 margin_left_20px">
                	<div class="b_srchBox_1 ">
                    	<div class="b_srchBox_1_du"><label for="searchDataType">자료구분 :&nbsp;</label></div>
                        <select class="b_select_1" name="searchDataType" id="searchDataType" title="검색조건 선택">
							<option value="">전체</option>
							<option value="교육" <%if("교육".equals(util.getStr(paramMap.get("searchDataType")))) {%> selected="selected" <%}%>>교육</option>
							<option value="행사" <%if("행사".equals(util.getStr(paramMap.get("searchDataType")))) {%> selected="selected" <%}%>>행사</option>
						</select>
                     </div>
				</div>

				<div class="list_top_1">
                	<div class="b_srchBox_1" style="width: auto;">
						<div style="margin: 0px 0px 0px 20px; height: 35px; line-height: 35px; float: left;"><label for="searchType">검색구분 :&nbsp;</label></div>
						<select class="b_select_1" name="searchType" id="searchType" title="검색조건 선택">
							<option value="SUBJECT" <%if("SUBJECT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>제목</option>
							<option value="CONTENT" <%if("CONTENT".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>내용</option>
							<option value="WRITER" <%if("WRITER".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>등록자</option>
						</select>

                        <div class="b_srch">
                            <label class="hide" for="searchWord">검색어를 입력하세요</label>
                           	<input type="text" class="b_srch_txt" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:97%;"/>
                        </div>
						<!-- 검색버튼 -->
						<div class="b_srch_dn">
                         	<input type="button" class="b_go_btn" value="검색" onclick="goSubmit('list')" />
                        </div>

                	</div>
              	</div>
            </div>
            <!-- basic_grid basic_grid2 e -->

		</form>
        <!-- searchForm e -->

        <!--list_top S-->
		<div class="list_top">
			<div class="board_count">
				전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
			</div>
		</div>
		<!--list_top E-->


		<!-- skin_basic_list s -->
		<table class="skin_list" summary="행사ㆍ교육자료 게시글 목록으로 글번호, 제목, 등록자, 등록일, 조회, 첨부로 구성되어 있습니다.">
          <caption>행사ㆍ교육자료</caption>
			<!-- colgroup s -->
			<colgroup>
				<col style="width: 10%;" />
				<col style="width: 45%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
				<col style="width: 10%;" />
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
					if(noticeList.size() == 0){
				%>
					<tr><td colspan="6">공지가 존재하지  않습니다</td></tr>
				<%
					}

						for(HashMap rs:noticeList) {
				%>
				<tr>
					<td class="number"><img src="/img/board/ico_notice.png" alt="공지 아이콘" /></td>
					<td class="b_notice" onclick="goSubmit('noticeView','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>','<%=util.getStr(rs.get("BOARD_ID"))%>')" >
						<a href="javascript:goSubmit('noticeView','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>','<%=util.getStr(rs.get("BOARD_ID"))%>')" title="<%=util.getStr(rs.get("SUBJECT"))%> 상세보기" >
						<span class="notice_blue">[<%=util.getStr(rs.get("SITE_NM"))%>]</span>
						<%if(util.getStr(rs.get("SUBJECT")).length()>15){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 15)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
						</a>
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

					if(dataList.size() == 0){
				%>
					<tr><td colspan="6" class="r_line_none" >데이터가 존재하지 않습니다</td></tr>
				<%
					}

					for(HashMap rs:dataList) {
				%>
				<tr>
					<td class="number"><%=cont%></td>
					<td class="b_notice line_new_reg">

							<%--
							<!-- 비밀글 사용안함 -->
							<%if(util.getStr(rs.get("SECRET_AT")).equals("Y")){ //비밀글 일때

								if(util.getStr(rs.get("WRITER_ID")).equals(loginVO.getUserId()) || util.getBbsAuth(loginVO,boardMap,"READ")){ //권한이 있을때
							%>
									<p style="cursor:pointer;">
									<a href="sub.do?m=<%=m %>&amp;boardComIdx=<%=util.getStr(rs.get("BOARD_ID"))%>&amp;mode=view&amp;boardIdx=<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>&amp;nowPage=<%=nowPage%>&amp;siteId=<%=siteId%>">
									<p style="cursor:pointer;" onclick="goSubmit('view','<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>','<%=util.getStr(rs.get("BOARD_ID"))%>')">
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
							%> --%>
								<p style="cursor:pointer;">
									<span style="color:blue; font-size:9pt; margin-right:10px;">[<%=util.getStr(rs.get("DATA01"))%>]</span>
									<a href="sub.do?m=<%=m %>&amp;boardComIdx=<%=util.getStr(rs.get("BOARD_ID"))%>&amp;mode=view&amp;boardIdx=<%=util.getStr(String.valueOf(rs.get("ARTICLE_ID")))%>&amp;nowPage=<%=nowPage%>&amp;siteId=<%=siteId%>">
										<%if(util.getStr(rs.get("SUBJECT")).length()>20){%><%=util.getStr(rs.get("SUBJECT")).substring(0, 20)+" · · · "%><%}else{%><%=util.getStr(rs.get("SUBJECT"))%><%}%>
									</a>
								</p>
							<%-- <%}%> --%>


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
                    	<a href="/cmm/fms/ComFileDown.do<%=fileParam%>" title="첨부파일 다운로드"><img src="/img/board/ico_file.png" alt="첨부파일 아이콘" /></a>
                    <%}%>
					</td>
				</tr>
				<% cont--; } %>
			</tbody>
		</table>

		<div class="b_btn_area">
			&nbsp;
			<% if(util.loginCheck() && util.getBbsAuth(loginVO,boardMap,"WRITE")) {%>
				<input type="button" class="btn_rgt" value="글쓰기" onclick="goSubmit('write')"/>
			<% } %>
		</div>
	</div>
</div>

<%=util.getPaging(staticVO, nowPage)%>

<!--// bo_btn -->
<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,boardIdx,boardComIdx){

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

	/*
	function sCheck(){
		alert("이 글은 비밀글입니다.");
	}
	*/

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
//]]>
</script>