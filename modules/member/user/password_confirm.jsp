<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>


<script type="text/javascript" src="<c:url value="/cms/validator.do"/>"></script>
<script type="text/javascript"> 
//<![CDATA[
$(function()
{	
	$("#passwordConfirm").validate();
});
//]]>
</script>

<div class="password-confirm">
	<div class="password-confirm-title">
		회원 비밀번호 확인
	</div>
	<form id="passwordConfirm" action="" method="post" class="password-confirm-form">
		<input type="hidden" name="act" value="passwordConfirm" />
		<div class="form-group">
			<div class="input-group">		
				<input type="password" name="password" class="form-control required" value="" />
				<span class="input-group-btn">
					<button class="btn btn-default">확인</button>
				</span>
			</div>			
		</div>			
	</form>	
	<div class="password-confirm-guide">
		외부로부터 회원님의 정보를 안전하게 보호하기 위해 비밀번호를 확인하셔야 합니다.
	</div>
</div>