<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%
	ComUtil util = new ComUtil();
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	String reUrl = util.getStr(request.getHeader("referer"),"/sys/main.do");
// 	if(reUrl.toLowerCase().indexOf("proc.do") > 0){
// 		reUrl = "/sys/sys_jnsptotal.do";
// 	}

// 	if(reUrl.indexOf("/login.do") > 0){
// 		reUrl = "/sys/sys_jnsptotal.do";
// 	}

%>



        <!-- admin_loginWrap s -->
		<div class="admin_loginWrap">

        <div class="tit_login"><img src="/img/login/tit_login.png" alt="Member Login" /></div>

        <!-- inputBox s -->
        <div class="inputBox">

        <input type="button" class="btn_pop1" style="cursor:pointer" onclick="actlogin('<%=reUrl%>')" value="로그인"/>

        <div class="txt_pop1">회원ID</div>
        <input type="text" class="input_pop1"  value="admin" id="login_id" name="login_id"  onkeydown="if(event.keyCode==13) actlogin('<%=reUrl%>');"/>

        <div class="txt_pop2">비밀번호</div>
        <input type="password" class="input_pop2" value="q1w2e3r4" id="login_pwd" name="login_pwd" onkeydown="if(event.keyCode==13) actlogin('<%=reUrl%>');"/>

        </div>
        <!-- inputBox e -->

        </div>
		<!-- admin_loginWrap e -->




<form method="post" id="actForm" name="actForm">
	<input type="hidden" id="mode" name="mode" value=""/>
</form>



<script type="text/javascript">
	//로그인 팝업
	function loginPopup(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/sys_popup.do?listMode="+listMode;
		var popOption="width=630, height=620, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}

	//회원가입 팝업
		function signPopup(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/sys_popup.do?listMode="+listMode;
		var popOption="width=900, height=700, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}

// 	function goSign(){
// 		$("#mode").val("sign");
// 		$("#actForm").attr("action","/sys/login.do#container");
// 		$("#actForm").submit();
// 	}

	$('#login_id').focus();
</script>