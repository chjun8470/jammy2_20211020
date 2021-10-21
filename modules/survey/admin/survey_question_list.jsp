<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div>
<c:out value="${surveyVO.title}"/>
</div>

<c:forEach var="result" items="${surveyQuestionList}" varStatus="status">
	<h2><c:out value="${result.qstnTitle}"/></h2>
	<c:if test="${result.qstnTy == 'B' || result.qstnTy == 'E'}">
		<div><c:out value='${result.minChkedNum}'/>개 이상 선택해 주세요.</div>
	</c:if>
	<a href="?act=qwrite&amp;srvyId=<c:out value='${result.srvyId}'/>&amp;srvyQstnId=<c:out value='${result.srvyQstnId}'/>">[수정]</a>
	<a href="#none" onclick="post_delete('', 'act=qdelete&amp;srvyId=<c:out value='${result.srvyId}'/>&amp;srvyQstnId=<c:out value='${result.srvyQstnId}'/>'); return false;">[삭제]</a>

	<div>
		<c:if test="${result.qstnTy == 'C'}">
			<textarea name="remarks[<c:out value='${result.srvyQstnId}' />]"></textarea>
		</c:if>
		<c:if test="${result.qstnTy != 'C'}">
			<ul>
				<c:forEach items="${result.exampleList}" var="example" varStatus="k">
				<li>
					<c:if test="${result.qstnTy == 'A' || result.qstnTy == 'D'}"><input type="radio" name="questions[<c:out value='${result.srvyQstnId}' />]" value="<c:out value='${example.srvyExId}' />" /></c:if>
					<c:if test="${result.qstnTy == 'B' || result.qstnTy == 'E'}"><input type="checkbox" name="questions[<c:out value='${result.srvyQstnId}' />]" value="<c:out value='${example.srvyExId}' />" /></c:if>
					<c:out value='${example.exTitle}' />
									
					<c:if test="${result.qstnTy == 'D' || result.qstnTy == 'E'}">
						<c:if test="${(k.index + 1) == fn:length(result.exampleList)}">
						<textarea name="remarks[<c:out value='${result.srvyQstnId}' />]"></textarea>
						</c:if>
					</c:if>					
				</li>
				</c:forEach>
			</ul>			
		</c:if>
	</div>
	
</c:forEach>

<a href="?act=qwrite&amp;srvyId=<c:out value='${surveyVO.srvyId}'/>" class="btn btn-primary btn-sm"><i class="fa fa-pencil"></i> <spring:message code="common.create"/></a>