<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();


	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String fileGrp = "jnsptotal";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
	String mode = util.getStr(paramMap.get("mode"));

	String m = util.getStr(paramMap.get("m"));

	String listMode = util.getStr(paramMap.get("listMode"));
	String rndEquIdx = util.getStr(paramMap.get("rndEquIdx"));
	String nowPage = util.getStr(paramMap.get("nowPage"));
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");

	String favMsg=util.getStr(paramMap.get("favMsg"));
	String userFavCount=util.getStr(paramMap.get("userFavCount"));


%>


<!--MoreView S-->
<div class="MoreView">

	<dl class="MoreView01">
		<dt>활용범위</dt>
		<%if(util.getStr(dataMap.get("USE_SCOPE_CD")).equals("2")) { %>
		<dd class="no_line on">공동활용허용</dd>
		<dd class="line">공동활용서비스</dd>
		<% } else if(util.getStr(dataMap.get("USE_SCOPE_CD")).equals("3")) { %>
		<dd class="line">공동활용허용</dd>
		<dd class="no_line on">공동활용서비스</dd>
		<% } else { %>
		<dd class="no_line">공동활용허용</dd>
		<dd class="line">공동활용서비스</dd>
		<% } %>
	</dl>

	<dl class="MoreView02" >

		<% if( util.getStr(dataMap.get("USE_SCOPE_CD")).equals("2") ){ %>
			<dt>활용대상</dt>
			<%if(util.getStr(dataMap.get("USE_SCOPE_RANGE")).equals("기관내부활용")) { %>
			<dd class="no_line on">기관내부활용</dd>
			<dd class="line">기관외부활용</dd>
			<% } else if(util.getStr(dataMap.get("USE_SCOPE_RANGE")).equals("기관외부활용")) { %>
			<dd class="no_line">기관내부활용</dd>
			<dd class="line on">기관외부활용</dd>
			<% } else { %>
				<dd class="no_line">&nbsp;-&nbsp;</dd>
			<% } %>
		<% } %>
	</dl>


	<dl class="MoreView03">
		<dt>예약방법</dt>
		<dd class="no_line on">온라인예약</dd>
		<!-- <dd class="no_line">오프라인예약</dd> -->
	</dl>

	<dl class="MoreView04">
		<% if( !util.getStr(dataMap.get("USE_SCOPE_CD")).equals("1") ){ %>
			<dt>이용방법</dt>

			<%if(util.getStr(dataMap.get("USE_SCOPE_MEAN")).equals("대여")) { %>
				<dd class="no_line on">대여</dd>
				<dd class="line">분석ㆍ시험의뢰</dd>
				<dd class="line">직접사용</dd>

			<% } else if(util.getStr(dataMap.get("USE_SCOPE_MEAN")).equals("분석ㆍ시험 의뢰")) { %>
				<dd class="no_line">대여</dd>
				<dd class="line on">분석ㆍ시험의뢰</dd>
				<dd class="line">직접사용</dd>

			<% } else if(util.getStr(dataMap.get("USE_SCOPE_MEAN")).equals("이용자 직접사용")) { %>
				<dd class="no_line">대여</dd>
				<dd class="line">분석ㆍ시험의뢰</dd>
				<dd class="line on">직접사용</dd>

			<% } else if(util.getStr(dataMap.get("USE_SCOPE_MEAN")).equals("모두 가능")) { %>
				<dd class="no_line on">대여</dd>
				<dd class="line on">분석ㆍ시험의뢰</dd>
				<dd class="line on">직접사용</dd>

			<% } else { %>
				<dd class="no_line">대여</dd>
				<dd class="line">분석ㆍ시험의뢰</dd>
				<dd class="line">직접사용</dd>
			<% } %>
		<% } %>
	</dl>

</div>
<!--MoreView E-->


<div class="MoreImg">
<%if(util.getStr(dataMap.get("TITLE")).equals("") || util.getStr(dataMap.get("TITLE")).equals(null)) { %>
	<img src="/img/board/img_sample4.jpg" width="400" height="282" alt="없는이미지"/>
<% } else { %>
	<img src="<%=util.getStr(dataMap.get("FILE_PATH"))+util.getStr(dataMap.get("TITLE"))%>" width="400" height="282" alt="장비사진"/>
<% } %>
</div>

