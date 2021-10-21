<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<form:form commandName="findMemberIdpw" id="findMemberId" class="form-horizontal" role="form">
	<input type="hidden" name="type" value="id" />
	<fieldset>
		<legend class="title-type1" style="border:none;">아이디 찾기</legend>
		<div class="bordered pd mg-t-sm">
			<div class="form-group">
				<span class="col-sm-2 text-right"><label for="name" class="control-label">* 이름</label></span>
				<div class="col-sm-10">
					<form:input path="name" class="form-control required" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2 text-right"><label for="email" class="control-label">* 이메일</label></span>
				<div class="col-sm-10">
					<form:input path="email" class="form-control email required" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-danger pd-l-lg pd-r-lg"><spring:message code="common.confirm" /></button>				
				</div>
			</div>
		</div>
	</fieldset>
</form:form>

<form:form commandName="findMemberIdpw" id="findMemberPw" class="form-horizontal mg-t-lg" role="form">
	<input type="hidden" name="type" value="pw" />
	<fieldset>
		<legend class="title-type1" style="border:none;">비밀번호 찾기</legend>
		<div class="bordered pd mg-t-sm">
			<div class="form-group">
				<span class="col-sm-2 text-right"><label for="name" class="control-label">* 아이디</label></span>
				<div class="col-sm-10">
					<form:input path="id" class="form-control required" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2 text-right"><label for="name" class="control-label">* 이름</label></span>
				<div class="col-sm-10">
					<form:input path="name" class="form-control required" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2 text-right"><label for="email" class="control-label">* 이메일</label></span>
				<div class="col-sm-10">
					<form:input path="email" class="form-control email required" />
				</div>
			</div>
			<div class="form-group">
				<div class="col-sm-offset-2 col-sm-10">
					<button type="submit" class="btn btn-danger pd-l-lg pd-r-lg"><spring:message code="common.confirm" /></button>				
				</div>
			</div>
		</div>
	</fieldset>
</form:form>

<script type="text/javascript" src="<c:url value="/cms/validator.do"/>"></script>
<script type="text/javascript"> 
//<![CDATA[
$(function()
{	
	$("#findMemberId").validate();
	$("#findMemberPw").validate();
});
//]]>
</script>