<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovStringUtil" %>
<%@ page import="egovframework.jammy2.member.service.GnrlMember" %>
<%@ page import="egovframework.jammy2.member.service.MemberRealnameVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%
	GnrlMember vo = (GnrlMember)request.getAttribute("writeGnrlMember");
	
	MemberRealnameVO realnameVO = (MemberRealnameVO)session.getAttribute("realnameVO");
	if (realnameVO != null)
	{
		vo.setMberNm(realnameVO.getName());
		vo.setSexdstnCode(realnameVO.getSex());
		vo.setBrthdy(realnameVO.getBirYMD());
	}

	request.setAttribute("writeGnrlMember", vo);

%>

<script type="text/javascript" src="<c:url value="/cms/validator.do"/>"></script>
<script type="text/javascript"> 
//<![CDATA[
$(function()
{	
	$("#writeGnrlMember").validate({
		rules: 
		{
			mberId:{minlength:4, maxlength: 20, remote: "<c:url value='/cms/member/register/gnrl.do?act=mberIdCheck'/>"}
			, mberNm:{maxlength: 50}
			, password:{minlength: 6, maxlength: 12}
			, passwordCnfirm:{equalTo: "#password"}			
			, telNo:{maxlength: 20}
			, hpNo:{maxlength: 20}
			, email:{maxlength: 50}
		},
		messages: 
		{
			mberId:{remote: "<spring:message code='fail.user.idDuplctn'/>"},
			passwordCnfirm:{equalTo: "<spring:message code='fail.user.passwordUpdate2'/>"}		
		}		
	});
});
//]]>
</script>

<form:form commandName="writeGnrlMember" class="form-horizontal" role="form">
	<input type="hidden" name="act" value="form" />
	<input type="hidden" name="form" value="ok" />	
	<fieldset>
		<legend class="title-type1" style="border:none;">로그인 정보</legend>
		<div class="bordered pd mg-t-sm">
			<div class="form-group">
				<span class="col-sm-2"><label for="mberId" class="control-label">* 아이디</label></span>
				<div class="col-sm-10">
					<form:input path="mberId" class="form-control required" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2"><label for="password" class="control-label">* 비밀번호</label></span>
				<div class="col-sm-10">
					<form:password path="password" class="form-control required" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2"><label for="passwordCnfirm" class="control-label">* 비밀번호 확인</label></span>
				<div class="col-sm-10">
					<input type="password" name="passwordCnfirm" id="passwordCnfirm" class="form-control required" value="" />
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
					<form:input path="mberNm" class="form-control required" />
				</div>
			</div>
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
					<form:input path="email" class="form-control email required" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2"><label for="zip" class="control-label">우편번호</label></span>
				<div class="col-sm-10">
					<form:input path="zip" class="form-control" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2"><label for="adres" class="control-label">주소</label></span>
				<div class="col-sm-10">
					<form:input path="adres" class="form-control" />
				</div>
			</div>
			<div class="form-group">
				<span class="col-sm-2"><label for="detailAdres" class="control-label">상세주소</label></span>
				<div class="col-sm-10">
					<form:input path="detailAdres" class="form-control" />
				</div>
			</div>
		</div>								
	</fieldset>
	<div class="text-center mg-t-lg">
		<button type="submit" class="btn btn-danger pd-l-lg pd-r-lg"><spring:message code="button.save" /></button>
		<a href="<c:out value='${INDEX_PAGE}'/>" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="button.reset" /></a>
	</div>	
</form:form>
