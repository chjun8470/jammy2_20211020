<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>

		<span class="top_logo" style="padding:6px">
			<a href="/web/main.do">
				<img src = "/imgs/comm/logo.png" />
			</a>
		</span>

<!--         <div style="position:absolute;top:0px;left:200px;height:48px;line-height:48px;width:100px;text-align:center;background-color:#1b2229;border-right:1px solid #ffffff;"> -->
<!--         	<a href="/cms/admin/main.do" style="color:#ffffff;font-size:20px;">CMS</a> -->
<!--         </div> -->

<!-- 		<div style="position:absolute;top:0px;left:300px;float:left;height:48px;line-height:48px;width:100px;text-align:center;background-color:#1b2229;"> -->
<!--         	<a href="/sys/main.do" style="color:#ffffff;font-size:20px;">PMS</a> -->
<!--         </div> -->

		<div class="logout_box">
			<span style=" font-size:1.3em; "><%=loginVO.getUserId()%> 님 환영합니다</span>
			&nbsp;&nbsp;&nbsp;
<!-- 			<input type="button" id="userEdit" name="userEdit" value="My Page" onclick="location.href='/web/webUserEdit.do';" /> -->
			<input type="button" id="userEdit" name="userEdit" style="cursor:pointer" value="My Page" onclick="myPagePopup('mypagePop')" />
			<!-- <img src = "/imgs/comm/logout.png" onclick="location.href='/web/logout.do';" style="cursor:pointer"/> -->
			<img src = "/imgs/comm/logout.png" onclick="location.href='/sso/logout.do';" style="cursor:pointer"/>
		</div>

	<script type="text/javascript">
	//마이페이지 팝업
	function myPagePopup(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/web/web_popup.do?listMode="+listMode;
// 		var popOption="width=630, height=620, resizable=no, scrollbars=no, status=no;";
		var popOption="height=" + screen.height + ",width=" + screen.width + "fullscreen=yes, resizable=no, scrollbars=no, status=no;";
 		window.open(popUrl,"",popOption);
		
	}
	</script>