<div class="MoreTxt">

	<div class="MoreTop">
		<div class="MoreTopNo">고정자산관리번호 : <%=util.getStr(dataMap.get("FIXED_ASET_NO"))%>
			<div class="star_publist_blog01">
			<%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("1")) { %> <img src="/img/board/star1.png" alt="1점" /> 1점 <% } %>
			<%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("2")) { %> <img src="/img/board/star2.png" alt="2점" /> 2점 <% } %>
			<%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("3")) { %> <img src="/img/board/star3.png" alt="3점" /> 3점 <% } %>
			<%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("4")) { %> <img src="/img/board/star4.png" alt="4점" /> 4점 <% } %>
			<%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("5")) { %> <img src="/img/board/star5.png" alt="5점" /> 5점 <% } %>
			<%if(util.getStr(dataMap.get("EQU_SATISFACTION")).equals("")) { %> <img src="/img/board/star5.png" alt="0점" /> 5점 <% } %>
			</div>
		</div>
	</div>

	<h4 class="MoreViewTit"><%=util.getStr(dataMap.get("KOR_NM"))%></h4>


	<dl>
		<dt>제작사 / 모델명</dt>
		<dd><%=util.getStr(dataMap.get("MANUFACTURE_NM"))%>&nbsp;/&nbsp;<%=util.getStr(dataMap.get("MODEL_NM"))%>&nbsp;</dd>

		<dt>구축일자</dt>
		<dd><%=util.getStr(dataMap.get("TAKE_SDT"))%>&nbsp;</dd>

		<dt>보유기관</dt>
		<dd><%=util.getStr(dataMap.get("OWN_ORG_NM"))%>&nbsp;
		<% if( !util.getStr(dataMap.get("OWN_ORG_SUB_NM")).equals("") ){ %>
			/&nbsp;<%=util.getStr(dataMap.get("OWN_ORG_SUB_NM"))%>
		<% } %>
		</dd>

		<dt>장비용도</dt>
		<dd><%=util.getStr(dataMap.get("USE_TYPE_CD"))%>&nbsp;</dd>

		<dt>표준분류</dt>
		<dd><%=util.getStr(dataMap.get("BRANCH_NM"))%>&nbsp;</dd>
	</dl>

	<br/>
	<div class="b_btn_area3">
		<%if(!"".equals(util.getStr(loginVO.getUserIdx()))) {%>
			<button class="btn_w_02" type="button" onclick="resveGo()" style="margin-right:5px">예약하기</button>
		<% } else { %>
			<button class="btn_w_02" type="button" onclick="ssoPopupShow('login')"  style="margin-right:5px">예약하기</button>
		<% } %>


		<%if(!"".equals(util.getStr(loginVO.getUserIdx()))) { %>
			<button class="btn_w_02" type="button" onclick="pageFavGo('<%=util.getStr(paramMap.get("rndEquIdx"))%>')">장바구니</button>
		<%} else { %>
			<button class="btn_w_02" type="button" onclick="ssoPopupShow('login')">장바구니</button>
		<% } %>

	</div>
</div>


