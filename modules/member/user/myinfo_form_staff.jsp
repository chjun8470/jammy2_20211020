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
	$("#writeOrgnztStaff").validate();
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

<form:form commandName="writeOrgnztStaff" action="?act=writeStaff" enctype="multipart/form-data" class="form-horizontal" role="form">
	<input type="hidden" name="m" value="<c:out value='${param.m}'/>" />
	<fieldset>
		<legend class="title-type1" style="border:none;">로그인 정보</legend>
		<div class="bordered pd mg-t-sm">
			<div class="form-group">
				<span class="col-sm-2"><label for="mberId" class="control-label">* 아이디</label></span>
				<div class="col-sm-10">
					<p class="form-control-static"><c:out value="${writeOrgnztStaff.loginId}"/> (아이디는 변경이 불가합니다.)</p> 
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
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="orgnztId" class="control-label">* 조직</label></span>
							<div class="col-sm-10">
								<form:select path="orgnztId" class="form-control required">
								<c:forEach var="result" items="${treeOrgnztList}" varStatus="status">
								<form:option value="${result.orgnztId}"><c:out value="${result.orgnztNm}" /></form:option>
								</c:forEach>
								</form:select>	
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="name" class="control-label">* 이름</label></span>
							<div class="col-sm-10">
								<p class="form-control-static"><c:out value="${writeOrgnztStaff.name}"/></p>
							</div>
						</div>		
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="rank" class="control-label">직급</label></span>
							<div class="col-sm-10">
								<form:input path="rank" maxlength="30" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="telNo" class="control-label">전화번호</label></span>
							<div class="col-sm-10">
								<form:input path="telNo" maxlength="30" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="faxNo" class="control-label">팩스</label></span>
							<div class="col-sm-10">
								<form:input path="faxNo" maxlength="14" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="hpNo" class="control-label">핸드폰번호</label></span>
							<div class="col-sm-10">
								<form:input path="hpNo" maxlength="30" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="email" class="control-label">이메일</label></span>
							<div class="col-sm-10">
								<form:input path="email" maxlength="60" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="asgnedArea" class="control-label">담당분야</label></span>
							<div class="col-sm-10">
								<form:textarea path="asgnedArea" class="form-control" />
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="mainBsnss" class="control-label">주업무</label></span>
							<div class="col-sm-10">
								<form:textarea path="mainBsnss" class="form-control" />
							</div>
						</div>
						<div class="form-group">
 							<span class="col-sm-2 text-right"><label for="uploadPhotoFile" class="control-label">사진</label></span>
							<div class="col-sm-10">
								<form:hidden path="photoFileId" />
								<input type="file" name="uploadPhotoFile" id="uploadPhotoFile" class="form-control" value="" />
								<c:if test="${not empty writeOrgnztStaff.photoFile}">
									<lable class="checkbox-inline"><input type="checkbox" name="deletePhotoFile" value="Y" /> 삭제(${writeOrgnztStaff.photoFile.orignlFileNm})</lable>
								</c:if>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="position" class="control-label">* 순서</label></span>
							<div class="col-sm-10">
								<form:input path="position" maxlength="4" class="form-control number" />
							</div>
						</div>		
		<div class="bordered pd mg-t-sm">
		</div>										
	</fieldset>
	<div class="text-center mg-t-lg">
		<button type="submit" class="btn btn-danger pd-l-lg pd-r-lg"><spring:message code="button.save" /></button>
		<a href="${INDEX_PAGE}" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="button.reset" /></a>
	</div>
</form:form>