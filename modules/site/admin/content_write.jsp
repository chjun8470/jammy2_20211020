<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="row">
	<div class="col-lg-2">
		<div class="block">
			<div class="block-content">
				<form action="<c:url value='/cms/admin/site/content.do' />" method="get" class="form-search" role="form">
					<fieldset>
						<legend class="sr-only">검색 폼</legend>
						<div class="form-group">
							<select name="siteId" id="siteId" class="form-control" onchange="this.form.submit();">
							<option value="">+ 사이트선택</option>
							<c:forEach var="result" items="${siteList}" varStatus="status">
							<option value="${result.siteId}" <c:if test="${searchSiteMenuVO.siteId == result.siteId}">selected="selected"</c:if>><c:out value="${result.siteNm}" /></option>
							</c:forEach>
							</select>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
		<div class="block">
			<ul class="nav nav-tabs nav-justified">
			    <li <c:if test="${searchSiteMenuVO.device == 'PC'}">class="active"</c:if>><a href="?siteId=<c:out value='${searchSiteMenuVO.siteId}'/>&amp;device=PC"><i class="fa fa-desktop"></i> PC</a></li>
			    <li <c:if test="${searchSiteMenuVO.device == 'MOBILE'}">class="active"</c:if>><a href="?siteId=<c:out value='${searchSiteMenuVO.siteId}'/>&amp;device=MOBILE"><i class="fa fa-mobile"></i> 모바일</a></li>
			</ul>
			<div class="block-content">
					<link rel="stylesheet" href="/core/js/dtree/dtree.css">
					<script type="text/javascript" src="/core/js/dtree/dtree.js"></script>
					<script type="text/javascript">
					//<![CDATA[
					var d = new dTree('d');
					d.add(1,-1,"메인", "?siteId=<c:out value='${searchSiteMenuVO.siteId}' />");
					<c:forEach var="result" items="${allSiteMenuList}" varStatus="status">
					<c:if test='${result.parntsMenuId > 0}'>
					d.add("<c:out value='${result.menuId}' />", "<c:out value='${result.parntsMenuId}' />", "<c:out value='${result.menuNm}' />", "?siteId=<c:out value='${result.siteId}' />&device=<c:out value='${result.device}' />&menuId=<c:out value='${result.menuId}' />", "", "", "");
					</c:if>
					</c:forEach>
					document.write(d);
					//]]>
					</script>
			</div>
		</div>
	</div>
	<div class="col-lg-10">
		<div class="block">
			<div class="block-head">
				<h2>컨텐츠관리</h2>
			</div>
			<div class="block-content">
				<c:choose>
					<c:when test="${siteMenuVO.menuTy == 'HTML'}">
						<form:form commandName="writeSiteContent" action="?act=write" class="form-horizontal" role="form">
							<input type="hidden" name="command" value="<c:out value='${command}'/>" />
							<input type="hidden" name="siteId" value="<c:out value='${searchSiteMenuVO.siteId}'/>" />
							<input type="hidden" name="device" value="<c:out value='${searchSiteMenuVO.device}'/>" />
							<input type="hidden" name="menuId" value="<c:out value='${searchSiteMenuVO.menuId}'/>" />
							<input type="hidden" name="contentId" value="<c:out value='${writeSiteContent.contentId}'/>" />
							<fieldset>
								<legend class="sr-only">컨텐츠 관리 폼</legend>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">상위메뉴</label></span>
									<div class="col-sm-10">
										<div class="form-control-static">
											홈
											<c:forEach var="result" items="${parntsSiteMenuList}" varStatus="status">
											&gt; <c:out value="${result.menuNm}" />
											</c:forEach>
										</div>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">메뉴명</label></span>
									<div class="col-sm-10">
										<p class="form-control-static"><c:out value="${siteMenuVO.menuNm}"/></p>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">마지막 파일변경</label></span>
									<div class="col-sm-10">
										<p class="form-control-static"><c:out value="${writeSiteContentFile.updtDate}"/></p>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">마지막 DB변경</label></span>
									<div class="col-sm-10">
										<p class="form-control-static"><c:out value="${writeSiteContent.lastUpdtPnttm}"/></p>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label for="bcontent" class="control-label">내용</label></span>
									<div class="col-sm-10">
										<form:textarea path="content" id="bcontent" class="form-control"/>
										<script type="text/javascript" src="<c:url value='/cms/ckeditor.do'/>"></script>
										<c:import url="/cms/ckeditor/config.do?id=bcontent" />
									</div>
								</div>
								<div class="bd-t md-t-md pd-t-md"></div>
								<div class="col-sm-offset-2 col-sm-10">
									<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								</div>
							</fieldset>
						</form:form>
					</c:when>
					<c:when test="${searchSiteMenuVO.menuId < 1 || siteMenuVO.menuTy == 'JSP'}">
						<form:form commandName="writeSiteContent" action="?act=write" class="form-horizontal" role="form">
							<input type="hidden" name="command" value="<c:out value='${command}'/>" />
							<input type="hidden" name="siteId" value="<c:out value='${searchSiteMenuVO.siteId}'/>" />
							<input type="hidden" name="device" value="<c:out value='${searchSiteMenuVO.device}'/>" />
							<input type="hidden" name="menuId" value="<c:out value='${searchSiteMenuVO.menuId}'/>" />
							<input type="hidden" name="contentId" value="<c:out value='${writeSiteContent.contentId}'/>" />
							<fieldset>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">마지막 파일변경</label></span>
									<div class="col-sm-10">
										<p class="form-control-static">
											<c:out value="${writeSiteContentFile.updtDate}"/>
										</p>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">마지막 DB변경</label></span>
									<div class="col-sm-10">
										<p class="form-control-static">
											<c:out value="${writeSiteContent.lastUpdtPnttm}"/>
										</p>
									</div>
								</div>
								<c:if test="${siteMenuVO.menuTy == 'JSP'}">
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">연동</label></span>
										<div class="col-sm-10">
											<p class="form-control-static">
												<span onclick="boardInsert()" class="btn btn-default">게시판 IMPORT</span>&nbsp;
												&nbsp;&nbsp;&nbsp;
												<span onclick="moduleInsert()" class="btn btn-default">모듈 IMPORT</span>
											</p>
										</div>

										<div id="importBox" style="display:none;">

											<span class="col-sm-2 text-right"><label class="control-label">샘플소스</label></span>
											<div class="col-sm-10">
												<textarea id="importText" style="width:700px;height:300px;" ></textarea>
												<div style="color:#ff0000;">※ 소스를 복사해서 사용해주세요</div>
											</div>
										</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">상위메뉴</label></span>
									<div class="col-sm-10">
										<p class="form-control-static">
											홈
											<c:forEach var="result" items="${parntsSiteMenuList}" varStatus="status">
											&gt; <c:out value="${result.menuNm}" />
											</c:forEach>
										</p>
									</div>
								</div>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">메뉴명</label></span>
									<div class="col-sm-10">
										<p class="form-control-static">
											<c:out value="${siteMenuVO.menuNm}"/>
											<a href="<c:url value='/${siteMenuVO.siteId}/menu/${siteMenuVO.menuId}.do'/>?device=${siteMenuVO.device}" target="_blank" class="btn btn-default">미리보기</a>
										</p>
									</div>
								</div>
								</c:if>
								<div class="form-group">
									<span class="col-sm-2 text-right"><label class="control-label">내용</label></span>
									<div class="col-sm-10">
										<form:textarea path="content" id="bcontent" class="form-control"/>
										<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/codemirror/codemirror.js'/>"></script>
										<script type="text/javascript">
										//<![CDATA[
										var myCodeMirror = CodeMirror.fromTextArea(document.getElementById("bcontent"), {lineNumbers: true, mode: "jsp"});
										myCodeMirror.setSize("100%", "500");
										//]]>
										</script>
									</div>
								</div>
								<div class="bd-t md-t-md pd-t-md"></div>
								<div class="col-sm-offset-2 col-sm-10">
