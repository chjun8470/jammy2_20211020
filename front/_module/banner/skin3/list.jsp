<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");

	String bannerSkin = util.getStr(paramMap.get("bannerSkin"));

	System.out.println(bannerSkin + " List");

%>
<style>
	.clsBannerScreen {overflow: hidden;position: relative;height: 150px;width: 600px; border:1px solid #e1e1e1; cursor:pointer; clear:both;}
	.clsBannerScreen .images {position:absolute; display:none; }
	ul, li {list-style:none; margin:0; padding:0; font-size:10pt; }
	.clsBannerButton {width:600px;cursor:pointer; border-bottom:1px solid #e1e1e1;}
	.clsBannerButton li {float:left;border-right:1px solid #e1e1e1;padding:2px;}
	.clsBannerButton li.fir {border-left:1px solid #e1e1e1;}
	.clsBannerButton li.labelOverClass {font-weight:bold;}
</style>
<script type="text/javascript" src="/js/jquery.banner.js"></script>
<script type="text/javascript">
//<![CDATA[
	$.getJSON("/file/banner/bannerData.txt", function(json) {

		var bannerScreen = "";
		var bannerButton = "";
		var bannerCount = json.length;

		$.each(json, function(key) {
			bannerScreen += "<div class='images'>";
			bannerScreen += "	<a href=\"" + json[key].LINK_URL + "\" target='" + json[key].LINK_TARGET + "' >";
			bannerScreen += "		<img src=\"" + json[key].IMG_SRC + "\" width='600px' height='150px'>";
			bannerScreen += "	</a>";
			bannerScreen += "</div>";
		});

		$.each(json, function(key) {
			bannerButton += "<li overclass=\"labelOverClass\" outclass=\"\">";
			bannerButton += json[key].TITLE;
			bannerButton += "</li>";
		});

//		console.info(bannerScreen);
//		console.info(bannerButton);

		$(".clsBannerScreen").append(bannerScreen);
		$(".clsBannerButton").append(bannerButton);

		$(function() {
			$("#bannerSkin3").jQBanner({		//롤링을 할 영역의 ID 값
				nWidth:600,						//영역의 width
				nHeight:150,						//영역의 height
				nCount:bannerCount,			//돌아갈 이미지 개수
				isActType:"left",					//움직일 방향 (left, right, up, down)
				nOrderNo:1,						//초기 이미지
				isStartAct:"N",
				isStartDelay:"Y",
				nDelay:2000,						//롤링 시간 타임 (1000 = 1초)
				isBtnType:"li"						//라벨(버튼 타입)
			});
		});
	});
//]]>
</script>
<div id="bannerSkin3">
	<div class="clsBannerScreen">

	</div>
	<ul class="clsBannerButton" id="label_2">
	</ul>
</div>
