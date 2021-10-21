<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html class="no-js" lang="ko">
<head>
	<title>로그인</title>

	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	
	<link href="/themes/admin/css/styles.css" rel="stylesheet" type="text/css" id="theme"/>
	<!--[if lt IE 10]><link rel="stylesheet" type="text/css" href="/themes/admin/css/ie.css"/><![endif]-->
	
	<script type="text/javascript" src="/themes/admin/js/plugins/jquery/jquery.min.js"></script>
	<script type="text/javascript" src="/themes/admin/js/plugins/jquery/jquery-ui.min.js"></script>
	<script type="text/javascript" src="/themes/admin/js/plugins/bootstrap/bootstrap.min.js"></script>
	<script type="text/javascript" src="/themes/admin/js/plugins/mcustomscrollbar/jquery.mCustomScrollbar.min.js"></script>
	
	<script type="text/javascript" src="/themes/admin/js/plugins/jquery-validation/jquery.validate.min.js"></script>
	<script type="text/javascript" src="/themes/admin/js/plugins/jquery-validation/localization/messages_ko.min.js"></script>

	<script type="text/javascript" src="/themes/admin/js/actions.js"></script>
</head>
<body>
<div class="page-container">
<c:choose>
	<c:when test="${empty sourceVO}">
		<script type="text/javascript">
		//<![CDATA[
		alert("소스 버전이 존재하지 않습니다.");
		if (window.opener != null && !window.opener.closed) {
			self.close(); 
		} else {    
		    history.back(-1);
		}
		//]]>
		</script>
	</c:when>
	<c:otherwise>
		<textarea id="sourceCn" class="form-control"><c:out value="${sourceVO.sourceCn}"/></textarea>
		<div class="text-center">
			<button type="button" class="btn btn-default" onclick="restore('<c:out value="${sourceVO.sourceId}"/>'); return false;">복원</button>
		</div>
		<script type="text/javascript" src="<c:url value='/themes/admin/js/plugins/codemirror/codemirror.js'/>"></script>
		<script type="text/javascript">
		//<![CDATA[
		var editor = CodeMirror.fromTextArea(document.getElementById("sourceCn"), 
		{
			lineNumbers: true,
			mode: "htmlmixed"
		});
		</script>		
		<script type="text/javascript">
		function restore(sourceId)
		{
			if (window.opener == null || window.opener.closed) {
				alert('부모창이 존재하지 않습니다 ㅠ');
				return false;
			}
			
		    try {
		    	if (confirm("정말로 복원하시겠습니까?"))
		    	{
		    		window.opener.sourceRestore(sourceId);
		    		self.close();
		    	}
		    }
		    catch(err) {
		        alert('보무창의 소스복원 함수가 존재하지 않습니다.');
		    }
		}
		//]]>
		</script>
	</c:otherwise>
</c:choose>
</div>
</body>
</html>