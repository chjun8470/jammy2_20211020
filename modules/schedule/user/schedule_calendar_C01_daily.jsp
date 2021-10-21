<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.schedule.service.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%!
public static String DateTypeIntForString(int iInput)
{
	String sOutput = "";
	if(Integer.toString(iInput).length() == 1) {
		sOutput = "0" + Integer.toString(iInput);
	} else {
		sOutput = Integer.toString(iInput);
	}

	return sOutput;
}
%>

<%
ScheduleInfoVO searchScheduleInfoVO = (ScheduleInfoVO)request.getAttribute("searchScheduleInfoVO");
String strYear = EgovStringUtil.nullConvert(request.getParameter("year"));
String strMonth = EgovStringUtil.nullConvert(request.getParameter("month"));
String strDay = EgovStringUtil.nullConvert(request.getParameter("day"));
String strSearchDay = "";

Calendar calNow = Calendar.getInstance();
int iNowYear = calNow.get(Calendar.YEAR);
int iNowMonth = calNow.get(Calendar.MONTH);
int iNowDay = calNow.get(Calendar.DATE);

if(!"".equals(strYear)) {
	iNowYear = Integer.parseInt(strYear);
	iNowMonth = Integer.parseInt(strMonth);
	iNowDay = Integer.parseInt(strDay);
}

calNow.set(iNowYear, iNowMonth, iNowDay);
int iNowWeek = calNow.get(Calendar.DAY_OF_WEEK);

strSearchDay = Integer.toString(iNowYear);
strSearchDay += DateTypeIntForString(iNowMonth+1);
strSearchDay += DateTypeIntForString(iNowDay);

String searchMode = "DAILY";
String searchDay = strSearchDay;

Calendar cal = Calendar.getInstance();
cal.set(iNowYear, iNowMonth, 1);
int startDay = cal.getMinimum(Calendar.DATE);
int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
int startWeek = cal.get(Calendar.DAY_OF_WEEK);

//요일설정
String arrDateTitle[] = new String[7];

arrDateTitle[0] = "일요일";
arrDateTitle[1] = "월요일";
arrDateTitle[2] = "화요일";
arrDateTitle[3] = "수요일";
arrDateTitle[4] = "목요일";
arrDateTitle[5] = "금요일";
arrDateTitle[6] = "토요일";
%>

<div class="tab-type1">
	<ul class="nav nav-pills nav-justified">
	<li class="active"><span><a href="?searchMode=DAILY">일간일정</a></span></li>
	<li><span><a href="?searchMode=MONTH">월간일정</a></span></li>
	</ul>
</div>

<div class="schedule-daily">
	<div class="mg-t-lg bordered pd-md">
		<div class="row">
			<div class="col-sm-2"></div>
			<div class="col-sm-8">
				<div class="text-center">
					<%if(iNowMonth > 0 ){ %>
					<a class="prev_mon" href="?year=<%=iNowYear%>&amp;month=<%=iNowMonth-1%>&amp;day=<%=iNowDay%>&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>">이전월</a>
					<%}else{%>
					<a class="prev_mon" href="?year=<%=iNowYear-1%>&amp;month=11&amp;day=<%=iNowDay%>&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>">이전월</a>
					<%}%>
					<%=iNowYear%>년 <%=iNowMonth+1%>월
					<%if(iNowMonth < 11 ){ %>
					<a class="next_mon" href="?year=<%=iNowYear%>&amp;month=<%=iNowMonth+1%>&amp;day=<%=iNowDay%>&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>">다음월</a>
					<%}else{%>
					<a class="next_mon" href="?year=<%=iNowYear+1%>&amp;month=0&amp;&amp;day=<%=iNowDay%><c:out value='${searchScheduleInfoVO.queryString}'/>">다음월</a>
					<%}%>
				</div>
			</div>
			<div class="col-sm-2 text-right">
				<a href="?searchMode=MONTH" class="btn btn-default btn-sm">월간 일정 보기</a>
			</div>
		</div>
		<div class="mg-t-sm mg-b-sm bd-b"></div>
		<div class="daily-list">
<%
int newLine = 0;
for (int index = 1; index < startWeek; index++) newLine++;
for (int i = 0; i < endDay; i++) { 
	String color = "";
	if(newLine == 0) {
		color = "sun";
	} else if (newLine == 6) {
		color = "sat";
	}

	String active = (iNowDay == (i+1)) ? "active" : "";
%>
		<a class="d<%=i%> <%=color%> <%=active%> calendar_day" href="?year=<%=iNowYear%>&amp;month=<%=iNowMonth%>&amp;day=<%=(i+1)%>&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>" title="<%=iNowYear%>년 <%=iNowMonth+1%>월 <%=i+1%>일"><%=i+1%></a>
<%
	if(newLine == 6) newLine=0;
	else newLine++;
}
%>
		</div>
	</div>

	<div class="mg-t-lg">
		<%=iNowYear%>년 <%=iNowMonth+1%>월 <%=iNowDay%>일 (<%=arrDateTitle[iNowWeek-1]%>)
		<table class="tbl_type1">
			<colgroup>
				<col style="width:250px;" />
				<col />
			</colgroup>
			<thead>
				<tr>	
					<th scope="col" class="leftL_none">시간</th>
					<th scope="col">일정</th>
				</tr>
			</thead>
			<tbody>
<%
ScheduleManager sm = new ScheduleManager(request);
List<ScheduleInfoVO> listResult = sm.getScheduleInfoListByDaily(searchScheduleInfoVO.getCalndId(), searchDay);
if (listResult != null) {
	for(int i = 0; i < listResult.size(); i++) {
		out.println("<tr>");		
		out.println("<th class=\"data\">");
		out.print(listResult.get(i).getSchdulBgnde().substring(8,10) + "시");
		out.print(listResult.get(i).getSchdulBgnde().substring(10,12) + "분 ~ ");
		out.print(listResult.get(i).getSchdulEndde().substring(8,10) + "시");
		out.print(listResult.get(i).getSchdulEndde().substring(10,12) + "분");
		out.println("</th>");
		out.println("<td>");
		out.print(String.format("<a href=\"?act=view&amp;schdulId=%s&amp;year=%d&amp;month=%d&amp;day=%d&amp;%s\">[%s] %s</a>", listResult.get(i).getSchdulId(), iNowYear, iNowMonth, iNowDay, searchScheduleInfoVO.getQueryString(), listResult.get(i).getSchdulSeNm(), listResult.get(i).getSchdulNm()));
		out.println("</td>");
		out.println("</tr>");
	}
}
%>
			</tbody>
		</table>
	</div>
</div>