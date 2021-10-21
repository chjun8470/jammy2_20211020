<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="egovframework.jammy2.board.service.BoardVO" %>
<%
	BoardVO boardVO = (BoardVO)request.getAttribute("boardVO");
	String configFile = String.format("config_%s.jsp", boardVO.getBoardTy());
%>
<jsp:include page="<%=configFile%>" flush="true" />

<div class="board">
	<div class="read-head">
		<p class="subject"><strong><c:out value="${boardArticleVO.subject}"/></strong></p>
		<dl class="info">
			<dt><spring:message code="common.writer"/></dt>
			<dd>
				<c:choose>
					<c:when test="${!isBoardAdmin && boardVO.boardTy == 'BBST02'}">익명</c:when>
					<c:otherwise><c:out value="${boardArticleVO.writerNm}"/></c:otherwise>
				</c:choose>				
			</dd>
			<dt><spring:message code="common.writeDate"/></dt>
			<dd><c:out value="${fn:substring(boardArticleVO.frstRegistPnttm,0,16)}" /></dd>
			<dt><spring:message code="common.hit"/></dt>
			<dd><c:out value="${boardArticleVO.hits}"/></dd>			
		</dl>
		<c:if test="${not empty boardArticleVO.atchFileList}">
		<dl class="file">
			<dt><spring:message code="common.atchFile"/></dt>
			<c:forEach var="result" items="${boardArticleVO.atchFileList}" varStatus="status">
			<dd><a href="<c:url value='${jmy:downloadUrl(result.value.atchFileId, result.value.fileSn)}'/>"><c:out value="${result.value.orignlFileNm}"/></a></dd>
			</c:forEach>
		</dl>
		</c:if>
	</div>
	<div class="read-content">
		<c:out value="${boardArticleVO.content}" escapeXml="false"/>
	</div>
	<div class="read-footer">
		<div class="pull-left">
			<a href="?act=list&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.list"/></a>
			<c:if test="${not empty prevBoardArticleVO}">
			<a href="?act=read&amp;articleId=<c:out value='${prevBoardArticleVO.articleId}'/>&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.prevArticle"/></a> 
			</c:if>
			<c:if test="${not empty nextBoardArticleVO}">
			<a href="?act=read&amp;articleId=<c:out value='${nextBoardArticleVO.articleId}'/>&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.nextArticle"/></a>
			</c:if>			
		</div>
		<div class="pull-right">
			<c:if test="${isBoardAdmin && boardArticleVO.deletedAt == 'Y'}">
			<button type="button" onclick="post_url('', 'act=restore&amp;articleId=<c:out value='${boardArticleVO.articleId}'/>&amp;<c:out value='${boardSearchQueryString}'/>', '<spring:message code="common.restore.msg"/>')" class="btn btn-default btn-sm"><spring:message code="common.restore"/></button>
			</c:if>
			<c:if test="${modifyAuthor}">
			<a href="?act=write&amp;mode=modify&amp;articleId=<c:out value='${boardArticleVO.articleId}'/>&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.update"/></a>
			</c:if>
			<c:if test="${deleteAuthor}">
			<a href="?act=delete&amp;articleId=<c:out value='${boardArticleVO.articleId}'/>&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.delete"/></a>
			</c:if>
			<c:if test="${replyAuthor}">
			<a href="?act=write&amp;mode=reply&amp;articleId=<c:out value='${boardArticleVO.articleId}'/>&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.reply"/></a>
			</c:if>
			<c:if test="${writeAuthor}">
			<a href="?act=write&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.write"/></a>
			</c:if>
		</div>
	</div>
</div>