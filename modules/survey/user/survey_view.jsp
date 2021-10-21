<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt_rt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<table class="table table-bordered">
<tbody>
	<tr>
		<th scope="row">제목</th>
		<td><c:out value='${surveyVO.title}'/></td>
	</tr>
	<tr>
		<th scope="row">설문기간</th>
		<td><c:out value='${surveyVO.bgnde}'/> ~ <c:out value='${surveyVO.endde}'/></td>
	</tr>
	<tr>
		<th scope="row">참여인원</th>
		<td><c:out value='${surveyVO.voteCnt}'/>명</td>
	</tr>
	<tr>
		<th scope="row">내용</th>
		<td><c:out value='${jmy:nl2br(surveyVO.content)}' escapeXml='false'/></td>
	</tr>	
	<tr>
		<th scope="row">진행상태</th>
		<td>
			<c:choose>
				<c:when test="${surveyVO.progress == 'ING'}">진행</c:when>
				<c:when test="${surveyVO.progress == 'PRE'}">중비중</c:when>
				<c:otherwise>종료</c:otherwise>
			</c:choose>		
		</td>
	</tr>	
</tbody>
</table>

<c:if test="${surveyVO.resultOpenYn == 'Y'}">
	<c:forEach items="${surveyQuestionList}" var="question" varStatus="i">
		<div class="item">	
			<h5><c:out value='${question.qstnTitle}' /></h5>
			<c:if test="${question.qstnTy == 'B' || question.qstnTy == 'E'}">
				<c:out value='${question.minChkedNum}'/>개 이상 선택해 주세요.
			</c:if>
			<div class="exampleListResult">
				<c:if test="${question.qstnTy != 'C'}">
					<ul>
						<c:forEach items="${question.exampleList}" var="example" varStatus="k">
						<c:set var="percent" value="${(example.answerCnt / question.totalAnswerCnt) * 100}" />
						<li>
							<span class="title"><c:out value='${example.exTitle}' /></span>
							<div class="bar">
								<div class="percent">
									<c:if test="${example.answerCnt > 0}">
									<div class="line"  style="width:${percent}%;"><c:out value='${example.answerCnt}' />명, <fmt_rt:formatNumber value="${percent}" maxFractionDigits="1" />%</div>
									</c:if>
								</div>
							</div>						
						</li>
						</c:forEach>
					</ul>			
				</c:if>
			</div>
		</div>
	</c:forEach>
</c:if>	


<a href="?<c:out value='${searchSurveyVO.queryString}' />" class="btn btn-default"><spring:message code="common.list" /></a>

<c:if test="${surveyVO.progress == 'ING'}">
	<a href="?act=participate&srvyId=<c:out value='${surveyVO.srvyId}' />&<c:out value='${searchSurveyVO.queryString}' />" class="btn btn-default">설문조사 참여하기</a>
</c:if>