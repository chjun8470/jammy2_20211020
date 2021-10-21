<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h2><c:out value="${boardVO.boardNm}" /> CSS 정보</h2>
			</div>			
			<div class="block-content">
			<form action="?act=css" method="post" class="form-horizontal" role="form">
				<input type="hidden" name="boardId" value="${boardVO.boardId}"/>
				<fieldset>
					<legend class="sr-only">CSS 수정 폼</legend>
					<div class="form-group">
						<span class="col-sm-2">
							마지막 파일변경
						</span>
						<div class="col-sm-10">
							${fileInfo.name}<br />
							${fileInfo.drctry}<br />
							${fn:substring(fileInfo.updtDate,0,19)}
						</div>
					</div>

					<div class="form-group">
						<span class="col-sm-2">
							마지막 DB변경
						</span>
						<div class="col-sm-10">
							${fn:substring(boardVO.cssUpdtPnttm,0,19)}
						</div>
					</div>

					<div class="form-group">
						<div class="col-sm-12">
							<textarea name="css" id="css"><c:out value="${boardVO.css}" escapeXml="false"/></textarea>
							<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/codemirror/codemirror.js'/>"></script>
							<script type="text/javascript">
							//<![CDATA[
							var editor = CodeMirror.fromTextArea(document.getElementById("css"), 
							{
								lineNumbers: true,
								mode: "css"
							});
							//]]>
							</script>
						</div>
					</div>		
					<div class="form-group mg-t-md">
						<div class="col-sm-offset-2 col-sm-10">
							<button type="submit" class="btn btn-primary"><i class="fa fa-pencil"></i> <spring:message code="common.save" /></button>
							<a href="?<c:out value='${searchBoardVO.queryString}' />" class="btn btn-default"><i class="fa fa-list"></i> <spring:message code="common.reset" /></a>
						</div>
					</div>
				</fieldset>
			</form>					
		</div>
			<form name="restoreForm" action="?act=restoreCss" method="post">
				<input type="hidden" name="boardId" value="${boardVO.boardId}"/>
				<input type="hidden" name="sourceId" value="" />
				<table class="table" id="versionControl">
					<thead>
					<tr>
						<th scope="col">버전</th>
						<th scope="col">아이디</th>
						<th scope="col">등록일</th>
						<th scope="col">복원일</th>
						<th scope="col">복원아이디</th>
						<th scope="col">소스보기</th>
						<th scope="col">복원</th>
					</tr>
					</thead>
					<tbody>
					<c:forEach var="result" items="${sourceVersionList}" varStatus="status">
					<tr>
						<td><c:out value='${fn:length(sourceVersionList) - status.index}'/>.0</td>
						<td><c:out value='${result.frstRegisterId}'/></td>
						<td><c:out value='${result.frstRegistPnttm}'/></td>
						<td><c:out value='${result.rstreUpdtPnttm}'/></td>
						<td><c:out value='${result.rstreUpdusrId}'/></td>
						<td><button type="button" class="btn btn-default" onclick="sourcePreview('<c:out value="${result.sourceId}"/>');">소스보기</button></td>
						<td><button type="button" class="btn btn-default" onclick="if(confirm('정말로 복원하시겠습니까?')){ sourceRestore('<c:out value="${result.sourceId}"/>'); }">복원</button></td>
					</tr>
					</c:forEach>
					</tbody>
				</table>
			</form>			
			<script type="text/javascript" src="<c:url value='/cms/admin/system/source/restorejs.do?tblId=versionControl&formNm=restoreForm'/>"></script>
	</div>
</div>