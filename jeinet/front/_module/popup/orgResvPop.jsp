<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ include file="/front/_temple/popup/t_top.jsp" %>
<%
	String display = "sub";
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	String fileGrp = "orgManage";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	ArrayList<HashMap<String, String>> companyType = request.getAttribute("companyType") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("companyType");
	ArrayList<HashMap<String, String>> agencyType = request.getAttribute("agencyType") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("agencyType");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));
%>

<style type="text/css" scoped>

#bgLayer {
  position:fixed;
  left:0;
  top:0;
  z-index:1001;
  width:100%;
  height:100%;
  -ms-filter: "progid:DXImageTransform.Microsoft.Alpha(Opacity=50)";
  filter: alpha(opacity=50);
  -khtml-opacity: 0.5;
  -moz-opacity: 0.5;
  opacity:0.5;
  background-color:#000;
  display:none;

}

#dataCheck{
 position:fixed;
  z-index:1002;
  width:400px;
  min-height:200px;
  background-color:#FFFFFF;
  display:none;
  text-align: left;
}

</style>


<div id="bgLayer" onclick="dataCheckExit();"></div>
<div id="dataCheck"></div>

<form id="fwrite" name="fwrite" method="post" action="/web/webOrgManageProc.do" enctype="multipart/form-data" >
	<input type="hidden" id="mode" name="mode" value="write" />

	<div class="agreeWrap" style="width:100%;">
		<div class="agreeBox1" style="padding-bottom:20px;margin-top:0px">
			<div class="tit_agree">
			<%=util.getStr(paramMap.get("orgType")).equals("1")?"기업 등록신청":"" %>
			<%=util.getStr(paramMap.get("orgType")).equals("2")?"기관/센터 등록신청":"" %>
			<%=util.getStr(paramMap.get("orgType")).equals("")?"기업/기관 등록신청":"" %>
			</div>
		</div>
		<div class="left_box w75" style="width:100%">

			<div class="both">
				<div class="fr">
					<!-- 기본정보영역 -->
					<table class="skin_basic_write">
						<colgroup>
							<col style="width:20%;" />
							<col style="width:30%;" />
							<col style="width:20%;" />
							<col style="width:30%;" />
						</colgroup>
						<tbody>
							<%if(util.getStr(paramMap.get("orgType")).equals("1")) { %>
							<th scope="col">기업분류</th>
								<td colspan="3">
								<%for(HashMap rs : companyType) { %>
									<input type="radio" name="companyType" value="<%=rs.get("CODE_CD") %>" /><%=rs.get("CODE_NM") %>
								<% } %>
								</td>
							<% } %>
							<%if(util.getStr(paramMap.get("orgType")).equals("2")) { %>
							<th scope="col">기관분류</th>
								<td colspan="3">
								<%for(HashMap rs : agencyType) { %>
									<input type="radio" name="agencyType" value="<%=rs.get("CODE_CD") %>" /><%=rs.get("CODE_NM") %>
								<% } %>
								</td>
							<% } %>
							<%if(util.getStr(paramMap.get("orgType")).equals("")){%>
							<tr>
								<th scope="col"><label for="orgType1">기업/기관구분</label></th>
								<td colspan="3">
									<label><input type="radio" id="orgType1" name="orgType" value="1"/>기업</label>
									<label><input type="radio" id="orgType2" name="orgType" value="2"/>기관/센터</label>
								</td>
							</tr>
							<%}else{ %>
							<input type="hidden" name="orgType" id="orgType" value="<%=util.getStr(paramMap.get("orgType"))%>"/>
							<%}%>


							<!--<tr style="display:none" id="authCdTr">
								<th scope="col"><label for="authCd1">관리권한</label></th>
								<td colspan="3">
									<label><input type="radio" id="authCd1" name="authCd" value="1"/>일반</label>
									<label><input type="radio" id="authCd2" name="authCd" value="2"/>관리자</label>
								</td>
							</tr>-->
							<%if(util.getStr(paramMap.get("orgType")).equals("2")) { %>
							<tr id="authOrgSiteTr">
								<th scope="col"><label for="authOrgSite1">사용사이트</label></th>
								<td colspan="3">
									<label>
									<input type="checkbox" id="authOrgSite1" name="authOrgSite1" value="Y" />전남연구장비정보망&nbsp;&nbsp;
									</label>
									<label>
									<input type="checkbox" id="authOrgSite2" name="authOrgSite2" value="Y" />전남지식재산정보은행&nbsp;&nbsp;
									</label>
									<label>
									<input type="checkbox" id="authOrgSite3" name="authOrgSite3" value="Y" />전남과학기술정보시스템
									</label>
								</td>
							</tr>
							<% } %>
							<tr>
								<th scope="col"><label for="orgGrpNm"><%=util.getStr(paramMap.get("orgType")).equals("1")?"기업명":"기관명(국문)"%></label></th>
								<td <% if(util.getStr(paramMap.get("orgType")).equals("1")) { %> colspan="3" <% } else { %> scope="col" <% } %>><input type="text" class="inp_text" id="orgGrpNm" name="orgGrpNm" maxlength="25" style="width: 98%"></td>
								<%if(util.getStr(paramMap.get("orgType")).equals("2")) { %>
								<th scope="col"><label for="orgEngNm">기관명(영문)</label></th>
								<td scope="col"><input type="text" class="inp_text" name="orgEngNm" id="orgEngNm" maxlength="50" style="width: 98%" /></td>
								<% } %>
							</tr>
							<tr>
								<th scope="col"><label for="areaCd1">소속지역</label></th>
								<td colspan="3">
									<label>
										<input type="radio" id="areaCd1" name="areaCd" value="1" />전라남도
									</label>
									<label>
										<input type="radio" id="areaCd1" name="areaCd" value="2"/>지역 외
									</label>
								</td>
							</tr>
							<tr>
								<th scope="col"><label for="ornerNm">대표자명</label></th>
								<td colspan="3"><input type="text" class="inp_text" id="ornerNm" name="ornerNm" maxlength="10"></td>

							</tr>
							<%if(util.getStr(paramMap.get("orgType")).equals("1")) {  %>
							<tr>
								<th scope="col"><label for="corpNum1">사업자등록번호</label></th>
								<td scope="col">
									<input type="text" class="inp_text" id="corpNum1" name="corpNum1" maxlength="20" style="width: 98%">
									<br/><span class="required" style="color: red;">하이픈(-)없이 입력해주세요.</span>
								</td>
								<th scope="col"><label for="workType">업종</label></th>
								<td scope="col"><input type="text" class="inp_text" id="workType" name="workType" style="width: 98%"/></td>
							</tr>
							<tr>
								<th scope="col"><label for="corpNum2">법인등록번호</label></th>
								<td scope="col">
									<input type="text" class="inp_text" id="corpNum2" name="corpNum2" maxlength="20" style="width: 98%">
									<br/><span class="required" style="color: red;">하이픈(-)없이 입력해주세요.</span>
								</td>
								<th scope="col"><label for="businessCon">업태</label></th>
								<td scope="col"><input type="text" class="inp_text" id="businessCon" name="businessCon" style="width: 98%"/></td>
							</tr>
							<% } else { %>
							<tr>
								<th scope="col"><label for="corpNum1">사업자등록번호</label></th>
								<td scope="col">
									<input type="text" class="inp_text" id="corpNum1" name="corpNum1" maxlength="20" style="width: 98%">
									<br/><span class="required" style="color: red;">하이픈(-)없이 입력해주세요.</span>
								</td>
								<th scope="col"><label for="corpNum2">법인등록번호</label></th>
								<td scope="col">
									<input type="text" class="inp_text" id="corpNum2" name="corpNum2" maxlength="20" style="width: 98%">
									<br/><span class="required" style="color: red;">하이픈(-)없이 입력해주세요.</span>
								</td>
							</tr>
							<% } %>
						<tr>
							<th scope="col"><label for="corpPhone">대표전화</label></th>
							<td ><input type="text" class="inp_text" id="corpPhone" name="corpPhone" maxlength="20" style="width: 98%"></td>
							<th scope="col"><label for="corpFax">FAX번호</label></th>
							<td ><input type="text" class="inp_text" id="corpFax" name="corpFax" maxlength="20" style="width: 98%"></td>
						</tr>
						<tr>
							<th scope="col"><label for="homepage">홈페이지</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="homepage" name="homepage" maxlength="50" style="width: 100%"></td>
						</tr>
						<tr>
							<th scope="col"><label for="addr1">주소</label></th>
							<td colspan="3">
								<input type="text" class="inp_text" id="zipcode" name="zipcode" maxlength="10" readonly="readonly">
								<input type="text" class="inp_text" id="addr1" name="addr1" maxlength="50" readonly="readonly">
								<input type="button" id = "orgPostButton" value="찾아보기" class="btn_inp_b_01" onclick = "orgPost()" />

							</td>
						</tr>
						<tr>
							<th scope="col"><label for="addr2">상세주소</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="addr2" name="addr2" maxlength="50" style="width:100%;"></td>
						</tr>
						<%
						/*
						<tr style="display:none" id="userIdxTr">
							<th scope="col"><label for="name">기관관리자</label></th>
							<td colspan="3">
								<input type="hidden" id="num1" name="userIdx" maxlength="15" >
								<input type="text" class="inp_text" id="name" name="name" maxlength="15" >
								<input type="button" name="userData" id="userData" value="조회" onclick="popupWindow('userList')" class="btn_inp_b_01">
							</td>
						</tr>
						*/
						%>
						<tr>
							<th scope="col"><label for="mapX">지도</label></th>
							<td colspan="3">
							<input type="hidden" id="mapX" name="mapX" maxlength="20">
							<input type="hidden" id="mapY" name="mapY" maxlength="20">
							<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="orgNote1">소개</label></th>
							<td colspan="3"><textarea id="orgNote1" name="orgNote1" cols="75" rows="4" maxlength="500"></textarea></td>
						</tr>
						<tr>
							<th scope="col"><label for="<%=fileFullGrp%>File1"><%=util.getStr(paramMap.get("orgType")).equals("1")?"기업":"기관"%>소개자료</label></th>
							<td colspan="3"><input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
							<input type="hidden" name="fileSn" value="1"/>
							<br/><span class="required" style="color: red;">PDF 확장자 파일만 업로드가능합니다.</span>
							</td>

						</tr>
						<%if(util.getStr(paramMap.get("orgType")).equals("1")) {  %>
						<tr>
							<th scope="col"><label for="bizRegDocFile1">사업자등록증</label></th>
							<td colspan="3"><input type="file" name="bizRegDocFile1"  id="bizRegDocFile1"  title="파일첨부" />
							<input type="hidden" name="fileSn" value="1"/>
							<br/><span class="required" style="color: red;">PDF, jpg 확장자 파일만 업로드가능합니다.</span>
							</td>

						</tr>
						<% } %>
						<tr>
							<th scope="col"><label for="orgCiFile1">CI이미지</label></th>
							<td colspan="3"><input type="file" name="orgCiFile1"  id="orgCiFile1"  title="파일첨부" />
							<input type="hidden" name="fileSn" value="1"/>
							<br/><span class="required" style="color: red;">150*50 픽셀의 이미지(bmp, gif, jpg, jpeg, png)를 등록해 주세요.</span>
							</td>
						</tr>
						<%if(util.getStr(paramMap.get("orgType")).equals("1")) {  %>
						<tr id="labUse">
							<th scope="col"><label for="labUse1">연구소 유무</label></th>
							<td colspan="3">
								<label><input type="radio" id="labUse1" name="labUse" value="Y"/>유</label>
								<label><input type="radio" id="labUse2" name="labUse" value="N"/>무</label>
							</td>
						</tr>
						<tr id="labNameLine" style="display:none;">
							<th scope="col"><label for="labName">연구소 이름</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="labName" name="labName" maxlength="100"></td>
						</tr>
						<tr id="labFaxLine" style="display:none;">
							<th scope="col"><label for="labPhone">연구소 전화번호</label></th>
							<td scope="col"><input type="text" class="inp_text" id="labPhone" name="labPhone" maxlength="20"></td>
							<th scope="col"><label for="labFax">연구소 FAX</label></th>
							<td scope="col"><input type="text" class="inp_text" id="labFax" name="labFax" maxlength="20"></td>
						</tr>
						<tr id="labAddr1Line" style="display:none;">
							<th scope="col"><label for="labAddr1">연구소 주소</label></th>
							<td colspan="3">
								<input type="text" class="inp_text" id="labZipcode" name="labZipcode" maxlength="10" readonly="readonly">
								<input type="text" class="inp_text" id="labAddr1" name="labAddr1" maxlength="50" readonly="readonly">
								<input type="button" id = "orgPostButton" value="찾아보기" class="btn_inp_b_01" onclick = "labPost()" />
							</td>
						</tr>
						<tr id="labAddr2Line" style="display:none;">
							<th scope="col"><label for="labAddr2">연구소 상세주소</label></th>
							<td colspan="3"><input type="text" class="inp_text" id="labAddr2" name="labAddr2" maxlength="50" style="width:100%;"></td>
						</tr>
						<tr id="labMapLine" style="display:none;">
							<th scope="col"><label for="labMapX">연구소 지도</label></th>
							<td colspan="3">
							<input type="text" class="inp_text" id="labMapX" name="labMapX" maxlength="20" style="display: none;">,
							<input type="text" class="inp_text" id="labMapY" name="labMapY" maxlength="20" style="display: none;">
							<div id="labMap" style="width:100%;height:300px;margin-top:10px;"></div>
							</td>
						</tr>
						<% } %>
					</tbody>
				</table>
				</div>
			</div>
			<div class="btn_box">
				<div class="btn_right_box" style="float:right;padding-right:20px">
					<button class="btn_inp_b_01" type="button" onclick="submitGo()">등록</button>
					<button class="btn_inp_w_01" type="button" onclick="window.close()">취소</button>
				</div>
			</div>
			</div>

	</div>
