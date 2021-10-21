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
	</script>
<div class="Cont101">
<dl class="Cont101List01">
<dt>주소</dt>
<dd>전라남도 영암군 삼호읍 대불주거3로 55 전남과학기술진흥센터</dd>
</dl>
<dl class="Cont101List02">
<dt>자가용</dt>
<dd>서영암 IC에서 25분 소요 &nbsp;&nbsp;&nbsp; / &nbsp;&nbsp;&nbsp; 목포IC에서 20분 소요</dd>
</dl>
<dl class="Cont101List03">
<dt>비행기</dt>
<dd>광주공항 → 송정리역 → 목포역 → 택시 21분 소요(시외요금적용) / 좌석버스 500번(약 50분 소요)</dd>
<dd>무안공항 → 택시 50분 소요(시외요금 적용)</dd>
</dl>
<dl class="Cont101List04">
<dt>고속버스</dt>
<dd>목포고속버스터미널 → 택시 15분 소요(시외요금적용) / 일반 13번, 좌석 500번, 일반 10번(약 50분 소요)</dd>
<dd>삼호읍시외버스터미널 → 택시 10분 소요(시외요금적용) / 좌석버스 500번(약 25 소요) </dd>
</dl>
<dl class="Cont101List05">
<dt>기차</dt>
<dd>목포역 → 택시 22분 소요(시외요금적용) / 좌석버스 500번(약 50분 소요)</dd>
<dd>임성리역 → 택시 14분 소요(시외요금적용) / 일반버스 10번, 좌석 800번, 좌석 500번(약 1시간 소요)</dd>
</dl>
</div>