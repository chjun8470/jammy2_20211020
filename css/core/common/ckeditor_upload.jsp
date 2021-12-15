<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
//<![CDATA[
window.parent.CKEDITOR.tools.callFunction(<c:out value="${param.CKEditorFuncNum}"/>, '<c:url value="/${atchFile.fileStreCours}${atchFile.streFileNm}"/>','<c:out value="${msg}"/>');
window.parent.document.getElementById("<c:out value='${atchFieldNm}'/>").value = "<c:out value='${atchFileId}'/>";
//]]>
</script>