<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="row">
	<div class="col-lg-5">
		<div class="block">
			<div class="block-content">
				경로 : <c:out value="${dir}" />
			</div>
			<div class="block-content np">				
				<table class="table">
					<thead>
						<tr>
							<th scope="col">파일명</th>
							<th scope="col">크기</th>
							<th scope="col">파일유형</th>
							<th scope="col">최종수정</th>
							<th scope="col">권한</th>
							<th scope="col">소유자/그룹</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${not empty dir}">
						<tr>
							<td><a href="?dir=<c:out value='${parentDir}' />">..</a></td>
						</tr>
					</c:if>
					<c:forEach var="result" items="${dirList}" varStatus="status">
						<tr>
							<td><a href="?dir=<c:out value='${dir}' />/<c:out value='${result.name}' />"><c:out value="${result.name}" /></a></td>
							<td>파일폴더</td>
							<td></td>
							<td></td>
						</tr>
					</c:forEach>
					<c:forEach var="result" items="${fileList}" varStatus="status">
						<tr>
							<td><a href="?dir=<c:out value='${dir}' />&amp;fileNm=<c:out value='${result.name}' />"><c:out value="${result.name}" /></a></td>
							<td><c:out value="${result.size}" />KB</td>
							<td></td>
							<td><c:out value="${result.updtDate}" /></td>
						</tr>
					</c:forEach>	
					</tbody>
				</table>			
			</div>
			<div class="block-content np">
			파일업로드 영역
			</div>
		</div>
	</div>
	<div class="col-lg-7">
		<div class="block">
			<div class="block-content">
				<textarea name="fileSource" id="fileSource" style="width:100%; height:700px;">${fileSource}</textarea>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript" src="<c:out value='${layoutPath}/js/plugins/codemirror/codemirror.js' />"></script>
<script type="text/javascript">
//<![CDATA[
var editor = CodeMirror.fromTextArea(document.getElementById("fileSource"), 
{
	lineNumbers: true,
	mode: "htmlmixed"
});
//]]>
</script>
