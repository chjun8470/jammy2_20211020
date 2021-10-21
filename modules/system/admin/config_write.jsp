<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
	String requestURL = request.getRequestURL().toString();
	String serverName = requestURL.substring(requestURL.indexOf("://") + 3);
	serverName = serverName.substring(0, serverName.indexOf("/"));

	request.setAttribute("serverName", serverName);
%>


<div class="row">
	<div class="col-lg-12">	
		<div class="block">
			<div class="block-content">
				<form:form commandName="writeSystemConfig" action="?act=write" class="form-horizontal" role="form">
					<input type="hidden" name="command" value="<c:out value='${command}' />" />
					<fieldset>
						<legend class="sr-only">환경설정 관리</legend>
						<div class="form-group">
							<span class="col-sm-2  text-right"><label for="adminAccessIp" class="control-label">관리자페이지 접근가능IP</label></span>
							<div class="col-sm-10">
								<form:textarea path="adminAccessIp" class="form-control" rows="8" />
								<div class="help-block">입력된 IP의 컴퓨터만 접근할 수 있습니다. (엔터로 구분)</div>
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
	$("#writeSystemConfig").validate();	
});
//]]>
</script>