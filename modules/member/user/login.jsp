<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script type="text/javascript" src="<c:url value="/cms/validator.do"/>"></script>
<script type="text/javascript"> 
//<![CDATA[
$(function()
{	
	$("#loginForm").validate();
});
//]]>
</script>

<div class="member-login">
	<div class="member-login-title">
		회원님의 아이디와 비밀번호를 입력해 주세요.
	</div>
	<form:form name="loginForm" id="loginForm" commandName="loginVO" class="form-horizontal member-login-form">
		<div class="form-group-container">
			<div class="form-group">
				<label for="id" class="sr-only">아이디</label>
				<form:input path="id" class="form-control required" value="" />
			</div>
			<div class="form-group">
				<label for="password" class="sr-only">비밀번호</label>
				<form:password path="password" class="form-control required" value="" />
			</div>
			<button class="login-submit" type="submit">Login</button>
		</div>
	</form:form>
	<div class="member-login-guide">		
	<dl class="clearfix">
		<dt>홈페이지 회원의 다양한 혜택을 받아보세요.</dt>
		<dd><a href="<c:out value='${BASE_URL}/member/register/gnrl.do'/>">회원가입하기</a></dd>
		<dt>아이디/비밀번호를 분실하셨나요?</dt>
		<dd><a href="<c:out value='${BASE_URL}/member/find/idpw.do'/>">아이디/비밀번호 찾기</a></dd>
	</dl>
	</div>	
</div>