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
				d.add("<c:out value='${rootOrgnztId}'/>",-1,"조직도", "<c:url value='/cms/admin/system/orgnzt.do' />");
				<c:forEach var="result" items="${allOrgnztAllList}" varStatus="status">
				<c:if test="${not empty result.parntsOrgnztId}">
				d.add("<c:out value='${result.orgnztId}' />", "<c:out value='${result.parntsOrgnztId}' />", "<c:out value='${result.orgnztNm}' />", "?orgnztId=<c:out value='${result.orgnztId}' />", "", "", "");
				</c:if>
				</c:forEach>
				document.write(d);
				//]]>
				</script>
			</div>
			<div class="block-footer">
				<a href="?act=move" class="btn btn-default"><i class="fa fa-arrows"></i> 부서이동</a>
			</div>
		</div>
	</div>
	<div class="col-lg-10">
		<div class="block">
			<ul class="nav nav-tabs">
			    <li class="active"><a href="#">부서관리</a></li>
			    <li><a href="<c:url value='/cms/admin/system/orgnzt/staff.do' />?searchOrgnztId=<c:out value='${searchOrgnztVO.orgnztId}' />">직원관리</a></li>
			    <li><a href="<c:url value='/cms/admin/system/orgnzt/staff/config.do' />">회원가입설정</a></li>
			</ul>			
			<div class="block-head">
				<c:choose>
					<c:when test="${not empty searchOrgnztVO.parntsOrgnztId}"><h1>하위부서 만들기</h1></c:when>				
					<c:when test="${not empty searchOrgnztVO.orgnztId}"><h1>부서 등록정보</h1></c:when>
					<c:otherwise><h1>최상위부서 만들기</h1></c:otherwise>
				</c:choose>
			</div>			
			<div class="block-content">
				<form:form commandName="writeOrgnzt" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}'/>" />
					<input type="hidden" name="orgnztId" value="<c:out value='${searchOrgnztVO.orgnztId}'/>"/>
					<input type="hidden" name="parntsOrgnztId" value="<c:out value='${searchOrgnztVO.parntsOrgnztId}'/>"/>						
					<fieldset>
						<legend>등록정보</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">상위부서</label></span>
							<div class="col-sm-10">
								<p class="form-control-static">
									홈
									<c:forEach var="result" items="${parntsOrgnztList}" varStatus="status">
									&gt; <c:out value="${result.orgnztNm}" />
									</c:forEach>
								</p>
							</div>
						</div>		
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="orgnztNm" class="control-label">* 부서명</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:input path="orgnztNm" class="form-control required" maxlength="20" />					
									</c:when>
									<c:otherwise>
										<div class="input-group">
											<form:input path="orgnztNm" class="form-control" />
											<c:if test="${not empty writeOrgnzt.orgnztId}">
											<span class="input-group-btn"><a href="?parntsOrgnztId=<c:out value='${writeOrgnzt.orgnztId}' />" class="btn btn-default btn-sm"><i class="fa fa-plus"></i> 하위조직등록</a></span>
											</c:if>										
										</div>
									</c:otherwise>
								</c:choose>
							</div>
						</div>
						<!-- 
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="orgnztDc" class="control-label">부서설명</label></span>
							<div class="col-sm-10">
								<form:textarea path="orgnztDc" class="form-control" />
								<script type="text/javascript" src="<c:url value='/cms/ckeditor.do'/>"></script>
								<c:import url="/cms/ckeditor/config.do?id=orgnztDc" />
							</div>
						</div>
						 -->		
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="telNo" class="control-label">전화번호</label></span>
							<div class="col-sm-10">
								<form:input path="telNo" class="form-control" maxlength="20" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="faxNo" class="control-label">팩스번호</label></span>
							<div class="col-sm-10">
								<form:input path="faxNo" class="form-control" maxlength="20" />
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
								<button type="button" class="btn btn-default pd-l-lg pd-r-lg" onclick="post_delete('', 'act=delete&orgnztId=<c:out value='${writeOrgnzt.orgnztId}'/>'); return false;"><spring:message code="common.delete"/></button>
								</c:if>
							</div>
						</div>
					</fieldest>
					<fieldset>
						<legend>부서 로그인정보</legend>						
						<c:if test="${not empty writeOrgnzt.loginId}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label class="control-label">부서 로그인 아이디</label></span>
							<div class="col-sm-10">
								<p class="form-control-static"><c:out value="${writeOrgnzt.loginId}" /></p>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="password" class="control-label">부서 로그인 비밀번호</label></span>
							<div class="col-sm-10">
								<form:password path="password" class="form-control" />
								<div class="help-block">
								비밀번호를 변경하시는 경우에만 입력해 주세요.
								</div>
							</div>
						</div>
						</c:if>						
						<c:if test="${empty writeOrgnzt.loginId}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="loginId" class="control-label">부서 로그인 아이디</label></span>
							<div class="col-sm-10">
								<form:input path="loginId" class="form-control" maxlength="20" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="password" class="control-label">부서 로그인 비밀번호</label></span>
							<div class="col-sm-10">
								<form:password path="password" class="form-control" />
							</div>
						</div>
						</c:if>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="groupId" class="control-label">부서 그룹</label></span>
							<div class="col-sm-10">
								<form:select path="groupId" class="form-control">
								<form:option value="">+ 선택</form:option>
								<c:forEach var="result" items="${groupList}" varStatus="status">
								<form:option value="${result.groupId}"><c:out value="${result.groupNm}" /></form:option>
								</c:forEach>
								</form:select>								
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="levelId" class="control-label">부서 등급</label></span>
							<div class="col-sm-10">
								<form:select path="levelId" class="form-control">
								<form:option value="0">+ 선택</form:option>
								<c:forEach var="result" items="${levelList}" varStatus="status">
								<form:option value="${result.levelId}"><c:out value="${result.levelNm}" /></form:option>
								</c:forEach>
								</form:select>								
							</div>
						</div>
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
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
$(function()
{	
	$("#writeOrgnzt").validate({
		rules: 
		{
			orgnztLoginPw:{minlength: 6, maxlength: 12}
			, orgnztLoginPwCnfirm:{equalTo: "#orgnztLoginPw"}
		},
		messages: 
		{
			passwordCnfirm:{equalTo: "<spring:message code='fail.user.passwordUpdate2'/>"}		
		}
	});	
});
//]]>
</script>