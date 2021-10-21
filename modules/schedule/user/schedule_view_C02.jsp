<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.schedule.service.ScheduleInfoVO" %>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%
ScheduleInfoVO searchScheduleInfoVO = (ScheduleInfoVO)request.getAttribute("searchScheduleInfoVO");
String strYear = EgovStringUtil.nullConvert(request.getParameter("year"));
String strMonth = EgovStringUtil.nullConvert(request.getParameter("month"));
String strDay = EgovStringUtil.nullConvert(request.getParameter("day"));
String strWeek = EgovStringUtil.nullConvert(request.getParameter("week"));

if (!"".equals(strYear)) {
	searchScheduleInfoVO.setQueryString(searchScheduleInfoVO.getQueryString() + "&" + "year=" + strYear);
}
if (!"".equals(strMonth)) {
	searchScheduleInfoVO.setQueryString(searchScheduleInfoVO.getQueryString() + "&" + "month=" + strMonth);
}
if (!"".equals(strDay)) {
	searchScheduleInfoVO.setQueryString(searchScheduleInfoVO.getQueryString() + "&" + "day=" + strDay);
}
if (!"".equals(strWeek)) {
	searchScheduleInfoVO.setQueryString(searchScheduleInfoVO.getQueryString() + "&" + "week=" + strWeek);
}

request.setAttribute("searchScheduleInfoVO", searchScheduleInfoVO);
%>

<table class="tbl_type1">
	<colgroup>	
		<col style="width:120px;" />
		<col />
	</colgroup>
	<tbody>
		<c:if test="${not empty scheduleInfoVO.schdulSeNm}">
		<tr>
			<th scope="row" class="bg-gray">구분</th>
			<td class="tal"><c:out value="${scheduleInfoVO.schdulSeNm}"/></td>
		</tr>
		</c:if>
		<tr>
			<th scope="row" class="bg-gray">일정명</th>
			<td class="tal"><c:out value="${scheduleInfoVO.schdulNm}"/></td>
		</tr>
		<tr>
			<th scope="row" class="bg-gray">일정장소</th>
			<td class="tal"><c:out value="${scheduleInfoVO.schdulPlace}"/></td>
		</tr>
		<tr>
			<th scope="row" class="bg-gray">시작일</th>
			<td class="tal"><c:out value="${fn:substring(scheduleInfoVO.schdulBgnde,0,10)}"/></td>
		</tr>
		<tr>
			<th scope="row" class="bg-gray">종료일</th>
			<td class="tal"><c:out value="${fn:substring(scheduleInfoVO.schdulEndde,0,10)}"/></td>
		</tr>
		<tr>
			<th scope="row" class="bg-gray">시간</th>
			<td class="tal">
				<c:out value="${fn:substring(scheduleInfoVO.schdulBgnde,11,16)}"/> ~
				<c:out value="${fn:substring(scheduleInfoVO.schdulEndde,11,16)}"/>
			</td>
		</tr>
		<tr>
			<th scope="row" class="bg-gray">내용</th>
			<td class="tal">
				<c:out value="${jmy:nl2br(scheduleInfoVO.schdulCn)}" escapeXml="false" />
			</td>
		</tr>
		<tr>
			<th scope="row" class="bg-gray">신청자명</th>
			<td class="tal">
				<c:out value="${scheduleInfoVO.data01}"/>
			</td>
		</tr>
		<tr>
			<th scope="row" class="bg-gray">인원</th>
			<td class="tal">
				<c:out value="${scheduleInfoVO.data02}"/>
			</td>
		</tr>
		<c:if test="${not empty scheduleInfoVO.schdulOrgnztNm || not empty scheduleInfoVO.schdulChargerNm}">
		<tr>
			<th scope="row" class="bg-gray">담당자</th>
			<td class="tal">
				<c:out value="${scheduleInfoVO.schdulOrgnztNm}"/>
				<c:out value="${scheduleInfoVO.schdulChargerNm}"/>
			</td>
		</tr>
		</c:if>
		<tr>
			<th scope="row" class="bg-gray">첨부파일</th>
			<td class="tal">
				<ul>
				<c:forEach var="file" items="${scheduleInfoVO.atchFileList}" varStatus="status">
				<li>
					<c:set var="fileVO" value="${scheduleInfoVO.atchFileList[status.index]}"/>							
					<a href="<c:url value='${jmy:downloadUrl(fileVO.atchFileId, fileVO.fileSn)}'/>"><c:out value="${fileVO.orignlFileNm}"/></a>
				</li>
				</c:forEach>
				</ul>
			</td>
		</tr>
	</tbody>
</table>

<div class="text-center">
	<a href="?<c:out value='${searchScheduleInfoVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.list" /></a>
</div>