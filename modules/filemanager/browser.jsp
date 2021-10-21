<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="/modules/filemanager/uploadify/uploadify.css">

<div class="row">
	<div class="col-lg-12">
		<div class="alert alert-warning">
		    수정/삭제 등 작업시 백업되지 않으니 신중히 사용하시기 바랍니다.
		</div>
	</div>
</div>
<div class="row">
	<div class="col-lg-5">
		<div class="block">
			<div class="block-content">
				경로 : /<c:out value="${dir}" />
			</div>
			<div class="block-content np">				
				<table class="table">
					<thead>
						<tr>
							<th scope="col">파일명</th>
							<th scope="col">크기</th>
							<th scope="col">파일형식</th>
							<th scope="col">최종수정</th>
							<th scope="col">관리</th>
						</tr>
					</thead>
					<tbody>
					<c:if test="${not empty dir}">
						<tr>
							<td><a href="?dir=<c:out value='${parentDir}' /><c:out value='${defaultQueryString}' />">..</a></td>
						</tr>
					</c:if>
					<c:forEach var="result" items="${dirList}" varStatus="status">
						<tr>
							<td><a href="?dir=<c:out value='${dir}' />/<c:out value='${result.name}' /><c:out value='${defaultQueryString}' />"><c:out value="${result.name}" /></a></td>
							<td></td>
							<td>파일폴더</td>
							<td></td>
							<td>							
								<button type="button" class="btn btn-default" onclick="modal_rename('dir', '<c:out value="${result.name}"/>'); return false;">이름변경</button>
								<button type="button" class="btn btn-default" onclick="post_delete('', 'act=delete&amp;dir=<c:out value="${dir}"/>&amp;type=dir&amp;name=<c:out value="${result.name}"/><c:out value="${defaultQueryString}" />')">삭제</button>
							</td>
						</tr>
					</c:forEach>
					<c:forEach var="result" items="${fileList}" varStatus="status">
						<tr>
							<td><a href="?dir=<c:out value='${dir}' />&amp;fileNm=<c:out value='${result.name}' /><c:out value='${defaultQueryString}' />"><c:out value="${result.name}" /></a></td>
							<td><fmt:formatNumber type="pattern" pattern="###,###,###.#" value="${result.size/1024}" />KB</td>
							<td><c:out value="${result.fileExt}" /></td>
							<td><c:out value="${result.updtDate}" /></td>
							<td>
								<button type="button" class="btn btn-default" onclick="modal_rename('file', '<c:out value="${result.name}"/>'); return false;">이름변경</button>
								<button type="button" class="btn btn-default" onclick="post_delete('', 'act=delete&amp;dir=<c:out value="${dir}"/>&amp;type=file&amp;name=<c:out value="${result.name}"/><c:out value="${defaultQueryString}" />')">삭제</button>
							</td>							
						</tr>
					</c:forEach>	
					</tbody>
				</table>			
			</div>
			<div class="block-footer">
				<div class="pull-left">
					<input id="file_upload" name="file_upload" type="file" multiple="true">
				</div>
				<div class="pull-right">
					<a href="#" class="btn btn-default" onclick="modal_create('dir'); return false;">디렉토리 생성</a>
					<a href="#" class="btn btn-default" onclick="modal_create('file'); return false;">파일 생성</a>
				</div>
			</div>
		</div>
		<div class="block">
			<div id="queue"></div>			
		</div>		
	</div>
	<c:if test="${not empty fileInfo}">
	<div class="col-lg-7">
       <div class="block">
            <div class="block-head">
                <h2><span class="text-warning"><c:out value="${param.fileNm}" /> 속성</span></h2>
            </div>
            <div class="block-content">                    
                <p><strong>파일 : </strong> /<c:out value="${fileInfo.drctry}"/></p>
                <p><strong>형식 : </strong> <c:out value="${fileInfo.fileExt}"/></p>
                <p><strong>수정날짜 : </strong> <c:out value="${fileInfo.updtDate}"/></p>
                <p><strong>크기 : </strong> <fmt:formatNumber type="pattern" pattern="###,###,###.#" value="${fileInfo.size/1024}" />KB</p>
			</div>
		</div>   	
		<c:if test="${not empty fileSource}">
		<form action="?act=save<c:out value='${defaultQueryString}' />" method="post">
			<input type="hidden" name="dir" value="<c:out value='${param.dir}'/>" />
			<input type="hidden" name="fileNm" value="<c:out value='${param.fileNm}'/>" />
			<div class="block">
				<div class="block-content">
					<textarea name="fileSource" id="fileSource" style="width:100%; height:700px;">${fileSource}</textarea>
					<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/codemirror/codemirror.js'/>"></script>
					<script type="text/javascript">
					//<![CDATA[
					CodeMirror.fromTextArea(document.getElementById("fileSource"), {lineNumbers: true, mode: "htmlmixed"});
					//]]>
					</script>
				</div>
				<div class="block-footer">
					<button type="submit" class="btn btn-default">저장</button>
				</div>
			</div>
		</form>
		</c:if>
		<c:if test="${fileInfo.fileExt == 'gif' || fileInfo.fileExt == 'jpg' || fileInfo.fileExt == 'png'}">
		<div class="block">
			<div class="block-content">
				<img src="/<c:out value='${fileInfo.drctry}'/>" alt="" />
			</div>
		</div>
		</c:if>
	</div>
	</c:if>
</div>


<div class="modal" id="modal-rename" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
    	<form action="?act=rename<c:out value='${defaultQueryString}' />" method="post">
    		<input type="hidden" name="dir" value="${param.dir}" />
    		<input type="hidden" name="type" value="" />
    		<input type="hidden" name="origName" value="" />
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title">Modal title</h4>
	            </div>
	            <div class="modal-body">
	                <input type="text" name="newName" value="" />
	                <button type="submit" class="btn btn-primary">Save changes</button>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>	                
	            </div>
	        </div>
        </form>
    </div>
</div>

<div class="modal" id="modal-create" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
    	<form action="?act=create<c:out value='${defaultQueryString}' />" method="post">
    		<input type="hidden" name="dir" value="${param.dir}" />
    		<input type="hidden" name="type" value="" />
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title">Modal title</h4>
	            </div>
	            <div class="modal-body">
	                <input type="text" name="name" value="" />
	                <button type="submit" class="btn btn-primary">Save changes</button>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>	                
	            </div>
	        </div>
        </form>
    </div>
</div>

<script type="text/javascript" src="/modules/filemanager/uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
//<![CDATA[
function modal_create(type)
{
	$('#modal-create').find(".modal-title").text((type == "dir") ? "디렉토리 생성" : "파일 생성");
	$('#modal-create').find("input[name='type']").val(type);
	$('#modal-create').modal({show: true});
}

function modal_rename(type, name)
{
	$('#modal-rename').find(".modal-title").text((type == "dir") ? "디렉토리명 변경" : "파일명 변경");
	$('#modal-rename').find("input[name='type']").val(type);
	$('#modal-rename').find("input[name='origName']").val(name);
	$('#modal-rename').find("input[name='newName']").val(name);
	$('#modal-rename').modal({show: true});
}

$(function() {
	$('#file_upload').uploadify(
	{
		'swf'      : '/modules/filemanager/uploadify/uploadify.swf',
		'uploader' : '${requestScope["javax.servlet.forward.request_uri"]}?act=uploadify&dir=${param.dir}',
        'onQueueComplete' : function(queueData) 
        {
        	alert('upload complete');
        	document.location.reload();
        }
	});
});
//]]>
</script>
