<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-content">
				<form:form commandName="writeGnrlMember" action="?act=write" enctype="multipart/form-data" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<input type="hidden" name="returnQueryString" value="<c:out value='${searchGnrlMemberVO.queryString}' escapeXml='false' />"/>
					
					<c:if test="${command == 'update'}">
					<input type="hidden" name="mberId" value="${searchGnrlMemberVO.mberId}"/>
					</c:if>
					
					<fieldset>
						<legend>회원 관리</legend>
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="mberId" class="control-label">* 아이디</label></span>
							<div class="col-sm-10">
								<c:choose>
									<c:when test="${command == 'insert'}">
										<form:input path="mberId" maxlength="20" class="form-control required" />
									</c:when>
									<c:otherwise>
										<form:input path="mberId" class="form-control" disabled="true" />
									</c:otherwise>
								</c:choose>
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="mberNm" class="control-label">* 이름</label></span>
							<div class="col-sm-10">
								<form:input path="mberNm" maxlength="50" class="form-control required" />
							</div>
						</div>
						<c:if test="${command == 'insert'}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="password" class="control-label">비밀번호</label></span>
							<div class="col-sm-10">
								<form:password path="password" class="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="passwordCnfirm" class="control-label">비밀번호 확인</label></span>
							<div class="col-sm-10">
								<input type="password" name="passwordCnfirm" id="passwordCnfirm" class="form-control required" value="" />
							</div>
						</div>
						</c:if>
						<c:if test="${command == 'update'}">
						<div class="form-group">
							<span class="col-sm-2 text-right"><label for="password" class="control-label">* 비밀번호변경</label></span>
							<div class="col-sm-10">
								<form:password path="password" class="form-control" />
								<div class="help-block">
								비밀번호를 변경하는 경우에만 입력해 주세요
								</div>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="passwordCnfirm" class="control-label">* 비밀번호변경 확인</label></span>
							<div class="col-sm-10">
								<input type="password" name="passwordCnfirm" id="passwordCnfirm" class="form-control" value="" />
							</div>
						</div>
						</c:if>						
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
								<form:input path="telNo" maxlength="20" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="hpNo" class="control-label">핸드폰번호</label></span>
							<div class="col-sm-10">
								<form:input path="hpNo" maxlength="20" class="form-control" />
							</div>
						</div>						
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="email" class="control-label">이메일</label></span>
							<div class="col-sm-10">
								<form:input path="email" maxlength="50" class="form-control email" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="zip" class="control-label">우편번호</label></span>
							<div class="col-sm-10">
								<div class="input-group">
									<form:input path="zip" maxlength="6" class="form-control digits" />
									<span class="input-group-btn">
										<button type="button" onclick="openDaumPostcode()" class="btn btn-default"><i class="fa fa-search"></i> 우편번호 찾기</button>
									</span>									
								</div>
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="adres" class="control-label">주소</label></span>
							<div class="col-sm-10">
								<form:input path="adres" maxlength="100" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="detailAdres" class="control-label">상세주소</label></span>
							<div class="col-sm-10">
								<form:input path="detailAdres" maxlength="100" class="form-control" />
							</div>
						</div>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="mberSttus" class="control-label">* 회원상태</label></span>
							<div class="col-sm-10">
								<form:select path="mberSttus" class="form-control required">
								<c:forEach var="result" items="${mberSttusList}" varStatus="status">
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
						<div class="bd-t md-t-md pd-t-md"></div>
						<div class="form-group">
							<div class="col-sm-offset-2 col-sm-10">
								<button type="submit" class="btn btn-primary pd-l-lg pd-r-lg"><spring:message code="common.save" /></button>
								<a href="?<c:out value='${searchGnrlMemberVO.queryString}' />" class="btn btn-default pd-l-lg pd-r-lg"><spring:message code="common.reset" /></a>
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
	$("#writeGnrlMember").validate({
		rules: 
		{
			mberId:{minlength:4, remote: "<c:url value='/cms/admin/member/gnrl.do?act=mberIdCheck'/>"}
			, password:{minlength: 6, maxlength: 12}
			, passwordCnfirm:{equalTo: "#password"}			
		},
		messages: 
		{
			mberId:{remote: "<spring:message code='fail.user.idDuplctn'/>"},
			passwordCnfirm:{equalTo: "<spring:message code='fail.user.passwordUpdate2'/>"}		
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

function completeRspnsSearch(data)
{
	$('#officerId').val(data.mberId);
}
//]]>
</script>