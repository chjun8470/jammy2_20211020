<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.board.service.BoardVO" %>
<%
	BoardVO boardVO = (BoardVO)request.getAttribute("boardVO");
	String readFile = String.format("read_%s.jsp", boardVO.getBoardTy());
%>

<jsp:include page="<%=readFile%>" flush="true" />