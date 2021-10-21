<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
//<![CDATA[
<c:choose>
	<c:when test="${message == 'success.request.msg'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?dir=<c:out value='${param.dir}'/><c:out value='${defaultQueryString}' escapeXml='false' />");
	</c:when>
	<c:when test="${message == 'success.common.update'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?dir=<c:out value='${param.dir}'/>&fileNm=<c:out value='${param.fileNm}'/><c:out value='${defaultQueryString}' escapeXml='false' />");	
	</c:when>
	<c:when test="${message == 'success.common.delete'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?dir=<c:out value='${param.dir}'/><c:out value='${defaultQueryString}' escapeXml='false' />");	
	</c:when>
	<c:otherwise>
		alert("<c:out value='${messageStr}' />");
		history.back(-1);
	</c:otherwise>
</c:choose>
//]]>
</script>