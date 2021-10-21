<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
//<![CDATA[
<c:if test="${message == 'info.nodata.msg'}">
alert("<c:out value='${messageStr}' />");
history.back(-1);
</c:if>
<c:if test="${message == 'success.common.insert'}">
alert("<c:out value='${messageStr}' />");
document.location.replace("?parntsMenuId=<c:out value='${searchAdminMenuVO.parntsMenuId}' />");
</c:if>
<c:if test="${message == 'success.common.update'}">
alert("<c:out value='${messageStr}' />");
document.location.replace("?menuId=<c:out value='${searchAdminMenuVO.menuId}' />");
</c:if>
<c:if test="${message == 'success.common.delete'}">
alert("<c:out value='${messageStr}' />");
document.location.replace("?");
</c:if>
//]]>
</script>