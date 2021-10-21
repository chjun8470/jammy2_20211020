<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<div class="row">
	<div class="col-lg-2">
		<div class="block">
			<div class="block-content">
				<form action="<c:url value='/cms/admin/site/menu.do' />" method="get" class="form-search" role="form">
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
					d.add(<c:out value="${rootMenuId}"/>,-1,"홈", "?siteId=<c:out value='${searchSiteMenuVO.siteId}' />");
					<c:forEach var="result" items="${allSiteMenuList}" varStatus="status">
					<c:if test='${result.parntsMenuId > 0}'>
					d.add(<c:out value='${result.menuId}' />, <c:out value='${result.parntsMenuId}' />, "<c:out value='${result.menuNm}' />", "?siteId=<c:out value='${result.siteId}' />&device=<c:out value='${result.device}' />&menuId=<c:out value='${result.menuId}' />", "", "", "");
					</c:if>
					</c:forEach>
					document.write(d);
					//]]>
					</script>
			</div>
			<div class="block-footer">					
				<a href="?act=move&amp;siteId=<c:out value='${writeSiteMenu.siteId}' />&amp;device=<c:out value='${writeSiteMenu.device}' />" class="btn btn-default"><i class="fa fa-arrows"></i> 메뉴이동</a>
				<button type="button" class="btn btn-default" onclick="post_url('', 'act=distribute&siteId=<c:out value='${writeSiteMenu.siteId}' />&device=<c:out value='${writeSiteMenu.device}' />&menuId=<c:out value='${writeSiteMenu.menuId}' />', '배포하시겠습니까?'); return false;"><i class="fa fa-cloud-download"></i> 배포</button>
			</div>
		</div>
	</div>
	<div class="col-lg-10">	
		<div class="block">
			<div class="block-head">
				<c:choose>
					<c:when test="${searchSiteMenuVO.parntsMenuId > 0}"><h1>서브메뉴 만들기</h1></c:when>				
					<c:when test="${searchSiteMenuVO.menuId > 0}"><h1>메뉴 등록정보</h1></c:when>
					<c:otherwise><h1>최상위메뉴 만들기</h1></c:otherwise>
				</c:choose>
			</div>
			<div class="block-content">				
				<form:form commandName="writeSiteMenu" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}'/>" />
					<input type="hidden" name="siteId" value="<c:out value='${searchSiteMenuVO.siteId}'/>" />
					<input type="hidden" name="device" value="<c:out value='${searchSiteMenuVO.device}'/>" />					
					<input type="hidden" name="menuId" value="<c:out value='${searchSiteMenuVO.menuId}'/>"/>
					<input type="hidden" name="parntsMenuId" value="<c:out value='${searchSiteMenuVO.parntsMenuId}'/>"/>					
					<fieldset>
						<legend class="sr-only">메뉴관리</legend>
						<c:if test="${searchSiteMenuVO.menuId > 0 || searchSiteMenuVO.parntsMenuId > 0}">
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
						</c:if>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="menuNm" class="control-label">* 메뉴명</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:input path="menuNm" class="form-control required" />
										<div class="help-block">
											복수의 메뉴를 한번에 등록하시려면 메뉴명을 콤마(,)로 구분해 주세요. 보기)회사소개,커뮤니티,고객센터								
										</div>										
									</c:when>
									<c:otherwise>
										<div class="input-group">
											<form:input path="menuNm" class="form-control" />
											<c:if test="${writeSiteMenu.menuId > 0}">
											<span class="input-group-btn"><a href="?siteId=<c:out value='${writeSiteMenu.siteId}' />&amp;device=<c:out value='${writeSiteMenu.device}' />&amp;parntsMenuId=<c:out value='${writeSiteMenu.menuId}' />" class="btn btn-default btn-sm"><i class="fa fa-plus"></i> 하위메뉴등록</a></span>
											</c:if>										
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="themeId" class="control-label">* 레이아웃</label></span>
							<div class="col-sm-10">
								<form:select path="themeId" class="form-control required">
								<form:option value="">+ 테마 선택</form:option>
								<c:forEach var="result" items="${themeList}" varStatus="status">
								<form:option value="${result.themeId}"><c:out value="${result.themeNm}" /></form:option>
								</c:forEach>
								</form:select>							
								<form:select path="layout" class="form-control required mg-t-xs">
								<form:option value="">+ 레이아웃 선택</form:option>
								<c:forEach var="result" items="${themeFileList}" varStatus="status">
								<c:if test="${result.themeId == writeSiteMenu.themeId}">
								<form:option value="${result.fileNm}"><c:out value="${result.fileDc}" /></form:option>
								</c:if>
								</c:forEach>
								</form:select>
								<label class="checkbox-inline"><input type="checkbox" name="updateChldrnsLayout" value="Y" />하위메뉴 일괄 적용</label>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">* 메뉴타입</label></span>
							<div class="col-sm-10">
								<label class="radio-inline"><form:radiobutton path="menuTy" value="HTML" />HTML</label>
								<label class="radio-inline"><form:radiobutton path="menuTy" value="JSP" />JSP</label>
								<%--
								<label class="radio-inline"><form:radiobutton path="menuTy" value="MENU_LINK" />메뉴연결</label>
								<label class="radio-inline"><form:radiobutton path="menuTy" value="BOARD" />게시판연결</label>
								<label class="radio-inline"><form:radiobutton path="menuTy" value="PROGRAM" />프로그램연결</label>
								 --%>								
								<label class="radio-inline"><form:radiobutton path="menuTy" value="LINK_IN" />내부링크</label>
								<label class="radio-inline"><form:radiobutton path="menuTy" value="LINK_OUT" />외부링크</label>
								
								<div id="linkMenuLayer" class="menuTyLayer">
									<div class="input-group mg-t-sm">
										<span class="input-group-addon">메뉴URL</span>
										<form:select path="linkMenuId" class="form-control required">
										<c:forEach var="result" items="${treeSiteMenuList}" varStatus="status">
										<form:option value="${result.menuId}"><c:out value="${result.menuNm}" /></form:option>
										</c:forEach>								
										</form:select>
									</div>
								</div>
								
								<div id="linkBoardLayer" class="menuTyLayer">
									<div class="mg-t-sm">
										<form:select path="linkBoardId" class="form-control required">
										<form:option value="">+ 선택</form:option>
										<c:forEach var="result" items="${boardList}" varStatus="status">
										<form:option value="${result.boardId}"><c:out value="${result.boardNm}" /></form:option>
										</c:forEach>								
										</form:select>
										<form:input path="linkUrl" id="linkBoardUrl" class="form-control mg-t-xs" />
									</div>
								</div>

								<div id="programUrlLayer" class="menuTyLayer">
									<div class="input-group mg-t-sm">
										<span class="input-group-addon">프로그램URL</span>
										<form:select path="linkUrl" class="form-control required">
										<c:forEach var="result" items="${programList}" varStatus="status">
										<form:option value="${result.programUrl}"><c:out value="${result.programNm}" /></form:option>
										</c:forEach>								
										</form:select>
									</div>
								</div>
								
								<div id="linkUrlLayer" class="menuTyLayer">
									<div class="input-group mg-t-sm">
										<span class="input-group-addon">메뉴URL</span>
										<form:input path="linkUrl" class="form-control" />
									</div>
								</div>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">링크타겟</label></span>
							<div class="col-sm-10">
								<label class="radio-inline">
									<form:radiobutton path="linkTarget" value="_SELF" />현재창
								</label>
								<label class="radio-inline">
									<form:radiobutton path="linkTarget" value="_BLANK" />새창
								</label>
								<label class="radio-inline">
									<form:radiobutton path="linkTarget" value="_POPUP" />팝업
								</label>
								<div class="input-group mg-t-sm" id="popupParamLayer" style="display:none;">
									<span class="input-group-addon"><label for="popupParam">팝업옵션</label></span>
									<form:input path="popupParam" class="form-control" />
								</div>
							</div>
						</div>
	
						                  	
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="useStfsAt" class="control-label">만족도조사 사용여부</label></span>
							<div class="col-sm-10">
								<form:select path="useStfsAt" class="form-control">
								<form:option value="Y">사용함</form:option>
								<form:option value="N">사용안함</form:option>
								</form:select>
								<label class="checkbox-inline"><input type="checkbox" name="updateChldrnsStfs" value="Y" />하위메뉴 일괄 적용</label>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="permLvlList" class="control-label">메뉴출력 (허용등급)</label></span>
							<div class="col-sm-10">
									<form:select path="permLvl" class="form-control">
									<form:option value="0">ㆍ전체허용</form:option>
									<form:option value="-2">-------------------------</form:option>
									<form:option value="-1">ㆍ비회원만</form:option>
									<form:option value="-2">-------------------------</form:option>
									<c:forEach var="result" items="${levelList}" varStatus="status">									
									<form:option value="${result.levelId}">ㆍ<c:out value="${result.levelNm}"/> 이상</form:option>
									</c:forEach>
									</form:select>											
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="showAt" class="control-label">출력여부</label></span>
							<div class="col-sm-10">
								<form:select path="showAt" class="form-control">
								<form:option value="Y">출력함</form:option>
								<form:option value="N">출력안함</form:option>
								</form:select>
							</div>
						</div>		
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="useAt" class="control-label">사용여부</label></span>
							<div class="col-sm-10">
								<form:select path="useAt" class="form-control">
								<form:option value="Y">사용함</form:option>
								<form:option value="N">사용안함</form:option>
								</form:select>
							</div>
						</div>		
						<div class="bd-t md-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<c:if test="${command == 'update'}">
								<button type="button" class="btn btn-default pd-l-lg pd-r-lg" onclick="post_delete('', 'act=delete&siteId=<c:out value='${writeSiteMenu.siteId}' />&device=<c:out value='${writeSiteMenu.device}' />&menuId=<c:out value='${writeSiteMenu.menuId}' />'); return false;"><spring:message code="common.delete" /></button>
								</c:if>
							</div>
						</div>							
					</fieldset>
				</form:form>			
			</div>
		</div>	
	</div>
