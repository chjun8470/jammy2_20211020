<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
String str = "<pre>JSP Request Method: "+request.getMethod()
+"\n Request URL: "+request.getRequestURL()
+"\n Request URI: "+request.getRequestURI()
+"\n Request Protocol:  "+request.getProtocol()
+"\n Servlet path:  "+request.getServletPath()
+"\n Path info:  "+request.getPathInfo()
+"\n Path translated:  "+request.getPathTranslated()
+"\n Query string:  "+request.getQueryString()
+"\n Content length:  "+request.getContentLength()
+"\n Content type:  "+request.getContentType()
+"\n Server name:  "+request.getServerName()
+"\n Server port:  "+request.getServerPort()
+"\n Remote user:  "+request.getRemoteUser()
+"\n Remote address:  "+request.getRemoteAddr()
+"\n Remote host:  "+request.getRemoteHost()
+"\n Authorization scheme:  "+request.getAuthType()
+"\n The browser you are using is  "+request.getHeader("User-Agent")+"</pre>";
%>
<script type="text/javascript">
//<![CDATA[
	$(function(){
		$('.left_main_menu').each(function(clickindex){
			$('.left_main_menu').eq(clickindex).click(function(){

				$('.left_main_menu').removeClass('_on');
				$(this).addClass('_on');

				$('.left_menu ul').each(function(){
					if($(this).attr('class')){
						if($(this).attr('class').indexOf("_ckon") < 0){
							$(this).hide();
						}
					}
					$('.left_menu ul').eq(clickindex).show();
				});

			});
		});

		$('.left_main_menu').dblclick(function(){
			console.log($(this).next("ul").children(":first-child").children().attr("href"));
			location.href= $(this).next("ul").children(":first-child").children().attr("href");
		}).on("selectstart", function(){
			return false;
		});


		$('.left_menu ul li').mouseover(function(){
			$('.left_menu ul li').removeClass('_on');
			$(this).addClass('_on');
		});
		$('.left_menu ul li').mouseout(function(){
			$(this).removeClass('_on');
		});

	});
	//]]>
</script>

		<div id="left_snb">
			<!-- 연구장비 정보망  -->
			<div class="left_title">
<%-- 				<%if("1".equals(menu1)){%>연구장비 정보망<%}%> --%>
<%-- 				<%if("2".equals(menu1)){%>회원정보수정<%}%> --%>
				<%if("1".equals(menu1)){%>My Page<%}%>
<%-- 				<%if("2".equals(menu1)){%>회원정보수정<%}%> --%>
			</div>
			<div class="left_menu">
				<div class="left_main_menu <%if("1".equals(menu1)){%>_ckon<%}%>">
					My Page
				</div>
				<ul <%if(!"1".equals(menu1)){%>class="hide"<%}%>>
					<li <%if("1".equals(menu1) && "1".equals(menu2)){%> class='_ckon' <%}%>><a href="/sso/myPage.do">내정보수정</a></li>
					<li <%if("1".equals(menu1) && "2".equals(menu2)){%> class='_ckon' <%}%>><a href="/sso/web_changeOrg.do">기간회원변경신청</a></li>
					
				</ul>
<%-- 				<%if(!loginVO.getUserId().equals("admin")){%> --%>
<%-- 				<div class="left_main_menu <%if("2".equals(menu1)){%>_ckon<%}%>"> --%>
<!-- 					회원정보수정 -->
<!-- 				</div> -->
				
<%-- 				<ul <%if(!"2".equals(menu1)){%>class="hide"<%}%>> --%>
<%-- 					<li <%if("1".equals(menu1) && "1".equals(menu2)){%> class='_ckon' <%}%>><a href="/web/web_useredit.do">회원정보수정</a></li> --%>
<!-- 				</ul> -->
				
<%-- 				<%} %> --%>
			</div>
		</div>




