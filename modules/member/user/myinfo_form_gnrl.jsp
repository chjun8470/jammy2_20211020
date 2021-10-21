<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.member.service.GnrlMember" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<script type="text/javascript" src="<c:url value="/cms/validator.do"/>"></script>
<script type="text/javascript">
//<![CDATA[
$(function()
{	
	$("#writeGnrlMember").validate();
	$("#btnPasswordChange").on('click', function() 
	{
		$("#layerPasswordChange").toggle(100, function() 
		{
			if ($(this).css("display") == "none")
			{
				$('#password').removeClass("required");
				$('#newPassword').removeClass("required");
				$('#newPasswordCnfirm').removeClass("required");
			}
			else
			{
				$('#password').addClass("required");
				$('#newPassword').addClass("required");
				$('#newPasswordCnfirm').addClass("required");
			}
		});
	});
});
//]]>
</script>

<form:form commandName="writeGnrlMember" class="form-horizontal" role="form">
	<input type="hidden" name="act" value="form" />
	<input type="hidden" name="type" value="gnrl" />
	<input type="hidden" name="form" value="ok" />
	<fieldset>
		<legend class="title-type1" style="border:none;">로그인 정보</legend>
		<div class="bordered pd mg-t-sm">
			<div class="form-group">
				<span class="col-sm-2"><label for="mberId" class="control-label">* 아이디</label></span>
				<div class="col-sm-10">
					<p class="form-control-static"><c:out value="${writeGnrlMember.mberId}"/> (아이디는 변경이 불가합니다.)</p> 
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2"><label for="password" class="control-label">비밀번호</label></span>
				<div class="col-sm-10">
					<button type="button" id="btnPasswordChange" class="btn btn-default">비밀번호변경</button>
				</div>
			</div>
			<div id="layerPasswordChange" style="display:none;">
				<div class="form-group">
					<span class="col-sm-2"><label for="password" class="control-label">* 현재 비밀번호</label></span>
					<div class="col-sm-10">
						<form:password path="password" class="form-control" />
					</div>
				</div>
				<div class="form-group">
					<span class="col-sm-2"><label for="newPassword" class="control-label">* 새 비밀번호</label></span>
					<div class="col-sm-10">
						<form:password path="newPassword" class="form-control" />
					</div>
				</div>			
				<div class="form-group">
					<span class="col-sm-2"><label for="newPasswordCnfirm" class="control-label">* 비밀번호 확인</label></span>
					<div class="col-sm-10">
						<input type="password" name="newPasswordCnfirm" id="newPasswordCnfirm" class="form-control" value="" />
					</div>
				</div>
			</div>
		</div>
	</fieldset>
	<fieldset class="mg-t-md">
		<legend class="title-type1" style="border:none;">회원 정보</legend>
		<div class="bordered pd mg-t-sm">
			<div class="form-group">
				<span class="col-sm-2"><label for="mberNm" class="control-label">* 이름</label></span>
				<div class="col-sm-10">
					<p class="form-control-static"><c:out value="${writeGnrlMember.mberNm}"/></p>
				</div>
			</div>
			<c:if test="${empty writeGnrlMember.dupinfo}">
			<div class="form-group">
				<span class="col-sm-2"><label for="brthdy" class="control-label">생년월일</label></span>
				<div class="col-sm-10">
					<form:input path="brthdy" class="form-control" />	
				</div>
			</div>						
			<div class="form-group">
				<span class="col-sm-2"><label for="sexdstnCode" class="control-label">성별</label></span>
				<div class="col-sm-10">
					<form:select path="sexdstnCode" class="form-control">
					<form:option value="">+ 성별선택</form:option>
					<c:forEach var="result" items="${sexdstnCodeList}" varStatus="status">
					<form:option value="${result.code}"><c:out value="${result.codeNm}" /></form:option>
					</c:forEach>
					</form:select>										
				</div>
			</div>
			</c:if>
			<c:if test="${not empty writeGnrlMember.dupinfo}">
			<div class="form-group">
				<span class="col-sm-2"><label for="brthdy" class="control-label">생년월일</label></span>
				<div class="col-sm-10">
					<c:out value="${writeGnrlMember.brthdy}"/>	
				</div>
			</div>						
			<div class="form-group">
				<span class="col-sm-2"><label for="sexdstnCode" class="control-label">성별</label></span>
				<div class="col-sm-10">
					<c:choose><c:when test="${writeGnrlMember.sexdstnCode == 'M'}">남</c:when><c:otherwise>여</c:otherwise></c:choose>  										
				</div>
			</div>			
			</c:if>
			<div class="form-group">
				<span class="col-sm-2"><label for="telNo" class="control-label">전화번호</label></span>
				<div class="col-sm-10">
					<form:input path="telNo" class="form-control" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2"><label for="hpNo" class="control-label">핸드폰번호</label></span>
				<div class="col-sm-10">
					<form:input path="hpNo" class="form-control" />
				</div>
			</div>						
			<div class="form-group">
				<span class="col-sm-2"><label for="email" class="control-label">* 이메일</label></span>
				<div class="col-sm-10">
					<form:input path="email" class="form-control required" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2  text-right"><label for="zip" class="control-label">우편번호</label></span>
				<div class="col-sm-10">
					<form:input path="zip" class="form-control" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2  text-right"><label for="adres" class="control-label">주소</label></span>
				<div class="col-sm-10">
					<form:input path="adres" class="form-control" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2  text-right"><label for="detailAdres" class="control-label">상세주소</label></span>
				<div class="col-sm-10">
					<form:input path="detailAdres" class="form-control" />
				</div>
			</div>
		</div>										
	</fieldset>
	<div class="text-center mg-t-lg">
		<button type="submit" class="btn btn-danger pd-l-lg pd-r-lg"><spring:message code="button.save" /></button>
		<a href="${INDEX_PAGE}" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="button.reset" /></a>
	</div>
</form:form>