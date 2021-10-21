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

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	ArrayList<HashMap<String, String>> eventTypeList = request.getAttribute("eventTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventTypeList");
	ArrayList<HashMap<String, String>> eventList = request.getAttribute("eventList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventList");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = util.getLoginInfo(request) == null ?  new LoginVO(): (LoginVO)util.getLoginInfo(request);

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));
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


	<script type="text/javascript">
	//<![CDATA[
	/*select box 년,월 변경시 실행*/
	function selYear(){
		$("#year").val($("#selYear option:selected").val());
		$("#month").val($("#selMonth option:selected").val());
		$('#searchForm').submit();
	}
	function selMonth(){
		$("#year").val($("#selYear option:selected").val());
		$("#month").val($("#selMonth option:selected").val());
		$('#searchForm').submit();
	}

	/*달력 버튼 체크*/
	function checkCalendar(m, year, month){
		var chYear = $("#selYear option:selected").val();
		var chMonth = $("#selMonth option:selected").val();
		var chLastYear = Number(<%=nowYear%>)+1;

		alert("m:: "+m+"  year:: "+year+"  month:: "+month);
		alert("chYear:: "+chYear+"  chMonth:: "+chMonth+"  chLastYear:: "+chLastYear);

		if(m==1){

			if(chYear == 2014){
				alert("2014년 이전의 데이터는 검색 하실 수 없습니다.");
				return false;
			}

		}else if(m==2){

			if(chYear == chLastYear){
				alert(chLastYear+"년 이후의 데이터는 검색 하실 수 없습니다.");
				return false;
			}

		}else if(m==3){

			if(chYear == 2014 && chMonth == 1){
				alert("2014년 이전의 데이터는 검색 하실 수 없습니다.");
				return false;
			}

		}else{

			if(chYear == chLastYear && chMonth == 12){
				alert(chLastYear+"년 이후의 데이터는 검색 하실 수 없습니다.");
				return false;
			}
		}

		goSubmit('list','calendar');
	}
	//]]>
</script>


