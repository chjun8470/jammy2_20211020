<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h1>프로그램 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>		
			<div class="block-content">
				<form:form commandName="writeProgram" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchProgramVO.queryString}' escapeXml='false' />"/>
					
					<c:if test="${command == 'update'}">
					<input type="hidden" name="programId" value="${searchProgramVO.programId}"/>
					</c:if>
					
					<fieldset>
						<legend>등록정보</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="programNm" class="control-label">* 프로그램명</label></span>
							<div class="col-sm-10">
								<form:input path="programNm" class="form-control required" maxlength="60" />
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="programUrl" class="control-label">* 프로그램URL</label></span>
							<div class="col-sm-10">
								<form:input path="programUrl" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="position" class="control-label">순서</label></span>
							<div class="col-sm-10">
								<form:input path="position" maxlength="3" class="form-control required digits" />
							</div>
						</div>
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchProgramVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
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
	$("#writeProgram").validate();	
});
//]]>
</script>