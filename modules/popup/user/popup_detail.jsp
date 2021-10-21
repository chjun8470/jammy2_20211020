<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="utf-8">
	<title><c:out value='${popupVO.title}'/></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<style type="text/css">
		body,div,dl,dt,dd,ul,ol,li,menu,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,textarea,p,blockquote,th,td,input,select,textarea,button {margin:0;padding:0}
		fieldset,img {border:0 none}
		dl,ul,ol,menu,li {list-style:none}
		blockquote, q {quotes: none}
		blockquote:before, blockquote:after,q:before, q:after {content:'';content:none}
		input,select,textarea,button {vertical-align:middle;font-size:12px}
		button {border:0 none;background-color:transparent;cursor:pointer}
		body,th,td,input,select,textarea,button {line-height:1.5;font-family:Nanum Gothic,Malgun Gothic,gulim,dotum,sans-serif;color:#333; letter-spacing:-1px;} 
		a {color:#333;text-decoration:none;cursor:pointer}
		a:active, a:hover {text-decoration:none}
		address,caption,cite,code,dfn,em,var {font-style:normal;font-weight:normal}
		body {background-color:#fff;font-size:12px;}
		table{border-spacing:0; border-collapse:collapse;}
		label {cursor: pointer;}
		
		.popup{}
		.popup .navi{position:fixed; left:0; bottom:0; width:100%; height:30px; line-height:30px; background:#000;}
		.popup .navi .txt{padding-left:5px; color:#ccc;}
		.popup .navi .close{position:fixed; right:0; bottom:0; display:inline-block; height:30px; padding:0 15px; line-height:30px; color:#ccc; background:#232323;}	
	</style>
	<script src="/core/js/jquery.min.js"></script>
    <script src="/core/js/sys.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	function popup_close()
	{
		checked = $('input[name="popup_close"]').is(":checked");
		if (checked)
		{
			var nowcookie = getCookie("popview");
			setCookie( "popview", "['<c:out value='${siteId}'/>_<c:out value='${popupVO.popupId}'/>']" + nowcookie , 1);
		}
		
		self.close();
	}
	//]]>
	</script>    
</head>
<body>
<div class="popup">
	<div class="content">
		<c:out value="${popupVO.content}" escapeXml="false" />
	</div>
	<div class="navi">
		<div class="txt"><input type="checkbox" name="popup_close" id="popup_close" value="Y" /> <label for="popup_close">오늘하루 열지 않기</label></div>
		<a href="javascript:popup_close();" class="close">닫기</a>
	</div>
</div>
</body>
</html>