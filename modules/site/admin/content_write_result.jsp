<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
//<![CDATA[
<c:choose>
	<c:when test="${message == 'success.common.insert'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?siteId=<c:out value='${searchSiteMenuVO.siteId}' />&device=<c:out value='${searchSiteMenuVO.device}' />&menuId=<c:out value='${searchSiteMenuVO.menuId}' />");
	</c:when>
	<c:when test="${message == 'success.common.update'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?siteId=<c:out value='${searchSiteMenuVO.siteId}' />&device=<c:out value='${searchSiteMenuVO.device}' />&menuId=<c:out value='${searchSiteMenuVO.menuId}' />");
	</c:when>
	<c:when test="${message == 'success.common.restore'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?siteId=<c:out value='${searchSiteMenuVO.siteId}' />&device=<c:out value='${searchSiteMenuVO.device}' />&menuId=<c:out value='${searchSiteMenuVO.menuId}' />");
	</c:when>
	<c:otherwise>
		alert("<c:out value='${messageStr}' />");
		history.back(-1);	
	</c:otherwise>
</c:choose>
//]]>
</script>