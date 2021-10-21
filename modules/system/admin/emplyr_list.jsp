<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div class="row">
	<div class="col-lg-12">
		<div class="block">
			<div class="block-head">
				<h2>관리자 목록</h2>
			</div>
			<div class="block-content np">
				<table class="table">
					<thead>
						<tr>
							<th scope="col" class="text-center">번호</th>
							<th scope="col" class="text-center">이름</th>
							<th scope="col" class="text-center">아이디</th>
							<th scope="col" class="text-center">등급</th>
							<th scope="col" class="text-center">그룹</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${(paginationInfo.totalRecordCount+1) - (searchEmplyrVO.pageIndex-1) * searchEmplyrVO.pageUnit - status.count}"/></td>
							<td class="text-center"><c:out value="${result.emplyrId}" /></td>
							<td class="text-center"><c:out value="${result.userNm}" /></td>
							<td class="text-center"><c:out value="${result.levelNm}" /></td>
							<td class="text-center"><c:out value="${result.groupNm}" /></td>
							<td class="text-center">
								<a href="?act=write&amp;emplyrId=<c:out value='${result.emplyrId}'/>&amp;<c:out value='${searchEmplyrVO.queryString}'/>" class="btn btn-default btn-xs">수정</a>
								<%--<a href="javascript:post_delete('', 'act=delete&emplyrId=<c:out value="${result.emplyrId}"/>');" class="btn btn-default btn-xs">삭제</a> --%>							
							</td>		
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
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
				<%--
				<div class="pull-right">
					<a href="?act=write&amp;<c:out value='${searchEmplyrVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-md pd-r-md"><spring:message code="common.create"/></a>
				</div>
				 --%>								
			</div>
		</div>	
	</div>
</div>