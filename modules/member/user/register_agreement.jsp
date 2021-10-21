<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<form id="registerAgreement" action="" method="post">
	
	<h4 class="title-type1">이용약관</h4>
	<div class="mg-t-md" style="height:300px; overflow-y:auto; border:1px solid #eee;">
		<c:out value="${memberConfigVO.serviceCn}" escapeXml="false" />
	</div>
	<label class="mg-t-xs checkbox-inline"><input type="checkbox" name="agree1" class="required" value="Y" /> 이용약관에 동의합니다.</label>
	
	<div class="mg-t-md">
		<h4 class="title-type1">개인정보취급방침</h4>
		<div class="mg-t-md" style="height:300px; overflow-y:auto;  border:1px solid #eee;">
			<c:out value="${memberConfigVO.privacyCn}" escapeXml="false" />
		</div>
		<label class="mg-t-xs checkbox-inline"><input type="checkbox" name="agree2" class="required" value="Y" /> 개인정보 취급방침에 동의합니다.</label>
	</div>
	<div class="mg-t-lg text-center">
		<button class="btn btn-danger pd-l-lg pd-r-lg">다음</button>
		<a href="${INDEX_PAGE}" class="btn btn-default pd-l-lg pd-r-lg">취소</a>
	</div>
</form>

<script type="text/javascript" src="<c:url value="/cms/validator.do"/>"></script>
<script type="text/javascript"> 
//<![CDATA[
$(function()
{	
	$("#registerAgreement").validate();
});
//]]>
</script>