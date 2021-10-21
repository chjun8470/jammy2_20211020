<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.site.service.*" %>
<%
	SiteInfoVO siteInfoVO = (SiteInfoVO)request.getAttribute("SITE_INFO");
	String redirectUrl = "";
	if (siteInfoVO == null)
	{
		redirectUrl = "/cms/member/myinfo.do";
	}
	else
	{
		redirectUrl = "/"+siteInfoVO.getSiteId()+"/member/myinfo.do";
	}	
%>

<jsp:forward page='<%=redirectUrl%>' />