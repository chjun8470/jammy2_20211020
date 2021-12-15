<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%	
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
		request.setAttribute("contentFile", "/core/common/message_login.jsp");
	}
	else
	{		
		contentFile = "/core/common/message_login.jsp";
	}	
%>

<jsp:include page="<%=contentFile%>" flush="false" />