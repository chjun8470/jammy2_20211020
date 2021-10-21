<%@ page language="java" contentType="javascript" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
document.write('<link rel="stylesheet" type="text/css" href="<c:url value='/themes/admin/js/plugins/jquery-datatables/jquery.dataTables.css'/>">');
document.write('<script type="text/javascript" src="<c:url value='/themes/admin/js/plugins/jquery-datatables/jquery.dataTables.min.js'/>"></script>');
$(function() { $('#<c:out value="${param.tblId}"/>').dataTable(); });

function sourcePreview(sourceId)
{
	window.open('<c:out value="/cms/admin/system/source/restore.do"/>?sourceId='+sourceId,'sourcePreview','width=1000, height=700');
}

function sourceRestore(sourceId)
{
	document.<c:out value="${param.formNm}"/>.sourceId.value = sourceId;
	document.<c:out value="${param.formNm}"/>.submit();
}