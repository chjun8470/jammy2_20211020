<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
//<![CDATA[
<c:if test="${message == 'success.common.update'}">
alert("<c:out value='${messageStr}' />");
document.location.replace("gnr.do");
</c:if>
//]]>
</script>