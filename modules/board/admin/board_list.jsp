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
				<h2>게시판 목록</h2>
			</div>
			<div class="block-content">
				<form action="<c:url value='/cms/admin/board.do'/>" method="post" class="form-inline" role="form">
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="siteId" id="siteId" class="form-control">
							<c:forEach var="result" items="${siteList}" varStatus="status">
							<option value="${result.siteId}" <c:if test="${searchBoardVO.siteId == result.siteId}">selected="selected"</c:if>><c:out value="${result.siteNm}" /></option>
							</c:forEach>
							</select>						
						</div>
						<div class="form-group">
							<select name="searchCondition" id="searchCondition" class="form-control">
							<option value="boardNm" <c:if test="${searchBoardVO.searchCondition == 'boardNm'}">selected="selected"</c:if>>게시판명</option>
							</select> 
						</div>
						<div class="input-group">						
							<input type="text" name="searchKeyword" id="searchKeyword" class="form-control" value="<c:out value='${searchBoardVO.searchKeyword}'/>"/>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search"/></button>
								<a href="board.do" class="btn btn-default"><i class="fa fa-refresh"></i> <spring:message code="common.reset"/></a>
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
							<th scope="col" class="text-center">사이트 ID</th>
							<th scope="col" class="text-center">게시판 아이디</th>
							<th scope="col" class="text-center">게시판명</th>
							<th scope="col" class="text-center">CSS</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${(paginationInfo.totalRecordCount+1) - (searchBoardVO.pageIndex-1) * searchBoardVO.pageUnit - status.count}"/></td>
							<td class="text-center"><c:out value="${result.siteId}"/></td>
							<td class="text-center"><a href="<c:url value='/${result.siteId}/board/${result.boardId}.do'/>" target="_blank"><c:out value="${result.boardId}"/></a></td>
							<td><c:out value="${result.boardNm}"/></td>
							<td class="text-center"><a href="?act=css&amp;boardId=<c:out value='${result.boardId}'/>">CSS관리</a></td>
							<td class="text-center">
								<a href="?act=write&amp;boardId=<c:out value='${result.boardId}'/>&amp;<c:out value='${searchBoardVO.queryString}'/>" class="btn btn-default btn-xs"><spring:message code="common.update"/></a>
								<a href="javascript:post_delete('', 'act=delete&amp;boardId=<c:out value="${result.boardId}"/>');" class="btn btn-default btn-xs"><spring:message code="common.delete"/></a>							
							</td>		
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
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
					<a href="?act=write&amp;<c:out value='${searchBoardVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-lg pd-r-lg"><spring:message code="common.create"/></a>
				</div>								
			</div>
		</div>	
	</div>
</div>