<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://egovframework.gov/ctl/ui" prefix="ui" %>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h2>게시글 목록</h2>
			</div>
			<div class="block-content">
				<form action="<c:url value='/cms/admin/board/article.do'/>" method="post" class="form-inline" role="form">
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="siteId" id="siteId" class="form-control">
							<option value="">+ 전체사이트</option>
							<c:forEach var="result" items="${siteList}" varStatus="status">
							<option value="${result.siteId}" <c:if test="${searchBoardArticleVO.siteId == result.siteId}">selected="selected"</c:if>><c:out value="${result.siteNm}" /></option>
							</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<select name="boardId" id="boardId" class="form-control">
							<option value="">+ 전체게시판</option>
							<c:forEach var="result" items="${boardList}" varStatus="status">
							<option value="${result.boardId}" <c:if test="${searchBoardArticleVO.boardId == result.boardId}">selected="selected"</c:if> class="${result.siteId}">[<c:out value="${result.siteId}" />] <c:out value="${result.boardNm}" /></option>
							</c:forEach>
							</select>						
						</div>						
						<div class="form-group">
							<select name="searchCondition" id="searchCondition" class="form-control">
							<option value="subject" <c:if test="${searchBoardArticleVO.searchCondition == 'subject'}">selected="selected"</c:if>>제목</option>
							<option value="content" <c:if test="${searchBoardArticleVO.searchCondition == 'content'}">selected="selected"</c:if>>내용</option>
							<option value="writerNm" <c:if test="${searchBoardArticleVO.searchCondition == 'writerNm'}">selected="selected"</c:if>>이름</option>
							<option value="writerId" <c:if test="${searchBoardArticleVO.searchCondition == 'writerId'}">selected="selected"</c:if>>아이디</option>
							<option value="frstRegistIp" <c:if test="${searchBoardArticleVO.searchCondition == 'frstRegistIp'}">selected="selected"</c:if>>아이피</option>
							</select> 
						</div>
						<div class="input-group">						
							<input type="text" name="searchKeyword" id="searchKeyword" class="form-control" value="<c:out value='${searchBoardArticleVO.searchKeyword}'/>"/>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search"/></button>
								<a href="<c:url value='/cms/admin/board/article.do'/>" class="btn btn-default"><i class="fa fa-refresh"></i> <spring:message code="common.reset"/></a>
							</span> 
						</div>						
					</fieldset>
				</form>
			</div>
			<div class="block-content">
				총 <c:out value="${resultCnt}"/>건
			</div>
			<form name="boardListForm" action="<c:url value='/cms/admin/board/article.do'/>" method="post" class="form-inline">
				<input type="hidden" name="act" value="" />
				<input type="hidden" name="memo" value="" />
				<input type="hidden" name="returnQueryString" value="<c:out value='${searchBoardArticleVO.queryString}' escapeXml='false' />" />
				<div class="block-content np">
					<table class="table">
						<colgroup>
							<col style="width:80px;" />
							<col style="width:80px;" />
							<col />
							<col style="width:200px;" />
							<col style="width:80px;" />
							<col style="width:200px;" />
							<col style="width:120px;" />
							<col style="width:120px;" />
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="text-center"><input type="checkbox" onclick="set_checkbox(this.form, 'chks', this.checked)" /></th>
								<th scope="col" class="text-center">번호</th>
								<th scope="col" class="text-center">제목</th>
								<th scope="col" class="text-center">이름</th>
								<th scope="col" class="text-center">조회</th>
								<th scope="col" class="text-center">등록일</th>
								<th scope="col" class="text-center">사이트아이디</th>
								<th scope="col" class="text-center">게시판</th>
							</tr>
						</thead>
						<tbody>	
						<c:forEach items="${resultList}" var="result" varStatus="status">
							<c:set var="iSecret" value="${result.secretAt == 'Y' ? true : false}"/>
							<c:set var="iReply" value="${result.depth > 0 ? true : false}"/>
							<c:set var="iAtchFile" value="${result.atchFileCnt > 0 ? true : false}"/>
							<c:set var="iNew" value="${boardVO.newIconPeriod > result.registDateDiff ? true : false}"/>						
							<tr>
								<td class="text-center"><input type="checkbox" name="chks" value="<c:out value='${result.articleId}'/>" /></td>
								<td class="text-center"><c:out value="${paginationInfo.totalRecordCount - (searchBoardArticleVO.pageIndex-1) * searchBoardArticleVO.pageSize - status.index}"/></td>
								<td>
									<c:if test="${iReply}"><span class="ireply depth<c:out value='${result.depth}'/>"><span class="txt">답변</span></span></c:if>
									<c:if test="${iSecret}"><span class="isecret"><span class="txt">비밀글</span></span></c:if>
									<a href="<c:url value='/cms/board/${result.boardId}.do'/>?act=read&amp;articleId=<c:out value='${result.articleId}'/>&amp;<c:out value='${searchBoardArticleVO.queryString}'/>" target="_blank" <c:if test="${result.deletedAt == 'Y'}">style="text-decoration:line-through;"</c:if>><c:out value="${result.subject}"/></a>
									<c:if test="${iNew}"><span class="inew"><span class="txt">새글</span></span></c:if>
								</td>
								<td class="text-center">
									<c:out value="${result.writerNm}"/>
									<c:if test="${not empty result.writerId}">
									(<c:out value="${result.writerId}"/>)
									</c:if>
								</td>
								<td class="text-center"><c:out value="${result.hits}"/></td>
								<td class="text-center"><c:out value="${result.frstRegistPnttm}"/></td>
								<td class="text-center"><c:out value="${result.siteId}"/></td>
								<td class="text-center"><c:out value="${result.boardNm}"/></td>
							</tr>
						</c:forEach>
						<c:if test="${fn:length(resultList) == 0}">
							<tr>
								<td colspan="8" class="text-center"><spring:message code="info.nodata.msg"/></td>  
							</tr>		 
						</c:if>	
						</tbody>					
					</table>
				</div>
				<div class="block-footer">
					<div class="text-center">
						<ul class="pagination pagination-sm">
						<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="${paginationQueryString}"/>
						</ul>
					</div>					
					<div class="bd-t mg-t-md pd-t-md">
						<div class="clearfix">
							<div class="input-group">
								<span class="mg-r-md"><strong>게시글 삭제</strong></span> 							
								<button type="button" class="btn btn-default" onclick="articleManager('delete');"><spring:message code="common.delete"/></button>
								<button type="button" class="btn btn-default" onclick="articleManager('deleteDatabase');"><spring:message code="common.deleteDatabase"/></button>
							</div>
						</div>
						<div class="clearfix mg-t-xs">
							<div class="input-group">
								<span class="mg-r-md"><strong>게시글 이동</strong></span> 
								<span class="input-group-btn">
									<select id="targetBoardId" name="targetBoardId" class="form-control">
									<c:forEach var="result" items="${boardList}" varStatus="status">
									<option value="${result.boardId}">[<c:out value="${result.siteId}" />] <c:out value="${result.boardNm}" /></option>
									</c:forEach>							
									</select>							
									<button type="button" class="btn btn-default" onclick="articleManager('move');">이동</button>
								</span>
							</div>
						</div>
						<div class="clearfix mg-t-xs">
							<div class="input-group">
								<span class="mg-r-md"><strong>게시글 복원</strong></span>
								<button type="button" class="btn btn-default" onclick="articleManager('restore');">복원</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>	
	</div>
