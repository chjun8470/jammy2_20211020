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
	.clsBannerButton {width:600px;cursor:pointer;border-bottom:1px solid #e1e1e1;}
	.clsBannerButton li {width:100px;float:left;border-right:1px solid #e1e1e1;padding:2px;}
	.clsBannerButton li.fir {border-left:1px solid #e1e1e1;}
	.clsBannerButton li.labelOverClass {font-weight:bold;}
</style>
<script type="text/javascript" src="/js/jquery.banner.js"></script>
<script type="text/javascript">
//<![CDATA[
	$.getJSON("/file/banner/bannerData.txt", function(json) {

		var bannerHtml = "";
		var bannerCount = json.length;

		$.each(json, function(key) {
			bannerHtml += "<div class='images'>";
			bannerHtml += "	<a href=\"" + json[key].LINK_URL + "\" target='" + json[key].LINK_TARGET + "' >";
			bannerHtml += "		<img src=\"" + json[key].IMG_SRC + "\" width='600px' height='150px'>";
			bannerHtml += "	</a>";
			bannerHtml += "</div>";
		});

//		console.info(bannerHtml);

		$(".clsBannerScreen").append(bannerHtml);

		$(function() {
			$("#bannerSkin2").jQBanner({		//????????? ??? ????????? ID ???
				nWidth:600,						//????????? width
				nHeight:150,						//????????? height
				nCount:bannerCount,			//????????? ????????? ??????
				isActType:"up",					//????????? ?????? (left, right, up, down)
				nOrderNo:1,						//?????? ?????????
				nDelay:2000						//?????? ?????? ?????? (1000 = 1???)
			});
		});
	});
//]]>
</script>
<div id="bannerSkin2">
	<div class="clsBannerScreen">

	</div>
</div>
