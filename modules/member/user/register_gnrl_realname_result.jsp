<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.member.service.MemberRealnameVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
MemberRealnameVO realnameVO = (MemberRealnameVO)session.getAttribute("realnameVO");
%>

<% if(realnameVO != null){ %>

<c:if test="${isAlreadyJoin}">
<div>이미 가입하셨습니다.</div>
<div><a href="<c:url value='${BASE_URL}/member/login.do'/>">로그인</a> | <a href="<c:url value='${BASE_URL}/member/find/idpw.do'/>">아이디/비밀번호 찾기</a></div>
</c:if>
<c:if test="${!isAlreadyJoin}">
<form action="<c:out value='${BASE_URL}'/>/member/register/gnrl.do" method="post">
	<input type="hidden" name="act" value="form" />
	<button type="submit">다음단계</button>
</form>
</c:if>
<% } else { %>
인증실패
<% } %>