<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:url var="url" value="/cms/ckeditor/upload.do">
	<c:if test="${param.atchFieldNm != null}">
	<c:param name="atchFieldNm" value="${param.atchFieldNm}"/>
	</c:if>
	<c:if test="${param.atchFileId != null}">
	<c:param name="atchFileId" value="${param.atchFileId}"/>
	</c:if>
</c:url>

<input type="hidden" name="<c:out value='${param.atchFieldNm}'/>" id="<c:out value='${param.atchFieldNm}'/>" value="<c:out value='${param.atchFileId}'/>" />
<script type="text/javascript">
//<![CDATA[
$(function()
{
	$("#<c:out value='${param.id}'/>").ckeditor(
	{
		filebrowserImageUploadUrl: '<c:out value="${url}" escapeXml="false"/>'
	});
});
//]]>
</script>