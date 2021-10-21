<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="egovframework.jammy2.board.service.BoardVO" %>
<%
	BoardVO boardVO = (BoardVO)request.getAttribute("boardVO");
	String configFile = String.format("config_%s.jsp", boardVO.getBoardTy());
%>
<jsp:include page="<%=configFile%>" flush="true" />

<div class="pass_box">
<form:form commandName="deleteBoardArticle">
	<input type="hidden" name="delete" value="ok" />
	<fieldset>
		<legend></legend>
		<h4>정말로 삭제하시겠습니까?</h4>		
		<div class="pass_form">			
			<c:if test="${isBoardAdmin}">
			<input type="hidden" name="deleteDatabase" value="" />
			<strong>삭제사유</strong> : <input type="text" name="deleteMemo" class="pass_input" id="deleteMemo" value="" />
			</c:if>
					
			<button type="button" class="btn btn-default btn-sm" onclick="if(confirm('<spring:message code="common.delete.msg"/>')){this.form.submit();}"><spring:message code="common.delete"/></button>
			<c:if test="${isBoardAdmin}">
			<button type="button" class="btn btn-default btn-sm" onclick="if(confirm('<spring:message code="common.deleteDatabase.msg"/>')) {this.form.deleteDatabase.value='Y'; this.form.submit();}"><spring:message code="common.deleteDatabase"/></button>
			</c:if>
			<a href="?act=read&amp;articleId=<c:out value='${boardArticleVO.articleId}'/>&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.reset"/></a>
		</div>
	</fieldset>
</form:form>
</div>