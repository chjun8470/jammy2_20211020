<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="jammy-message">
	<p class="message-title"><c:out value="${messageStr}" /></p>
	<div class="navi">
		<a href="<c:out value='${INDEX_PAGE}'/>">홈으로</a>
		<a href="javascript:history.back(-1);">이전화면</a>
	</div>
</div>