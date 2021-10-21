<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>

<%
	String requestUri = (String)request.getAttribute("javax.servlet.forward.request_uri");
	if ("/cms/admin/survey.do".equals(requestUri) && "qlist".equals(EgovStringUtil.nullConvert(request.getParameter("act"))))
	{
		request.setAttribute("layout", "blank_layout.jsp");	
	}	
	if ("/cms/admin/survey.do".equals(requestUri) && "qwrite".equals(EgovStringUtil.nullConvert(request.getParameter("act"))))
	{
		request.setAttribute("layout", "blank_layout.jsp");	
	}
%>

<%@include file="/core/view/admin.jsp"%>