<%

	if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) < 70){
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

	<!-- list_top S-->
	<div class="list_top">

		 <form action="sub.do" name="searchForm" id="searchForm" method="post" class="boardSearch">
			<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
			<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
			<input type="hidden" name="listMode" id="listMode" value="<%=listMode%>" />
			<input type="hidden" name="m" value="<%=m%>" />
			<input type="text" name="mode" id="mode"  value="<%=mode%>" />
			<input type="text" name="year" id="year"  value="<%=year%>" />
			<input type="text" name="month" id="month"  value="<%=month%>" />

		  <div class="public_top_wrap">
		  	<div class="b_srchBox">
				<!-- 검색필드 -->
				<select class="b_select" name="searchType" id="searchType">
					<option value="EVENT_NM" <%if("EVENT_NM".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사명</option>
					<option value="EVENT_CONTENTS" <%if("EVENT_CONTENTS".equals(util.getStr(paramMap.get("searchType")))) {%> selected="selected" <%}%>>행사내용</option>
				</select>
				<div class = "b_srch">
					<!-- 키워드 -->
					<input class="b_srch_txt" type="text" name="searchWord" id="searchWord" value="<%=util.getStr(paramMap.get("searchWord"))%>" style="width:50%; height:20px" />
					<!-- 검색버튼 -->
					<input type="image" class="b_go_btn" src="/img/board/btn_ico_srch.png" alt="검색" onclick="goSubmit('list','calendar')" />
				</div>
			</div>
			<div class="b_srchBox_gap" style="width: 15px;" >
				<img src="/img/board/srch_box_gap.gif">
			</div>
			<div class="b_btn_listBox">
				<button type="button" class="b_btn_list" onclick="goSubmit('list','list')" title="게시판형"><img src="/img/board/btn_list.png" /></button>
				<button type="button" class="b_btn_blog" onclick="goSubmit('list','imageList')" title="블로그형"><img src="/img/board/btn_blog.png" /></button>
				<button type="button" class="b_btn_blog" onclick="goSubmit('list','calendar')" title="달력형"><img src="/img/board/btn_calendar_ovr.png" /></button>
			</div>
		</div>

		</form>
		<!-- searchForm e -->

	</div>
	<!--list_top E-->

	<div class="calendar_box" id="cont_block">
		<table boder="0" cellspacing="5" cellpadding="5" align="center">
			 <tr>
				<td colspan="7" align="center" style="height:50px;vertical-align:bottom;">

						<img src="/img/board/p_prev_m.gif" onclick="checkCalendar(1,<%=ppreYear %>,<%=preMonth %>)" />

						<select name = "selYear" id="selYear" onchange="selYear()">
						<%/*2014년도 부터 시작함 한계점은 현재 년도의 다음년도까지 */
						  for(int i=2014;i<=nowYear+1;i++){%>
							<option id="selYear<%=i%>" value ="<%=i%>" <%if(i == year){%>selected="selected"<%} %>><%=i%></option>
						<%}%>
						</select>년

						<img src="/img/board/p_next_m.gif" onclick="checkCalendar(2,<%=nnextYear %>,<%=nextMonth %>)" />

					&nbsp;&nbsp;

						<a href="./<%=myPage%>?year=<%=preYear %>&month=<%=ppreMonth %>" onclick="checkCalendar(3)">
							<img src="/img/board/p_prev_m.gif" />
						</a>

						<select name = "selMonth" id="selMonth" onchange="selMonth()">
						<%for(int i=1;i<=12;i++){%>
							<option id="selMonth<%=i%>" value ="<%=i%>" <%if(i == month) {%>selected="selected"<%} %>><%=i%></option>
						<%}%>
						</select>월

						<a href="./<%=myPage%>?year=<%=nextYear %>&month=<%=nnextMonth %>" onclick="checkCalendar(4)">
							<img src="/img/board/p_next_m.gif" />
						</a>

				</td>
			</tr>

			<tr>
				<td>

					<!-- 전체 건수 -->
					<div class="search_row">
							<div class="total" style="margin:2px; padding:5px;">
								[전체 <span><%=staticVO.getTotalCount() %></span>건]
							</div>
					</div>

					<table border="1" bordercolor="#D5D5D5" width="900" height="600" cellpadding="0" cellspacing="0">
						<!--<colgroup s> -->
						<colgroup>
							<col style="width: 10%;" />
							<col style="width: 10%;" />
							<col style="width: 10%;" />
							<col style="width: 10%;" />
							<col style="width: 10%;" />
							<col style="width: 10%;" />
							<col style="width: 10%;" />
						</colgroup>
						<!--<colgroup e> -->
						<thead>
							<tr align="center" style="background-color:#EAEAEA;height:30px;">
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

								String tBgcolor = "#FFFFFF"; //오늘날짜 배경색지정
								String dayFcolor = "black"; //날짜색
								if(cal.get(Calendar.DAY_OF_WEEK)==1){ //일요일
									dayFcolor = "red";
								}else if(cal.get(Calendar.DAY_OF_WEEK)==7){ //토요일
									dayFcolor = "blue";
								}

								if(cal2.get(Calendar.DATE)==j && (cal2.get(Calendar.MONTH))==(cal.get(Calendar.MONTH)) && (cal.get(Calendar.YEAR))==nowYear){
									tBgcolor = "#E4F7BA";
								}
							%>
							<!--sytle="height:120px;"-->
								<td align="right" style="background-color:<%=tBgcolor%>;vertical-align:top;padding:2px;">
									<div style="color:<%=dayFcolor%>;"><b><%=j%></b></div>

									<%
										int cont = (staticVO.getTotalCount());
										for(HashMap rs:eventList) {

											/*달력출력 셋팅값*/
											int stYear = util.getInt(rs.get("ST_YEAR"));
											int edYear = util.getInt(rs.get("ED_YEAR"));
											int stMonth = util.getInt(rs.get("ST_MONTH"));
											int edMonth = util.getInt(rs.get("ED_MONTH"));
											int stDay = util.getInt(rs.get("ST_DAY"));
											int edDay = util.getInt(rs.get("ED_DAY"));

										if(stYear < year && edYear == year){
											stDate = 1;
											edDate = edDay;
										}else if(stYear == year && edYear > year){
											stDate = stDay;
											edDate = cal.getActualMaximum(Calendar.DATE);
										}else{

											if(month > stMonth && month == edMonth){
												stDate = 1;
												edDate = edDay;
											}else if(month == stMonth && month < edMonth){
												stDate = stDay;
												edDate = cal.getActualMaximum(Calendar.DATE);
											}else if(month > stMonth && month < edMonth){
												stDate = 1;
												edDate = cal.getActualMaximum(Calendar.DATE);
											}else{
												stDate = stDay;
												edDate = edDay;
											}

										}

										/*업무진행여부에 다른 출력 셋팅값*/
										String stateVal = util.getStr(rs.get("STATE"));

										String stFcolor = "#F15F5F"; //완료
										if(stateVal.equals("진행중")){ //진행중
											stFcolor = "#6799FF";
										}else if(stateVal.equals("보류")){ //보류
											stFcolor = "#2F9D27";
										}
									%>

									<%if(j >= stDate  && j <= edDate){%>

										<%if(util.getStr(rs.get("SUBJECT")).length()>5){%>
										<div style='text-align:left'>
											<span style="display:inline-block; width:5px; vertical-align:middle; height:5px; background-color:<%=stFcolor%>;">&nbsp;</span>
											<a href="./<%=myPage%>?mode=calendarView&amp;myWkIdx=<%=util.getStr(rs.get("MY_WK_IDX"))%>">
												<%=util.getStr(rs.get("SUBJECT")).substring(0, 4)+"..."%>
												<span>(<%=util.getStr(rs.get("NAME"))%>)</span>
											</a>
										</div>
									    <%}else{%>
										<div style='text-align:left'>
											<span style="display:inline-block; width:5px; vertical-align:middle; height:5px; background-color:<%=stFcolor%>;">&nbsp;</span>
											<a href="./<%=myPage%>?mode=calendarView&amp;myWkIdx=<%=util.getStr(rs.get("MY_WK_IDX"))%>">
												<%=util.getStr(rs.get("SUBJECT"))%>
												<span>(<%=util.getStr(rs.get("NAME"))%>)</span>
											</a>
										</div>
									    <%}%>

									<%}%>

									<%
										cont--;
										}
									%>
								</td>
							<%
								if(cal.get(Calendar.DAY_OF_WEEK)==7){
							%>
								</tr><tr>
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

				</td>
			</tr>
		</table>
		<!-- skin_basic_list e -->

		<div style='background-color:#FFFFF; float:right; margin:5px; padding:5px; width:320px; height:30px;'>
			<span style='display:inline-block; width:15px; height:15px; background-color:#565656;'>&nbsp;&nbsp;&nbsp;</span> <span>접수전&nbsp;</span>
			<span style='display:inline-block; width:15px; height:15px; background-color:#6799FF;'>&nbsp;&nbsp;&nbsp;</span> <span>접수중&nbsp;</span>
			<span style='display:inline-block; width:15px; height:15px; background-color:#2F9D27;'>&nbsp;&nbsp;&nbsp;</span> <span>접수마감&nbsp;</span>
			<span style='display:inline-block; width:15px; height:15px; background-color:#F15F5F;'>&nbsp;&nbsp;&nbsp;</span> <span>행사종료&nbsp;</span>
		</div>
	</div>

<script type="text/javascript">
//<![CDATA[
	function goSubmit(mode,listMode){
		$('#mode').val(mode);
		$('#listMode').val(listMode);
		$('#searchForm').submit();
	}
//]]>	
</script>
