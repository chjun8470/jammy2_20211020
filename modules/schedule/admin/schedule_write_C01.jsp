<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h1>일정 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writeScheduleInfo" action="?act=write" enctype="multipart/form-data" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchScheduleInfoVO.queryString}' escapeXml='false' />" />
					<input type="hidden" name="schdulId" value="<c:out value='${searchScheduleInfoVO.schdulId}' />" />
					<fieldset>
						<legend class="sr-only">일정 관리 폼</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="schdulSe" class="control-label">구분</label></span>
							<div class="col-sm-10">
								<form:select path="schdulSe" class="form-control">
									<form:option value="">+ 선택</form:option>
									<form:options items="${calendarCatList}" itemValue="code" itemLabel="codeNm"/>
								</form:select>
							</div>
						</div>					
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="schdulNm" class="control-label">* 일정명</label></span>
							<div class="col-sm-10">
								<form:input path="schdulNm" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="schdulPlace" class="control-label">일정장소</label></span>
							<div class="col-sm-10">
								<form:input path="schdulPlace" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="schdulCn" class="control-label">* 일정내용</label></span>
							<div class="col-sm-10">
								<form:textarea path="schdulCn" rows="7" class="form-control required" />
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">* 날짜/시간</label></span>
							<div class="col-sm-10">
								<div class="input-group">
									<span class="input-group-addon">시작일</span>								
									<form:input path="schdulBgndeYYYMMDD" class="form-control required datepicker date" style="display:inline-block; width:120px;" />
									<form:select path="schdulBgndeHH">
										<form:options items="${schdulBgndeHH}" itemValue="code" itemLabel="codeNm"/>
									</form:select>시
									<form:select path="schdulBgndeMM">
										<form:options items="${schdulBgndeMM}" itemValue="code" itemLabel="codeNm"/>
									</form:select>분									
								</div>
								<div class="input-group mg-t-xs">
									<span class="input-group-addon">종료일</span>
									<form:input path="schdulEnddeYYYMMDD" class="form-control required datepicker date" style="display:inline-block; width:120px;"/>
									<form:select path="schdulEnddeHH">
										<form:options items="${schdulEnddeHH}" itemValue="code" itemLabel="codeNm"/>
									</form:select>시
									<form:select path="schdulEnddeMM">
										<form:options items="${schdulEnddeMM}" itemValue="code" itemLabel="codeNm"/>
									</form:select>분									
								</div>								
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="bizChargerNm" class="control-label">첨부파일</label></span>
							<div class="col-sm-10">
								<form:hidden path="atchFileId" />
								<c:forEach var="result" begin="0" end="1" varStatus="status">
									<c:set var="fileVO" value="${writeScheduleInfo.atchFileList[status.index]}"/>							
									<input type="file" name="atchFile" id="atchFile[]" class="form-control" value="" />
									<c:if test="${not empty fileVO}">
										<img src="<c:url value='/${fileVO.fileStreCours}/${fileVO.streFileNm}'/>" alt="" width="50" height="50"/>
										<input type="checkbox" name="deleteAtchFile" value="<c:out value='${fileVO.fileSn}'/>" />삭제(<c:out value='${fileVO.orignlFileNm}'/>)
									</c:if>						
								</c:forEach>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="schdulOrgnztId" class="control-label">담당부서</label></span>
							<div class="col-sm-10">
								<form:select path="schdulOrgnztId" class="form-control">
								<form:option value="">+ 선택</form:option>
								<form:options items="${treeOrgnztList}" itemValue="orgnztId" itemLabel="orgnztNm"/>
								</form:select>
							</div>
						</div>	
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="schdulChargerNm" class="control-label">담당자명</label></span>
							<div class="col-sm-10">
								<form:input path="schdulChargerNm" maxlength="20" class="form-control" />
							</div>
						</div>
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchScheduleInfoVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
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
	$("#writeScheduleInfo").validate();
});
//]]>
</script>