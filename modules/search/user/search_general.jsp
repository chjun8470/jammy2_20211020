<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%
	String requestURL = request.getRequestURL().toString();
	String serverName = requestURL.substring(requestURL.indexOf("://") + 3);
	serverName = serverName.substring(0, serverName.indexOf("/"));

	request.setAttribute("serverName", serverName);
%>

<div class="tab-type1">
	<ul class="nav nav-pills nav-justified">
	<li><span><a href="?query=<c:out value='${jmy:urlEncoder(queryString)}'/>">통합검색</a></span></li>
	<li<c:if test="${param.where eq 'MENU'}"> class="active"</c:if>><span><a href="?where=MENU&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">메뉴검색</a></span></li>
	<li><span><a href="?where=STAFF&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">직원업무</a></span></li>
	<li<c:if test="${param.where eq 'WEBDOC'}"> class="active"</c:if>><span><a href="?where=WEBDOC&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">웹문서</a></span></li>
	<li<c:if test="${param.where eq 'BBS'}"> class="active"</c:if>><span><a href="?where=BBS&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">게시판</a></span></li>
	<li<c:if test="${param.where eq 'FILE'}"> class="active"</c:if>><span><a href="?where=FILE&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">첨부파일</a></span></li>
	</ul>
</div>

<div class="search_con">
	<div class="search_result01">검색어 "<strong><span class="blue01"><c:out value='${queryString}'/></span></strong>" 로 검색한 결과 <span class="orange01"><c:out value='${total}'/></span>건의 검색결과가 있습니다.</div>


	<div class="search_result01">
		<ul>
		<c:forEach var="result" items="${resultList}" varStatus="status">
		<li>
			<a href="<c:out value="${result.url}" />"><c:out value="${result.title}" /></a>
			<span class="blank"><a href="<c:out value="${result.url}" />" target="_blank" title="새창"><img src="<c:out value='${CONTENT_PATH}/images/sub/search_blank_icon.gif'/>" alt="새창" /></a></span>
			<span class="s_url"><a href="<c:out value="${result.url}" />">http://<c:out value="${serverName}"/><c:out value="${result.url}" /></a></span>
			<c:if test="${param.where != 'MENU'}">
			<span class="s_con"><c:out value="${jmy:cutString(result.content, '...', 200)}" escapeXml="false" /></span>
			</c:if>
		</li>
		</c:forEach>
		</ul>
	</div>

	<div class="text-center">
		<ul class="pagination pagination-sm">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="where=${param.where}&query=${jmy:urlEncoder(queryString)}&"/>
		</ul>
	</div>
</div>