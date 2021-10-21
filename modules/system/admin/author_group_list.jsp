<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<ul class="nav nav-tabs">
			    <li class="active"><a href="#">그룹</a></li>
			    <li><a href="<c:url value='/cms/admin/system/author/level.do' />">등급</a></li>
			</ul>
			<div class="block-head">
				<h2>그룹 목록</h2>
			</div>
			<div class="block-content np">
				<table class="table">
					<thead>
						<tr>
							<th scope="col" class="text-center">그룹ID</th>
							<th scope="col" class="text-center">그룹명</th>
							<th scope="col" class="text-center">그룹설명</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${result.groupId}"/></td>
							<td class="text-center"><c:out value="${result.groupNm}"/></td>
							<td class="text-center"><c:out value="${result.groupDc}"/></td>
							<td class="text-center">
								<a href="?act=write&amp;groupId=<c:out value='${result.groupId}'/>" class="btn btn-default btn-xs"><spring:message code="common.update"/></a>
								<a href="javascript:post_delete('', 'act=delete&amp;groupId=<c:out value="${result.groupId}"/>');" class="btn btn-default btn-xs"><spring:message code="common.delete"/></a>							
							</td>		
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 4}">
						<tr>
							<td nowrap colspan="6"><spring:message code="info.nodata.msg"/></td>  
						</tr>		 
					</c:if>	
					</tbody>					
				</table>
			</div>
			<div class="block-footer">
				<div class="pull-right">
					<a href="?act=write" class="btn btn-primary btn-sm pd-l-md pd-r-md"><spring:message code="common.create"/></a>
				</div>								
			</div>
		</div>	
	</div>
</div>