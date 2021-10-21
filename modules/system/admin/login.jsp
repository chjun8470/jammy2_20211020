<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!doctype html>
<html class="no-js" lang="ko">
<head>
	<title>로그인</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />

	<link href="/themes/admin/css/styles.css" rel="stylesheet" type="text/css" id="theme"/>
	<!--[if lt IE 10]><link rel="stylesheet" type="text/css" href="/themes/admin/css/ie.css"/><![endif]-->

	<script type="text/javascript" src="/themes/admin/js/plugins/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="/themes/admin/js/plugins/jquery/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/themes/admin/js/plugins/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript" src="/themes/admin/js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>

	<script type="text/javascript" src="/themes/admin/js/plugins/jquery-validation/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/themes/admin/js/plugins/jquery-validation/localization/messages_ko.min.js"></script>

	<script type="text/javascript" src="/themes/admin/js/actions.js"></script>
</head>
<body>
<div class="page-container">
	<div class="page-content page-content-default">
		<div class="block-login">
			<div class="block-login-logo">
				<a class="logo">Be Pro</a>
			</div>
			<div class="block-login-content">
				<h1>Login</h1>
				<form:form name="loginForm" id="loginForm" commandName="loginVO" role="form">
					<div class="form-group">
						<form:input path="id" class="form-control required" placeholder="ID" value="admin" />
					</div>
					<div class="form-group">
						<form:password path="password" class="form-control required" placeholder="Password" value="q1w2e3r4" />
					</div>
					<button class="btn btn-primary btn-block" type="submit">Login</button>
				</form:form>
				<div class="sp"></div>
				<div class="pull-left">© All Rights Reserved Caon System 2015</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
//<![CDATA[
$(function()
{
	$("#loginForm").validate();
});
//]]>
</script>
</body>
</html>