</form>

<script type="text/javascript">
document.title="전남과학기술정보시스템";

function popupWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

	var popUrl="/web/popup/"+listMode+".do";
	var popOption="width=500, height=550, resizable=no, scrollbars=no, status=no;";
	window.open(popUrl,"",popOption);
}

var telPattern = /^\d{2,3}\-\d{3,4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

	function pageListGo() {
		$('#mode').val('list');
		$('#fwrite').submit();
	}

	//////////////////검색관련

	function orgPost(){
	    new daum.Postcode({
	        oncomplete: function(data) {

	             $("#zipcode").val(data.zonecode);
	             $("#addr1").val(data.address);
	             $("#addr2").focus();

	             if(data.address.indexOf("전남")>-1||data.address.indexOf("광주")>-1){
	            	 $('input:radio[name=areaCd]:input[value=1]').attr("checked", "checked");
	             }else{
	            	 $('input:radio[name=areaCd]:input[value=2]').attr("checked", "checked");
	            	}

	             /**/
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
	////////////////지이도

    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(35.2268795, 126.8429492), // 지도의 중심좌표
            //center: new daum.maps.LatLng(35.2268795, 126.8429492),

            level: 5 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(35.2268795, 126.8429492),
        map: map
    });

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


 <%if(util.getStr(paramMap.get("orgType")).equals("1")) {  %>
     function labPost(){
	    new daum.Postcode({
	        oncomplete: function(data) {

	             $("#labZipcode").val(data.zonecode);
	             $("#labAddr1").val(data.address);
	             $("#labAddr2").focus();

	             if(data.address.indexOf("전남")>-1||data.address.indexOf("광주")>-1){
	            	 $('input:radio[name=areaCd]:input[value=1]').attr("checked", "checked");
	             }else{
	            	 $('input:radio[name=areaCd]:input[value=2]').attr("checked", "checked");
	            	}

	             /**/
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
	                labGeocoder.addr2coord(data.address, function(status, result) {
	                    // 정상적으로 검색이 완료됐으면
	                    if (status === daum.maps.services.Status.OK) {
	                        // 해당 주소에 대한 좌표를 받아서
	                        var coords = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
	                           $("#labMapX").val(result.addr[0].lat);
	                           $("#labMapY").val(result.addr[0].lng);
	                        // 지도를 보여준다.
	                        labMapContainer.style.display = "block";
	                        labMap.relayout();
	                        // 지도 중심을 변경한다.
	                        labMap.setCenter(coords);
	                        // 마커를 결과값으로 받은 위치로 옮긴다.
	                        labMarker.setPosition(coords)
	                    }
	                });

	        }
	    }).open();
	}

     //연구소 지도
     var labMapContainer = document.getElementById('labMap'), // 지도를 표시할 div
     labMapOption = {
         center: new daum.maps.LatLng(35.2268795, 126.8429492), // 지도의 중심좌표
         //center: new daum.maps.LatLng(35.2268795, 126.8429492),

         level: 5 // 지도의 확대 레벨
     };

	 //지도를 미리 생성
	 var labMap = new daum.maps.Map(labMapContainer, labMapOption);
	 //주소-좌표 변환 객체를 생성
	 var labGeocoder = new daum.maps.services.Geocoder();
	 //마커를 미리 생성
	 var labMarker = new daum.maps.Marker({
	     position: new daum.maps.LatLng(35.2268795, 126.8429492),
	     map: labMap
	 });

	 daum.maps.event.addListener(labMap, 'click', function(mouseEvent) {
	        searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
	             if (status === daum.maps.services.Status.OK) {

	                   // 클릭한 위도, 경도 정보를 가져옵니다
	                   var latlng = mouseEvent.latLng;
	                   // 마커 위치를 클릭한 위치로 옮깁니다
	                   labMarker.setPosition(latlng);
	                   //페이지에 값 넣어주기(상세주소, X좌표, Y좌표)
	                //$("#location").val(result[0].jibunAddress.name);
	                   $("#labMapX").val(latlng.getLat());
	                $("#labMapY").val(latlng.getLng());

	                labMarker.setMap(labMap);

	             }
	        });
	  });

 	// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
     daum.maps.event.addListener(labMap, 'idle', function() {
           searchAddrFromCoords(labMap.getCenter(), displayCenterInfo);
     });

<% } %>

function submitGo(){

	var errMsg = "";
	<%if(util.getStr(paramMap.get("orgType")).equals("")){%>
	if(!$("input[type=radio][name='orgType']").is(":checked")){
		errMsg+="기관구분 : 필수입력사항입니다."+"<br/>";
	}
	<%}%>
	/*if(!$("input[type=radio][name='authCd']").is(":checked")){
		errMsg+="관리권한 : 필수입력사항입니다."+"<br/>";
	}*/

	//if($("input[type=radio][name='authCd']:checked").val()==2){
	/*	if($("#authOrgSite1").val()==null || $("#authOrgSite1").val()==""||$("#authOrgSite2").val()==null || $("#authOrgSite2").val()==""||$("#authOrgSite3").val()==null || $("#authOrgSite3").val()==""){
			errMsg+="관리기관 : 필수입력사항입니다."+"<br/>";
		}
	*/
	//	}

	if($("#orgGrpNm").val()==null || $("#orgGrpNm").val()==""){
		errMsg+="기관명 : 필수입력사항입니다."+"<br/>";
	}
	if(!$("input[type=radio][name='areaCd']").is(":checked")){
		errMsg+="소속지역 : 필수입력사항입니다."+"<br/>";
	}
	if($("#ornerNm").val()==null || $("#ornerNm").val()==""){
		errMsg+="대표자명 : 필수입력사항입니다."+"<br/>";
	}
	if($("#corpNum1").val()==null || $("#corpNum1").val()==""){
		errMsg+="사업자등록번호 : 필수입력사항입니다."+"<br/>";
	}
	/* if($("#corpNum2").val()==null || $("#corpNum2").val()==""){
		errMsg+="법인등록번호 : 필수입력사항입니다."+"<br/>";
	} */
	if($("#corpPhone").val()==null || $("#corpPhone").val()==""){
		errMsg+="대표전화번호 : 필수입력사항입니다."+"<br/>";
	}else if(!telPattern.test($('#corpPhone').val())){
		errMsg+="대표전화번호 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
	}
	if($("#corpFax").val()==null || $("#corpFax").val()==""){
		errMsg+="대표FAX번호 : 필수입력사항입니다."+"<br/>";
	}else if(!telPattern.test($('#corpFax').val())){
		errMsg+="대표FAX번호 : 양식에 맞게 입력해주세요.<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(ex:010-0000-0000)"+"<br/>";
	}
	/* if($("#homepage").val()==null || $("#homepage").val()==""){
		errMsg+="홈페이지 : 필수입력사항입니다."+"<br/>";
	} */
	if($("#addr1").val()==null || $("#addr1").val()==""||$("#zipcode").val()==null || $("#zipcode").val()==""){
		errMsg+="기관주소 : 필수입력사항입니다."+"<br/>";
	}
	if($("#addr2").val()==null || $("#addr2").val()==""){
		errMsg+="기관상세주소 : 필수입력사항입니다."+"<br/>";
	}
	/*
	if($("input[type=radio][name='orgType']:checked").val()==2){
		if($("#name").val()==null || $("#name").val()==""){
			errMsg+="기관관리자 : 필수입력사항입니다."+"<br/>";
		}
	}
	*/
	if($("#mapX").val()==null || $("#mapX").val()==""||$("#mapY").val()==null || $("#mapY").val()==""){
		errMsg+="기관주소(지도) : 필수입력사항입니다."+"<br/>";
	}

	////////////
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var infPattern = new Array("pdf");
	var bizPattern = new Array("pdf","jpg");

	var fileName = $('#orgCiFile1').val();
	if(fileName != "" && fileName != null){
		fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
		if(imgPattern.indexOf(fileName)==-1){
			errMsg+="CI이미지는  bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다."+"<br/>";
			//$('#orgCiFile1').val("");
		}/*else if(this.files[0].size<300000){
			alert("300kb 이상의 이미지를 등록해주세요.");
			$('#jnsptotalFile'+fileCount).val("");
		}*/
	}

	var fileName2 = $('#orgManageFile1').val();
	if(fileName2 != "" && fileName2 != null){
		fileName2 = fileName2.slice(fileName2.indexOf(".") + 1).toLowerCase();
		if(infPattern.indexOf(fileName2)==-1){
			errMsg+="기업소개자료는 PDF 확장자 파일만 업로드가능합니다."+"<br/>";
			//$('#orgManageFile1').val("");
		}/*else if(this.files[0].size<300000){
			alert("300kb 이상의 이미지를 등록해주세요.");
			$('#jnsptotalFile'+fileCount).val("");
		}*/
	}
	var fileName4 = $('#bizRegDocFile1').val();
	if(fileName4 != "" && fileName4 != null){
		fileName4 = fileName4.slice(fileName4.indexOf(".") + 1).toLowerCase();
		if(bizPattern.indexOf(fileName4)==-1){
			errMsg+="사업자등록증은 PDF, jpg 확장자 파일만 업로드가능합니다."+"<br/>";
			//$('#orgManageFile1').val("");
		}/*else if(this.files[0].size<300000){
			alert("300kb 이상의 이미지를 등록해주세요.");
			$('#jnsptotalFile'+fileCount).val("");
		}*/
	}
	/* if($("input[type=radio][name='orgType']:checked").val()=='2' || $("#orgType").val() == '2'){
		var fileName3 = $('#orgStampFile1').val();
		if(fileName3 == "" || fileName3 == null){
			errMsg+="기업 직인(도장)이미지 : 필수입력사항입니다"+"<br/>";
		}
		else if(fileName3 != "" && fileName3 != null){
			fileName3 = fileName3.slice(fileName3.indexOf(".") + 1).toLowerCase();
			if(imgPattern.indexOf(fileName3)==-1){
				errMsg+="기업 직인(도장)이미지는   bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다."+"<br/>";
				//$('#orgManageFile1').val("");
			}/*else if(this.files[0].size<300000){
				alert("300kb 이상의 이미지를 등록해주세요.");
				$('#jnsptotalFile'+fileCount).val("");
			}
		}
	} */
	//////////

	if(errMsg==""){
		fwrite.submit();
	}else{
		errMsg="<div class='line' style='height:2px;background-color:#333333;margin-top:10px;margin-bottom:10px'></div>" + errMsg;
		errMsg="<div style='margin:20px'><h2>데이터 검증결과</h2>" + errMsg;
		errMsg+="<div id='dataCheckExitButton' style='text-align:center'><input type='button' onclick='dataCheckExit()' value='닫기'/></div>";
		errMsg+="</div>";
		$('#dataCheck').html(errMsg);
		$("#dataCheck").css("left",($(document).width()/2)-($("#dataCheck").width()/2)+"px");
		//$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
		$("#dataCheck").css("top","200px");
		$('#dataCheck,#bgLayer').show();
		return false;
	}


}

$('input[name="orgType"]').change(function(){
	if($(this).val()=='1'){
		$('#userIdx').val("");
		$('#userIdxTr').hide();
		$('#authOrgSiteTr').hide();
		//$('#authCdTr').hide();
	}else{
		$('#userIdxTr').show();
		//$('#authCdTr').show();
		if($("input[type=radio][name='authCd']:checked").val()==2){
			$('#authOrgSiteTr').show();
		}
	}
});

$('input[name="authCd"]').change(function(){
	if($(this).val()=='1'){
		//$('#authOrgSite1,#authOrgSite2,#authOrgSite3').val("");
		$('#authOrgSiteTr').hide();
	}else{
		$('#authOrgSiteTr').show();
	}
});

function dataCheckExit(){
	$("#bgLayer,#dataCheck").hide();
	$("#dataCheck").html("");
}

$('input[name="labUse"]').change(function() {
	if($(this).val() == 'Y') {
		$("#labNameLine").show();
		$("#labFaxLine").show();
		$("#labAddr1Line").show();
		$("#labAddr2Line").show();
		$("#labMapLine").show();
		var coords = new daum.maps.LatLng(35.2268795, 126.8429492);
		labMap.relayout();
		labMap.setCenter(coords);
	} else {
		$("#labNameLine").hide();
		$("#labFaxLine").hide();
		$("#labAddr1Line").hide();
		$("#labAddr2Line").hide();
		$("#labMapLine").hide();
	}
});

$('input[name="areaCd"]').change(function(){
	var areaCd = $(this).val();
	$("#area").remove();
	$("#otherAreaCd").remove();
	$.ajax({
		url : "/sys/areaList.do",
		data : {"areaCd" : $(this).val()},
		success : function(data) {
		    var tag = "";
		    if(areaCd == 1) {
		    	tag = "<select id='area' name='area'></select>";
		    } else {
		    	tag = "<select id='otherAreaCd' name='otherAreaCd'></select>";
		    }
		    $("input:radio[name='areaCd']:checked").parent().after(tag);
			for(i = 0; i < data.areaList.length; i++) {
				if(areaCd == 1) {
					$("#area").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
				} else {
					$("#otherAreaCd").append("<option value='"+data.areaList[i].CODE_CD+ "'>"+data.areaList[i].CODE_NM+"</option>");
				}
			}
		},
		error : function() {
			alert("문제가 발생하였습니다.");
		}
	});
});
</script>



<%@include file="/front/_temple/popup/t_footer.jsp" %>