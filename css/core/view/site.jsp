<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>

<%	
	boolean isMainPage = request.getAttribute("isMainPage") != null ? true : false;

	String contentFile = "";
	String layoutPath = request.getContextPath().concat("/themes/");
	String themeId = EgovStringUtil.nullConvert((String)request.getAttribute("themeId"));
	String layout = EgovStringUtil.nullConvert((String)request.getAttribute("layout"));

	if (!layout.equals(""))
	{
		layoutPath = layoutPath.concat(themeId);
		contentFile = String.format("/themes/%s/%s", themeId, layout);
		
		request.setAttribute("CORE_PATH", request.getContextPath().concat("/core"));
		request.setAttribute("LAYOUT_PATH", layoutPath);
		request.setAttribute("IS_MAIN_PAGE", isMainPage);
	}
	else
	{		
		request.setAttribute("CORE_PATH", request.getContextPath().concat("/core"));
		//contentFile = EgovStringUtil.nullConvert((String)request.getAttribute("contentFile"));
		contentFile = "/core/common/default_layout.jsp";
	}
	
	//pageContext.forward(page_name); 
%>


<jsp:include page="<%=contentFile%>" flush="false" />




