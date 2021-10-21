<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	response.setHeader("Cache-Control","no-cache");     
	response.setHeader("Pragma","no-cache");
	
	String siteId = (String)session.getAttribute("siteId") == null ? "cms" : (String)session.getAttribute("siteId");
	String param = "";
	String enc_retInfo    = request.getParameter("retInfo").trim();
	param= "&retInfo="+enc_retInfo;
%>
<html>
<head>
<script type="text/javascript">
//<![CDATA[
	function end() {
		window.opener.location.href = '/<%=siteId%>/member/register/gnrl.do?act=realnameResult<%=param%>&flag=ipin';
		self.close();
	}
//]]>
</script>
</head>
<body onload="javascript:end()">
</body>
</html>