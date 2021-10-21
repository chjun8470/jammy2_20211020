<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovProperties" %>
<%@ page import="egovframework.jammy2.cmm.service.EgovDateUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt_rt" uri="http://java.sun.com/jstl/fmt_rt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div class="page-toolbar">
    <div class="page-toolbar-block">
        <div class="page-toolbar-title">Dashboard</div>
    </div>
</div>

<div class="row-fluid">
	<div class="col-md-12">
		<div class="block">
			<div class="block-content">
				<h2>
					<%=EgovDateUtil.getToday().substring(0,4)%>년
					<%=EgovDateUtil.getToday().substring(4,6)%>월
					<%=EgovDateUtil.getToday().substring(6,8)%>일
					
					<c:out value='${LOGIN_INFO.name}'/>(<c:out value='${LOGIN_INFO.id}'/>)님 환영합니다.
				</h2>
			</div>
		</div>
	</div>
	<div class="col-md-8">
		<div class="block">
        	<div class="block-head">
            	<h2>접속통계 (<c:out value="${siteInfo.siteNm}"/>)</h2>
				<ul class="buttons">
                	<li><a href="<c:url value='/cms/admin/counter.do'/>"><span class="fa fa-plus"></span></a></li>
				</ul>            	
			</div>
			<div class="block-content">
				<table class="table">
					<colgroup>
						<col style="width:150px;" />
						<col />
						<col />
					</colgroup>				
					<thead>
						<tr>
							<th scope="col">월별</th>
							<th scope="col">페이지뷰</th>
							<th scope="col">방문자</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="result" items="${resultCounterList}" varStatus="status">
						<fmt_rt:formatNumber var="percentHits" value="${counterSumHits == 0 ? 0 : (result.hits / counterSumHits * 100)}" maxFractionDigits="1" />
						<fmt_rt:formatNumber var="percentUniqHits" value="${counterSumUniqHits == 0 ? 0 : (result.uniqHits / counterSumUniqHits * 100)}" maxFractionDigits="1" />						
						<tr>
							<td>${result.countDe}</td>
							<td>
								<div class="progress progress-small no-margin mg-b-sm">
									<div class="progress-bar progress-bar-primary" role="progressbar" aria-valuenow="${percentHits}" aria-valuemin="0" aria-valuemax="100" style="width:${percentHits}%"></div>
								</div>							
								페이지뷰 : <fmt_rt:formatNumber value="${result.hits}" groupingUsed="true" /> / ${percentHits}%
							</td>
							<td>
								<div class="progress progress-small no-margin mg-b-sm">
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
							<td><fmt_rt:formatNumber value="${counterSumHits}" groupingUsed="true" /></td>
							<td><fmt_rt:formatNumber value="${counterSumUniqHits}" groupingUsed="true" /></td>
						</tr>
					</tfoot>					
				</table>
			</div>
		</div>
	</div>
	<div class="col-md-4">
<%
long free  = Runtime.getRuntime().freeMemory();
long total = Runtime.getRuntime().totalMemory();
long max   = Runtime.getRuntime().maxMemory();
long totalMB = (total/1024)/1024;
long useMB = (total - free)/1024/1024;
%>		
		<div class="block">
        	<div class="block-head">
            	<h2>Info</h2>
			</div>
			<div class="block-content">
				<dl class="dl-horizontal">
					<dt>WAS</dt>
					<dd><%=EgovProperties.getProperty("Globals.WAS")%></dd>
					<dt>JDK</dt>
					<dd><%=System.getProperty("java.version")%></dd>				
					<dt>DB</dt>
					<dd><%=EgovProperties.getProperty("Globals.DbType")%></dd>
					<dt>CMS Ver</dt>
					<dd><%=EgovProperties.getProperty("Globals.CMSVer")%></dd>					
					<dt>Memory</dt>
					<dd>Total : <%=totalMB%>MB / Use : <%=useMB%>MB</dd>
				 </dl>			
			</div>
		</div>
		<div class="block">
        	<div class="block-head">
            	<h2>최근 로그인정보</h2>
				<ul class="buttons">
                	<li><a href="<c:url value='/cms/admin/system/loginlog.do'/>"><span class="fa fa-plus"></span></a></li>
				</ul>             	
			</div>
			<div class="block-content">
				<table class="table table-bordered table-striped">
					<thead>
						<tr>
							<th scope="col">구분</th>
							<th scope="col">아이디</th>
							<th scope="col">로그인일시</th>
							<th scope="col">로그인IP</th>
							<th scope="col">비고</th>
							<th scope="col">브라우져</th>
						</tr>
					</thead>
					<tbody>	
					<c:forEach var="result" items="${resultLoginLogList}" varStatus="status">
						<tr>
							<td>
								<c:if test="${result.success == 0}"><span class="label label-danger">실패</span></c:if>
								<c:if test="${result.success == 1}"><span class="label label-info">성공</span></c:if>
							</td>
							<td><c:out value="${result.userId}" /></td>		
							<td><c:out value="${result.loginPnttm}" /></td>
							<td><c:out value="${result.loginIp}" /></td>
							<td><c:out value="${result.reason}" /></td>
							<td><c:out value="${result.useragent}" /></td>
						</tr>
					</c:forEach>
					<c:if test="${!empty resultLoginLogList}" >
						<tr>
							<td nowrap colspan="6"><spring:message code="info.nodata.msg"/></td>  
						</tr>		 
					</c:if>	
					</tbody>					
				</table>		
			</div>
		</div>
	</div>
</div>