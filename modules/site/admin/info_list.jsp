<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h2>사이트 목록</h2>
			</div>
			<div class="block-content">
				<form action="<c:url value='/cms/admin/site/info.do'/>" method="post" class="form-inline" role="form">
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="searchCondition" id="searchCondition" class="form-control">
							<option value="siteId" <c:if test="${searchSiteInfoVO.searchCondition == 'siteId'}">selected="selected"</c:if>>사이트ID</option>
							<option value="siteNm" <c:if test="${searchSiteInfoVO.searchCondition == 'siteNm'}">selected="selected"</c:if>>사이트명</option>
							</select> 
						</div>
						<div class="input-group">						
							<input type="text" name="searchKeyword" id="searchKeyword" class="form-control" value="<c:out value='${searchSiteInfoVO.searchKeyword}'/>"/>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search"/></button>
								<a href="<c:url value='/cms/admin/site/info.do'/>" class="btn btn-default"><i class="fa fa-refresh"></i> <spring:message code="common.reset"/></a>
							</span> 
						</div>						
					</fieldset>
				</form>
			</div>
			<div class="block-content np">
				<table class="table">
					<thead>
						<tr>
							<th scope="col" class="text-center">번호</th>
							<th scope="col" class="text-center">사이트ID</th>
							<th scope="col" class="text-center">사이트명</th>
							<th scope="col" class="text-center">사이트타이틀</th>
							<th scope="col" class="text-center">사이트언어</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${paginationInfo.totalRecordCount - (searchSiteInfoVO.pageIndex-1) * searchSiteInfoVO.pageSize - status.index}"/></td>
							<td class="text-center"><a href="<c:url value='/${result.siteId}/main.do'/>" target="_blank"><c:out value="${result.siteId}"/></a></td>
							<td class="text-center"><c:out value="${result.siteNm}"/></td>
							<td class="text-center"><c:out value="${result.siteTitle}"/></td>
							<td class="text-center"><c:out value="${result.siteLang}"/></td>
							<td class="text-center">
								<a href="?act=write&amp;siteId=<c:out value='${result.siteId}'/>&amp;<c:out value='${searchSiteInfoVO.queryString}'/>" class="btn btn-default btn-xs"><spring:message code="common.update"/></a>
								<c:if test="${empty EMPLYR_INFO.adminSiteId}">
								<a href="javascript:post_delete('', 'act=delete&amp;siteId=<c:out value="${result.siteId}"/>');" class="btn btn-default btn-xs"><spring:message code="common.delete"/></a>
								</c:if>							
							</td>		
						</tr>
					</c:forEach>
					<c:if test="${!empty resultList}">
						<tr>
							<td colspan="6" class="text-center"><spring:message code="info.nodata.msg"/></td>  
						</tr>		 
					</c:if>	
					</tbody>					
				</table>
			</div>
			<div class="block-footer">
				<div class="pull-left">
					<ul class="pagination pagination-sm">
					<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${paginationQueryString}"/>
					</ul>
				</div>
				<div class="pull-right">
					<c:if test="${empty EMPLYR_INFO.adminSiteId}">
					<a href="?act=write&amp;<c:out value='${searchSiteInfoVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-lg pd-r-lg"><spring:message code="common.create"/></a>
					</c:if>
				</div>								
			</div>
		</div>	
	</div>
</div>