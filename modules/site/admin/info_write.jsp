<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h1>사이트 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>
			<div class="block-content">				
				<form:form commandName="writeSiteInfo" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchSiteInfoVO.queryString}' escapeXml='false' />"/>
					
					<c:if test="${command == 'update'}">
					<input type="hidden" name="siteId" value="<c:out value='${searchSiteInfoVO.siteId}'/>"/>
					</c:if>
					
					<fieldset>
						<legend class="sr-only">사이트 관리 폼</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="siteId" class="control-label">* 사이트 아이디</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:input path="siteId" maxlength="20" class="form-control required" />
									</c:when>
									<c:otherwise>																				
										<form:input path="siteId" class="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="siteNm" class="control-label">* 사이트 명</label></span>
							<div class="col-sm-10">
								<form:input path="siteNm" maxlength="60" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="siteTitle" class="control-label">* 사이트 타이틀</label></span>
							<div class="col-sm-10">
								<form:input path="siteTitle" maxlength="60" class="form-control required" />
								<div class="help-block">
									브라우져의 타이틀에 출력됩니다.							
								</div>								
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="siteLang" class="control-label">* 사이트 언어</label></span>
							<div class="col-sm-10">
								<form:select path="siteLang" class="form-control required">
								<c:forEach var="result" items="${langList}" varStatus="status">
								<form:option value="${result.code}"><c:out value="${result.codeNm}" /></form:option>
								</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="themeId" class="control-label">* 레이아웃</label></span>
							<div class="col-sm-10">
								<form:select path="themeId" class="form-control required">
								<form:option value="">+ 테마 선택</form:option>
								<c:forEach var="result" items="${themeList}" varStatus="status">
								<form:option value="${result.themeId}"><c:out value="${result.themeNm}" /></form:option>
								</c:forEach>
								</form:select>					
								<form:select path="layout" class="mg-t-xs form-control required">
								<form:option value="">+ 레이아웃 선택</form:option>
								<c:forEach var="result" items="${themeFileList}" varStatus="status">
								<c:if test="${result.themeId == writeSiteInfo.themeId}">
								<form:option value="${result.fileNm}"><c:out value="${result.fileDc}" /></form:option>
								</c:if>
								</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="serviceSttus" class="control-label">* 서비스상태</label></span>
							<div class="col-sm-10">
								<form:select path="serviceSttus" class="form-control required">
								<form:option value="OPEN">ㆍ정상서비스</form:option>
								<form:option value="ADMIN_OPEN">ㆍ관리자오픈</form:option>
								<form:option value="STOP">ㆍ정지</form:option>
								</form:select>					
							</div>
						</div>		
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="useMobileAt" class="control-label">모바일 사용여부</label></span>
							<div class="col-sm-10">
								<label class="checkbox-inline"><form:checkbox path="useMobileAt" value="Y" />사용</label>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="mobileThemeId" class="control-label">모바일 레이아웃</label></span>
							<div class="col-sm-10">
								<form:select path="mobileThemeId" class="form-control">
								<form:option value="">+ PC접속과 동일</form:option>
								<c:forEach var="result" items="${themeList}" varStatus="status">
								<form:option value="${result.themeId}"><c:out value="${result.themeNm}" /></form:option>
								</c:forEach>
								</form:select>					
								<form:select path="mobileLayout" class="form-control mg-t-xs">
								<form:option value="">+ PC접속과 동일</form:option>
								<c:forEach var="result" items="${themeFileList}" varStatus="status">
								<c:if test="${result.themeId == writeSiteInfo.mobileThemeId}">
								<form:option value="${result.fileNm}"><c:out value="${result.fileDc}" /></form:option>
								</c:if>
								</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="position" class="control-label">* 순서</label></span>
							<div class="col-sm-10">
								<form:input path="position" maxlength="3" class="form-control required digits" />
							</div>
						</div>
						<div class="bd-t md-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchSiteInfoVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
							</div>
						</div>						
					</fieldset>
				</form:form>			
			</div>
		</div>	
	</div>
</div>

<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/jquery-chained/jquery.chained.min.js' />"></script>
<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/jquery-chained/jquery.chained.remote.min.js' />"></script>
<script type="text/javascript"> 
//<![CDATA[
$(function()
{
	$.ajax(
	{
		url:'?act=getLayoutList&themeId=<c:out value="${writeSiteInfo.themeId}"/>',
		dataType: "json",
		success:function(data) 
		{
			$("#layout").remoteChained({parents: "#themeId", url: "?act=getLayoutList", bootstrap: data});
		},
		error:function(request,status,error)
		{
			alert(error);
		}
	});

	$.ajax(
	{
		url:'?act=getLayoutList&themeId=<c:out value="${writeSiteInfo.mobileThemeId}"/>',
		dataType: "json",
		success:function(data) 
		{
			$("#mobileLayout").remoteChained({parents: "#mobileThemeId", url: "?act=getLayoutList", bootstrap: data});
		},
		error:function(request,status,error)
		{
			alert(error);
		}
	});
		
    jQuery.validator.addMethod("alphanumeric", function(value, element) 
    {
        return this.optional(element) || /^[a-zA-Z0-9]+$/.test(value);
	}); 	
	    
	$("#writeSiteInfo").validate({
		rules: 
		{
			siteId:{alphanumeric: true, minlength: 2, remote: "<c:url value='/cms/admin/site/info.do?act=siteIdCheck'/>"}
		},
		messages: 
		{
			siteId:{alphanumeric: "알파벳과 숫자만 사용가능합니다.", remote: "<spring:message code='site.info.idDuplctn'/>"}
		}
	});
});
//]]>
</script>