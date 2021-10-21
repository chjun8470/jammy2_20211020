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
				<h1>공통분류코드 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writeCmmnClCode" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchCmmnClCodeVO.queryString}' escapeXml='false' />" />
					
					<c:if test="${command == 'update'}">
					<input type="hidden" name="clCode" value="<c:out value='${writeCmmnClCode.clCode}' />" />
					</c:if>										
					
					<fieldset>
						<legend>등록정보</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="clCode" class="control-label">* 분류코드</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:input path="clCode" class="form-control required" maxlength="3" />
										<div class="help-block">3자리의 영문(대문자)으로 입력해 주세요.</div>
									</c:when>
									<c:otherwise>
										<form:input path="clCode" class="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="clCodeNm" class="control-label">* 분류코드명</label></span>
							<div class="col-sm-10">
								<form:input path="clCodeNm" class="form-control required" maxlength="60" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="clCodeDc" class="control-label">분류코드설명</label></span>
							<div class="col-sm-10">
								<form:input path="clCodeDc" class="form-control" maxlength="200" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="useAt" class="control-label">사용여부</label></span>
							<div class="col-sm-10">
								<form:select path="useAt" class="form-control">
								<form:option value="Y">사용함</form:option>
								<form:option value="N">사용안함</form:option>
								</form:select>
							</div>
						</div>
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchCmmnClCodeVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
							</div>
						</div>						
					</fieldset>
				</form:form>			
			</div>
		</div>	
	</div>
</div>

<script type="text/javascript" src="<c:out value='${layoutPath}/js/plugins/jquery-chained/jquery.chained.min.js' />"></script>
<script type="text/javascript"> 
//<![CDATA[
$(function()
{		
	$("#writeCmmnClCode").validate({
		rules: 
		{
			clCode:{minlength:3, remote:"<c:url value='/cms/admin/system/code/clcode.do?act=clCodeCheck'/>"}
		},
		messages: 
		{
			clCode:{remote : "<spring:message code='code.clCodeDuplctn'/>"}
		}
	});	
});
//]]>
</script>