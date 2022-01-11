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
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	String m = util.getStr(request.getQueryString());

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> moduleDataList = request.getAttribute("moduleDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("moduleDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	//SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>

	<!--tabBox S-->
	<div class="tabBox">
		<ul>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("ALL") || util.getStr(paramMap.get("orderState")).equals("")) { %> class="on" <% } %> id="tabALL" style="width:90px; " ><a href="javascript:orderTab('ALL');" title="전체 검색" >전체</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("1")) { %> class="on" <% } %> style="width:90px; " ><a href="javascript:orderTab('1');" title="승인요청 검색" >승인요청</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("2")) { %> class="on" <% } %>id="tab2" style="width:90px; " ><a href="javascript:orderTab('2');" title="이용승인 검색" >이용승인</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("3")) { %> class="on" <% } %>id="tab3" style="width:90px; " ><a href="javascript:orderTab('3');" title="승인거절 검색" >승인거절</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("4")) { %> class="on" <% } %>id="tab4" style="width:90px; " ><a href="javascript:orderTab('4');" title="이용완료 검색" >이용완료</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("5")) { %> class="on" <% } %>id="tab5" style="width:90px; " ><a href="javascript:orderTab('5');" title="승인취소 검색" >승인취소</a></li>
		</ul>
	</div>
	<!--tabBox E-->

	<!--list_top S-->
	<div class="list_top">
		<form id="searchForm" name="searchForm" method="post" action="./equorder.do">
			<input type="hidden" name="nowPage" id="nowPage" />
			<input type="hidden" name="mode" id="mode" />
			<input type="hidden" name="equOrderIdx" id="equOrderIdx" value="" />
			<input type="hidden" name="orderState" id="orderState" value="" />
		<div class="board_count">
			전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
		</div>

		<div class="b_srchBox" style="width:100%">
			<div>
				<label for="searchStDt" >예약신청일조회</label>
				<!-- <div class="b_srch" style="width:15%; float:left;margin-right:25px;"> -->
				 <input type="text" class="txtbox" name="searchStDt" id="searchStDt" value="<%=util.getStr(paramMap.get("searchStDt")) %>" size="10" title="예약신청 시작일 예시 2016-09-20" />
				<!-- </div> --> ~
				<input type="text" class="txtbox" name="searchEdDt" id="searchEdDt" value="<%=util.getStr(paramMap.get("searchEdDt")) %>" size="10" title="예약신청 종류일 예시 2016-09-20" />
				<label for="searchWord" >장비/시설명</label>
				<div class="b_srch" style="float:right;margin-right:25px;">
					<!-- 키워드 -->
					<input type="text" name="searchWord" id="searchWord" class="b_srch_txt" value="<%=util.getStr(paramMap.get("searchWord")) %>" title="검색어" />
					<!-- 검색버튼 -->
					<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn" alt="검색" onclick="pageSearchGo()" style="float: right;" />
				</div>
			</div>
		</div>
		</form>
	</div>
	<!--list_top E-->

	<!--cont_block S-->
	<div id="cont_block">
		<!--basic_listWrap S-->
		<div class="basic_listWrap">

			<table class="skin_list" summary="일반게시판의 게시글 목록으로 순번, 제목, 등록일, 조회수, 첨부로 구성되어 있습니다.">
				<caption>번호, 제목, 작성일, 첨부, 조회로 구성된 표입니다.</caption>
				<colgroup>
					<col style="width: 8%;" />
					<col style="width: 17%;" />
					<col style="width: 10%;" />
					<col style="width: *%;" />
					<col style="width: 15%;" />
					<col style="width: 23%;" />
				</colgroup>

				<thead>
					<tr>
						<th scope="col" class="">NO</th>
						<th scope="col" >예약현황</th>
						<th scope="col" >예약번호</th>
						<th scope="col" >장비/시설명</th>
						<th scope="col" >실사용일</th>
						<th scope="col" class="r_line_none2">신청자(신청일)</th>
					</tr>
				</thead>
				<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:moduleDataList) {
			%>
					<tr style="cursor: pointer"	onclick="pageViewGo('<%=rs.get("EQU_ORDER_IDX")%>');">
						<td class="">
							<%=cont%>
						</td>
						<td class="">
							<%if(util.getStr(rs.get("ORDER_STATE")).equals("1")) { %>
							<img alt="승인요청" src="/img/back/comm/order_state_img_1.png" />
							<% } %> <%if(util.getStr(rs.get("ORDER_STATE")).equals("2")) { %>
							<img alt="이용승인" src="/img/back/comm/order_state_img_2.png" />
							<% } %> <%if(util.getStr(rs.get("ORDER_STATE")).equals("3")) { %>
							<img alt="승인거절" src="/img/back/comm/order_state_img_3.png" />
							<% } %> <%if(util.getStr(rs.get("ORDER_STATE")).equals("4")) { %>
							<img alt="이용완료" src="/img/back/comm/order_state_img_4.png" />
							<% } %> <%if(util.getStr(rs.get("ORDER_STATE")).equals("5")) { %>
							<img alt="승인취소" src="/img/back/comm/order_state_img_5.png" />
							<% } %>
						</td>
						<td class="">
							J-<%=util.getStr(rs.get("EQU_ORDER_IDX"))%>
						</td>
						<td class="">
							<%=util.getStr(rs.get("KOR_NM"))%><br />(<%=util.getStr(rs.get("ENG_NM"))%>)
						</td>
						<td class="">
							<%if(util.getStr(rs.get("REAL_USE_ST_DT")).equals("")) { %>
							정보없음 <% } else { %> <%=util.getStr(rs.get("REAL_USE_ST_DT"))%>
							<br /> ~ <%=util.getStr(rs.get("REAL_USE_ST_DT"))%> <% } %>
						</td>
						<td class="">
							<%=util.getStr(rs.get("PSN_NM"))%> <br /> (<%=util.getStr(rs.get("ORDER_DT"))%>)
						</td>
					</tr>
					<% cont--; } %>
				</tbody>
			</table>
























