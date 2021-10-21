<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h1>캘린더 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writeScheduleCalendar" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchScheduleCalendarVO.queryString}' escapeXml='false' />" />
					<input type="hidden" name="calndId" value="<c:out value='${searchScheduleCalendarVO.calndId}' />" />
					<fieldset>
						<legend class="sr-only">캘린더 관리 폼</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="calndTy" class="control-label">* 캘린더타입</label></span>
							<div class="col-sm-10">
								<form:select path="calndTy" class="form-control required">
									<form:options items="${calendarTyList}" itemValue="code" itemLabel="codeNm"/>
								</form:select>
							</div>
						</div>					
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="calndNm" class="control-label">* 캘린더명</label></span>
							<div class="col-sm-10">
								<form:input path="calndNm" maxlength="60" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="calndCatCode" class="control-label">캘린더카테고리코드</label></span>
							<div class="col-sm-10">
								<form:input path="calndCatCode" maxlength="6" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="permLvl" class="control-label">캘린더출력 (허용등급)</label></span>
							<div class="col-sm-10">
								<form:select path="permLvl" class="form-control">
								<form:option value="0">ㆍ전체허용</form:option>
								<c:forEach var="result" items="${levelList}" varStatus="status">									
								<form:option value="${result.levelId}">ㆍ<c:out value="${result.levelNm}"/> 이상</form:option>
								</c:forEach>
								</form:select>											
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">(차단그룹)</label></span>
							<div class="col-sm-10">
								<c:forEach var="result" items="${groupList}" varStatus="status">
								<label class="checkbox-inline"><form:checkbox path="permGrpArr" value="${result.groupId}" /> <c:out value="${result.groupNm}"/></label>
								</c:forEach>											
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
								<a href="?<c:out value='${searchScheduleCalendarVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
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
	$("#writeScheduleCalendar").validate();
});
//]]>
</script>