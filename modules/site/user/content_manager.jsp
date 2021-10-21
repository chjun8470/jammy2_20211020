<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:if test="${siteContentManagerVO != null}">

	<dl class="con_ma">
		<dt class="buseo">담당부서 : </dt>
		<dd><c:out value="${siteContentManagerVO.orgnztNm}" /></dd>
		<dt class="mana">담당자 : </dt>
		<dd><c:out value="${siteContentManagerVO.staffNm}" /></dd>		
		<dt>연락처 : </dt>
		<dd><c:out value="${siteContentManagerVO.telNo}" /></dd>
		<dt class="date">최근업데이트 : </dt>
		<dd class="date"><c:out value="${fn:substring(siteContentManagerVO.updtDate,0,16)}" /></dd>
	</dl>

</c:if>