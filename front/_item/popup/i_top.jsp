<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<script type="text/javascript">
//<![CDATA[
$(document).ready(function(){
	$(window).resize(function(){
		winResize();
	});
	winResize();
});
function winResize(){
	var win_w = $(window).width();
	$(".ci").css("left",((win_w-127)/2));
	
}
//]]>
</script>
	<h1 class="ci"><img src="/img/jntis/sub/logo2.png" alt="전남과학기술진흥센터"></h1>
