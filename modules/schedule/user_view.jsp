<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%
	String themeId = EgovStringUtil.nullConvert((String)request.getAttribute("themeId"));

	ArrayList cssList = new ArrayList();
	cssList.add("/themes/"+themeId+"/css/schedule.css");

	request.setAttribute("cssList", cssList);
%>

<jsp:include page="/core/view/site.jsp" flush="false" />