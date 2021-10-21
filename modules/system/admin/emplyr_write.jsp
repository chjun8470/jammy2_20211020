<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<c:if test="${command == 'insert'}">
	<script type="text/javascript">
	location.href="/cms/admin/system/emplyr.do";
	</script>
</c:if>
<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-head">
				<h1>관리자 <c:choose><c:when test="${command == 'insert'}"><spring:message code="common.create" /></c:when><c:otherwise><spring:message code="common.update" /></c:otherwise></c:choose></h1>
			</div>		
			<div class="block-content">
				<form:form commandName="writeEmplyr" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchEmplyrVO.queryString}' escapeXml='false' />"/>
					
					<c:if test="${command == 'update'}">
					<input type="hidden" name="emplyrId" value="${searchEmplyrVO.emplyrId}"/>
					</c:if>
					
					<fieldset>
						<legend>등록정보</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="emplyrId" class="control-label">* 아이디</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:input path="emplyrId" class="form-control required" maxlength="20" />
									</c:when>
									<c:otherwise>
										<form:input path="emplyrId" class="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="userNm" class="control-label">* 이름</label></span>
							<div class="col-sm-10">
								<form:input path="userNm" class="form-control required" maxlength="60" />
							</div>
						</div>
						<c:if test="${command == 'insert'}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="password" class="control-label">* 비밀번호</label></span>
							<div class="col-sm-10">
								<form:password path="password" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="passwordCnfirm" class="control-label">* 비밀번호 확인</label></span>
							<div class="col-sm-10">
								<input type="password" name="passwordCnfirm" id="passwordCnfirm" class="form-control required" value="" />
							</div>
						</div>
						</c:if>
						<c:if test="${command == 'update'}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="password" class="control-label">비밀번호변경</label></span>
							<div class="col-sm-10">
								<form:password path="password" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="passwordCnfirm" class="control-label">비밀번호변경 확인</label></span>
							<div class="col-sm-10">
								<input type="password" name="passwordCnfirm" id="passwordCnfirm" class="form-control" value="" />
							</div>
						</div>
						</c:if>						
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="ofcpsNm" class="control-label">직위명</label></span>
							<div class="col-sm-10">
								<form:input path="ofcpsNm" class="form-control" maxlength="60" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="sexdstnCode" class="control-label">성별</label></span>
							<div class="col-sm-10">
								<form:select path="sexdstnCode" class="form-control">
								<form:option value="">+ 성별선택</form:option>
								<c:forEach var="result" items="${sexdstnCodeList}" varStatus="status">
								<form:option value="${result.code}"><c:out value="${result.codeNm}" /></form:option>
								</c:forEach>
								</form:select>							
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="telNo" class="control-label">전화번호</label></span>
							<div class="col-sm-10">
								<form:input path="telNo" class="form-control" maxlength="20" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="faxNo" class="control-label">팩스번호</label></span>
							<div class="col-sm-10">
								<form:input path="faxNo" class="form-control" maxlength="20" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="hpNo" class="control-label">핸드폰번호</label></span>
							<div class="col-sm-10">
								<form:input path="hpNo" class="form-control" maxlength="20" />
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="email" class="control-label">이메일</label></span>
							<div class="col-sm-10">
								<form:input path="email" class="form-control email" maxlength="50" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="zip" class="control-label">우편번호</label></span>
							<div class="col-sm-10">
								<div class="input-group">
									<form:input path="zip" class="form-control digits" maxlength="6" />
									<span class="input-group-btn">
										<button type="button" onclick="openDaumPostcode()" class="btn btn-default"><i class="fa fa-search"></i> 우편번호 찾기</button>
									</span>									
								</div>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="adres" class="control-label">주소</label></span>
							<div class="col-sm-10">
								<form:input path="adres" class="form-control" maxlength="100" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="detailAdres" class="control-label">상세주소</label></span>
							<div class="col-sm-10">
								<form:input path="detailAdres" class="form-control" maxlength="100" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="emplyrSttusCode" class="control-label">* 사용자상태</label></span>
							<div class="col-sm-10">
								<form:select path="emplyrSttusCode" class="form-control required">
								<c:forEach var="result" items="${emplyrSttusCodeList}" varStatus="status">
								<form:option value="${result.code}"><c:out value="${result.codeNm}" /></form:option>
								</c:forEach>
								</form:select>								
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="groupId" class="control-label">* 그룹</label></span>
							<div class="col-sm-10">
								<form:select path="groupId" class="form-control required">
								<c:forEach var="result" items="${groupList}" varStatus="status">
								<form:option value="${result.groupId}"><c:out value="${result.groupNm}" /></form:option>
								</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="levelId" class="control-label">* 등급</label></span>
							<div class="col-sm-10">
								<form:select path="levelId" class="form-control required">
								<c:forEach var="result" items="${levelList}" varStatus="status">
								<form:option value="${result.levelId}"><c:out value="${result.levelNm}" /></form:option>
								</c:forEach>
								</form:select>
							</div>
						</div>
						<%--<div class="form-group">
							<span class="col-sm-2  text-right"><label for="adminSiteId" class="control-label">관리사이트</label></span>
							<div class="col-sm-10">
								<form:select path="adminSiteId" class="form-control">
								<form:option value="">+ 사이트 선택</form:option>
								<c:forEach var="result" items="${siteList}" varStatus="status">
								<form:option value="${result.siteId}"><c:out value="${result.siteNm}"/></form:option>
								</c:forEach>
								</form:select>
								<div class="help-block">
									관리사이트를 선택하지 않는 경우 전체 사이트관리를 할 수 있습니다.
								</div>								
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label class="control-label">관리메뉴</label></span>
							<div class="col-sm-10">
								<div style="overflow-y:auto; height:400px; border:1px solid #000;">
									<ul>
									<c:forEach var="result" items="${adminMenuList}" varStatus="status">
										<c:if test="${result.lvl > 1}">
										<li style="padding-left:<c:out value='${(result.lvl-2)*25}'/>px;">
											<label><form:checkbox path="adminMenuIdsArr" value="${result.menuId}" /> <c:out value="${result.menuNm}"/></label>
										</li>
										</c:if>
									</c:forEach>
									</ul>
								</div>
							</div>
						</div>
						 --%>
						<div class="bd-t mg-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchEmplyrVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
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
	$("#writeEmplyr").validate({
		rules: 
		{
			emplyrId:{remote:"<c:url value='/cms/admin/system/emplyr.do?act=emplyrIdCheck'/>"}
			, password:{minlength: 6, maxlength: 12}	
			, passwordCnfirm:{equalTo:"#password"}	
			, userNm:{maxlength: 60}
			, ofcpsNm:{maxlength: 60}
			, brthdy:{maxlength: 20}
			, telNo:{maxlength: 20}
			, hpNo:{maxlength: 20}
			, email:{maxlength: 50}
			, zip:{maxlength: 6}
			, adres:{maxlength: 100}
			, detailAdres:{maxlength: 100}			
		},
		messages: 
		{
			emplyrId:{remote : "<spring:message code='member.register.idDuplctn'/>"}
			, passwordCnfirm:{equalTo : "<spring:message code='fail.user.passwordUpdate2'/>"}		
		}
	});	
});
//]]>
</script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
function openDaumPostcode() {
	new daum.Postcode({
		oncomplete: function(data) {
			document.getElementById('zip').value = data.postcode1+data.postcode2;
			document.getElementById('adres').value = data.address;
			document.getElementById('detailAdres').focus();
		}
	}).open();
}
//]]>
</script>