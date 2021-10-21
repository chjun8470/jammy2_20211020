<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div class="row">
	<div class="col-lg-12">
		<div class="block">
			<div class="block-content">
				<form method="get" class="form-inline">
					<fieldset>
						<legend class="sr-only">테마선택 폼</legend>
						<div class="input-group">
							<select name="themeId" class="form-control">
							<option value="">+ 테마선택</option>
							<c:forEach var="result" items="${themeList}" varStatus="status">
							<option value="<c:out value='${result.themeId}'/>" <c:if test="${searchThemeVO.themeId == result.themeId}">selected="selected"</c:if>><c:out value="${result.themeNm}"/></option>
							</c:forEach>			
							</select>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search" /></button>
							</span>							
						</div>				
						<div class="input-group">
							<a href="?page=info" class="btn btn-default"><i class="fa fa-plus"></i> 테마등록</a>
						</div>
					</fieldset>
				</form>			
			</div>
		</div>	
		<c:if test="${command == 'update'}">
		<div class="block">
			<ul class="nav nav-tabs">
			    <li><a href="?themeId=<c:out value='${searchThemeVO.themeId}'/>">레이아웃</a></li>
			    <li><a href="?themeId=<c:out value='${searchThemeVO.themeId}'/>&amp;fileGb=include">INCLUDE</a></li>
			    <li><a href="?themeId=<c:out value='${searchThemeVO.themeId}'/>&amp;fileGb=css">CSS</a></li>
			    <li><a href="?themeId=<c:out value='${searchThemeVO.themeId}'/>&amp;fileGb=js">JS</a></li>
			    <li><a href="?themeId=<c:out value='${searchThemeVO.themeId}'/>&amp;fileGb=file">FILE</a></li>
			    <li class="active"><a href="#">테마정보</a></li>
			</ul>
		</div>
		</c:if>
	</div>
	<div class="col-lg-12">
		<div class="block">
			<div class="block-head">
				<h1>테마정보 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">
				<form:form commandName="writeTheme" class="form-horizontal" role="form">
					<input type="hidden" name="act" value="write" />
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<fieldset>
						<legend class="sr-only">테마정보관리폼</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="themeId" class="control-label">* 테마ID</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:input path="themeId" class="form-control required" />
									</c:when>
									<c:otherwise>
										<form:input path="themeId" class="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>							
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="themeNm" class="control-label">* 테마명</label></span>
							<div class="col-sm-10">
								<form:input path="themeNm" maxlength="60" class="form-control required" />
							</div>
						</div>
						<c:if test="${command == 'insert'}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">테마복사</label></span>
							<div class="col-sm-10">
								<form:select path="copyThemeId" class="form-control">
								<form:option value="">+ 복사할 테마를 선택해주세요.</form:option>
								<c:forEach var="result" items="${themeList}" varStatus="status">
								<form:option value="${result.themeId}"><c:out value="${result.themeNm}"/></form:option>
								</c:forEach>							
								</form:select>
							</div>
						</div>
						</c:if>
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
								<c:if test="${command == 'update'}">
								<button type="button" class="btn btn-default pd-l-lg pd-r-lg" onclick="post_delete('', 'page=info&act=delete&themeId=<c:out value="${writeTheme.themeId}"/>');"><spring:message code="common.delete"/></a>
								</c:if>								
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
	$("#writeTheme").validate();
});
//]]>
</script>