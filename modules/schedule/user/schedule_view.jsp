<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.jammy2.schedule.service.*" %>
<%
	ScheduleCalendarVO scheduleCalendarVO = (ScheduleCalendarVO)request.getAttribute("scheduleCalendarVO");
	ScheduleInfoVO searchScheduleInfoVO = (ScheduleInfoVO)request.getAttribute("searchScheduleInfoVO");
	String skinFile = String.format("schedule_view_%s.jsp", scheduleCalendarVO.getCalndTy());
%>
<jsp:include page="<%=skinFile%>" flush="true" />