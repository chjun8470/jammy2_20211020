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
				<h1>그룹 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writeAuthorGroup" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					
					<c:if test="${command == 'update'}">
					<input type="hidden" name="groupId" value="<c:out value='${writeAuthorGroup.groupId}' />" />
					</c:if>							
					
					<fieldset>
						<legend>등록정보</legend>
						<c:if test="${command == 'update'}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="groupId" class="control-label">* 그룹ID</label></span>
							<div class="col-sm-10">
								<p class="form-control-static"><c:out value="${writeAuthorGroup.groupId}"/></p>
							</div>
						</div>								
						</c:if>				
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="groupNm" class="control-label">* 그룹명</label></span>
							<div class="col-sm-10">
								<form:input path="groupNm" maxlength="60" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="groupDc" class="control-label">설명</label></span>
							<div class="col-sm-10">
								<form:input path="groupDc" maxlength="100" class="form-control" />			
							</div>
						</div>
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="group.do" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
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
	$("#writeAuthorGroup").validate();	
});
//]]>
</script>