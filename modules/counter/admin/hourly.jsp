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
				<li class="active"><a href="#">시간대별</a></li>
			    <li><a href="?act=daily&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">일자별</a></li>
			    <li><a href="?act=weekly&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">요일별</a></li>
			    <li><a href="?act=monthly&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">월별</a></li>
			    <li><a href="?act=browser&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">브라우저별</a></li>
			    <li><a href="?act=os&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">OS별</a></li>
			    <li><a href="?act=page&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>">페이지별</a></li>
			</ul>
			<div class="block-content">
				<div class="pull-left">
					<form:form commandName="searchCounterDayVO" action="${pageContext.request.contextPath}/cms/admin/counter.do?act=hourly" method="post" class="form-inline form-search" role="form">
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
					<a href="?act=houly&amp;mode=excel&amp;siteId=<c:out value='${searchCounterDayVO.siteId}'/>&amp;device=<c:out value='${searchCounterDayVO.device}'/>&amp;startDate=<c:out value='${searchCounterDayVO.startDate}'/>&amp;endDate=<c:out value='${searchCounterDayVO.endDate}'/>" class="btn btn-primary">엑셀다운로드</a>
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
							<th scope="col">시간별</th>
							<th scope="col">페이지뷰</th>
							<th scope="col">방문자</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>00:00 ~ 01:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh0 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh0}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh0 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh0}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>01:00 ~ 02:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh1 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh1}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh1 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh1}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>02:00 ~ 03:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh2 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh2}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh2 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh2}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>03:00 ~ 04:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh3 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh3}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh3 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh3}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>04:00 ~ 05:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh4 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh4}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh4 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh4}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>05:00 ~ 06:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh5 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh5}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh5 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh5}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>06:00 ~ 07:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh6 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh6}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh6 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh6}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>07:00 ~ 08:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh7 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh7}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh7 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh7}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>08:00 ~ 09:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh8 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh8}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh8 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh8}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>09:00 ~ 10:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh9 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh9}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh9 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh9}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>10:00 ~ 11:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh10 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh10}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh10 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh10}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>11:00 ~ 12:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh11 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh11}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh11 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh11}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>12:00 ~ 13:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh12 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh12}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh12 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh12}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>13:00 ~ 14:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh13 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh13}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh13 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh13}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>14:00 ~ 15:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh14 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh14}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh14 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh14}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>15:00 ~ 16:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh15 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh15}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh15 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh15}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>16:00 ~ 17:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh16 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh16}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh16 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh16}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>17:00 ~ 18:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh17 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh17}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh17 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh17}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>18:00 ~ 19:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh18 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh18}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh18 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh18}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>19:00 ~ 20:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh19 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh19}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh19 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh19}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>20:00 ~ 21:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh20 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh20}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh20 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh20}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>21:00 ~ 22:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh21 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh21}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh22 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh21}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>22:00 ~ 23:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh22 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh22}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh22 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh22}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
						<tr>
							<td>23:00 ~ 24:00</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.hits == 0 ? 0 : (result.hh23 / result.hits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								페이지뷰 : <fmt_rt:formatNumber value="${result.hh23}" groupingUsed="true" /> / ${countPer}% 
							</td>
							<td>
								<fmt_rt:formatNumber var="countPer" value="${result.uniqHits == 0 ? 0 : (result.uhh23 / result.uniqHits * 100)}" maxFractionDigits="1" />								
								<div class="progress progress-small no-radius no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${countPer}" aria-valuemin="0" aria-valuemax="100" style="width:${countPer}%"></div>
								</div>
								방문자 : <fmt_rt:formatNumber value="${result.uhh23}" groupingUsed="true" /> / ${countPer}%
							</td>
						</tr>
					</tbody>
					<tfoot>
						<tr>	
							<td>전체</td>
							<td><fmt_rt:formatNumber value="${result.hits}" groupingUsed="true" /></td>
							<td><fmt_rt:formatNumber value="${result.uniqHits}" groupingUsed="true" /></td>
						</tr>
					</tfoot>
				</table>
			</div>
		</div>
	</div>
</div>