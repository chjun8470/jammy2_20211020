<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> eventTypeList = request.getAttribute("eventTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventTypeList");
	ArrayList<HashMap<String, String>> eventCalendarList = request.getAttribute("eventCalendarList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventCalendarList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
	String eventIdx = util.getStr(paramMap.get("eventIdx"));
	String m = util.getStr(paramMap.get("m"));

	String listMode = util.getStr(paramMap.get("listMode"));
	if("".equals(listMode)) mode = "list";



	//Calendar 객체 생성
	Calendar cal = Calendar.getInstance();
	Calendar cal2 = Calendar.getInstance();


	//오늘 날짜 구하기
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1; //월은 0부터 시작하므로 1월 표시를 위해 1을 더해 준다
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);
	String nowWeek = "";

	switch (cal.get(Calendar.DAY_OF_WEEK)){
	    case 1:
	    	nowWeek ="일요일";
	        break;
	    case 2:
	    	nowWeek ="월요일";
	        break;
	    case 3:
	    	nowWeek ="화요일";
	        break;
	    case 4:
	    	nowWeek ="수요일";
	        break;
	    case 5:
	    	nowWeek ="목요일";
	        break;
	    case 6:
	    	nowWeek ="금요일";
	        break;
	    case 7:
	    	nowWeek ="토요일";
	        break;
	}

	//클라이언트가 선택하여 넘어온 날짜
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");

	//표시한 달력의 년,월
	int year = nowYear;
	int month = nowMonth;
		if(strYear!=null){
		year = Integer.parseInt(strYear); //클라이언트가 선택한 값을 입력
		}
		if(strMonth!=null){
		month = Integer.parseInt(strMonth); //클라이언트가 선택한 값을 입력
	}

	System.out.println("year값::"+year);
	System.out.println("month값::"+month);
	int ppreYear = 0;
	int preYear = 0;
	int ppreMonth = 0;
	int preMonth = 0;
	int nnextYear = 0;
	int nextYear = 0;
	int nnextMonth = 0;
	int nextMonth = 0;

	//전월 이동
	ppreYear = year-1;
	preYear = year;
	ppreMonth = month-1;
	preMonth = month;
	if(ppreMonth<1){ //1월 전월은 작년 12월
		preYear = year-1;
		ppreMonth = 12;
	}

	if(year == 2014){
		ppreYear = 2014;
		preYear = 2014;
		if(month == 1){
			ppreMonth = 1;
			preMonth = 1;
		}
	}

	//다음달 이동
	nnextYear = year+1;
	nextYear = year;
	nnextMonth = month+1;
	nextMonth = month;
	if(nnextMonth>12){ //12월 다음달은 내년 1월
		nextYear = year+1;
		nnextMonth = 1;
	}
		if(year == nowYear+1){
		nnextYear = nowYear+1;
		nextYear = nowYear+1;
		if(month == 12){
			nnextMonth = 12;
			nextMonth = 12;
		}
	}

	//출력할 달력 세팅
	cal.set(year,month-1,1); //년,월,일

	//달력데이터 출력시 비교 변수
	int stDate = 0;
	int edDate = 0;

