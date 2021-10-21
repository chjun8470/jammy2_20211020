<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="egovframework.jammy2.board.service.BoardVO" %>
<%
	BoardVO boardVO = (BoardVO)request.getAttribute("boardVO");
	String configFile = String.format("config_%s.jsp", boardVO.getBoardTy());
%>
<jsp:include page="<%=configFile%>" flush="true" />

<div class="pass_box">
<c:choose>
	<c:when test="${boardArticleVO.writerId == boardArticleVO.delusrId}">
	<br /><br />
	<h4>해당 게시글은 삭제되었습니다.</h4><br /><br />
	</c:when>
	<c:otherwise>
	<h4>해당 게시글은 <c:out value="${boardArticleVO.delusrId}"/>님에 의해 삭제되었습니다.</h4>
	<dl>
		<dt><strong>삭제일시</strong></dt>
		<dd><c:out value="${boardArticleVO.deletePnttm}"/></dd>
		<c:if test="${not empty boardArticleVO.deleteMemo}">
		<dt class="mgt10"><strong>삭제사유</strong></dt>
		<dd><c:out value="${boardArticleVO.deleteMemo}"/></dd>
		</c:if>
	</dl>
	</c:otherwise>
</c:choose>

<a href="?act=list&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.list"/></a>
</div>