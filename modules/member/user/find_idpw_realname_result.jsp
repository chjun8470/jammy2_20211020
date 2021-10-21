<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

	<c:choose>
		<c:when test="${not empty resultVO}">
		아이디 : <c:out value="${resultVO.mberId}"/>
		임시비밀번호 : <c:out value="${resultVO.password}"/>
		</c:when>
		<c:otherwise>
		입력하신 정보와 일치하는 회원정보가 존재하지 않습니다.
		</c:otherwise>
	</c:choose>