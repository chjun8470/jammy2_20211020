<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>

<div class="row">
	<div class="col-lg-12">
		<div class="block">
			<div class="block-head">
				<h2>프로그램 목록</h2>
			</div>
			<div class="block-content np">
				<table class="table">
					<thead>
						<tr>
							<th scope="col" class="text-center">번호</th>
							<th scope="col" class="text-center">프로그램명</th>
							<th scope="col" class="text-center">프로그램URL</th>
							<th scope="col" class="text-center">순서</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${(paginationInfo.totalRecordCount+1) - (searchProgramVO.pageIndex-1) * searchProgramVO.pageUnit - status.count}"/></td>
							<td class="text-center"><c:out value="${result.programNm}" /></td>
							<td><c:out value="${result.programUrl}" /></td>
							<td class="text-center"><c:out value="${result.position}" /></td>
							<td class="text-center">
								<a href="?act=write&amp;programId=<c:out value='${result.programId}'/>&amp;<c:out value='${searchProgramVO.queryString}'/>" class="btn btn-default btn-xs">수정</a>
								<a href="javascript:post_delete('', 'act=delete&programId=<c:out value="${result.programId}"/>');" class="btn btn-default btn-xs">삭제</a>							
							</td>		
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td nowrap colspan="5"><spring:message code="info.nodata.msg"/></td>  
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
					<a href="?act=write&amp;<c:out value='${searchProgramVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-md pd-r-md"><spring:message code="common.create"/></a>
				</div>								
			</div>
		</div>	
	</div>
</div>