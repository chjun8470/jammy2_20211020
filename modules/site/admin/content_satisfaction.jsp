<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt_rt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div class="row">
	<div class="col-lg-12">
		<div class="block">
			<div class="block-content">
				<div class="pull-left">
					<form:form commandName="searchSiteContentSatisfactionVO" action="${pageContext.request.contextPath}/cms/admin/site/content/satisfaction.do" method="post" class="form-inline form-search" role="form">
						<fieldset>
							<legend class="sr-only">검색 폼</legend>
							<div class="form-group">
								<form:select path="siteId" class="form-control">
								<form:option value="">+ 사이트선택</form:option>
								<c:forEach var="result" items="${siteList}" varStatus="status">
								<form:option value="${result.siteId}"><c:out value="${result.siteNm}" /></form:option>
								</c:forEach>
								</form:select>
							</div>
							<div class="form-group">
								<form:select path="device" class="form-control">
								<form:option value="PC">PC</form:option>
								<form:option value="MOBILE">MOBILE</form:option>
								</form:select>
							</div>
							<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search" /></button>
						</fieldset>
					</form:form>
				</div>
				<div class="pull-right">
					<a href="?mode=excel&amp;siteId=<c:out value='${searchCounterLogVO.siteId}'/>&amp;device=<c:out value='${searchCounterLogVO.device}'/>" class="btn btn-primary">엑셀다운로드</a>
				</div>				
			</div>
			<div class="block-content np">
				<table class="table">					
					<thead>
						<tr>
							<th scope="col" class="text-center">메뉴명</th>
							<th scope="col" class="text-center">매우만족</th>
							<th scope="col" class="text-center">만족</th>
							<th scope="col" class="text-center">보통</th>
							<th scope="col" class="text-center">불만</th>
							<th scope="col" class="text-center">매우불만</th>
							<th scope="col" class="text-center">의견보기</th>
							<th scope="col" class="text-center">전체참여자</th>
							<th scope="col" class="text-center">평균</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
						<fmt_rt:formatNumber var="stsfdg10percent" value="${result.stsfdg10Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg10Count * 100)}" maxFractionDigits="1" />
						<fmt_rt:formatNumber var="stsfdg8percent" value="${result.stsfdg8Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg8Count * 100)}" maxFractionDigits="1" />
						<fmt_rt:formatNumber var="stsfdg6percent" value="${result.stsfdg6Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg6Count * 100)}" maxFractionDigits="1" />
						<fmt_rt:formatNumber var="stsfdg4percent" value="${result.stsfdg4Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg4Count * 100)}" maxFractionDigits="1" />
						<fmt_rt:formatNumber var="stsfdg2percent" value="${result.stsfdg2Count == 0 ? 0 : (result.stsfdgTotal / result.stsfdg2Count * 100)}" maxFractionDigits="1" />
						<fmt_rt:formatNumber var="average" value="${(result.stsfdg10Count * 100 + result.stsfdg8Count * 80 + result.stsfdg6Count * 60 + result.stsfdg4Count * 40 + result.stsfdg2Count * 20) / result.stsfdgTotal}" maxFractionDigits="1" />
						<tr>
							<td><c:out value="${result.menuPath}"/></td>
							<td class="text-center">
								<c:out value="${result.stsfdg10Count}"/>명<br />
								[<c:out value="${stsfdg10percent}"/>%]
							</td>
							<td class="text-center">
								<c:out value="${result.stsfdg8Count}"/>명<br />
								[<c:out value="${stsfdg8percent}"/>%]
							</td>
							<td class="text-center">
								<c:out value="${result.stsfdg6Count}"/>명<br />
								[<c:out value="${stsfdg6percent}"/>%]
							</td>
							<td class="text-center">
								<c:out value="${result.stsfdg4Count}"/>명<br />
								[<c:out value="${stsfdg4percent}"/>%]
							</td>
							<td class="text-center">
								<c:out value="${result.stsfdg2Count}"/>명<br />
								[<c:out value="${stsfdg2percent}"/>%]
							</td>
							<td class="text-center">
								<button type="button" onclick="window.open('?act=comment&amp;siteId=<c:out value='${result.siteId}'/>&amp;device=<c:out value='${result.device}'/>&amp;menuId=<c:out value='${result.menuId}'/>', 'stsfg', 'width=700, height=800, scrollbars=auto'); return false;" class="btn btn-default btn-xs">의견보기</button>
							</td>
							<td class="text-center"><c:out value="${result.stsfdgTotal}"/>명</td>
							<td class="text-center"><c:out value="${average}"/>점</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>