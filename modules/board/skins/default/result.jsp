<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
//<![CDATA[
<c:choose>
	<c:when test="${message == 'success.common.insert'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?act=list&<c:out value='${boardSearchQueryString}' escapeXml='false' />");
	</c:when>
	<c:when test="${message == 'success.common.update'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?act=list&<c:out value='${boardSearchQueryString}' escapeXml='false' />");
	</c:when>
	<c:when test="${message == 'success.common.delete'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?act=list&<c:out value='${boardSearchQueryString}' escapeXml='false' />");
	</c:when>
	<c:when test="${message == 'success.common.restore'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?act=read&articleId=<c:out value='${param.articleId}' />&<c:out value='${boardSearchQueryString}' escapeXml='false' />");
	</c:when>	
	<c:otherwise>
		alert("<c:out value='${messageStr}' />");
		history.back(-1);
	</c:otherwise>
</c:choose>
//]]>
</script>