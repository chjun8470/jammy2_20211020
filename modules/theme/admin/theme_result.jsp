<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
//<![CDATA[
<c:if test="${empty param.page}">
<c:choose>
	<c:when test="${message == 'success.common.insert'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&fileGb=<c:out value='${searchThemeFileVO.fileGb}'/>&fileNm=<c:out value='${searchThemeFileVO.fileNm}'/>");
	</c:when>
	<c:when test="${message == 'success.common.update'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&fileGb=<c:out value='${searchThemeFileVO.fileGb}'/>&fileNm=<c:out value='${searchThemeFileVO.fileNm}'/>");
	</c:when>
	<c:when test="${message == 'success.common.restore'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&fileGb=<c:out value='${searchThemeFileVO.fileGb}'/>&fileNm=<c:out value='${searchThemeFileVO.fileNm}'/>");
	</c:when>
	<c:when test="${message == 'success.common.delete'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&fileGb=<c:out value='${searchThemeFileVO.fileGb}'/>");
	</c:when>
	<c:otherwise>
		alert("<c:out value='${messageStr}' />");
		history.back(-1);
	</c:otherwise>
</c:choose>
</c:if>
<c:if test="${not empty param.page}">
<c:choose>
	<c:when test="${message == 'success.common.insert'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&fileGb=<c:out value='${searchThemeFileVO.fileGb}'/>&fileNm=<c:out value='${searchThemeFileVO.fileNm}'/>");
	</c:when>
	<c:when test="${message == 'success.common.update'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&page=info");
	</c:when>
	<c:when test="${message == 'success.common.delete'}">
		alert("<c:out value='${messageStr}' />");
		document.location.replace("<c:url value='/cms/admin/theme.do'/>");
	</c:when>
	<c:otherwise>
		alert("<c:out value='${messageStr}' />");
		history.back(-1);
	</c:otherwise>
</c:choose>
</c:if>
//]]>
</script>