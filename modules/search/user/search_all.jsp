<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String requestURL = request.getRequestURL().toString();
	String serverName = requestURL.substring(requestURL.indexOf("://") + 3);
	serverName = serverName.substring(0, serverName.indexOf("/"));

	request.setAttribute("serverName", serverName);
%>

<div class="tab-type1">
	<ul class="nav nav-pills nav-justified">
	<li class="active"><span><a href="?query=<c:out value='${jmy:urlEncoder(queryString)}'/>">통합검색</a></span></li>
	<li><span><a href="?where=MENU&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">메뉴검색</a></span></li>
	<li><span><a href="?where=STAFF&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">직원업무</a></span></li>
	<li><span><a href="?where=WEBDOC&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">웹문서</a></span></li>
	<li><span><a href="?where=BBS&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">게시판</a></span></li>
	<li><span><a href="?where=FILE&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">첨부파일</a></span></li>
	</ul>
</div>
<div class="search_con">
	<div class="search_result01">검색어 "<strong><span class="blue01"><c:out value='${queryString}'/></span></strong>" 로 검색한 결과 <span class="orange01"><c:out value='${total}'/></span>건의 검색결과가 있습니다.</div>
	
	<div class="search_result01">
	<h4>메뉴검색<span class="orange01">(<c:out value="${resultCnt.MENU}"/>건)</span></h4>
	<c:if test="${resultCnt.MENU > 0}">

		<ul>
		<c:forEach var="result" items="${resultList.MENU}" varStatus="status">
		<li>
			<a href="<c:out value="${result.url}" />"><c:out value="${result.title}" /></a>
			<span class="blank"><a href="<c:out value="${result.url}" />" target="_blank" title="새창"><img src="<c:out value='${CONTENT_PATH}/images/sub/search_blank_icon.gif'/>" alt="새창" /></a></span>
		</li>
		</c:forEach>
		</ul>
	</c:if>
	</div>

	<div class="search_result01">
	<h4>직원업무<span class="orange01">(<c:out value="${resultStaffCnt}"/>)</span></h4>
	<c:if test="${fn:length(resultStaffList) > 0}">
		<div class="orgnzt-staff">	
			<c:forEach var="result" items="${resultStaffList}" varStatus="status">
			<div class="staff-item">
				<ul>	
					<li class="none">	
						<div class="clearfix">
							<div class="col-sm-6 item-left">
								<div class="photo">
									<img src="<c:url value='/${result.photoFileNm}'/>" width="60" alt="<c:out value="${result.name}"/> 사진" />
								</div>
								<dl>
									<dt>성명</dt>
									<dd>
										<c:out value="${result.name}"/>
									</dd>
									<dt>E-mail</dt>
									<dd><c:out value="${result.email}"/></dd>
									<dt>Tel</dt>
									<dd><c:out value="${result.telNo}"/></dd>
								</dl>
							</div>
							<div class="col-sm-6 item-right" style="line-height:220%;">
								<span class="black01">부서</span> : <c:out value="${result.orgnztPath}"/><br />
								<span class="black01">담당업무</span> : <c:out value="${result.asgnedArea}"/>
							</div>
						</div>
					</li>
				</ul>
			</div>
			</c:forEach>
		</div>
	</c:if>
	</div>

	<div class="search_result01">
	<h4>웹문서<span class="orange01">(<c:out value="${resultCnt.WEBDOC}"/>건)</span></h4>
	<c:if test="${resultCnt.WEBDOC > 0}">
		<ul>
		<c:forEach var="result" items="${resultList.WEBDOC}" varStatus="status">
		<li>
			<a href="<c:out value="${result.url}" />"><c:out value="${result.title}" /></a>
			<span class="blank"><a href="<c:out value="${result.url}" />" target="_blank" title="새창"><img src="<c:out value='${CONTENT_PATH}/images/sub/search_blank_icon.gif'/>" alt="새창" /></a></span>
			<span class="s_url"><a href="<c:out value="${result.url}" />">http://<c:out value="${serverName}"/><c:out value="${result.url}" /></a></span>
			<span class="s_con"><c:out value="${jmy:cutString(result.content, '...', 200)}" escapeXml="false" /></span>
		</li>
		</c:forEach>
		</ul>
	</c:if>
	</div>

	<div class="search_result01">
	<h4>게시판<span class="orange01">(<c:out value="${resultCnt.BBS}"/>건)</span></h4>
	<c:if test="${resultCnt.BBS > 0}">
		<ul>
		<c:forEach var="result" items="${resultList.BBS}" varStatus="status">
		<li>
			<a href="<c:out value="${result.url}" />"><c:out value="${result.title}" /></a>
			<span class="blank"><a href="<c:out value="${result.url}" />" target="_blank" title="새창"><img src="<c:out value='${CONTENT_PATH}/images/sub/search_blank_icon.gif'/>" alt="새창" /></a></span>
			<span class="s_url"><a href="<c:out value="${result.url}" />">http://<c:out value="${serverName}"/><c:out value="${result.url}" /></a></span>
			<span class="s_con"><c:out value="${jmy:cutString(result.content, '...', 200)}" escapeXml="false" /></span>
		</li>
		</c:forEach>
		</ul>
	</c:if>
	</div>

	<div class="search_result01">
	<h4>첨부파일<span class="orange01">(<c:out value="${resultCnt.FILE}"/>건)</span></h4>
	<c:if test="${resultCnt.FILE > 0}">
		<ul>
		<c:forEach var="result" items="${resultList.FILE}" varStatus="status">
		<li>
			<a href="<c:out value="${result.url}" />"><c:out value="${result.title}" /></a>
			<span class="blank"><a href="<c:out value="${result.url}" />" target="_blank" title="새창"><img src="<c:out value='${CONTENT_PATH}/images/sub/search_blank_icon.gif'/>" alt="새창" /></a></span>
			<span class="s_url"><a href="<c:out value="${result.url}" />">http://<c:out value="${serverName}"/><c:out value="${result.url}" /></a></span>
			<span class="s_con"><c:out value="${jmy:cutString(result.content, '...', 200)}" escapeXml="false" /></span>
		</li>
		</c:forEach>
		</ul>
	</c:if>
	</div>
</div>