</div>

<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/jquery-chained/jquery.chained.min.js' />"></script>
<script type="text/javascript" src="<c:out value='${LAYOUT_PATH}/js/plugins/jquery-chained/jquery.chained.remote.min.js' />"></script>
<script type="text/javascript"> 
//<![CDATA[
$(document).ready(function()  
{
	$.ajax(
	{
		url:'?act=getLayoutList&themeId=<c:out value="${writeSiteMenu.themeId}"/>',
		dataType: "json",
		success:function(data) 
		{
			$("#layout").remoteChained({parents: "#themeId", url: "?act=getLayoutList", bootstrap: data});
		},
		error:function(request,status,error)
		{
			alert(error);
		}
	});
	
	$("#mngStaffId").remoteChained(
	{
		parents : "#mngOrgnztId",
		url : "?act=getOrgnztStaffList"
	});
	
	$("#writeSiteMenu").validate({});
	
	function menuTySelect(value)
	{
		$(".menuTyLayer").hide();
		$(".menuTyLayer").find("[name='linkUrl']").attr("disabled", true);
		
		switch(value)
		{
			case "MENU_LINK":
				$("#linkMenuLayer").show();
				break;
			case "BOARD":
				$("#linkBoardLayer").show();
				$("#linkBoardLayer").find("[name='linkUrl']").attr("disabled", false);
				break;
			case "PROGRAM":
				$("#programUrlLayer").show();
				$("#programUrlLayer").find("[name='linkUrl']").attr("disabled", false);
				break;
			case "LINK_IN":
			case "LINK_OUT":
				$("#linkUrlLabel").text("링크URL");
				$("#linkUrlLayer").show();
				$("#linkUrlLayer").find("[name='linkUrl']").attr("disabled", false);
				break;				
		}
	}
	$("input[name='menuTy']").change(function()
	{
		menuTySelect($(this).val());
	});
	menuTySelect("<c:out value='${writeSiteMenu.menuTy}' />");
	
	function showAtSelect(value)
	{
		$('#showAtLayer').hide();
		if (value == 'Y')
		{
			$('#showAtLayer').show();
		}
	}
	$("input[name='showAt']").change(function()
	{
		showAtSelect($(this).val());
	});
	showAtSelect("<c:out value='${writeSiteMenu.showAt}' />")

	function linkTargetSelect(value)
	{
		$("#popupParamLayer").hide();
		switch(value)
		{
			case "_POPUP":
				$("#popupParamLayer").show();
				$("#popupParam").val("<c:out value='${writeSiteMenu.popupParam}' />");
				break;
			default:
				$("#popupParam").val("");
				break;
		}
	}
	$("input[name='linkTarget']").change(function()
	{
		linkTargetSelect($(this).val());
	});
	linkTargetSelect("<c:out value='${writeSiteMenu.linkTarget}' />");
	
	function useMngStaffAtSelect(value)
	{
		$('#mngOrgnztLayer').hide();
		if (value == 'Y')
		{
			$('#mngOrgnztLayer').show();
		}
	}
	$("select[name='useMngStaffAt']").change(function()
	{
		useMngStaffAtSelect($(this).val());
	});
	useMngStaffAtSelect("<c:out value='${writeSiteMenu.useMngStaffAt}' />")
	
	$("select[name='linkBoardId']").change(function()
	{
		$("#linkBoardUrl").val('/cms/board/'+$(this).val()+'.do');
	});
});
//]]>
</script>