<%-- <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
	<div class="tabBox_pub">
		<ul>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("ALL") || util.getStr(paramMap.get("orderState")).equals("")) { %> class="on" <% } %> id="tabALL"><a href="#" onclick="orderTab('ALL')">전체</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("1")) { %> class="on" <% } %> ><a href="#" onclick="orderTab('1')">승인요청</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("2")) { %> class="on" <% } %>id="tab2" class ><a href="#" onclick="orderTab('2')">이용승인</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("3")) { %> class="on" <% } %>id="tab3" class ><a href="#" onclick="orderTab('3')">승인거절</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("4")) { %> class="on" <% } %>id="tab4" class ><a href="#" onclick="orderTab('4')">이용완료</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("5")) { %> class="on" <% } %>id="tab5" class ><a href="#" onclick="orderTab('5')">승인취소</a></li>
		</ul>
	</div>
<div class="skin_list">

<form id = "searchForm" name = "searchForm" method="post" action="./equorder.do">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "equOrderIdx" id = "equOrderIdx" value />
			<input type="hidden" name = "orderState" id = "orderState" value />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<!-- 예약신청기간 -->
							예약신청기간&nbsp;
							<input type="text" class="inp_text" name="searchStDt" id="searchStDt" value="<%=util.getStr(paramMap.get("searchStDt")) %>" size="10"/> ~
							<input type="text" class="inp_text" name="searchEdDt" id="searchEdDt" value="<%=util.getStr(paramMap.get("searchEdDt")) %>" size="10"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

							<!-- 키워드 -->
							검색어&nbsp;
							<input type="text" name="searchWord" id="searchWord" class="inp_text" value="<%=util.getStr(paramMap.get("searchWord")) %>" />
							<!-- 검색버튼 -->
						<input type="button" class="btn_inp_g_01" value="검색" onclick="pageSearchGo()" style="float: right;" />
						</div>
						<!-- board-search -->
					 </div>
				</div>
			<!-- bbs-top e -->
