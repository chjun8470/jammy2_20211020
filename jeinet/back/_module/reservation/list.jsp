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
	ArrayList<HashMap<String, String>> moduleDataList = request.getAttribute("moduleDataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("moduleDataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));

	//SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<div class="skin_list">

	<div class="tabBox_pub">
		<ul>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("ALL") || util.getStr(paramMap.get("orderState")).equals("")) { %> class="on" <% } %> id="tabALL"><a href="#" onclick="orderTab('ALL')">전체</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("1")) { %> class="on" <% } %> ><a href="#" onclick="orderTab('1')">승인요청</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("2")) { %> class="on" <% } %>id="tab2" class ><a href="#" onclick="orderTab('2')">이용승인</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("3")) { %> class="on" <% } %>id="tab3" class ><a href="#" onclick="orderTab('3')">승인거절</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("4")) { %> class="on" <% } %>id="tab4" class ><a href="#" onclick="orderTab('4')">이용완료/운영일지</a></li>
			<li <%if(util.getStr(paramMap.get("orderState")).equals("5")) { %> class="on" <% } %>id="tab5" class ><a href="#" onclick="orderTab('5')">승인취소</a></li>
		</ul>
	</div>

<form id = "searchForm" name = "searchForm" method="post" action="/sys/sys_eq_reservation.do">
			<input type="hidden" name = "nowPage" id = "nowPage" />
			<input type="hidden" name = "mode" id = "mode" />
			<input type="hidden" name = "equOrderIdx" id = "equOrderIdx" value />
			<input type="hidden" name = "orderState" id = "orderState" value="<%=util.getStr(paramMap.get("orderState")) %>" />
				<div class="basic_grid">
					<div class="search_box" style="padding:10px">
						<div class="board-search">
							<!-- 예약신청기간 -->
							예약신청기간&nbsp;
							<input type="text" class="inp_text" name="searchStDt" id="searchStDt" value="<%=util.getStr(paramMap.get("searchStDt")) %>" size="10"/> ~
							<input type="text" class="inp_text" name="searchEdDt" id="searchEdDt" value="<%=util.getStr(paramMap.get("searchEdDt")) %>" size="10"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

							<!-- 키워드 -->
							장비/시설명&nbsp;
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
				<%if(util.getStr(paramMap.get("orderState")).equals("4")) { %>
				<span style="float: right; margin-bottom: 5px;">
					<button type="button" id="excelDownload" class="btn_inp_b_01" onclick="location.href='/sys/reservationExcel.do'">엑셀다운로드</button>
				</span>
				<% } %>
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
					<%if(util.getStr(rs.get("ORDER_STATE")).equals("5")) { %> <img alt="이용완료" src="/img/back/comm/order_state_img_5.png"> <% } %></td>
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
			<button class="btn_inp_b_01" type="button" onclick="resveGo()">예약하기</button>
		</div> -->
	<%=util.getPaging(staticVO, nowPage) %>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function(){
			$( "#searchStDt" ).datepicker({
		    dateFormat: 'yy-mm-dd'
		  });
		  $( "#searchEdDt" ).datepicker({
		    dateFormat: 'yy-mm-dd'
		  });
	});
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
</script>


<!--// bo_btn -->
