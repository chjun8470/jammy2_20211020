<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ page import="egovframework.jammy2.board.service.BoardVO" %>
<%
	BoardVO boardVO = (BoardVO)request.getAttribute("boardVO");
	String configFile = String.format("config_%s.jsp", boardVO.getBoardTy());
%>
<jsp:include page="<%=configFile%>" flush="true" />

<script type="text/javascript" src="<c:url value="/cms/validator.do"/>"></script>
<script type="text/javascript"> 
//<![CDATA[
$(function()
{	
	$("#writeBoardArticle").validate();
});
//]]>
</script>

<form:form commandName="writeBoardArticle" action="?act=write" enctype="multipart/form-data" class="form-horizontal">
	<input type="hidden" name="write" value="ok" />
	<input type="hidden" name="mode" value="<c:out value='${mode}'/>" />
	<input type="hidden" name="returnQueryString" value="<c:out value='${boardSearchQueryString}' escapeXml='false' />" />
	
	<c:if test="${mode == 'modify' || mode == 'reply'}">
	<input type="hidden" name="articleId" value="<c:out value='${param.articleId}'/>" />
	</c:if>
	
	<fieldset>
		<legend></legend>
		<c:if test="${noticeAuthor || secretAuthor}">
		<div class="form-group">
			<label class="col-sm-2 control-label"><spring:message code="common.option"/></label>
			<div class="col-sm-10">
				<c:if test="${noticeAuthor}">
				<label class="checkbox-inline"><form:checkbox path="noticeAt" value="Y"/><spring:message code="common.notice"/></label>
				</c:if>
				<c:if test="${secretAuthor}">
				<label class="checkbox-inline"><form:checkbox path="secretAt" value="Y"/><spring:message code="common.secret"/></label>
				</c:if>
			</div>
		</div>
		</c:if>
		<form:checkbox path="shareBoardIdArr" value="B0009"/>게시판1
		<form:checkbox path="shareBoardIdArr" value="B0010"/>게시판2
		
		<c:if test="${empty LOGIN_INFO}">
		<div class="form-group">
			<label for="writerNm" class="col-sm-2 control-label"><span class="essential">*</span> <spring:message code="common.name"/></label>
			<div class="col-sm-10">
				<form:input path="writerNm" class="form-control input-sm required" />
			</div>
		</div>		
		<div class="form-group">
			<label for="password" class="col-sm-2 control-label"><span class="essential">*</span> <spring:message code="common.password"/></label>
			<div class="col-sm-10">
				<c:choose>
					<c:when test="${mode == 'modify'}">
					<form:password path="password" class="form-control input-sm" />
					</c:when>
					<c:otherwise>
					<form:password path="password" class="form-control input-sm required" />
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		</c:if>
		<c:if test="${boardVO.useCategoryAt == 'Y'}">
		<div class="form-group">
			<label for="categoryNm" class="col-sm-2 control-label">* 분류</label>
			<div class="col-sm-10">
				<form:select path="categoryNm" class="form-control input-sm required">
				<form:option value="">+ 선택</form:option>
				<c:forEach var="result" items="${boardCategory}" varStatus="status">
				<form:option value="${result}"><c:out value="${result}"/></form:option>
				</c:forEach>
				</form:select>
			</div>
		</div>				
		</c:if>
		<div class="form-group">
			<label for="subject" class="col-sm-2 control-label"><span class="essential">*</span> <spring:message code="common.subject"/></label>
			<div class="col-sm-10">
				<form:input path="subject" class="form-control input-sm required" />
			</div>
		</div>		
		<div class="form-group">
			<label for="bcontent" class="col-sm-2 control-label"><span class="essential">*</span> <spring:message code="common.content"/></label>
			<div class="col-sm-10">
				<form:textarea path="content" id="bcontent" rows="10" class="form-control input-sm required" />
				<c:if test="${editorAuthor}">
					<script type="text/javascript" src="<c:url value='/cms/ckeditor.do'/>"></script>
					<c:import url="/cms/ckeditor/config.do?id=bcontent" />
				</c:if>
			</div>
		</div>
		<div class="form-group">
			<label for="thumbAttachFile" class="col-sm-2 control-label">썸네일</label>
			<div class="col-sm-10">
				<form:hidden path="thumbAtchFileId" />
				<input type="file" name="thumbAttachFile" id="thumbAtchFileId" class="form-control input-sm" value="" />
				<c:if test="${not empty writeBoardArticle.thumbAtchFile}">
				<input type="checkbox" name="deleteThumbAtchFile" value="Y" />삭제(${writeBoardArticle.thumbAtchFile.orignlFileNm})
				</c:if>
			</div>
		</div>		
<c:if test="${boardVO.uploadCount>0}">
		<div class="form-group">
			<label for="attachFile[0]" class="col-sm-2 control-label"><spring:message code="common.atchFile"/></label>
			<div class="col-sm-10">
				<form:hidden path="atchFileId" />
				<span class="file_txt"><strong>업로드 가능 파일</strong> : <c:out value="${boardVO.uploadExt}"/> | <strong>업로드 제한 용량</strong> : <c:out value="${boardVO.uploadSize}"/>MB</span>
		
				<c:forEach var="result" begin="0" end="${boardVO.uploadCount-1}" varStatus="status">
					<c:set var="fileVO" value="${writeBoardArticle.atchFileList[status.index]}"/>
					<input type="file" name="attachFile" id="attachFile[]" class="form-control input-sm" value="" />
					<c:if test="${not empty fileVO}">
						<img src="<c:url value='/${fileVO.fileStreCours}/${fileVO.streFileNm}'/>" alt="" width="50" height="50"/>
						<input type="checkbox" name="deleteAtchFile" value="<c:out value='${fileVO.fileSn}'/>" />삭제(<c:out value='${fileVO.orignlFileNm}'/>)
					</c:if>						
				</c:forEach>

			</div>
		</div>
</c:if>
<c:if test="${boardVo.permLvlWrite < 1 || empty LOGIN_INFO}">
</c:if>
		<div class="text-center">
			<button type="submit" class="btn btn-danger btn-sm"><spring:message code="common.save"/></button>
			<a href="?act=list&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-default btn-sm"><spring:message code="common.reset"/></a>
		</div>
	</fieldset>
</form:form>
