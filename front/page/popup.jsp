<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	ComUtil util = new ComUtil();
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
%>
<!DOCTYPE html>
<html lang="ko" >
	<head>
		<script type="text/javascript">
		//<![CDATA[

			// 창닫기
			function closeWin(winName, expiredays) {
			   setCookie( winName, "done" , expiredays);
			   window.close();
			}

			function closeWin2() {
			    window.close();
			}

			// 24시간 기준 쿠키 설정하기
			// expiredays 후의 클릭한 시간까지 쿠키 설정
			function setCookie(cname, cvalue, exdays) {
			    var d = new Date();
			    d.setTime(d.getTime() + (exdays*24*60*60*1000));
			    var expires = "expires="+d.toUTCString();
			    document.cookie = cname + "=" + cvalue + "; " + expires+";path=/";

			}
			/* setCookie('popup20151220','Y',1);
			alert(getCookie('popup20151220')); */
		//]]>	
		</script>
	</head>
	<body style="padding:0px;margin:0px;">

	<div style="position:relative;height:700px;">
		<div >
			<%if(util.getStr(dataMap.get("CONT_TYPE")).equals("html")){ %>
				<%=util.deStr(util.getStr(dataMap.get("HTML_CODING"))) %>
			<%} else{%>
				<a href="<%=util.getStr(dataMap.get("LINK_URL")) %>"><img src="<%=util.getStr(dataMap.get("IMG_SRC"))%>" width="300" /></a>
			<%} %>
			<br />
			<div class="btn_box" style="position:fixed;bottom:0px;background-color:#000000;color:#fffff;height:30px;line-height:30px;width:100%;">
				<div class="btn_left_box" style="display:inline-block;margin-left:10px;">
					<input type="checkbox" name="ck_close"  id="ck_close"  value="Y" onclick="javascript:closeWin('popup_layer<%=util.getIntStr(dataMap.get("POPUP_IDX"))%>', 1);"/>
					&nbsp;<label for="ck_close" style="color:#ffffff;cursor:pointer;">하루동안 이 창을 열지 않음</label>
				</div>
				<div class="btn_right_box" style="display:inline-block;float:right;margin-right:10px;">
	                	<span class="btn_b_01" onclick='closeWin2();' style="cursor:pointer;color:#ffffff;">닫기</span>
	            </div>
			</div>
	    <!-- <input type="checkbox" name="close" value="OK" onclick="javascript:closeWinAt00('div_laypopup', 1);"/>오늘만 이 창을 열지 않음 -->
	 	</div>
	 </div>
	</body>
</html>
