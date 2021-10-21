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
			    <li class="active"><a href="#">공통분류코드</a></li>
			    <li><a href="<c:url value='/cms/admin/system/code/code.do' />">공통코드</a></li>
			    <li><a href="<c:url value='/cms/admin/system/code/detail.do' />">공통상세코드</a></li>
			</ul>
			<div class="block-head">
				<h2>공통분류코드 목록</h2>
			</div>
			<div class="block-content np">
				<table class="table">
					<thead>
						<tr>
							<th scope="col" class="text-center">번호</th>
							<th scope="col" class="text-center">분류코드</th>
							<th scope="col" class="text-center">분류코드명</th>
							<th scope="col" class="text-center">사용여부</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${(paginationInfo.totalRecordCount+1) - (searchCmmnClCodeVO.pageIndex-1) * searchCmmnClCodeVO.pageUnit - status.count}"/></td>
							<td class="text-center"><c:out value="${result.clCode}"/></td>
							<td><c:out value="${result.clCodeNm}"/></td>
							<td class="text-center"><c:out value="${result.useAt}"/></td>
							<td class="text-center">
								<a href="?act=write&amp;clCode=<c:out value='${result.clCode}'/>&amp;<c:out value='${searchCmmnClCodeVO.queryString}'/>" class="btn btn-default btn-xs"><spring:message code="common.update"/></a>
								<a href="javascript:post_delete('', 'act=delete&amp;clCode=<c:out value="${result.clCode}"/>');" class="btn btn-default btn-xs"><spring:message code="common.delete"/></a>							
							</td>		
						</tr>
					</c:forEach>
					<c:if test="${!empty resultList}">
						<tr>
							<td nowrap colspan="5" class="text-center"><spring:message code="info.nodata.msg"/></td>  
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
					<a href="?act=write&amp;<c:out value='${searchCmmnClCodeVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-md pd-r-md"><spring:message code="common.create"/></a>
				</div>								
			</div>
		</div>	
	</div>
</div>