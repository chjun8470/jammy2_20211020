<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<div class="row">
	<div class="col-lg-2">
		<div class="block">
			<div class="block-content">
					<link rel="stylesheet" href="/core/js/dtree/dtree.css">
					<script type="text/javascript" src="/core/js/dtree/dtree.js"></script>
					<script type="text/javascript">
					//<![CDATA[
					var d = new dTree('d');
					d.add("",-1,"도메인", "<c:url value='/cms/admin/site/domain.do'/>");
					<c:forEach var="result" items="${siteDomainList}" varStatus="status">
					d.add("<c:out value='${result.domainId}' />", "<c:out value='${result.parntsDomainId}' />", "<c:out value='${result.domain}' />", "?domainId=<c:out value='${result.domainId}' />", "", "", "");
					</c:forEach>
					document.write(d);
					//]]>
					</script>
			</div>
		</div>
	</div>
	<div class="col-lg-10">
		<div class="block">
			<div class="block-head">
				<h1>
					<c:choose><c:when test="${not empty parntsSiteDomainVO}">서브도메인</c:when><c:otherwise>메인도메인</c:otherwise></c:choose>
					<c:choose><c:when test="${command == 'insert'}">등록</c:when><c:otherwise>등록정보</c:otherwise></c:choose>
				</h1>
			</div>
			<div class="block-content">
				<form:form commandName="writeSiteDomain" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					
					<c:if test="${command == 'insert'}">
					<input type="hidden" name="parntsDomainId" value="<c:out value='${searchSiteDomainVO.parntsDomainId}'/>"/>
					</c:if>
					<c:if test="${command == 'update'}">
					<input type="hidden" name="domainId" value="<c:out value='${searchSiteDomainVO.domainId}'/>"/>
					</c:if>			
					
					<fieldset>
						<legend class="sr-only">사이트 관리 폼</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">소속도메인</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${empty writeSiteDomain.parntsDomainId}"><p class="form-control-static">최상위도메인</p></c:when>
									<c:otherwise><p class="form-control-static"><c:out value='${parntsSiteDomainVO.domain}'/></p></c:otherwise>
								</c:choose>								
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="domain" class="control-label">* 도메인주소</label></span>
							<div class="col-sm-10">
								http://
								<form:input path="domain" class="form-control required" style="display:inline-block; width:150px;"/>
								<c:if test="${command == 'update'}">
								<button type="button" onclick="post_delete('', 'act=delete&amp;domainId=<c:out value="${writeSiteDomain.domainId}"/>');" class="btn btn-default">도메인 <spring:message code="common.delete"/></button>
								</c:if>
								<c:if test="${empty writeSiteDomain.parntsDomainId}">
								<a href="?parntsDomainId=<c:out value='${writeSiteDomain.domainId}'/>" class="btn btn-default">서브도메인 등록</a>
								</c:if>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="mobileYn0" class="control-label">모바일도메인 여부</label></span>
							<div class="col-sm-10">
								<label class="checkbox-inline">
									<form:checkbox path="mobileYn" value="Y"/>모바일홈페이지 도메인인 경우 체크 
								</label>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="siteId" class="control-label">* 연결사이트</label></span>
							<div class="col-sm-10">
								<form:select path="siteId" class="form-control required" style="display:inline-block; width:250px;">
								<c:forEach var="result" items="${siteList}" varStatus="status">
								<form:option value="${result.siteId}"><c:out value="${result.siteNm}"/></form:option>
								</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="bd-t md-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
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
	$("#writeSiteDomain").validate();
});
//]]>
</script>