</form>
			<div class="total" style="margin-top: 10px;">
				[전체 <span><%=staticVO.getTotalCount()%></span>건, <span><%=staticVO.getNowPage()%></span>/<%=(int)(Math.ceil(staticVO.getTotalCount()/staticVO.getPageSize())+1)%> page]
			</div>

	<div>
		<!-- skin_basic_list s -->
		<table class="skin_basic_list" summary="게시판 목록을 나타내는 표입니다..">
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 8%;" />
				<col style="width: 10%;" />
				<col style="width: *%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
				<col style="width: 15%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">NO</th>
					<th scope="col">예약현황</th>
					<th scope="col">예약번호</th>
					<th scope="col">장비/시설명</th>
					<th scope="col">이용희망일</th>
					<th scope="col">실사용일</th>
					<th scope="col">신청자(신청일)</th>
				</tr>
			</thead>
			<tbody>
			<%
			int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));
			for(HashMap rs:moduleDataList) {%>
				<tr style="cursor:pointer" onclick = "pageViewGo('<%=rs.get("EQU_ORDER_IDX")%>');">
					<td><%=cont%></td>
					<td><%if(util.getStr(rs.get("ORDER_STATE")).equals("1")) { %> <img alt="승인요청" src="/img/back/comm/order_state_img_1.png"> <% } %>
					<%if(util.getStr(rs.get("ORDER_STATE")).equals("2")) { %> <img alt="이용승인" src="/img/back/comm/order_state_img_2.png"> <% } %>
					<%if(util.getStr(rs.get("ORDER_STATE")).equals("3")) { %> <img alt="승인거절" src="/img/back/comm/order_state_img_3.png"> <% } %>
					<%if(util.getStr(rs.get("ORDER_STATE")).equals("4")) { %> <img alt="이용완료" src="/img/back/comm/order_state_img_4.png"> <% } %>
					<%if(util.getStr(rs.get("ORDER_STATE")).equals("5")) { %> <img alt="승인취소" src="/img/back/comm/order_state_img_5.png"> <% } %></td>
					<td><%if(util.getStr(rs.get("ORDER_STATE")).equals("1")) { %> 승인요청 <% } %>
					<%if(util.getStr(rs.get("ORDER_STATE")).equals("2")) { %> 이용승인 <% } %>
					<%if(util.getStr(rs.get("ORDER_STATE")).equals("3")) { %> 반려 <% } %>
					<%if(util.getStr(rs.get("ORDER_STATE")).equals("4")) { %> 이용완료 <% } %></td>
					<td>J-<%=util.getStr(rs.get("EQU_ORDER_IDX"))%></td>
					<td><%=util.getStr(rs.get("KOR_NM"))%>(<%=util.getStr(rs.get("ENG_NM"))%>)</td>
					<td><%=util.getStr(rs.get("USE_ST_DT"))%>
					<br /> ~ <%=util.getStr(rs.get("USE_ED_DT"))%></td>

					<td><%if(util.getStr(rs.get("REAL_USE_ST_DT")).equals("")) { %> 정보없음 <% } else { %>
					<%=util.getStr(rs.get("REAL_USE_ST_DT"))%>
					<br /> ~ <%=util.getStr(rs.get("REAL_USE_ST_DT"))%>
					 <% } %></td>

					<td><%=util.getStr(rs.get("PSN_NM"))%>
					<br /> (<%=util.getStr(rs.get("ORDER_DT"))%>)</td>

				</tr>
			<%
			cont--;
			} %>
			</tbody>
		</table>
		<!-- <div class="bbs_btn">
			<input class="btn_inp_b_01" type="button" onclick="pageWriteGo()" value="등록" />
		</div> --> --%>
							<%=util.getPaging(staticVO, nowPage) %>
						</div>
					</div>
<script type="text/javascript">
//<![CDATA[
		//var j = jQuery.noConflict();
	$(document).ready(function(){
		$( "#searchStDt" ).datepicker({
		    dateFormat: 'yy-mm-dd'
		  });
		  $( "#searchEdDt" ).datepicker({
		    dateFormat: 'yy-mm-dd'
		  });
	});

	/* $(document).ready(function(){
	    $('#searchStDt').datepicker();
	    $('#searchEdDt').datepicker();
	}); */

	function pageSearchGo(){
		$('#mode').val('list');
		$('#searchForm').submit();
	}
	function pageViewGo(idx){
		$('#mode').val('view');
		$('#equOrderIdx').val(idx);
		$('#searchForm').submit();
	}
	function pageWriteGo(){
		$('#mode').val('write');
		$('#searchForm').submit();
	}
	function orderTab(orderState){
		$('#mode').val('list');
		$('#orderState').val(orderState);
		$('#searchForm').submit();
	}
	/* function listPageSubmit(mode,listMode,sortMode){
		$('#listMode').val(listMode);
		$('#sortMode').val(sortMode);
		$('#mode').val(mode);
		$('#searchForm').submit();
	} */
//]]>	
</script>


					<!--// bo_btn -->