<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript">
//<![CDATA[
<c:choose>
	<c:when test="${message == 'success.common.insert'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?<c:out value='${param.returnQueryString}' escapeXml='false' />");
	</c:when>
	<c:when test="${message == 'success.common.update'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?<c:out value='${param.returnQueryString}' escapeXml='false' />");
	</c:when>
	<c:when test="${message == 'success.common.delete'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?<c:out value='${param.returnQueryString}' escapeXml='false' />");
	</c:when>
	<c:otherwise>
		alert("<c:out value='${messageStr}' />");
		history.back(-1);
	</c:otherwise>
</c:choose>
//]]>
</script>