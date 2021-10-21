<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<c:set var="queryString" value="${requestScope['javax.servlet.forward.query_string']}"/>
<c:set var="returnUrl" value="${requestScope['javax.servlet.forward.request_uri']}"/>
<c:if test="${not empty queryString}">
	<c:set var="returnUrl" value="${returnUrl}?${queryString}"/>
</c:if>

<div class="jammy-message-login">
	<h1>회원전용서비스</h1>
	<div class="message">해당서비스는 <strong>회원만 이용가능</strong>합니다. <span class="newline">회원이시라면 로그인 후 이용해 주십시요.</span></div>
	<div class="navi">
		<a href="${BASE_URL}/member/login.do?returnUrl=${jmy:urlEncoder(returnUrl)}" class="btn btn-danger pd-l-lg pd-r-lg">로그인</a>
		<a href="javascript:history.back(-1);" class="btn btn-default pd-l-lg pd-r-lg">이전화면</a>
	</div>
</div>