<div class="MoreViewEX">
	<dl>	
		<dt>장비설명</dt>
		<dd>&nbsp;<%=util.getStr(dataMap.get("EQUIP_DETAIL_FEATURE"))%></dd>
		
		<dt>구성 및 기능</dt>
		<dd>&nbsp;<%=util.getStr(dataMap.get("EQUIP_DETAIL_CAPABILITY"))%></dd>
		
		<dt>사용 예</dt>
		<dd>&nbsp;<%=util.getStr(dataMap.get("EQUIP_DETAIL_EXAMPLE"))%></dd>
		
		<dt>이용안내</dt>
		<dd>&nbsp;<%=util.getStr(dataMap.get("HOW_USE"))%></dd>
		
		<dt>유의사항</dt>
		<dd>&nbsp;<%=util.getStr(dataMap.get("EQU_ATTENTION"))%></dd>
		
		<dt>이용료안내</dt>
		<dd>&nbsp;<%=util.getStr(dataMap.get("RENTAL_INFO"))%></dd>
			
		<dt>설치장소</dt>
		<%if( !util.getStr(dataMap.get("MAP_X")).equals("") && !util.getStr(dataMap.get("MAP_Y")).equals("") ) { %>
			<dd class="map">
		<% }else{%>
			<dd>
		<% } %>
			<p>&nbsp;&nbsp;&nbsp;<%=util.getStr(dataMap.get("LOCATION")) %> <%=util.getStr(dataMap.get("LOCATION_DTL")) %></p>
			<!--지도들어갈자리-->			
			<%if( !util.getStr(dataMap.get("MAP_X")).equals("") && !util.getStr(dataMap.get("MAP_Y")).equals("") ) { %>
					<div id="map" style="width:100%;height:250px;margin-top:10px;"></div>
			<% } %>
		</dd>
		
		<dt>담당자정보</dt>
		<dd>
			<table class="skin_basic_write">
             <colgroup>
              <col style="width:10%" />
              <col style="width:15%" />
              <col style="width:10%" />
              <col style="width:15%" />
             </colgroup>
				<tr>
					<th>기관명</th>
					<td id="operChargerTd">
						<%=util.getStr(dataMap.get("OPER_ORG_GRP")) %>
					</td>
					<th>부서명</th>
					<td id="operPositionTd">
						<%=util.getStr(dataMap.get("OPER_ORG_GRP_SUB")) %>
					</td>
				</tr>
				<tr>
					<th>담당자</th>
					<td id="operChargerTd">
						<%=util.getStr(dataMap.get("OPER_CHARGER")) %>
					</td>
					<th>직위</th>
					<td id="operPositionTd">
						<%=util.getStr(dataMap.get("OPER_POSITION")) %>
					</td>
				</tr>
				<tr>
					<th>전화번호</th>
					<td id="operTelTd">
						<%=util.getStr(dataMap.get("OPER_TEL")) %>
					</td>
					<th>이메일</th>
					<td id="operEmailTd">
						<%=util.getStr(dataMap.get("OPER_EMAIL")) %>
					</td>
				</tr>
			</table>
		</dd>
	</dl>
</div>


<!-- bo_btn  -->
<div class="btn_box">
   	<div class="btn_right_box">
   		<button class="btn_lft2" type="button" onclick="pageListGo()">목록</button>
	</div>
</div>
<!--// bo_btn -->



<form id = "fview" name = "fview" method="post" action="sub.do?m=53">
	<input type="hidden" id="mode" 					name="mode" 				value="<%=mode%>"/>
	<input type="hidden" id="reUrl"  				name="reUrl" 				value="?m=<%=m%>&amp;mode=view&amp;listMode=<%=listMode%>&amp;nowPage=<%=nowPage%>&amp;rndEquIdx=<%=rndEquIdx%>" />
	<input type="hidden" id="reject"  				name="reject" 				value="" />
	<input type="hidden" id="m"  					name="m" 					value="53" />
	<input type="hidden" id="favYn"  				name="favYn" 				value="" />
	<input type="hidden" id="listMode" 				name="listMode" 			value="<%=listMode%>" />
	<input type="hidden" id="rndEquIdx" 			name="rndEquIdx" 			value="<%=util.getStr(paramMap.get("rndEquIdx"))%>"/>

	<input type="hidden" id="searchUseScopeCd" 		name="searchUseScopeCd" 	value="<%=util.getStr(paramMap.get("searchUseScopeCd"))%>"/>
	<input type="hidden" id="searchUseScopeRange" 	name="searchUseScopeRange" 	value="<%=util.getStr(paramMap.get("searchUseScopeRange"))%>"/>
	<input type="hidden" id="searchUseScopeMean" 	name="searchUseScopeMean" 	value="<%=util.getStr(paramMap.get("searchUseScopeMean"))%>"/>
	<input type="hidden" id="searchUseTypeCd" 		name="searchUseTypeCd" 		value="<%=util.getStr(paramMap.get("searchUseTypeCd"))%>"/>
	<input type="hidden" id="searchWord" 			name="searchWord" 			value="<%=util.getStr(paramMap.get("searchWord"))%>"/>
</form>

