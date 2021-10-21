<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="/WEB-INF/taglib/jmy.tld" prefix="jmy" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>
<%@ page import="egovframework.jammy2.board.service.BoardVO" %>
<%
	BoardVO boardVO = (BoardVO)request.getAttribute("boardVO");
	String configFile = String.format("config_%s.jsp", boardVO.getBoardTy());
%>
<jsp:include page="<%=configFile%>" flush="true" />

<c:if test="${boardVO.useCategoryAt == 'Y'}">
	<a href="?act=list">전체</a>
	<c:forEach var="result" items="${boardCategory}" varStatus="status">
	<a href="?categoryNm=<c:out value='${jmy:urlEncoder(result)}'/>"><c:out value="${result}"/></a>
	</c:forEach>
</c:if>

<div class="board">
	<div class="list-head">
	</div>
	<div class="list-content">
		<form name="boardListForm" action="<c:url value='/cms/board/${boardVO.boardId}.do'/>" method="post">
		<input type="hidden" name="act" value="" />
		<div class="table-responsive">
			<table class="table list-table">
				<colgroup>
					<c:if test="${isBoardAdmin}">
					<col style="width:60px;"/>
					</c:if>
					<col style="width:80px;"/>
					<c:if test="${boardVO.useCategoryAt == 'Y'}">
					<col style="width:100px;"/>
					</c:if>
					<col />				
					<col style="width:100px;"/>
					<col style="width:120px;"/>
					<col style="width:75px;"/>
					<col style="width:90px;"/>
				</colgroup>
				<thead>
					<tr>
						<c:if test="${isBoardAdmin}">
						<th scope="col"><input type="checkbox" onclick="set_checkbox(this.form, 'chks', this.checked)" /></th>
						</c:if>
						<th scope="col"><spring:message code="common.no"/></th>
						<c:if test="${boardVO.useCategoryAt == 'Y'}">
						<th scope="col">분류</th>
						</c:if>
						<th scope="col"><spring:message code="common.subject"/></th>
						<th scope="col"><spring:message code="common.writer"/></th>
						<th scope="col"><spring:message code="common.writeDate"/></th>
						<th scope="col"><spring:message code="common.atch"/></th>
						<th scope="col"><spring:message code="common.hit"/></th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${resultList}" var="result" varStatus="status">
					<c:set var="iSecret" value="${result.secretAt == 'Y' ? true : false}"/>
					<c:set var="iNotice" value="${result.noticeAt == 'Y' ? true : false}"/>
					<c:set var="iReply" value="${result.depth > 0 ? true : false}"/>
					<c:set var="iAtchFile" value="${result.atchFileCnt > 0 ? true : false}"/>
					<c:set var="iNew" value="${boardVO.newIconPeriod > result.registDateDiff ? true : false}"/>
					<tr>
						<c:if test="${isBoardAdmin}">
						<td><input type="checkbox" name="chks" value="<c:out value='${result.articleId}'/>" /></td>
						</c:if>
						<td>
							<c:choose>
								<c:when test="${iNotice}">
									<span class="inotice"><span class="txt">공지</span></span>
								</c:when>
								<c:otherwise>
									<c:out value="${(paginationInfo.totalRecordCount+1) - (searchBoardArticleVO.pageIndex-1) * searchBoardArticleVO.pageUnit - status.count}"/>
								</c:otherwise>
							</c:choose>
						</td>
						<c:if test="${boardVO.useCategoryAt == 'Y'}">
						<td><c:out value="${result.categoryNm}"/></td>
						</c:if>
						<td class="subject">
							<c:if test="${iReply}"><span class="ireply depth<c:out value='${result.depth}'/>"><span class="txt">답변</span></span></c:if>
							<c:if test="${iSecret}"><span class="isecret"><span class="txt">비밀글</span></span></c:if>
							<a href="?act=read&amp;articleId=<c:out value="${result.articleId}"/>&amp;<c:out value="${boardSearchQueryString}"/>" <c:if test="${result.deletedAt == 'Y'}">style="color:#ddd;"</c:if>>
							<c:choose>
								<c:when test="${!isBoardAdmin && result.deletedAt == 'Y'}">
								삭제된 글입니다.
								</c:when>
								<c:otherwise>
								<c:out value="${result.subject}"/>
								</c:otherwise>
							</c:choose>
							</a>
							<c:if test="${iNew}"><span class="inew"><span class="txt">새글</span></span></c:if>					
						<td><c:out value="${result.writerNm}"/></td>
						<td><c:out value="${fn:substring(result.frstRegistPnttm,0,10)}" /></td>
						<td><c:if test="${result.atchFileCnt > 0}">첨부</c:if></td>
						<td><c:out value="${result.hits}"/></td>
					</tr>
				</c:forEach>
				<c:if test="${fn:length(resultList) == 0}">
					<tr>
						<td colspan="7"><spring:message code="info.nodata.msg"/></td>
					</tr>		 
				</c:if>	
				</tbody>					
			</table>
		</div>
		</form>
	</div>
	<div class="list-footer">
		<div class="clearfix">
			<div class="pull-left">
				<c:if test="${isBoardAdmin}">
				<button type="button" class="btn btn-default btn-sm" onclick="board_manager(); return false;">게시글 관리</button>
				</c:if>
			</div>
			<div class="pull-right">
				<c:if test="${writeAuthor}">
				<a href="?act=write&amp;<c:out value='${boardSearchQueryString}'/>" class="btn btn-primary btn-sm"><i class="fa fa-pencil"></i> <spring:message code="button.create"/></a>
				</c:if>			
			</div>
		</div>
		<div class="text-center">
			<ul class="pagination pagination-sm">
			<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${paginationQueryString}"/>
			</ul>
		</div>
		<div class="text-center">			
			<form action="?act=list" method="post" class="form-inline" role="form">
				<input type="hidden" name="categoryNm" value="<c:out value='${param.categoryNm}'/>" />
				<fieldset>
					<legend class="sr-only">검색 폼</legend>
					<div class="form-group">
						<label for="searchCondition" class="sr-only">검색방법선택</label>
						<select name="searchCondition" id="searchCondition" class="form-control input-sm">
						<option value="subject" <c:if test="${param.searchCondition == 'subject'}">selected="selected"</c:if>><spring:message code="common.subject"/></option>
						<option value="content" <c:if test="${param.searchCondition == 'content'}">selected="selected"</c:if>><spring:message code="common.content"/></option>
						<option value="writerNm" <c:if test="${param.searchCondition == 'writerNm'}">selected="selected"</c:if>><spring:message code="common.name"/></option>
						<option value="writerId" <c:if test="${param.searchCondition == 'writerId'}">selected="selected"</c:if>><spring:message code="common.userId"/></option>
						</select>
					</div>
					<div class="input-group">
						<label for="searchKeyword" class="sr-only">검색어</label>
						<input type="text" name="searchKeyword" id="searchKeyword" class="form-control input-sm" value="<c:out value='${param.searchKeyword}'/>"/>
						<span class="input-group-btn">
							<button type="submit" class="btn btn-default btn-sm mgt0"><spring:message code="common.search"/></button>
						</span>
					</div>					
				</fieldset>
			</form>		
		</div>
	</div>
</div>