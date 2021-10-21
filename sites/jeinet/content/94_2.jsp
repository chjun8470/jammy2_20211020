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

<script type="text/javascript" src="http://openapi.map.naver.com/openapi/v2/maps.js?clientId=VI7OH807qtUF8f6yzurq"></script>

<div  class="nav_box" id = "testMap"></div>
 
                <script type="text/javascript">
                        var oPoint = new nhn.api.map.LatLng(34.754750, 126.448923);
                        nhn.api.map.setDefaultPoint('LatLng');
                        oMap = new nhn.api.map.Map('testMap' ,{
                                                point : oPoint,
                                                zoom : 10,
                                                enableWheelZoom : true,
                                                enableDragPan : true,
                                                enableDblClickZoom : false,
                                                mapMode : 0,
                                                activateTrafficMap : false,
                                                activateBicycleMap : false,
                                                minMaxLevel : [ 1, 14 ],
                                                size : new nhn.api.map.Size(900, 400)
                       });
                       var markerCount = 0;
                        
                        var oSize = new nhn.api.map.Size(28, 37);
                        var oOffset = new nhn.api.map.Size(14, 37);
                        var oIcon = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);
                        
                        var mapInfoTestWindow = new nhn.api.map.InfoWindow(); // - info window 생성
                        mapInfoTestWindow.setVisible(false); // - infowindow 표시 여부 지정.
                        oMap.addOverlay(mapInfoTestWindow);     // - 지도에 추가.     
                        
                       var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
                        oMap.addOverlay(oLabel); // 
                         mapInfoTestWindow.attach('changeVisible', function(oCustomEvent) {
                                if (oCustomEvent.visible) {
                                        oLabel.setVisible(false);
                                }
                        });
        
        
                        oMap.attach('mouseenter', function(oCustomEvent) {
                                var oTarget = oCustomEvent.target;
                                // 마커위에 마우스 올라간거면
                                if (oTarget instanceof nhn.api.map.Marker) {
                                        var oMarker = oTarget;
                                        oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.
                                }
                        });
        
                        oMap.attach('mouseleave', function(oCustomEvent) {
                                var oTarget = oCustomEvent.target;
                                // 마커위에서 마우스 나간거면
                                if (oTarget instanceof nhn.api.map.Marker) {
                                        oLabel.setVisible(false);
                                }
                        });
                        

                         var oMarker = new nhn.api.map.Marker(oIcon, { title : '전남과학기술진흥센터'});
                                oMarker.setPoint(oPoint);
                                oMap.addOverlay(oMarker);
                </script>


<div class="Cont94">
<dl class="Cont94List01">
<dt>주소</dt>
<dd>전라남도 영암군 삼호읍 대불주거3로 55 전남과학기술진흥센터</dd>
</dl>
<dl class="Cont94List02">
<dt>자가용</dt>
<dd>서영암 IC에서 25분 소요 &nbsp;&nbsp;&nbsp; / &nbsp;&nbsp;&nbsp; 목포IC에서 20분 소요</dd>
</dl>
<dl class="Cont94List03">
<dt>비행기</dt>
<dd>광주공항 → 송정리역 → 목포역 → 택시 21분 소요(시외요금적용) / 좌석버스 500번(약 50분 소요)</dd>
<dd>무안공항 → 택시 50분 소요(시외요금 적용)</dd>
</dl>
<dl class="Cont94List04">
<dt>고속버스</dt>
<dd>목포고속버스터미널 → 택시 15분 소요(시외요금적용) / 일반 13번, 좌석 500번, 일반 10번(약 50분 소요)</dd>
<dd>삼호읍시외버스터미널 → 택시 10분 소요(시외요금적용) / 좌석버스 500번(약 25 소요) </dd>
</dl>
<dl class="Cont94List05">
<dt>기차</dt>
<dd>목포역 → 택시 22분 소요(시외요금적용) / 좌석버스 500번(약 50분 소요)</dd>
<dd>임성리역 → 택시 14분 소요(시외요금적용) / 일반버스 10번, 좌석 800번, 좌석 500번(약 1시간 소요)</dd>
</dl>
</div>