<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<c:choose>
	<c:when test="${memberConfigVO.joinConfirm == 'ADMIN_CONFIRM'}">
	관리자확인 후 가입승인시 회원가입이 완료됩니다.
	<a href="<c:out value='${INDEX_PAGE}'/>" class="btn btn-default btn-sm">홈으로</a>
	</c:when>
	<c:otherwise>
	회원가입이 완료되었습니다. 
	<a href="<c:out value='${BASE_URL}/member/login.do'/>" class="btn btn-default btn-sm">로그인</a>
	<a href="<c:out value='${INDEX_PAGE}'/>" class="btn btn-default btn-sm">홈으로</a>
	</c:otherwise>
</c:choose>