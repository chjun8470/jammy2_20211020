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
				<h1>공통상세코드 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writeCmmnDetailCode" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchCmmnDetailCodeVO.queryString}' escapeXml='false' />" />
					
					<c:if test="${command == 'update'}">
					<input type="hidden" name="codeId" value="<c:out value='${writeCmmnDetailCode.codeId}' />" />
					<input type="hidden" name="code" value="<c:out value='${writeCmmnDetailCode.code}' />" />
					</c:if>

					<fieldset>
						<legend>등록정보</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="codeId" class="control-label">* 코드ID</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<select name="clCode" id="clCode" class="form-control required">
										<c:forEach var="result" items="${cmmnClCodeList}" varStatus="status">
										<option value="${result.clCode}" <c:if test="${param.clCode == result.clCode}">selected="selected"</c:if>>${result.clCodeNm}</option>
										</c:forEach>
										</select>
										<form:select path="codeId" class="form-control required mg-t-xs">
										<c:forEach var="result" items="${cmmnCodeList}" varStatus="status">
										<form:option value="${result.codeId}" class="${result.clCode}">${result.codeIdNm}</form:option>
										</c:forEach>
										</form:select>
									</c:when>
									<c:otherwise>
										<form:select path="codeId" class="form-control mg-t-xs" disabled="true">
										<c:forEach var="result" items="${cmmnCodeList}" varStatus="status">
										<form:option value="${result.codeId}">${result.codeIdNm}</form:option>
										</c:forEach>
										</form:select>
									</c:otherwise>
								</c:choose>
							</div>
						</div>					
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="code" class="control-label">* 코드</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:input path="code" class="form-control required" maxlength="20" />
									</c:when>
									<c:otherwise>
										<form:input path="code" class="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>					
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="codeNm" class="control-label">* 코드명</label></span>
							<div class="col-sm-10">
								<form:input path="codeNm" class="form-control required" maxlength="60" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="codeDc" class="control-label">코드설명</label></span>
							<div class="col-sm-10">
								<form:input path="codeDc" class="form-control" maxlength="200" />			
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
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="position" class="control-label">순서</label></span>
							<div class="col-sm-10">
								<form:input path="position" maxlength="5" class="form-control digits" />
							</div>
						</div>
						<div class="bd-t md-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchCmmnDetailCodeVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
							</div>
						</div>
					</fieldset>
					<fieldset>					
						<legend>확장데이터</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="data01" class="control-label">데이터01</label></span>
							<div class="col-sm-10">
								<form:input path="data01" class="form-control" />			
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="data02" class="control-label">데이터02</label></span>
							<div class="col-sm-10">
								<form:input path="data02" class="form-control" />			
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="data03" class="control-label">데이터03</label></span>
							<div class="col-sm-10">
								<form:input path="data03" class="form-control" />			
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="data04" class="control-label">데이터04</label></span>
							<div class="col-sm-10">
								<form:input path="data04" class="form-control" />			
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="data05" class="control-label">데이터05</label></span>
							<div class="col-sm-10">
								<form:input path="data05" class="form-control" />			
							</div>
						</div>	
						<div class="bd-t md-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchCmmnDetailCodeVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
							</div>
						</div>
					</fieldset>
				</form:form>			
			</div>
		</div>	
	</div>
</div>

<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/jquery-chained/jquery.chained.min.js' />"></script>
<script type="text/javascript"> 
//<![CDATA[
$(function()
{	
	$("#codeId").chained("#clCode");
		
	$("#writeCmmnDetailCode").validate({
		rules: 
		{
			code:{remote:{url:"<c:url value='/cms/admin/system/code/detail.do?act=codeCheck'/>", data:{codeId:function(){return $('#codeId').val();}}}}
		},
		messages: 
		{
			code:{remote : "<spring:message code='code.codeDuplctn'/>"}
		}
	});	
});
//]]>
</script>