<!-- 									<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button> -->
								</div>
							</fieldset>
						</form:form>
					</c:when>
					<c:otherwise>
						컨텐츠 메뉴타입(HTML 및 JSP)만 편집가능합니다.
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<c:if test="${searchSiteMenuVO.menuId < 1 || siteMenuVO.menuTy == 'HTML' || siteMenuVO.menuTy == 'JSP'}">
		<div class="block">
			<div class="block-head">
				<h2>버전관리</h2>
			</div>
			<div class="block-content">
				<form name="restoreForm" action="?act=restore" method="post">
					<input type="hidden" name="siteId" value="<c:out value='${searchSiteMenuVO.siteId}'/>" />
					<input type="hidden" name="device" value="<c:out value='${searchSiteMenuVO.device}'/>" />
					<input type="hidden" name="menuId" value="<c:out value='${searchSiteMenuVO.menuId}'/>" />
					<input type="hidden" name="contentId" value="<c:out value='${writeSiteContent.contentId}'/>" />
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
							
							<td></td>
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
			</c:if>
		</div>
	</div>
</div>


<%


%>
<script type="text/javascript">
//<![CDATA[

	var siteId = '<c:out value="${searchSiteMenuVO.siteId}"/>';

	function boardInsert(){

		var inHtml = '';
		inHtml += '<'+'%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%'+'>\r\n';
		inHtml += '<'+'%@ page import="info.elsys.jnsp.util.ComUtil"%'+'>\r\n';
		inHtml += '<'+'%@ page import="info.elsys.jnsp.util.CriptUtil"%'+'>\r\n';
		inHtml += '<'+'% \r\n';
		inHtml += '\trequest.setCharacterEncoding("UTF-8");\r\n';
		inHtml += '\tComUtil util = new ComUtil();\r\n';
		inHtml += '\tCriptUtil ctuil = new CriptUtil();\r\n';

		inHtml += '\tHashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");\r\n';
		inHtml += '\tString mode = util.getStr(request.getParameter(("mode"));\r\n';
		inHtml += '\tString listMode = util.getStr(request.getParameter(("listMode"));\r\n';
		inHtml += '\tString nowPage = util.getStr(request.getParameter(("nowPage"),"0");\r\n';
		inHtml += '\tString searchType = util.getStr(request.getParameter(("searchType"));\r\n';
		inHtml += '\tString searchWord = util.getStr(request.getParameter(("searchWord"));\r\n';
		inHtml += '\tString boardIdx = util.getStr(request.getParameter(("boardIdx"));\r\n';
		inHtml += '\tString m = util.getStr(request.getParameter(("m"));\r\n';
		inHtml += '\tString boardComIdx = "00001";//코드를 입력하세요\r\n';

		inHtml += '%'+'>\r\n';

		inHtml += '<'+'jsp:include page="/web/comBoard.do" flush="true">\r\n';

		inHtml += '\t<'+'jsp:param name="mode" value="<'+'%='+'mode'+'%'+'>"/>\r\n';
		inHtml += '\t<'+'jsp:param name="listMode" value="<'+'%='+'listMode'+'%'+'>"/>\r\n';

		inHtml += '\t<'+'jsp:param name="nowPage" value="<'+'%='+'nowPage'+'%'+'>"/>\r\n';
		inHtml += '\t<'+'jsp:param name="searchType" value="<'+'%='+'searchType'+'%'+'>"/>\r\n';
		inHtml += '\t<'+'jsp:param name="searchWord" value="<'+'%'+'='+'searchWord'+'%'+'>"/>\r\n';
		inHtml += '\t<'+'jsp:param name="boardIdx" value="<'+'%='+'boardIdx'+'%'+'>"/>\r\n';
		inHtml += '\t<'+'jsp:param name="m" value="<'+'%='+'m'+'%'+'>"/>\r\n';
		inHtml += '\t<'+'jsp:param name="boardComIdx" value="<'+'%='+'boardComIdx'+'%'+'>"/>\r\n';
		inHtml += '<'+'/jsp:include>\r\n';

		$('#importText').val(inHtml);
		$('#importBox').show();
	}

	function moduleInsert(){
		var inHtml = '';
		inHtml += '<'+'%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%'+'>\r\n';
		inHtml += '<'+'%@ page import="info.elsys.jnsp.util.ComUtil"%'+'>\r\n';
		inHtml += '<'+'%@ page import="info.elsys.jnsp.util.CriptUtil"%'+'>\r\n';
		inHtml += '<'+'% \r\n';
		inHtml += '\trequest.setCharacterEncoding("UTF-8");\r\n';
		inHtml += '\tComUtil util = new ComUtil();\r\n';
		inHtml += '\tCriptUtil ctuil = new CriptUtil();\r\n';

		inHtml += '\tHashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");\r\n';
		inHtml += '\tString mode = util.getStr(request.getParameter(("mode"));\r\n';
		inHtml += '\tString m = util.getStr(request.getParameter(("m"));\r\n';
		inHtml += '\tString nowPage = util.getStr(request.getParameter(("nowPage"),"0");//추가적으로 파라미터 를 추가해준다\r\n';

		inHtml += '%'+'>\r\n';
		inHtml += '\t<'+'jsp:include page="/web/{모듈컨트롤명을 입력하세요}.do" flush="true">\r\n';
		inHtml += '\t<'+'jsp:param name="mode" value="<'+'%='+'mode'+'%'+'>"/>\r\n';
		inHtml += '\t<'+'jsp:param name="m" value="<'+'%='+'m'+'%'+'>"/>\r\n';
		inHtml += '\t<'+'jsp:param name="nowPage" value="<'+'%='+'nowPage'+'%'+'>"/>\r\n';
		inHtml += '</'+'jsp:include>\r\n';
		$('#importText').val(inHtml);
		$('#importBox').show();
	}
//]]>
</script>