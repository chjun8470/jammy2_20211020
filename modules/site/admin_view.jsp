<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
String requestUri = (String)request.getAttribute("javax.servlet.forward.request_uri");
String act = request.getParameter("act") == null ? "" : request.getParameter("act");
if ("/cms/admin/site/content/satisfaction.do".equals(requestUri) && "comment".equals(act))
{
	request.setAttribute("layout", "blank_layout.jsp");
}
%>		

<%@include file="/core/view/admin.jsp"%>