<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
alert("<c:out value='${messageStr}' />");
<c:choose>
	<c:when test="${open == 'true'}">self.close();</c:when>
	<c:otherwise>history.back(-1);</c:otherwise>
</c:choose>
</script>