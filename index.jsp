<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.site.service.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	SiteManager siteManager = new SiteManager(request);

	String requestURL = request.getRequestURL().toString();
	
	String serverName = requestURL.substring(requestURL.indexOf("://") + 3);
	serverName = serverName.substring(0, serverName.indexOf("/"));

	SiteDomainVO siteDomainVO = siteManager.getSiteDomain(serverName);
	if (siteDomainVO == null)
	{
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>전남과학기술정보시스템</title>

<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7"  />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<script type="text/javaScript">
//<![CDATA[
document.location.href='<%=request.getContextPath() + "/jeinet/main.do"%>'
//]]>
</script>
<%
	}
	else
	{
		if ("Y".equals(siteDomainVO.getMobileYn()))
		{
			request.getSession().setAttribute("DEVICE", "MOBILE");
		}
%>
<script type="text/javaScript">
//<![CDATA[
document.location.href='<%=request.getContextPath() + "/" + siteDomainVO.getSiteId() + "/main.do"%>'
//]]>
</script>
<%
	}
%>

</head>
<body>
페이지 이동 중입니다.
</body>
</html>