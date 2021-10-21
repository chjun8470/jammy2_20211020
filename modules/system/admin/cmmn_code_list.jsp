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
			    <li><a href="<c:url value='/cms/admin/system/code/clcode.do' />">공통분류코드</a></li>
			    <li class="active"><a href="#">공통코드</a></li>
			    <li><a href="<c:url value='/cms/admin/system/code/detail.do' />">공통상세코드</a></li>
			</ul>
			<div class="block-head">
				<h2>공통코드 목록</h2>
			</div>
			<div class="block-content">
				<form action="<c:url value='/cms/admin/system/code/code.do'/>" method="post" class="form-inline" role="form">
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="clCode" id="clCode" class="form-control">
							<option value="">+ 공통분류코드</option>
							<c:forEach var="result" items="${cmmnClCodeList}" varStatus="status">
							<option value="${result.clCode}" <c:if test="${searchCmmnCodeVO.clCode == result.clCode}">selected="selected"</c:if>><c:out value="${result.clCodeNm}" /></option>
							</c:forEach>							
							</select> 
						</div>						
						<div class="form-group">
							<select name="searchCondition" id="searchCondition" class="form-control">
							<option value="codeId" <c:if test="${searchCmmnCodeVO.searchCondition == 'codeId'}">selected="selected"</c:if>>코드ID</option>
							<option value="codeIdNm" <c:if test="${searchCmmnCodeVO.searchCondition == 'codeIdNm'}">selected="selected"</c:if>>코드ID명</option>
							</select> 
						</div>
						<div class="input-group">						
							<input type="text" name="searchKeyword" id="searchKeyword" class="form-control" value="<c:out value='${searchCmmnCodeVO.searchKeyword}'/>"/>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search"/></button>
								<a href="<c:url value='/cms/admin/system/code/code.do'/>" class="btn btn-default"><i class="fa fa-refresh"></i> <spring:message code="common.reset"/></a>
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
							<th scope="col" class="text-center">분류명</th>
							<th scope="col" class="text-center">코드ID</th>
							<th scope="col" class="text-center">코드ID명</th>
							<th scope="col" class="text-center">사용여부</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${(paginationInfo.totalRecordCount+1) - (searchCmmnCodeVO.pageIndex-1) * searchCmmnCodeVO.pageUnit - status.count}"/></td>
							<td><c:out value="${result.clCodeNm}"/></td>
							<td class="text-center"><c:out value="${result.codeId}"/></td>
							<td class="text-center"><c:out value="${result.codeIdNm}"/></td>
							<td class="text-center"><c:out value="${result.useAt}"/></td>
							<td class="text-center">
								<a href="?act=write&amp;codeId=<c:out value='${result.codeId}'/>&amp;<c:out value='${searchCmmnCodeVO.queryString}'/>" class="btn btn-default btn-xs"><spring:message code="common.update"/></a>
								<a href="javascript:post_delete('', 'act=delete&amp;codeId=<c:out value="${result.codeId}"/>');" class="btn btn-default btn-xs"><spring:message code="common.delete"/></a>							
							</td>		
						</tr>
					</c:forEach>
					<c:if test="${!empty resultList}">
						<tr>
							<td nowrap colspan="6"><spring:message code="info.nodata.msg"/></td>  
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
					<a href="?act=write&amp;<c:out value='${searchCmmnCodeVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-md pd-r-md"><spring:message code="common.create"/></a>
				</div>								
			</div>
		</div>	
	</div>
</div>