<script type="text/javascript">
//<![CDATA[
<%if(util.getStr(paramMap.get("favMsg")) != null) { %>
	<%if(!"".equals(util.getStr(paramMap.get("favMsg")))) {%>
		alert("<%=favMsg%>");
	<%} %>
<%} %>

	function pageListGo(){
		$('#mode').val('list');
		$('#fview').submit();
	}
	function resveGo(){
		$('#mode').val('write');
		$('#fview').submit();
	}
	function pageEditGo(){
		$('#mode').val('edit');
		$('#fview').submit();
	}
	function resveReturnDisplay(){
		$('#rejectDisplayDiv').show();
	}

	function pageFavGo(idx){
		var userFavCount = <%=userFavCount%>
		if(userFavCount >=1){
			alert("이미 장바구니에 등록된 상품입니다.");
			return false;
		}else {

		//alert("userFavCount:"+userFavCount);
		//alert("idx :" + idx);
		$('#mode').val('view');
		$('#favYn').val('Y');

		//$('#rndEquIdx').val(idx);
		//$('#reUrl').val("sub.do");
		$('#fview').attr('action','?<%=m%>');
		//$('#searchForm').attr('method','get');
		$('#fview').submit();
		}
	}

	var mapX = '<%=util.getStr(dataMap.get("MAP_X"))%>';
	var mapY = '<%=util.getStr(dataMap.get("MAP_Y"))%>';
		//alert("mapX: "+mapX +"/ mapY:"+ mapY);

<%if(!util.getStr(dataMap.get("MAP_X")).equals(null) && !util.getStr(dataMap.get("MAP_X")).equals("")) { %>
	<%if(!util.getStr(dataMap.get("MAP_Y")).equals(null) && !util.getStr(dataMap.get("MAP_Y")).equals("")) { %>

	var mapContainer = document.getElementById('map'), // 지도를 표시할 div
    mapOption = {
        center: new daum.maps.LatLng(mapX, mapY), // 지도의 중심좌표
        level: 5 // 지도의 확대 레벨
    };

//지도를 미리 생성
var map = new daum.maps.Map(mapContainer, mapOption);
//주소-좌표 변환 객체를 생성
var geocoder = new daum.maps.services.Geocoder();
//마커를 미리 생성
var marker = new daum.maps.Marker({
    position: new daum.maps.LatLng(mapX, mapY),
    map: map
});

function find_location() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var fullAddr = data.address; // 최종 주소 변수
            var extraAddr = ''; // 조합형 주소 변수

            // 기본 주소가 도로명 타입일때 조합한다.
            if(data.addressType === 'R'){
                //법정동명이 있을 경우 추가한다.
                if(data.bname !== ''){
                    extraAddr += data.bname;
                }
                // 건물명이 있을 경우 추가한다.
                if(data.buildingName !== ''){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
            }

            // 주소 정보를 해당 필드에 넣는다.
            //$("#location").val(fullAddr);
            // 주소로 좌표를 검색
            geocoder.addr2coord(data.address, function(status, result) {
                // 정상적으로 검색이 완료됐으면
                if (status === daum.maps.services.Status.OK) {
                    // 해당 주소에 대한 좌표를 받아서
                    var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
                       $("#mapX").val(result.addr[0].lat);
                       $("#mapY").val(result.addr[0].lng);
                    // 지도를 보여준다.
                    mapContainer.style.display = "block";
                    map.relayout();
                    // 지도 중심을 변경한다.
                    map.setCenter(coords);
                    // 마커를 결과값으로 받은 위치로 옮긴다.
                    marker.setPosition(coords)
                }
            });
        }
    }).open();
}

daum.maps.event.addListener(map, 'click', function(mouseEvent) {
       searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
            if (status === daum.maps.services.Status.OK) {

                  // 클릭한 위도, 경도 정보를 가져옵니다
                  var latlng = mouseEvent.latLng;
                  // 마커 위치를 클릭한 위치로 옮깁니다
                  marker.setPosition(latlng);
                  //페이지에 값 넣어주기(상세주소, X좌표, Y좌표)
               //$("#location").val(result[0].jibunAddress.name);
                  $("#mapX").val(latlng.getLat());
               $("#mapY").val(latlng.getLng());

               marker.setMap(map);

            }
       });
 });

 // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
 daum.maps.event.addListener(map, 'idle', function() {
       searchAddrFromCoords(map.getCenter(), displayCenterInfo);
 });

 function searchAddrFromCoords(coords, callback) {
       // 좌표로 행정동 주소 정보를 요청합니다
       geocoder.coord2addr(coords, callback);
 }

 function searchDetailAddrFromCoords(coords, callback) {
       // 좌표로 법정동 상세 주소 정보를 요청합니다
       geocoder.coord2detailaddr(coords, callback);
 }

 // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
 function displayCenterInfo(status, result) {
       if (status === daum.maps.services.Status.OK) {
            $("#centerAddr").html(result[0].fullName);
       }
 }

 	<% } %>
<% } %>
//]]>
</script>