</div>

<div class="modal" id="modal-delete" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">삭제하시겠습니까?</h4>
            </div>
            <div class="modal-body">
            	<div class="input-group">
            		<input type="text" name="deleteMemo" id="deleteMemo" class="form-control" value="" placeholder="삭제사유를 입력해 주세요." />
            		<span class="input-group-btn">
                	<button type="button" class="btn btn-primary" onclick="document.boardListForm.act.value='delete'; document.boardListForm.memo.value=$('#deleteMemo').val();  document.boardListForm.submit();"><spring:message code="common.delete"/></button>
                	</span>
                </div>
                <div class="help-block">
                	※ 삭제표시만 되며 실제 데이터베이스에서는 삭제되지 않습니다.
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>	                
            </div>
        </div>
    </div>
</div>

<div class="modal" id="modal-deleteDatabase" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title"><spring:message code="common.deleteDatabase.msg"/></h4>
            </div>
            <div class="modal-body">
                <button type="button" class="btn btn-primary" onclick="document.boardListForm.act.value='deleteDatabase'; document.boardListForm.submit();"><spring:message code="common.deleteDatabase"/></button>
                <div class="help-block">
                	※ 삭제시 복구되지 않습니다.
                </div>                
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>	                
            </div>
        </div>
    </div>
</div>

<div class="modal" id="modal-move" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">이동시키시겠습니까?</h4>
            </div>
            <div class="modal-body">
                <button type="button" class="btn btn-primary" onclick="document.boardListForm.act.value='move'; document.boardListForm.submit();"><spring:message code="common.confirm"/></button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>	                
            </div>
        </div>
    </div>
</div>

<div class="modal" id="modal-restore" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">복원하시겠습니까?</h4>
            </div>
            <div class="modal-body">
                <button type="button" class="btn btn-primary" onclick="document.boardListForm.act.value='restore'; document.boardListForm.submit();"><spring:message code="common.confirm"/></button>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>	                
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
//<![CDATA[
function articleManager(act) {
	if (!chk_checkbox(boardListForm, 'chks', true)) {
		alert('게시글을 선택해 주세요');
		return;
	}	
	
	$('#modal-'+act).modal();
}
//]]>
</script>