<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt_rt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div class="row">
	<div class="col-lg-12">
		<div class="block">
			<ul class="nav nav-tabs">
				<li><a href="?act=hourly&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">시간대별</a></li>
			    <li class="active"><a href="#">일자별</a></li>
			    <li><a href="?act=weekly&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">요일별</a></li>
			    <li><a href="?act=monthly&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">월별</a></li>
			    <li><a href="?act=browser&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">브라우저별</a></li>
			    <li><a href="?act=os&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">OS별</a></li>
			    <li><a href="?act=page&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">페이지별</a></li>
			</ul>		
			<div class="block-content">
				<div class="pull-left">
					<form:form commandName="searchCounterDayVO" action="${pageContext.request.contextPath}/cms/admin/counter.do?act=daily" method="post" class="form-inline form-search" role="form">
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
							<div class="form-group">
								<form:input path="startDate" class="form-control datepicker" style="display:inlne-block; width:100px;" /> ~ 
								<form:input path="endDate" class="form-control datepicker" style="display:inlne-block; width:100px;" />
							</div>						
							<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search" /></button>
						</fieldset>
					</form:form>
				</div>
				<div class="pull-right">
					<a href="?act=daily&amp;mode=excel&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>&amp;device=<c:out value='${searchCounterDayVO.device}'/>&amp;startDate=<c:out value='${searchCounterDayVO.startDate}'/>&amp;endDate=<c:out value='${searchCounterDayVO.endDate}'/>" class="btn btn-primary">엑셀다운로드</a>
				</div>			
			</div>
			<div class="block-content np">	
				<table class="table">
					<colgroup>
						<col style="width:150px;" />
						<col />
						<col />
					</colgroup>				
					<thead>
						<tr>
							<th scope="col">일별</th>
							<th scope="col">페이지뷰</th>
							<th scope="col">방문자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultList}" varStatus="status">
						<fmt_rt:formatNumber var="percentHits" value="${result.hits == 0 ? 0 : (result.hits / sumHits * 100)}" maxFractionDigits="1" />
						<fmt_rt:formatNumber var="percentUniqHits" value="${result.uniqHits == 0 ? 0 : (result.uniqHits / sumUniqHits * 100)}" maxFractionDigits="1" />	
						<tr>
							<td>${result.countDe}</td>
							<td>
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${percentHits}" aria-valuemin="0" aria-valuemax="100" style="width:${percentHits}%"></div>
								</div>							
								페이지뷰 : <fmt_rt:formatNumber value="${result.hits}" groupingUsed="true" /> / ${percentHits}%
							</td>
							<td>
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${percentUniqHits}" aria-valuemin="0" aria-valuemax="100" style="width:${percentUniqHits}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uniqHits}" groupingUsed="true" /> / ${percentUniqHits}%
							</td>
						</tr>
						</c:forEach>
					</tbody>
					<tfoot>
						<tr>	
							<td>전체</td>
							<td><fmt_rt:formatNumber value="${sumHits}" groupingUsed="true" /></td>
							<td><fmt_rt:formatNumber value="${sumUniqHits}" groupingUsed="true" /></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>