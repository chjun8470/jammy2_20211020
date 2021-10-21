<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%

	String layoutPath = request.getContextPath().concat("/themes/");

	String layout = EgovStringUtil.nullConvert((String)request.getAttribute("layout"));
	if (!layout.equals(""))
	{
		layout = String.format("admin/%s", layout);
		String[] tmp = layout.split("/");
		layoutPath = layoutPath.concat(tmp[0]);
		String layoutFile = "/themes/".concat(layout);

		request.setAttribute("CORE_PATH", request.getContextPath().concat("/core"));
		request.setAttribute("LAYOUT_PATH", layoutPath);

%>
	<jsp:include page="<%=layoutFile%>" flush="true" />
<%
	}
	else
	{
%>
	<c:import url="${contentFile}" />
<%
	}
%>