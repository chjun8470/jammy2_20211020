<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h1>등급 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writeAuthorLevel" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					
					<c:if test="${command == 'update'}">
					<input type="hidden" name="levelId" value="<c:out value='${writeAuthorLevel.levelId}' />" />
					</c:if>						
					
					<fieldset>
						<legend>등록정보</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="levelId" class="control-label">* 등급ID</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:input path="levelId" maxlength="2" class="form-control required digits" />
									</c:when>
									<c:otherwise>
										<form:input path="levelId" class="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="levelNm" class="control-label">* 등급명</label></span>
							<div class="col-sm-10">
								<form:input path="levelNm" maxlength="60" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="levelDc" class="control-label">설명</label></span>
							<div class="col-sm-10">
								<form:input path="levelDc" maxlength="100" class="form-control" />			
							</div>
						</div>
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="level.do" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
							</div>
						</div>						
					</fieldset>
				</form:form>			
			</div>
		</div>	
	</div>
</div>

<script type="text/javascript"> 
//<![CDATA[
$(function()
{	
	$("#writeAuthorLevel").validate({
		rules: 
		{
			levelId:{remote:"<c:url value='/cms/admin/system/author/level.do?act=levelIdCheck'/>"}
		},
		messages: 
		{
			levelId:{remote : "<spring:message code='system.author.level.idDuplctn'/>"}
		}
	});
});
//]]>
</script>