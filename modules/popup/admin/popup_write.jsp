<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h1>팝업 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writePopup" action="?act=write" enctype="multipart/form-data" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchPopupVO.queryString}' escapeXml='false' />" />
					<input type="hidden" name="popupId" value="<c:out value='${searchPopupVO.popupId}' />" />
					<fieldset>
						<legend class="sr-only">팝업 관리 폼</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="device" class="control-label">디바이스</label></span>
							<div class="col-sm-10">
								<form:select path="device" class="form-control">
								<form:option value="ALL">모두출력</form:option>
								<form:option value="PC">PC</form:option>
								<form:option value="MOBILE">모바일</form:option>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="title" class="control-label">* 타이틀</label></span>
							<div class="col-sm-10">
								<form:input path="title" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="startDt" class="control-label">* 노출기간</label></span>
							<div class="col-sm-10">
								<div class="input-group">
									<span class="input-group-addon">부터</span>
									<form:input path="startDt" maxlength="10" class="form-control datepicker required date" />
								</div>
								<div class="input-group mg-t-xs">
									<span class="input-group-addon">까지</span>
									<form:input path="endDt" maxlength="10" class="form-control datepicker required date" />
								</div>								
							</div>
						</div>
						<c:choose>
							<c:when test="${searchPopupVO.popupTy == 'POPUPZONE' || searchPopupVO.popupTy == 'BANNER' || searchPopupVO.popupTy == 'MAIN_VISUAL'}">
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="attachFile" class="control-label">* 이미지</label></span>
									<div class="col-sm-10">
										<form:hidden path="atchFileId" />
										<input type="file" name="attachFile" id="attachFile" class="form-control" value="" />
										<c:if test="${not empty writePopup.atchFile}">
											<img src="<c:url value='/${writePopup.atchFile.fileStreCours}/${writePopup.atchFile.streFileNm}'/>" alt="" width="50" height="50"/>
											<input type="checkbox" name="deleteAtchFile" value="Y" />삭제(${writePopup.atchFile.orignlFileNm})
										</c:if>										
									</div>
								</div>												
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="linkUrl" class="control-label">링크URL</label></span>
									<div class="col-sm-10">
										<form:input path="linkUrl" class="form-control" />
									</div>
								</div>	
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="linkTarget" class="control-label">링크타겟</label></span>
									<div class="col-sm-10">
										<label class="radio-inline">
											<form:radiobutton path="linkTarget" value="_SELF" />현재창
										</label>
										<label class="radio-inline">
											<form:radiobutton path="linkTarget" value="_BLANK" />새창
										</label>										
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="bcontent" class="control-label">* 내용</label></span>
									<div class="col-sm-10">
										<form:textarea path="content" id="bcontent" rows="10" class="form-control required" />
									</div>
								</div>
							</c:when>
							<c:otherwise>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="popupWidth" class="control-label">* 팝업사이즈</label></span>
									<div class="col-sm-10">
										<div class="input-group">
											<span class="input-group-addon">가로</span>
											<form:input path="popupWidth" maxlength="5" class="form-control required digits" />
										</div>
										<div class="input-group mg-t-xs">
											<span class="input-group-addon">세로</span>
											<form:input path="popupHeight" maxlength="5" class="form-control required digits" />
										</div>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="popupLeft" class="control-label">* 팝업위치</label></span>
									<div class="col-sm-10">
										<div class="input-group">
											<span class="input-group-addon">왼쪽</span>
											<form:input path="popupLeft" maxlength="5" class="form-control required digits" />
										</div>
										<div class="input-group mg-t-xs">
											<span class="input-group-addon">위쪽</span>
											<form:input path="popupTop" maxlength="5" class="form-control required digits" />
										</div>							
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="scrollAt" class="control-label">스크롤</label></span>
									<div class="col-sm-10">
										<form:select path="scrollAt" class="form-control">
										<form:option value="AUTO">자동</form:option>
										<form:option value="YES">예</form:option>
										<form:option value="NO">아니오</form:option>
										</form:select>
									</div>
								</div>		
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="bcontent" class="control-label">* 내용</label></span>
									<div class="col-sm-10">
										<form:textarea path="content" id="bcontent" class="form-control required" />
										<script type="text/javascript" src="<c:url value='/cms/ckeditor.do'/>"></script>
										<c:import url="/cms/ckeditor/config.do?id=bcontent">
											<c:param name="id" value="bcontent" />
											<c:param name="atchFieldNm" value="editorAtchFileId" />
											<c:param name="atchFileId" value="${writePopup.editorAtchFileId}" />
										</c:import>
									</div>
								</div>
							</c:otherwise>
						</c:choose>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="position" class="control-label">* 정렬순서</label></span>
							<div class="col-sm-10">
								<form:input path="position" maxlength="5" class="form-control required digits" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="position" class="control-label">적용 사이트</label></span>
							<div class="col-sm-10">
								<c:forEach var="result" items="${siteList}" varStatus="status">
									<label class="checkbox-inline"><form:checkbox path="showSiteIdsArr" value="${result.siteId}" /> <c:out value="${result.siteNm}"/></label>
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
								<a href="?<c:out value='${searchPopupVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
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
	$("#writePopup").validate();
});
//]]>
</script>