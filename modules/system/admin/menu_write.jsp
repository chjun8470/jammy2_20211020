<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>

<div class="row">
	<div class="col-lg-2">
		<div class="block">
			<div class="block-content">
					<link rel="stylesheet" href="/core/js/dtree/dtree.css">
					<script type="text/javascript" src="/core/js/dtree/dtree.js"></script>
					<script type="text/javascript">
					//<![CDATA[
					var d = new dTree('d');
					d.add(<c:out value="${rootMenuId}"/>,-1,"홈", "?");
					<c:forEach var="result" items="${allAdminMenuList}" varStatus="status">
					<c:if test="${result.parntsMenuId > 0}">
					d.add(<c:out value='${result.menuId}' />, <c:out value='${result.parntsMenuId}' />, "<c:out value='${result.menuNm}' />", "?menuId=<c:out value='${result.menuId}' />", "", "", "");
					</c:if>
					</c:forEach>
					document.write(d);
					//]]>
					</script>
			</div>
			<div class="block-footer">
				<a href="?act=move" class="btn btn-default"><i class="fa fa-arrows"></i> 메뉴이동</a>
			</div>
		</div>
	</div>
	<div class="col-lg-10">
		<div class="block">
			<div class="block-head">
				<c:choose>
					<c:when test="${searchAdminMenuVO.parntsMenuId > 0}"><h1>서브메뉴 만들기</h1></c:when>				
					<c:when test="${searchAdminMenuVO.menuId > 0}"><h1>메뉴 등록정보</h1></c:when>
					<c:otherwise><h1>최상위메뉴 만들기</h1></c:otherwise>
				</c:choose>
			</div>
			<div class="block-content">				
				<form:form commandName="writeAdminMenu" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}'/>" />
					<input type="hidden" name="menuId" value="<c:out value='${searchAdminMenuVO.menuId}'/>"/>
					<input type="hidden" name="parntsMenuId" value="<c:out value='${searchAdminMenuVO.parntsMenuId}'/>"/>					
					<fieldset>
						<legend class="sr-only">메뉴관리</legend>
						<c:if test="${searchAdminMenuVO.menuId > 0 || searchAdminMenuVO.parntsMenuId > 0}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">상위메뉴</label></span>
							<div class="col-sm-10">
								<p class="form-control-static">
									홈 
									<c:forEach var="result" items="${parntsAdminMenuList}" varStatus="status">
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
											<c:if test="${writeAdminMenu.menuId > 0}">
											<span class="input-group-btn"><a href="?parntsMenuId=<c:out value='${writeAdminMenu.menuId}' />" class="btn btn-default btn-sm"><i class="fa fa-plus"></i> 하위메뉴등록</a></span>
											</c:if>										
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<c:if test="${writeAdminMenu.lvl < 3}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">메뉴아이콘</label></span>
							<div class="col-sm-10">
								<form:input path="menuIcon" class="form-control" />
							</div>
						</div>
						</c:if>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">* 메뉴타입</label></span>
							<div class="col-sm-10">
								<label class="radio-inline"><form:radiobutton path="menuTy" value="PROGRAM" />프로그램연결</label>								
								<label class="radio-inline"><form:radiobutton path="menuTy" value="LINK_IN" />내부링크</label>
								<label class="radio-inline"><form:radiobutton path="menuTy" value="LINK_OUT" />외부링크</label>

								<div id="linkUrlLayer" class="menuTyLayer">
									<div class="input-group mg-t-xs mg-b-xs">
										<span class="input-group-addon" id="linkUrlLabel">URL</span>
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
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<c:if test="${command == 'update'}">
								<button type="button" class="btn btn-default pd-l-lg pd-r-lg" onclick="post_delete('', 'act=delete&menuId=<c:out value='${writeAdminMenu.menuId}' />'); return false;"><spring:message code="common.delete" /></button>
								</c:if>
							</div>
						</div>							
					</fieldset>
				</form:form>			
			</div>
		</div>	
	</div>
</div>

<script type="text/javascript"> 
//<![CDATA[
$(document).ready(function()  
{	
	$("#writeAdminMenu").validate({});
	
	function linkTargetSelect(value)
	{
		$("#popupParamLayer").hide();
		switch(value)
		{
			case "_POPUP":
				$("#popupParamLayer").show();
				$("#popupParam").val("<c:out value='${writeAdminMenu.popupParam}' />");
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
	linkTargetSelect("<c:out value='${writeAdminMenu.linkTarget}' />");
	
});
//]]>
</script>