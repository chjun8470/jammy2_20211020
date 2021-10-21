<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>

<div class="tab-type1">
	<ul class="nav nav-pills nav-justified">
	<li><span><a href="?query=<c:out value='${jmy:urlEncoder(queryString)}'/>">통합검색</a></span></li>
	<li><span><a href="?where=MENU&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">메뉴검색</a></span></li>
	<li class="active"><span><a href="?where=STAFF&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">직원업무</a></span></li>
	<li><span><a href="?where=WEBDOC&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">웹문서</a></span></li>
	<li><span><a href="?where=BBS&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">게시판</a></span></li>
	<li><span><a href="?where=FILE&amp;query=<c:out value='${jmy:urlEncoder(queryString)}'/>">첨부파일</a></span></li>
	</ul>
</div>

<div class="search_con">
	<div class="search_result01">검색어 "<strong><span class="blue01"><c:out value='${queryString}'/></span></strong>" 로 검색한 결과 <span class="orange01"><c:out value='${total}'/></span>건의 검색결과가 있습니다.</div>

	<div class="orgnzt-staff">
			<c:forEach var="result" items="${resultList}" varStatus="status">
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

	<div class="text-center">
		<ul class="pagination pagination-sm">
		<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${paginationQueryString}"/>
		</ul>
	</div>
</div>