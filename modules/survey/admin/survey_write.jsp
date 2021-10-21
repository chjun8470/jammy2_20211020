<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h1>설문 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writeSurvey" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchSurveyVO.queryString}' escapeXml='false' />"/>					
					<c:if test="${command == 'update'}">
					<input type="hidden" name="srvyId" value="<c:out value='${searchSurveyVO.srvyId}'/>"/>
					</c:if>
					
					<fieldset>
						<legend class="sr-only">설문 관리 폼</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="title" class="control-label">* 설문제목</label></span>
							<div class="col-sm-10">
								<form:input path="title" maxlength="60" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="bcontent" class="control-label">* 설문내용</label></span>
							<div class="col-sm-10">
								<form:textarea path="content" id="bcontent" rows="10" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="title" class="control-label">* 설문기간</label></span>
							<div class="col-sm-10">
								<div class="input-group">
									<span class="input-group-addon">시작일</span>
									<form:input path="bgnde" maxlength="10" class="form-control datepicker required date" />
								</div>
								<div class="input-group mg-t-xs">
									<span class="input-group-addon">종료일</span>
									<form:input path="endde" maxlength="10" class="form-control datepicker required date" />
								</div>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">공개여부</label></span>
							<div class="col-sm-10">
								<label class="radio-inline"><form:radiobutton path="openYn" value="Y" />공개</label>
								<label class="radio-inline"><form:radiobutton path="openYn" value="N" />비공개 (회원만 이용가능합니다.)</label>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">중복투표</label></span>
							<div class="col-sm-10">
								<label class="radio-inline"><form:radiobutton path="dplctnYn" value="Y" />허용</label>
								<label class="radio-inline"><form:radiobutton path="dplctnYn" value="N" />허용안함</label>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">결과공개여부</label></span>
							<div class="col-sm-10">
								<label class="radio-inline"><form:radiobutton path="resultOpenYn" value="Y" />공개</label>
								<label class="radio-inline"><form:radiobutton path="resultOpenYn" value="N" />비공개</label>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">사용여부</label></span>
							<div class="col-sm-10">
								<label class="radio-inline"><form:radiobutton path="useYn" value="Y" />사용함</label>
								<label class="radio-inline"><form:radiobutton path="useYn" value="N" />사용안함</label>
							</div>
						</div>					
						<div class="bd-t mg-t-md pd-t-md"></div>	
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchSurveyVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
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
	$("#writeSurvey").validate();
});
//]]>
</script>