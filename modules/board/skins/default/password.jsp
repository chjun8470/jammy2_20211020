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
<c:if test="${returnAct == 'write'}">
	<c:if test="${returnMode == 'modify'}">
	<h4>글 수정</h4>
	<div>작성자만 글을 수정할 수 있습니다.<br />
	작성자 본인이라면, 글 작성시 입력한 비밀번호를 입력하여 글을 수정할 수 있습니다. </div>
	</c:if>
</c:if>
<c:if test="${returnAct == 'read'}">
<c:out value="${boardArticleVO.subject}" /><br />
<div>비밀글 기능으로 보호된 글입니다.<br />
작성자와 관리자만 열람하실 수 있습니다. 본인이라면 비밀번호를 입력하세요. </div>
</c:if>
<c:if test="${returnAct == 'delete'}">
<h4>글 삭제</h4>
<div>작성자만 글을 삭제할 수 있습니다.<br />
작성자 본인이라면, 글 작성시 입력한 비밀번호를 입력하여 글을 삭제할 수 있습니다.</div>
</c:if>
<form method="post" class="pass_form">
	<c:if test="${returnAct == 'delete'}">
	<input type="hidden" name="delete" value="ok" />
	</c:if>
	<strong>비밀번호</strong> <input type="password" class="pass_input" name="password" value="" />
	<button class="btn btn-danger btn-sm">확인</button>
	<a href="javascript:history.back(-1);" class="btn btn-default btn-sm">돌아가기</a>
</form>
</div>