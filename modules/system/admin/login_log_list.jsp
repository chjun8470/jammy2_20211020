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
				<h2>로그인 로그 목록</h2>
			</div>
			<div class="block-content">
				<form action="<c:url value='/cms/admin/system/loginlog.do'/>" method="post" class="form-inline" role="form">
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="success" id="success" class="form-control">
							<option value="">+ 선택</option>
							<option value="1" <c:if test="${searchLoginLogVO.success == '1'}">selected="selected"</c:if>>성공</option>
							<option value="0" <c:if test="${searchLoginLogVO.success == '0'}">selected="selected"</c:if>>실패</option>
							</select> 
						</div>
						<div class="form-group">
							<select name="searchCondition" id="searchCondition" class="form-control">
							<option value="userId" <c:if test="${searchLoginLogVO.searchCondition == 'userId'}">selected="selected"</c:if>>아이디</option>
							<option value="loginPnttm" <c:if test="${searchLoginLogVO.searchCondition == 'loginPnttm'}">selected="selected"</c:if>>로그인일시</option>
							<option value="loginIp" <c:if test="${searchLoginLogVO.searchCondition == 'loginIp'}">selected="selected"</c:if>>로그인IP</option>
							<option value="remarks" <c:if test="${searchLoginLogVO.searchCondition == 'remarks'}">selected="selected"</c:if>>비고</option>
							<option value="useragent" <c:if test="${searchLoginLogVO.searchCondition == 'useragent'}">selected="selected"</c:if>>브라우져</option>
							</select> 
						</div>
						<div class="input-group">						
							<input type="text" name="searchKeyword" id="searchKeyword" class="form-control" value="<c:out value='${searchLoginLogVO.searchKeyword}'/>"/>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search"/></button>
								<a href="<c:url value='/cms/admin/system/loginlog.do'/>" class="btn btn-default"><i class="fa fa-refresh"></i> <spring:message code="common.reset"/></a>
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
							<th scope="col" class="text-center">구분</th>
							<th scope="col" class="text-center">아이디</th>
							<th scope="col" class="text-center">로그인일시</th>
							<th scope="col" class="text-center">로그인IP</th>
							<th scope="col" class="text-center">비고</th>
							<th scope="col" class="text-center">브라우져</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultList}" varStatus="status">
						<tr>
							<td class="text-center"><c:out value="${(paginationInfo.totalRecordCount+1) - (searchLoginLogVO.pageIndex-1) * searchLoginLogVO.pageUnit - status.count}"/></td>
							<td class="text-center">
								<c:if test="${result.success == 0}"><span class="label label-danger">실패</span></c:if>
								<c:if test="${result.success == 1}"><span class="label label-info">성공</span></c:if>
							</td>
							<td class="text-center"><c:out value="${result.userId}" /></td>		
							<td class="text-center"><c:out value="${result.loginPnttm}" /></td>
							<td class="text-center"><c:out value="${result.loginIp}" /></td>
							<td class="text-center"><c:out value="${result.reason}" /></td>
							<td class="text-center"><c:out value="${result.useragent}" /></td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(resultList) == 0}">
						<tr>
							<td nowrap colspan="7"><spring:message code="info.nodata.msg"/></td>  
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
			</div>
		</div>	
	</div>
</div>