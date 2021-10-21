<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui"%>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h2>팝업 목록</h2>
			</div>
			<div class="block-content">
				<form action="<c:url value='/cms/admin/popup/${searchPopupVO.popupTy}.do'/>" method="post" class="form-inline" role="form">
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="searchSiteId" id="searchSiteId" class="form-control">
							<c:forEach var="result" items="${siteList}" varStatus="status">
							<option value="${result.siteId}" <c:if test="${searchPopupVO.searchSiteId == result.siteId}">selected="selected"</c:if>><c:out value="${result.siteNm}" /></option>
							</c:forEach>
							</select>						
						</div>
						<div class="form-group">
							<select name="device" id="device" class="form-control">
							<option value="">+ 디바이스 선택</option>
							<option value="ALL" <c:if test="${searchPopupVO.device == 'ALL'}">selected="selected"</c:if>>모두출력</option>
							<option value="PC" <c:if test="${searchPopupVO.device == 'PC'}">selected="selected"</c:if>>PC</option>
							<option value="MOBILE" <c:if test="${searchPopupVO.device == 'MOBILE'}">selected="selected"</c:if>>MOBILE</option>
							</select>						
						</div>						
						<div class="form-group">
							<select name="searchCondition" id="searchCondition" class="form-control">
							<option value="title" <c:if test="${searchPopupVO.searchCondition == 'title'}">selected="selected"</c:if>>제목</option>
							</select> 
						</div>
						<div class="input-group">						
							<input type="text" name="searchKeyword" id="searchKeyword" class="form-control" value="<c:out value='${searchPopupVO.searchKeyword}'/>"/>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search"/></button>
								<a href="<c:url value='/cms/admin/popup/${searchPopupVO.popupTy}.do'/>" class="btn btn-default"><i class="fa fa-refresh"></i> <spring:message code="common.reset"/></a>
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
							<th scope="col" class="text-center">디바이스</th>
							<th scope="col" class="text-center">제목</th>
							<th scope="col" class="text-center">시작일/종료일</th>
							<th scope="col" class="text-center">정렬순서</th>
							<th scope="col" class="text-center">사용여부</th>
							<th scope="col" class="text-center">등록일</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${(paginationInfo.totalRecordCount+1) - (searchPopupVO.pageIndex-1) * searchPopupVO.pageUnit - status.count}"/></td>
							<td class="text-center">
								<c:choose>
									<c:when test="${result.device == 'PC'}">PC</c:when>
									<c:when test="${result.device == 'MOBILE'}">MOBILE</c:when>
									<c:otherwise>모두출력</c:otherwise>
								</c:choose>
							</td>
							<td class="text-center"><c:out value="${result.title}"/></td>
							<td class="text-center"><c:out value="${result.startDt}"/> ~ <c:out value="${result.endDt}"/></td>
							<td class="text-center"><c:out value="${result.position}"/></td>
							<td class="text-center"><c:out value="${result.useAt}"/></td>
							<td class="text-center"><c:out value="${result.frstRegistPnttm}"/></td>
							<td class="text-center">
								<a href="?act=write&amp;popupId=<c:out value='${result.popupId}'/>&amp;<c:out value='${searchPopupVO.queryString}'/>" class="btn btn-default btn-xs"><spring:message code="common.update"/></a>
								<c:if test="${empty adminSiteId}">
								<a href="javascript:post_delete('', 'act=delete&amp;popupId=<c:out value="${result.popupId}"/>');" class="btn btn-default btn-xs"><spring:message code="common.delete"/></a>
								</c:if>							
							</td>		
						</tr>
					</c:forEach>
					<c:if test="${empty resultList}">
						<tr>
							<td colspan="8" class="text-center"><spring:message code="info.nodata.msg"/></td>  
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
					<c:if test="${empty adminSiteId}">
					<a href="?act=write&amp;<c:out value='${searchPopupVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-lg pd-r-lg"><spring:message code="common.create"/></a>
					</c:if>
				</div>								
			</div>
		</div>	
	</div>
</div>