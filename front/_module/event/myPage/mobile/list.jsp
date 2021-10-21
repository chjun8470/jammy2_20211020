<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();
	String m = util.getStr(request.getQueryString());

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> dataList = request.getAttribute("dataList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("dataList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));
	String nowPage2 = util.getStr(paramMap.get("searchWord"));
	String tap = util.getStr(paramMap.get("tap"));
	String siteId = util.getStr(paramMap.get("siteId"));

	//SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
%>

	<div class="MPTit MPTit02">행사정보</div>

	<!--tabBox S-->
	<div class="tabBox02">
		<ul>
			<li <%if(tap.equals("ALL") || tap.equals("")) { %> class="on" <% } %> id="tabALL" onclick="goSubmit('list','','','ALL')">전체</li>
			<li <%if(tap.equals("10")) { %> class="on" <% } %>id="tab1" class="end02" onclick="goSubmit('list','','','10')">신청</li>
			<li <%if(tap.equals("20")) { %> class="on" <% } %>id="tab2" class="MA02" onclick="goSubmit('list','','','20')">승인</li>
			<li <%if(tap.equals("30")) { %> class="on end" <% } %>id="tab3" class="end end02 MA02" onclick="goSubmit('list','','','30')">취소/반려</li>
		</ul>
	</div>
	<!--tabBox E-->

	<!--list_top S-->
	<div class="list_top">
		<form id="searchForm" name="searchForm" method="post" action="./event.do">
			<input type="hidden" name="nowPage" id="nowPage" value="<%=nowPage %>" />
			<input type="hidden" name="mode" id="mode" />
			<input type="hidden" name="eventReqIdx" id="eventReqIdx" value="" />
			<input type="hidden" name="eventIdx" id="eventIdx" value="<%=eventIdx%>" />
			<input type="hidden" name="tap" id="tap" value="<%=tap%>" />
			<input type="hidden" name="siteId" id="siteId" value="<%=siteId%>" />

			<div class="board_count">
				전체 <span class="blue1"><%=staticVO.getTotalCount()%></span>건
			</div>

			<div class="b_srchBox">
			
				<div class="labelBox01">
				
					<label>행사기간조회</label>
					<input type="text" class="txtbox MAL10" id="searchStDt" name ="searchStDt" value="<%=util.getStr(paramMap.get("searchStDt")) %>"/>
					<div class="btw">~</div>
					<input type="text" class="txtbox MAL0" id="searchEdDt" name ="searchEdDt" value="<%=util.getStr(paramMap.get("searchEdDt")) %>"/>
					
				</div>
				
				<div class="labelBox02 MAL10">
			
					<div class="b_srch">
						<!-- 키워드 -->
						<input type="text" name="searchWord" id="searchWord" class="b_srch_txt" value="<%=util.getStr(paramMap.get("searchWord")) %>"/>
						<!-- 검색버튼 -->
						<input type="image" src="/img/board/btn_ico_srch.png" class="b_go_btn" value="검색" onclick="goSubmit('list','','','<%=tap%>')"/>
					</div>
				
				</div>
				
			</div>

		</form>
	</div>
	<!--list_top E-->

		<!--basic_listWrap S-->
		<div class="basic_listWrap">

			<table class="skin_list01">
				<colgroup>
					<col style="width:auto" />
					<col style="width:auto" />
					<col style="width:auto" />
					<col style="width:auto" />
					<col style="width:auto" />
					<col style="width:auto" />
					<col style="width:auto" />
				</colgroup>

				<!--<thead>
					<tr>
						<th scope="col">NO</th>
						<th scope="col">접수상태</th>
						<th scope="col">행사분류</th>
						<th scope="col">행사명</th>
						<th scope="col">행사기간</th>
						<th scope="col">참가신청기간</th>
						<th scope="col" class="r_line_none">행사<br>참가비</th>
					</tr>
				</thead>-->
				<tbody>

					<%
						int cont = (staticVO.getTotalCount() - ((staticVO.getNowPage() - 1) * staticVO.getPageSize()));

						if(dataList.size() == 0){
					%>
						<tr><td colspan="7">데이터가 존재하지 않습니다</td></tr>
					<%
						}

						for(HashMap rs:dataList) {
					%>

					<tr>
						<th scope="col">NO</th>
						<th scope="col">접수상태</th>
						<td>
							<%if(util.getStr(rs.get("APPLICANT_STATE")).equals("10")) { %>
							<!-- <img alt="승인신청" src="/img/back/comm/edu_state_img_08.png" /> --><div class="br01">승인신청</div>
							<% } %> <%if(util.getStr(rs.get("APPLICANT_STATE")).equals("20")) { %>
							<!-- <img alt="승인" src="/img/back/comm/edu_state_img_07.png" /> --><div class="br01">승인</div>
							<% } %> <%if(util.getStr(rs.get("APPLICANT_STATE")).equals("30")) { %>
							<!-- <img alt="승인거절" src="/img/back/comm/order_state_img_3.png" /> --><div class="rd01">승인거절</div>
							<% } %> <%if(util.getStr(rs.get("APPLICANT_STATE")).equals("40")) { %>
							<!-- <img alt="승인취소" src="/img/back/comm/order_state_img_5.png" /> --><div class="br02">승인취소</div>
							<% } %>
						</td>
						<th scope="col">행사분류</th>
						<td>
							<%=util.getStr(rs.get("CODE_NM"))%>
						</td>
					</tr>

					<tr>
						<td rowspan="2">
							<%=cont%>
						</td>
						<th scope="col">행사기간</th>
						<td>
							<%=util.getStr(rs.get("EVENT_ST_DT"))%><br /> ~ <%=util.getStr(rs.get("EVENT_ED_DT"))%>
						</td>
						<th scope="col">참가신청기간</th>
						<td>
							<%=util.getStr(rs.get("REQ_ST_DT"))%><br /> ~ <%=util.getStr(rs.get("REQ_ED_DT"))%>
						</td>
					</tr>
					<tr>
						<th scope="col">행사명</th>
						<td class="algnL" style="cursor: pointer" onclick="goSubmit('view','<%=util.getStr(rs.get("EVENT_IDX"))%>','<%=rs.get("EVENT_REQ_IDX")%>','<%=tap%>')">
							<%if(util.getStr(rs.get("EVENT_NM")).length()>10){%>
								<u><%=util.getStr(rs.get("EVENT_NM")).substring(0, 10)+" · · · "%></u>
							<%}else{%>
								<u><%=util.getStr(rs.get("EVENT_NM"))%></u>
							<%}%>
						</td>
						<th scope="col" class="r_line_none">행사<br>참가비</th>
						<td class="r_line_none">
							<% String pay = util.getStr(rs.get("EVENT_PAY"));
							if(util.getStr(rs.get("EVENT_FREE_YN")).equals("Y")){%>
								유료<br>(<%=util.setFormatNum(pay,"comma")%>)
							<%}else{ %>
								무료
							<%} %>
						</td>
					</tr>
					<% cont--; } %>
				</tbody>
			</table>
			<%=util.getPaging(staticVO, nowPage) %>
		</div>
<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,eventIdx,eventReqIdx,tap){
		$('#mode').val(mode);
		$('#eventIdx').val(eventIdx);
		$('#eventReqIdx').val(eventReqIdx);
		$('#tap').val(tap);
		$('#searchForm').submit();
	}

	$(document).ready(function(){

		$("#searchStDt, #searchEdDt").datepicker({
			showMonthAfterYear : true,
			showButtonPanel : true,
			changeMonth : true,
			changeYear : true,
			nextText : '다음 달',
			prevText : '이전 달',
			currentText : '오늘 날짜',
			closeText : '닫기',
			dateFormat : "yy-mm-dd",
			dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일' ],
			dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
		});

		// 시작일 값에 따른 종료일 선택 값 제한
	    $('#searchStDt').datepicker("option", "maxDate", $("#searchEdDt").val());
	    $('#searchStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#searchEdDt").datepicker( "option", "minDate", selectedDate );
	    });
		// 종료일 값에 따른 시작일 선택 값 제한
	    $('#searchEdDt').datepicker("option", "minDate", $("#searchStDt").val());
	    $('#searchEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#searchStDt").datepicker( "option", "maxDate", selectedDate );
		});

	});
//]]>	
</script>