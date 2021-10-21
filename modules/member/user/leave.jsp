<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<ol>
	<li>회원탈퇴 시 회원님의 개인정보는 모두 삭제처리됩니다.</li>
	<li>해당 아이디로 재가입은 불가능합니다.</li>
	<li>공공의 게시판에 남긴 글/댓글은 탈퇴 후에도 삭제되지 않습니다. 삭제를 원하시는 경우에는 삭제를 하시고 탈퇴를 신청하시기 바랍니다.</li>
</ol>
								


<form:form commandName="leaveMember" action="?act=leave" class="form-horizontal" role="form">
	<fieldset>
		<legend>회원 탈퇴</legend>
		<div class="form-group">
			<span class="col-sm-2 text-right"><label for="id" class="control-label">아이디</label></span>
			<div class="col-sm-10">
				<form:input path="id" class="form-control" disabled="true" />
			</div>
		</div>
		<div class="form-group">
			<span class="col-sm-2 text-right"><label for="id" class="control-label">* 비밀번호</label></span>
			<div class="col-sm-10">
				<form:password path="password" class="form-control" />
			</div>
		</div>
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-10">
				<button type="button" class="btn btn-primary" onclick="if(confirm('정말로 탈퇴하시겠습니까?')){this.form.submit();}">탈퇴</button>
				<a href="<c:out value='${INDEX_PAGE}'/>" class="btn btn-default"><i class="fa fa-list"></i> <spring:message code="button.reset" /></a>
			</div>
		</div>
	</fieldset>
</form:form>