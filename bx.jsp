<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<title>전남과학기술정보시스템</title>

<meta http-equiv="X-UA-Compatible" content="IE=10; IE=9; IE=8; IE=7"  />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />


<script type="text/javascript" src="/core/js/jquery.min.js"></script>
<!-- 
	<link href="/js/cms/front/bxslide/jquery.bxslider.css" rel="stylesheet" type="text/css" />
	    <script type="text/javascript" src="/js/cms/front/bxslide/jquery.bxslider.min.js"></script>
	    <script type="text/javascript" src="/js/cms/front/bxslide/js_allim3.js"></script> -->

<script type="text/javaScript">
//<![CDATA[
//	var telPattern = /^\[0-9]$/;
	var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
	function pt(){
		var input_text = $("#input_text").val();
		alert(input_text+":"+telPattern.test(input_text));
	}
//]]>
</script>
<style>

#popBox {position:relative;margin:0 auto;width:454px;height:234px;z-index:1;padding:0;border:0;overflow:hidden;}
#popBox .popWarp {padding:0;margin:0;border:0;}
#popBox .popWarp #p3box li { padding:0;margin:0;border:0;height:234px;}
#popBox .popWarp #p3box li a { padding:0;margin:0;border:0; }
#popBox .popWarp #p3box li a img { padding:0;margin:0;border:0; }


.tbl_type1 th{border:1px solid #ff0000;}
.tbl_type1 td{border:1px solid #ff0000;overflow:hidden;}

</style>
</head>
<body >

		<% 
			String daumKey = "09cdede77b4c4027e119e58c73d4e495";//실서버 운영키
			if( request.getRequestURL().indexOf("localhost:8080") > 0 ){
				daumKey = "1950e0038e121d1163985ed2bae5c660";//localhost:8080 테스트키		
			}
		%>
	<script src="http://apis.daum.net/maps/maps3.js?apikey=<%=daumKey %>&libraries=services" type="text/javascript"></script>
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map" style="width:300px;height:350px;"></div>
	
	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=발급받은 API KEY를 사용하세요"></script>
	<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	var map = new daum.maps.Map(mapContainer, mapOption); 
	</script>
</body>
</html>