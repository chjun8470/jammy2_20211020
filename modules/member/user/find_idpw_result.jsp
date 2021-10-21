<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<c:if test="${resultType == 'id'}">
	<c:choose>
		<c:when test="${not empty resultVO}">
		회원님의 아이디는 <c:out value="${resultVO.id}"/>입니다.
		</c:when>
		<c:otherwise>
		입력하신 정보와 일치하는 회원정보가 존재하지 않습니다.
		</c:otherwise>
	</c:choose>
</c:if>

<c:if test="${resultType == 'pw'}">
	<c:choose>
		<c:when test="${result > 0}">
		회원님의 임시비밀번호를 메일로 발송하였습니다.
		</c:when>
		<c:when test="${result == -1}">
		입력하신 정보와 일치하는 회원정보가 존재하지 않습니다.
		</c:when>
		<c:otherwise>
		이메일발송실패
		</c:otherwise>
	</c:choose>
</c:if>