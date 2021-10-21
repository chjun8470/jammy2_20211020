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
				<div class="pull-left">
					<h2>캘린더 목록</h2>
				</div>
				<div class="pull-right">
					<div class="mg-t-xs mg-r-xs">
					<a href="?act=write&amp;<c:out value='${searchScheduleInfoVO.queryString}'/>" class="btn btn-primary btn-sm"><i class="fa fa-pencil"></i> <spring:message code="common.create"/></a>
					</div>
				</div>
			</div>
			<div class="block-content">
				<div id="calendar"></div>
			</div>
		</div>	
	</div>
</div>