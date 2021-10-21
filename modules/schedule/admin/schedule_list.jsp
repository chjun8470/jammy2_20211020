<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h2>일정 목록</h2>
			</div>
			<div class="block-content">
				<form action="<c:url value='/cms/admin/schedule/${scheduleCalendarVO.calndId}.do'/>" method="post" class="form-inline" role="form">
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="searchCondition" id="searchCondition" class="form-control">
							<option value="title" <c:if test="${searchScheduleInfoVO.searchCondition == 'title'}">selected="selected"</c:if>>제목</option>
							</select> 
						</div>
						<div class="input-group">						
							<input type="text" name="searchKeyword" id="searchKeyword" class="form-control" value="<c:out value='${searchScheduleInfoVO.searchKeyword}'/>"/>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search"/></button>
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
							<th scope="col" class="text-center">일정명</th>
							<th scope="col" class="text-center">날짜</th>
							<th scope="col" class="text-center">시간</th>
							<th scope="col" class="text-center">담담부서</th>
							<th scope="col" class="text-center">담담자</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${(paginationInfo.totalRecordCount+1) - (searchScheduleInfoVO.pageIndex-1) * searchScheduleInfoVO.pageUnit - status.count}"/></td>
							<td>
								<c:if test="${not empty result.schdulSeNm}"><span class="label label-default"><c:out value="${result.schdulSeNm}"/></span></c:if>
								<c:out value="${result.schdulNm}"/>
							</td>
							<td class="text-center"><c:out value="${fn:substring(result.schdulBgnde,0,10)}"/> ~ <c:out value="${fn:substring(result.schdulEndde,0,10)}"/></td>
							<td class="text-center"><c:out value="${fn:substring(result.schdulBgnde,11,16)}"/> ~ <c:out value="${fn:substring(result.schdulEndde,11,16)}"/></td>
							<td class="text-center"><c:out value="${result.schdulOrgnztNm}"/></td>
							<td class="text-center"><c:out value="${result.schdulChargerNm}"/></td>
							<td class="text-center">
								<a href="?act=write&amp;schdulId=<c:out value='${result.schdulId}'/>&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>"><spring:message code="common.update"/></a>
								<c:if test="${empty adminSiteId}">
								<a href="javascript:post_delete('', 'act=delete&amp;schdulId=<c:out value="${result.schdulId}"/>');"><spring:message code="common.delete"/></a>
								</c:if>							
							</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="7" class="text-center"><spring:message code="info.nodata.msg"/></td>  
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
					<a href="?act=write&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-lg pd-r-lg"><spring:message code="common.create"/></a>
				</div>								
			</div>
		</div>	
	</div>
</div>