%>


	<form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
		<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
		<input type="hidden" name="m" value="<%=m%>" />
		<input type="hidden" name="eventIdx" id="eventIdx" value="<%=eventIdx%>" />
		<input type="hidden" name="year" id="year"  value="<%=year%>" />
		<input type="hidden" name="month" id="month"  value="<%=month%>" />

	<!-- list_top S-->
	<div class="list_top">

		  <div class="public_top_wrap">
		  	<div class="b_btn_listBox">
				<button type="button" class="b_btn_list" onclick="goSubmit('list','list')" title="게시판형"><img src="/img/board/btn_list.png"/></button>
				<button type="button" class="b_btn_blog" onclick="goSubmit('list','imageList')" title="블로그형"><img src="/img/board/btn_blog.png"/></button>
				<button type="button" class="b_btn_blog" onclick="goSubmit('list','calendar',<%=nowYear%>,<%=nowMonth%>)" title="달력형(선택됨)"><img src="/img/board/btn_calendar_ovr.png" /></button>
			</div>
			<div class="b_srchBox_gap" style="margin-left: 10px;">
				<img src="/img/board/srch_box_gap.gif" alt="">
			</div>
		  	<div class="b_srchBox">
				<!-- 검색필드 -->
				<select class="b_select" name="searchType" id="searchType" onclick="check_only()" title="검색조건 선택">
					<option value="EVENT_NM" <%if("EVENT_NM".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사명</option>
					<option value="EVENT_CONTENTS" <%if("EVENT_CONTENTS".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사내용</option>
					<option value="EVENT_STATE" <%if("EVENT_STATE".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사상태</option>
				</select>
				<div class = "b_srch">
                    <label class="hide" for="searchWord">검색어를 입력하세요</label>
					<!-- 키워드 -->
					<input class="b_srch_txt" type="text" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" />
					<!-- 행사상태  -->
					<select class="b_select" name="searchState" id="searchState" style="display:none; width:40%; height: 36px; border-color: white;">
						<option value="">전체</option>
						<option value="접수전"<%if("접수전".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수전</option>
						<option value="접수중"<%if("접수중".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수중</option>
						<option value="접수마감"<%if("접수마감".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>접수마감</option>
						<option value="행사종료"<%if("행사종료".equals(util.getStr(paramMap.get("searchState")))) {%> selected="selected" <%}%>>행사종료</option>
					</select>
					<!-- 검색버튼 -->
					<input type="image" class="b_go_btn" src="/img/board/btn_ico_srch.png" alt="검색" onclick="goSubmit('list','calendar',<%=year%>,<%=month%>)" />
				</div>
			</div>
		</div>

	</div>
	<!--list_top E-->

	</form>
	<!-- searchForm e -->




	<div class="calendar_box" id="cont_block">

		<!-- calendar_in S -->
		<div class="calendar_in" style="float:left;">

			<!-- 년/월 선택 -->
			<p class="cal-ym01">
			<span class="prev"><a href="sub.do?m=<%=m%>&mode=<%=mode %>&listMode=calendar&year=<%=ppreYear %>&month=<%=preMonth %>" onclick="checkCalendar(1)" title="1년전으로 이동">◀</a></span>
				<span><%=year%>년</span>
				<span class="next"><a href="sub.do?m=<%=m%>&mode=<%=mode %>&listMode=calendar&year=<%=nnextYear %>&month=<%=nextMonth %>" onclick="checkCalendar(2)" title="1년후로 이동">▶</a></span>
				<span class="prev"><a href="sub.do?m=<%=m%>&mode=<%=mode %>&listMode=calendar&year=<%=preYear %>&month=<%=ppreMonth %>" onclick="checkCalendar(3)" title="1개월 전으로 이동">◀</a></span>
				<span><%=month%>월</span>
				<span class="next"><a href="sub.do?m=<%=m%>&mode=<%=mode %>&listMode=calendar&year=<%=nextYear %>&month=<%=nnextMonth %>" onclick="checkCalendar(4)" title="1개월 후로 이동">▶</a></span>
			</p>


			<!-- 달력 -->
			<div class="carendar01">

				<table class="table_a" border="0" cellpadding="0" cellspacing="0">

						<!--<colgroup s> -->
						<colgroup>
							<col style="width: 15%;" />
							<col style="width: 14%;" />
							<col style="width: 14%;" />
							<col style="width: 14%;" />
							<col style="width: 14%;" />
							<col style="width: 14%;" />
							<col style="width: 15%;" />
						</colgroup>
						<!--<colgroup e> -->
						<thead>
							<tr>
							<th scope="col" style="color:red;">일</th>
							<th scope="col">월</th>
							<th scope="col">화</th>
							<th scope="col">수</th>
							<th scope="col">목</th>
							<th scope="col">금</th>
							<th scope="col" style="color:blue;">토</th>
						</tr>
					</thead>
					<tbody>
						<tr>

							<!--Calculation_1 Start-->
							<%
								cal.set(Calendar.DATE,1);
							    for(int i=1;i<cal.get(Calendar.DAY_OF_WEEK);i++){
							%>
								<td>&nbsp;</td>
							<%
							    }
							%>

							<!--Calculation_2 Start-->
							<%
								for(int j=1;j<=cal.getActualMaximum(Calendar.DATE);j++){
								cal.set(Calendar.DATE,j);

								String dayFcolor = "black"; //날짜색
								if(cal.get(Calendar.DAY_OF_WEEK)==1){ //일요일
									dayFcolor = "red";
								}else if(cal.get(Calendar.DAY_OF_WEEK)==7){ //토요일
									dayFcolor = "blue";
								}
							%>

							<%
								if(cal2.get(Calendar.DATE)==j && (cal2.get(Calendar.MONTH))==(cal.get(Calendar.MONTH)) && (cal.get(Calendar.YEAR))==nowYear){
							%>
								<td class="check">
							<% }else{ %>
								<td>
							<% } %>
									<div style="color:<%=dayFcolor%>;">
									<b><%=j%></b>
									<% if(cal2.get(Calendar.DATE)==j && (cal2.get(Calendar.MONTH))==(cal.get(Calendar.MONTH)) && (cal.get(Calendar.YEAR))==nowYear){
									%>
										<span style="width:0px;height:0px;text-indent:-9999px;overflow:hidden;display:inline-block">당일</span>
									<%}%>
									</div>
								</td>
							<%
								if(cal.get(Calendar.DAY_OF_WEEK)==7){
							%>
						</tr>
						<tr>
							<%
								}
							}
							%>

							<!--Calculation_3 Start-->
							<%
						    	for(int i=cal.get(Calendar.DAY_OF_WEEK);i<7;i++){
							%>
								<td>&nbsp;</td>
							<%
								}
							%>

						</tr>

						</tbody>
				</table>
			</div>
		</div>
		<!-- calendar_in E-->

		<!-- CalendarList S-->
		<div class="CalendarList" style="float:left;">
			<p class="listT">
				<span class="blue">Today</span>
				<%=nowYear%>년 <%=nowMonth%>월 <%=nowDay%>일 <%=nowWeek%>
			</p>
			<div class="clist_box" style="height:255px; overflow:auto;">
			<ul class="DateList">

			<%
					//int cont = 1;
					if(eventCalendarList.size() == 0){
			%>
					<li>행사일정이 존재하지 않습니다.</li>
			<%
					}

					for(HashMap rs:eventCalendarList) {
			%>

			<li>
				<a href="sub.do?m=<%=m%>&mode=view&listMode=calendar&eventIdx=<%=util.getStr(rs.get("EVENT_IDX"))%>" title="<%=util.getStr(rs.get("EVENT_NM"))%> 상세보기" >
					<!-- 행사분류 -->
					[<%=util.getStr(rs.get("EVENT_TYPE_NM"))%>]
					<!-- 행사명 -->
					<%if(util.getStr(rs.get("EVENT_NM")).length()>15){%><%=util.getStr(rs.get("EVENT_NM")).substring(0, 15)+" · · · "%><%}else{%><%=util.getStr(rs.get("EVENT_NM"))%><%}%>
					<!-- 행사상태 -->
					<% if("접수중".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
						<img alt="접수중" src="/img/back/comm/edu_state_img_01.png" />
					<% }else if("접수전".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
						<img alt="접수전" src="/img/back/comm/edu_state_img_02.png" />
					<% }else if("접수마감".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
						<img alt="접수마감" src="/img/back/comm/edu_state_img_03.png" />
					<% }else{%>
						<img alt="행사종료" src="/img/back/comm/edu_state_img_06.png" />
					<% } %><br />

					<!-- 행사기간 -->
					행사기간 : <%=util.getStr(rs.get("EEVENT_ST_DT"))%> ~ <%=util.getStr(rs.get("EEVENT_ED_DT"))%><br />
					<%-- <input type="text" name="cont" id="cont" value="<%=cont%>">
					<input type="text" name="stDay" id="stDay<%=cont%>" value="<%=util.getStr(rs.get("ST_DAY"))%>">
					<input type="text" name="edDay" id="edDay" value="<%=util.getStr(rs.get("ED_DAY"))%>"> --%>

					<!-- 접수기간 -->
					<% if("접수중".equals(util.getStr(rs.get("EVENT_STATE")))){ %>
					접수기간 : <%=util.getStr(rs.get("RREQ_ST_DT"))%> ~ <%=util.getStr(rs.get("RREQ_ED_DT"))%>
					<%} %>
				</a>
			</li>
			<%
				//cont++;
				}
			%>
			</ul>
			</div>

		</div>
		<!--CalendarList E-->
</div>

<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){

	 	// 검색필드값이 행사상태일때
	    if($("#searchType option:selected").val() == 'EVENT_STATE'){
	    	$('#searchState').show();
			$('#searchWord').hide();
	    }else{
			$('#searchWord').show();
			$('#searchState').hide();
        	$('#searchState').val('');
		}

	});

	function goSubmit(mode,listMode,year,month){

		if(listMode == 'calendar'){
			$('#year').val(year);
			$('#month').val(month);
		}

		$('#mode').val(mode);
		$('#listMode').val(listMode);
		$('#searchForm').submit();
	}

	//행사상태 checkBox
 	function check_only(){

		var slectVal = $("#searchType option:selected").val();

		if(slectVal == "EVENT_STATE"){
			$('#searchState').show();
			$('#searchWord').hide();
		}else{
			$('#searchWord').show();
			$('#searchState').hide();
        	$('#searchState').val('');
		}
    }
//]]>	
</script>
