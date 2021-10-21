<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>


				<form action="<c:out value='${BASE_URL}'/>/survey.do" method="post" class="form-inline" role="form">
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
							</span> 
						</div>						
					</fieldset>
				</form>

				<table class="table">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">설문기간</th>
							<th scope="col">진행상태</th>
							<th scope="col">참여인원</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td><c:out value="${paginationInfo.totalRecordCount - (searchSurveyVO.pageIndex-1) * searchSurveyVO.pageSize - status.index}"/></td>
							<td><a href="?act=view&amp;srvyId=<c:out value='${result.srvyId}'/>&amp;<c:out value='${searchSurveyVO.queryString}'/>"><c:out value="${result.title}"/></a></td>
							<td><c:out value="${result.bgnde}"/> ~ <c:out value="${result.endde}"/></td>
							<td>
								<c:choose>
									<c:when test="${result.progress == 'ING'}">진행</c:when>
									<c:when test="${result.progress == 'PRE'}">중비중</c:when>
									<c:otherwise>종료</c:otherwise>
								</c:choose>
							</td>	
							<td><c:out value='${result.voteCnt}'/>명</td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td nowrap colspan="6"><spring:message code="info.nodata.msg"/></td>  
						</tr>		 
					</c:if>	
					</tbody>					
				</table>

			<ul class="pagination pagination-sm">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${paginationQueryString}"/>
			</ul>