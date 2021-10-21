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

Calendar calNow = Calendar.getInstance();
int iNowYear = calNow.get(Calendar.YEAR);
int iNowMonth = calNow.get(Calendar.MONTH);
int iNowDay = calNow.get(Calendar.DATE);

if(!"".equals(strYear) && !"".equals(strMonth)) {
	iNowYear = Integer.parseInt(strYear);
	iNowMonth = Integer.parseInt(strMonth);
}

int iNowWeek = calNow.get(Calendar.DAY_OF_WEEK);

String strSearchDate = "";
strSearchDate = Integer.toString(iNowYear);
strSearchDate += DateTypeIntForString(iNowMonth+1);

String searchDate = strSearchDate;

java.util.Calendar cal = Calendar.getInstance();
cal.set(iNowYear, iNowMonth, 1);

int startDay = cal.getMinimum(Calendar.DATE);
int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
int start = cal.get(Calendar.DAY_OF_WEEK);
int newLine = 0;
%>

<div class="mg-t-lg bordered pd-md">
	<div class="row">
		<div class="col-sm-2"></div>
		<div class="col-sm-8">
			<div class="text-center">
				<%if(iNowMonth > 0 ){ %>
				<a class="prev_mon" href="?year=<%=iNowYear%>&amp;month=<%=iNowMonth-1%>&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>">이전월</a>
				<%}else{%>
				<a class="prev_mon" href="?year=<%=iNowYear-1%>&amp;month=11&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>">이전월</a>
				<%}%>
				<%=iNowYear%>년 <%=iNowMonth+1%>월
				<%if(iNowMonth < 11 ){ %>
				<a class="next_mon" href="?year=<%=iNowYear%>&amp;month=<%=iNowMonth+1%>&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>">다음월</a>
				<%}else{%>
				<a class="next_mon" href="?year=<%=iNowYear+1%>&amp;month=0&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>">다음월</a>
				<%}%>
			</div>	
		</div>
	</div>
</div>

<style>
.tbl_calendar{width:100%; position:relative; border-collapse:collapse; border-right:1px solid #ddd; border-top:1px solid #ddd;}
.tbl_calendar th,
.tbl_calendar td {width:14%; min-width:100px; padding:5px; border-left:1px solid #DDDDDD; border-bottom:1px solid #DDDDDD; overflow:hidden; vertical-align:top;}
.tbl_calendar th {background:#f7f7f7; text-align:center;}
.tbl_calendar td {height:80px; padding-top:5px;}
.tbl_calendar td.today {background:#f4f4f4;}
.tbl_calendar td .sun {color:#fe7474;}
.tbl_calendar td .sat {color:#1974d1;}
.tbl_calendar td .day {}
.tbl_calendar td .plan {font-size:13px; text-align:left; line-height:1.4;}
</style>

<div class="table-responsive mg-t-lg">
	<table class="table tbl_calendar">
		<thead>
			<tr>
				<th scope="col">일</th>
				<th scope="col">월</th>
				<th scope="col">화</th>
				<th scope="col">수</th>
				<th scope="col">목</th>
				<th scope="col">금</th>
				<th scope="col">토</th>			
			</tr>
		</thead>
		<tbody>
			<tr>
<%

ScheduleManager sm = new ScheduleManager(request);
List<ScheduleInfoVO> listResult = (List)sm.getScheduleInfoListByMonth(searchScheduleInfoVO.getCalndId(), searchDate);

for(int index = 1; index < start; index++) {
	out.println("<td></td>");
	newLine++;
}

for(int index = 1; index <= endDay; index++) {
	String color = "";
	if(newLine == 0) {           color = "sun";
	} else if (newLine == 6) {   color = "sat";
	} else {                     color = ""; };

	String today = "";
	if (index == iNowDay) today = "today";

	String sUseDate = Integer.toString(iNowYear);
	sUseDate += Integer.toString(iNowMonth+1).length() == 1 ? "0" + Integer.toString(iNowMonth+1) : Integer.toString(iNowMonth+1);  
	sUseDate += Integer.toString(index).length() == 1 ? "0" + Integer.toString(index) : Integer.toString(index);
	
	int iUseDate = Integer.parseInt(sUseDate);

	out.println(String.format("<td class=\"%s %s\">", "d"+index, today));
	out.println(String.format("<span class=\"day %s\">%d</span>", color, index));
	
	if (listResult != null) {
		for (int i = 0; i < listResult.size(); i++) {    		
			int iBeginDate = Integer.parseInt(listResult.get(i).getSchdulBgnde().substring(0, 8));
			int iEndDate = Integer.parseInt(listResult.get(i).getSchdulEndde().substring(0, 8));
			if(iUseDate >= iBeginDate && iUseDate <= iEndDate){
				out.println("<div class=\"plan\">");
				out.print(String.format("<a href=\"?act=view&amp;schdulId=%s&amp;year=%d&amp;month=%d&amp;%s\">%s</a>", listResult.get(i).getSchdulId(), iNowYear, iNowMonth, searchScheduleInfoVO.getQueryString(), listResult.get(i).getSchdulNm()));
				out.println("</div>");
			}
		}
	}

	out.println("</td>");
	newLine++;

	if(newLine == 7) {
		out.println("</tr>");
		if(index <= endDay) {
			out.println("<tr>");
		}
		newLine=0;
	}
}
//마지막 공란 LOOP
while(newLine > 0 && newLine < 7) {
	out.println("<td>&nbsp;</td>");
	newLine++;
}
%>
			</tr>
		</tbody>
	</table>
</div>