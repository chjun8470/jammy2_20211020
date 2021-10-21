<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.util.CriptUtil"%>
<% 
	request.setCharacterEncoding("UTF-8");
	ComUtil util = new ComUtil();
	CriptUtil ctuil = new CriptUtil();
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	String mode = util.getStr(request.getParameter("mode"));
	String listMode = util.getStr(request.getParameter("listMode"));
	String nowPage = util.getStr(request.getParameter("nowPage"),"0");
	String searchType = util.getStr(request.getParameter("searchType"));
	String searchWord = util.getStr(request.getParameter("searchWord"));
	String boardIdx = util.getStr(request.getParameter("boardIdx"));
	String m = util.getStr(request.getParameter("m"));
%>

	<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=VI7OH807qtUF8f6yzurq"></script>
	<div  class="nav_box" id = "testMap"></div>
	<script type="text/javascript">
	//<![CDATA[
		var oPoint = new naver.maps.LatLng(34.754750, 126.448923);
		var oSize = new naver.maps.Size(930, 400);
		var mapOptions = {
			center: oPoint,
			zoom: 12
		}
		var map = new naver.maps.Map('testMap', mapOptions);
		var marker = new naver.maps.Marker({
			position: oPoint,
			map: map
		});
		var contentString = ['<h4 style="padding:5px;">전남과학기술진흥센터</h4>'].join('');
		var infowindow = new naver.maps.InfoWindow({
			content: contentString
		});
		infowindow.open(map, marker);
		$(window).resize(function(){
			map.setSize(new naver.maps.Size($("#testMap").width(), 400));
			map.refresh(false);
			map.setCenter(oPoint);
		});
		//]]>
	</script>
<div class="Cont101">
<dl class="Cont101List01">
<dt>주소</dt>
<dd>전라남도 순천시 해룡면 율촌산단4로 13 전남테크노파크</dd>
</dl>
<dl class="Cont101List02">
<dt>자가용</dt>
<dd>순천IC 통과후 순천자동차전용도로(여수방면)으로 10분~15분</dd>
</dl>
<dl class="Cont101List03">
<dt>비행기</dt>
<dd>여수공항 → 택시 : 15분소요(시외요금 적용)</dd>
</dl>
<dl class="Cont101List04">
<dt>고속버스</dt>
<dd>순천 고속터미널 → 일반버스 : 21번 (약 1시간 소요)</dd>
<dd>순천 고속터미널 → 택시 : 40분 소요 (시외요금 적용)</dd>
<dd>광양 고속터미널 → 택시 : 15~20분 소요 (시외요금 적용)</dd>
</dl>
<dl class="Cont101List05">
<dt>기차</dt>
<dd>순천역 → 일반버스 : 21번</dd>
</dl>
</div>