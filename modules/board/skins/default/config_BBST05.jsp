<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.cmm.service.UrlQueryString" %>
<%@ page import="egovframework.jammy2.board.service.BoardVO" %>
<%
	BoardVO boardVO = (BoardVO)request.getAttribute("boardVO");

	LinkedHashMap<String, Object> queryItems = new LinkedHashMap<String, Object>();
	if ("Y".equals(boardVO.getUseCategoryAt()))
	{
		queryItems.put("categoryNm", EgovStringUtil.nullConvert(request.getParameter("categoryNm")));
	}		
	queryItems.put("searchCondition", EgovStringUtil.nullConvert(request.getParameter("searchCondition")));
	queryItems.put("searchKeyword", EgovStringUtil.nullConvert(request.getParameter("searchKeyword")));
	queryItems.put("pageIndex", EgovStringUtil.nullConvert(request.getParameter("pageIndex"), "1"));
	queryItems.put("m", EgovStringUtil.nullConvert(request.getParameter("m")));
		
	String boardSearchQueryString = UrlQueryString.buildQueryString(queryItems);
	
	request.setAttribute("boardSearchQueryString", boardSearchQueryString);
%>