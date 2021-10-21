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
				<h2>설문 목록</h2>
			</div>
			<div class="block-content">
				<form action="<c:url value='/cms/admin/survey.do'/>" method="post" class="form-inline" role="form">
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="searchCondition" id="searchCondition" class="form-control">
							<option value="title" <c:if test="${searchSurveyVO.searchCondition == 'title'}">selected="selected"</c:if>>타이틀</option>						
							</select> 
						</div>
						<div class="input-group">						
							<input type="text" name="searchKeyword" id="searchKeyword" class="form-control" value="<c:out value='${searchSurveyVO.searchKeyword}'/>"/>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search"/></button>
								<a href="<c:url value='/cms/admin/survey.do'/>" class="btn btn-default"><i class="fa fa-refresh"></i> <spring:message code="common.reset"/></a>
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
							<th scope="col" class="text-center">설문제목</th>
							<th scope="col" class="text-center">시작일/종료일</th>
							<th scope="col" class="text-center">공개여부</th>
							<th scope="col" class="text-center">중복투표여부</th>
							<th scope="col" class="text-center">결과공개여부</th>
							<th scope="col" class="text-center">사용여부</th>							
							<th scope="col" class="text-center">항목설정</th>
							<th scope="col" class="text-center">결과보기</th>
							<th scope="col" class="text-center">설문복사</th>
							<th scope="col" class="text-center">관리</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${paginationInfo.totalRecordCount - (searchSurveyVO.pageIndex-1) * searchSurveyVO.pageSize - status.index}"/></td>
							<td><c:out value="${result.title}"/></td>
							<td class="text-center"><c:out value="${result.bgnde}"/> ~ <c:out value="${result.endde}"/></td>
							<td class="text-center">
								<c:choose>
									<c:when test="${result.openYn == 'Y'}">공개</c:when>
									<c:otherwise>비공개</c:otherwise>
								</c:choose>
							</td>
							<td class="text-center">
								<c:choose>
									<c:when test="${result.dplctnYn == 'Y'}">허용</c:when>
									<c:otherwise>허용안함</c:otherwise>
								</c:choose>							
							</td>
							<td class="text-center">
								<c:choose>
									<c:when test="${result.resultOpenYn == 'Y'}">공개</c:when>
									<c:otherwise>비공개</c:otherwise>
								</c:choose>							
							</td>
							<td class="text-center">
								<c:choose>
									<c:when test="${result.useYn == 'Y'}">사용함</c:when>
									<c:otherwise>사용안함</c:otherwise>
								</c:choose>
							</td>
							<td class="text-center"><button class="btn btn-default btn-xs" onclick="window.open('?act=qlist&srvyId=<c:out value='${result.srvyId}'/>', 'qlist', 'width=900, height=1000, scrollbars=auto'); return false;">항목설정</button></td>
							<td class="text-center"><a href="?act=excel&amp;srvyId=<c:out value='${result.srvyId}'/>" class="btn btn-default btn-xs">엑셀다운</a></td>
							<td class="text-center"><button class="btn btn-default btn-xs" onclick="post_url('', 'act=copy&amp;srvyId=<c:out value="${result.srvyId}"/>', '정말로 복사하시겠습니까?');">설문복사</button></td>
							<td class="text-center">
								<a href="?act=write&amp;srvyId=<c:out value='${result.srvyId}'/>&amp;<c:out value='${searchSurveyVO.queryString}'/>" class="btn btn-default btn-xs"><spring:message code="common.update"/></a>
								<c:if test="${empty EMPLYR_INFO.adminSiteId}">
								<a href="javascript:post_delete('', 'act=delete&amp;srvyId=<c:out value="${result.srvyId}"/>');" class="btn btn-default btn-xs"><spring:message code="common.delete"/></a>
								</c:if>
							</td>		
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td colspan="11" class="text-center"><spring:message code="info.nodata.msg"/></td>  
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
					<a href="?act=write&amp;<c:out value='${searchSurveyVO.queryString}'/>" class="btn btn-primary btn-sm pd-l-lg pd-r-lg"><spring:message code="common.create"/></a>
					</c:if>
				</div>								
			</div>
		</div>	
	</div>
</div>