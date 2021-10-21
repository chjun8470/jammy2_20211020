<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>

<div class="row">
	<div class="col-lg-12">
		<div class="block">
			<div class="block-content">
				<form method="get" class="form-inline">
					<input type="hidden" name="fileGb" value="<c:out value='${searchThemeFileVO.fileGb}'/>" />
					<fieldset>
						<legend class="sr-only">테마선택 폼</legend>
						<div class="input-group">
							<select name="themeId" class="form-control">
							<c:forEach var="result" items="${themeList}" varStatus="status">
							<option value="<c:out value='${result.themeId}'/>" <c:if test="${searchThemeFileVO.themeId == result.themeId}">selected="selected"</c:if>><c:out value="${result.themeNm}"/></option>
							</c:forEach>			
							</select>
							<span class="input-group-btn">
								<button type="submit" class="btn btn-default"><i class="fa fa-search"></i> <spring:message code="common.search" /></button>
							</span>							
						</div>				
						<div class="input-group">
							<a href="?page=info" class="btn btn-default"><i class="fa fa-plus"></i> 테마등록</a>
						</div>
					</fieldset>
				</form>			
			</div>
		</div>	
		<div class="block">
			<ul class="nav nav-tabs">
			    <li<c:if test="${searchThemeFileVO.fileGb == 'LAYOUT'}"> class="active"</c:if>><a href="?themeId=<c:out value='${searchThemeFileVO.themeId}'/>">레이아웃</a></li>
			    <li<c:if test="${searchThemeFileVO.fileGb == 'INCLUDE'}"> class="active"</c:if>><a href="?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&amp;fileGb=include">INCLUDE</a></li>
			    <li<c:if test="${searchThemeFileVO.fileGb == 'CSS'}"> class="active"</c:if>><a href="?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&amp;fileGb=css">CSS</a></li>
			    <li<c:if test="${searchThemeFileVO.fileGb == 'JS'}"> class="active"</c:if>><a href="?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&amp;fileGb=js">JS</a></li>
			    <li<c:if test="${searchThemeFileVO.fileGb == 'FILE'}"> class="active"</c:if>><a href="?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&amp;fileGb=file">FILE</a></li>
			    <li><a href="?themeId=<c:out value='${searchThemeFileVO.themeId}'/>&amp;page=info">테마정보</a></li>
			</ul>
		</div>
	</div>
	<c:choose>
		<c:when test="${not empty themeVO && searchThemeFileVO.fileGb == 'file'}">
			<div class="col-lg-12">
				<div class="block">
					<c:import url="/cms/admin/filemanager.do" />
				</div>
			</div>
		</c:when>
		<c:otherwise>	
			<div class="col-lg-2">
				<div class="block">
					<div class="block-content">
						<ul class="list-group">
						<c:forEach var="result" items="${themeFileList}" varStatus="status">
						<li class="list-group-item">ㆍ<a href="?themeId=<c:out value='${result.themeId}'/>&amp;fileGb=<c:out value='${result.fileGb}'/>&amp;fileNm=<c:out value='${result.fileNm}'/>"><c:out value="${result.fileDc}"/></a></li>
						</c:forEach>
						</ul>
						<div class="bd-t mg-t-sm pd-t-sm"></div>
						<div class="text-center">
							<a href="?themeId=<c:out value='${param.themeId}'/>&amp;fileGb=<c:out value='${param.fileGb}'/>" class="btn btn-default btn-xs"><i class="fa fa-plus"></i> 추가</a>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-10">
				<div class="block">
					<div class="block-head">
						<h1>파일 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
					</div>
					<div class="block-content">								
						<form:form commandName="writeThemeFileVO" action="/cms/admin/theme.do" class="form-horizontal" role="form">
							<input type="hidden" name="act" value="write" />
							<input type="hidden" name="command" value="<c:out value='${command}' />" />
							<input type="hidden" name="themeId" value="<c:out value='${searchThemeFileVO.themeId}'/>" />
							<input type="hidden" name="fileGb" value="<c:out value='${searchThemeFileVO.fileGb}'/>" />
							<c:if test="${command == 'update'}">
							<input type="hidden" name="fileNm" value="<c:out value='${searchThemeFileVO.fileNm}'/>" />
							</c:if>
							<form:hidden path="fileId"/>
							<fieldset>
								<legend class="sr-only">파일관리폼</legend>
								<c:if test="${command == 'update'}">
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">마지막 파일 변경</label></span>
									<div class="col-sm-10">
										<p class="form-control-static"><c:out value="${writeThemeReailFileInfo.updtDate}"/></p>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">마지막 DB 변경</label></span>
									<div class="col-sm-10">
										<p class="form-control-static"><!-- c:out value="${fn:substring(writeThemeFileVO.lastUpdtPnttm, 0, 19)}"/--></p>
									</div>
								</div>
								</c:if>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="fileNm" class="control-label">* 파일명</label></span>
									<div class="col-sm-10">
										<c:choose>
											<c:when test="${command == 'insert'}">
												<form:input path="fileNm" class="form-control required" />
											</c:when>
											<c:otherwise>
												<form:input path="fileNm" class="form-control" disabled="true" />
											</c:otherwise>
										</c:choose>							
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="fileDc" class="control-label">* 파일설명</label></span>
									<div class="col-sm-10">
										<form:input path="fileDc" class="form-control required"/>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="position" class="control-label">* 순서</label></span>
									<div class="col-sm-10">
										<form:input path="position" maxlength="3" class="form-control required digits"/>
									</div>
								</div>						
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="fileDs" class="control-label">* 소스</label></span>
									<div class="col-sm-10">
										<form:textarea path="fileDs" class="form-control"/>
									</div>
								</div>
								<div class="bd-t mg-t-md pd-t-md"></div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">
										<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
										<c:if test="${command == 'update'}">
										<button type="button" class="btn btn-default pd-l-lg pd-r-lg" onclick="post_delete('', 'act=delete&themeId=<c:out value="${writeThemeFileVO.themeId}"/>&fileGb=<c:out value="${writeThemeFileVO.fileGb}"/>&fileNm=<c:out value="${writeThemeFileVO.fileNm}"/>');"><spring:message code="common.delete"/></a>
										</c:if>								
									</div>
								</div>
							</fieldset>
						</form:form>								
					</div>
				</div>
				<c:if test="${command == 'update'}">
				<div class="block">
					<div class="block-head">
						<h1>버전관리</h1>
					</div>
					<div class="block-content">				
						<form name="restoreForm" action="?act=restore" method="post">
							<input type="hidden" name="themeId" value="<c:out value='${writeThemeFileVO.themeId}'/>" />
							<input type="hidden" name="fileGb" value="<c:out value='${writeThemeFileVO.fileGb}'/>" />
							<input type="hidden" name="fileNm" value="<c:out value='${writeThemeFileVO.fileNm}'/>" />
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
				</c:if>
			</div>
		</c:otherwise>		
	</c:choose>	
</div>

<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/codemirror/codemirror.js'/>"></script>
<script type="text/javascript">
//<![CDATA[
var editor = CodeMirror.fromTextArea(document.getElementById("fileDs"), 
{
	lineNumbers: true,
	mode: "htmlmixed"
});

$(function()
{	
	$("#writeThemeFileVO").validate();	
});
//]]>
</script>
