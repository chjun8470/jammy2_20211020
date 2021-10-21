<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%-- 206-04-15 엘시스 임수현 만족도조사 히든처리
<c:if test="${writeSiteContentSatisfaction != null }">
<%--2016-04-12 엘시스 임수현 만족도 평가기능 pms로그인 연동 및 미로그인자 기능실행불가 적용 
	<c:if test="${pmsLoginVO.userIdx != '' && pmsLoginVO.userIdx != null}">
		<c:set var="queryString" value="${requestScope['javax.servlet.forward.query_string']}"/>
		<c:set var="requestUrl" value="${requestScope['javax.servlet.forward.request_uri']}"/>
		<c:if test="${not empty queryString}">
			<c:set var="requestUrl" value="${requestUrl}?${queryString}"/>
		</c:if>
		
		<form:form commandName="writeSiteContentSatisfaction" action="/cms/site/content/satisfaction.do">
			<input type="hidden" name="mode" value="satisfaction" />
			<input type="hidden" name="act" value="write" />
			<input type="hidden" name="returnUrl" value="<c:out value='${requestUrl}'/>" />		
			<form:hidden path="siteId" />
			<form:hidden path="device" />
			<form:hidden path="menuId" />
			<fieldset>
				<legend>만족도 평가</legend>
				<p>이 페이지에서 제공하는 정보와 사용편의성에 만족하십니까?</p>
				<form:radiobutton path="stsfdg" value="10" checked="checked" />매우만족
				<form:radiobutton path="stsfdg" value="8" />만족
				<form:radiobutton path="stsfdg" value="6" />보통
				<form:radiobutton path="stsfdg" value="4" />불만족
				<form:radiobutton path="stsfdg" value="2" />매우불만족
				
				<form:input path="stsfdgCn"/>
				
				<button type="submit">등록</button>
			</fieldset>
		</form:form>
	</c:if>
</c:if>
--%>