<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page
	import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@page import="info.elsys.jnsp.comm.vo.LoginVO"%>

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
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	String mode = util.getStr(paramMap.get("mode"));
%>
<style>
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
<div id = "bgLayer" onclick="dataCheckExit();"></div>
<div id="dataCheck"></div>
<form id="fwrite" name="fwrite" method="post" action="/sys/sysOrgManageProc.do" enctype="multipart/form-data" >
	<input type="hidden" id="mode" name="mode" value="write" />

	<div class="clear_wrap">
		<div class="left_box w75">

			<div class="both">
				<div class="fr">
					<!-- 기본정보영역 -->
					<table class="skin_basic_write">
						<colgroup>
							<col width="20%">
							<col width="30%">
							<col width="20%">
							<col width="30%">
						</colgroup>
						<tbody>
							<tr>
								<th scope="col"><label for="orgType1">기관구분</label></th>
								<td colspan="3">
									<label><input type="radio" id="orgType1" name="orgType" value="1"/>기업</label>
									<label><input type="radio" id="orgType2" name="orgType" value="2"/>기관/센터</label>
								</td>
							</tr>
							<tr style="display:none" id="authCdTr">
								<th scope="col"><label for="authCd1">관리권한</label></th>
								<td colspan="3">
									<label><input type="radio" id="authCd1" name="authCd" value="1"/>일반</label>
									<label><input type="radio" id="authCd2" name="authCd" value="2"/>관리자</label>
								</td>
							</tr>
							<tr id="authOrgSiteTr" style="display:none">
								<th scope="col"><label for="authOrgSite1">관리기관</label></th>
								<td colspan="3">
									연구장비정보망 :
									<label><input type="radio" id="authOrgSite1" name="authOrgSite1" value="Y"/>Y</label>
									<label><input type="radio" id="authOrgSite1" name="authOrgSite1" value="N"/>N</label>
									<br/>
									지식재산센터 :
									<label><input type="radio" id="authOrgSite2" name="authOrgSite2" value="Y"/>Y</label>
									<label><input type="radio" id="authOrgSite2" name="authOrgSite2" value="N"/>N</label>
									<br/>
									과학기술진흥센터 :
									<label><input type="radio" id="authOrgSite3" name="authOrgSite3" value="Y"/>Y</label>
									<label><input type="radio" id="authOrgSite3" name="authOrgSite3" value="N"/>N</label>
								</td>
							</tr>
							<tr>
								<th scope="col"><label for="orgGrpNm">기관명</label></th>
								<td colspan="3"><input type="text" id="orgGrpNm" name="orgGrpNm" maxlength="10"></td>
							</tr>
							<tr>
								<th scope="col"><label for="areaCd1">소속지역</label></th>
								<td colspan="3">
									<label>
										<input type="radio" id="areaCd1" name="areaCd" value="1" />전라남도 기관
									</label>
									<label>
										<input type="radio" id="areaCd1" name="areaCd" value="2"/>지역 외 기관
									</label>
								</td>
							</tr>
							<tr>
								<th scope="col"><label for="ornerNm">대표자명</label></th>
								<td colspan="3"><input type="text" id="ornerNm" name="ornerNm" maxlength="10"></td>

							</tr>
							<tr>
								<th scope="col"><label for="corpNum1">사업자등록번호</label></th>
								<td colspan="3"><input type="text" id="corpNum1" name="corpNum1" maxlength="20"></td>
							</tr>
							<tr>
								<th scope="col"><label for="corpNum2">법인등록번호</label></th>
								<td colspan="3"><input type="text" id="corpNum2" name="corpNum2" maxlength="20"></td>
							</tr>
						<tr>
							<th scope="col"><label for="corpPhone">대표전화번호</label></th>
							<td ><input type="text" id="corpPhone" name="corpPhone" maxlength="20"></td>
							<th scope="col"><label for="corpFax">대표FAX번호</label></th>
							<td ><input type="text" id="corpFax" name="corpFax" maxlength="20"></td>
						</tr>
						<tr>
							<th scope="col"><label for="homepage">홈페이지</label></th>
							<td colspan="3"><input type="text" id="homepage" name="homepage" maxlength="50"></td>
						</tr>
						<tr>
							<th scope="col"><label for="addr1">기관주소</label></th>
							<td colspan="3">
								<input type="text" id="zipcode" name="zipcode" maxlength="10" readonly="readonly">
								<input type="text" id="addr1" name="addr1" maxlength="50" readonly="readonly">
								<input type="button" id = "orgPostButton" value="찾아보기" class="btn_inp_b_01" onclick = "orgPost()" />
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="addr2">기관상세주소</label></th>
							<td colspan="3"><input type="text" id="addr2" name="addr2" maxlength="50"></td>
						</tr>
						<tr style="display:none" id="userIdxTr">
							<th scope="col"><label for="name">기관관리자</label></th>
							<td colspan="3">
								<input type="hidden" id="num1" name="userIdx" maxlength="15" >
								<input type="text" id="name" name="name" maxlength="15" >
								<input type="button" name="userData" id="userData" value="조회" onclick="popupWindow('userList')" class="btn_inp_b_01">
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="mapX">지도</label></th>
							<td colspan="3">
							X : <input type="text" id="mapX" name="mapX" maxlength="20">,
							Y : <input type="text" id="mapY" name="mapY" maxlength="20">
							<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
							</td>
						</tr>
						<tr>
							<th scope="col"><label for="orgNote1">기관분류</label></th>
							<td colspan="3"><textarea id="orgNote1" name="orgNote1" cols="50" rows="4" maxlength="500"></textarea></td>
						</tr>
						<tr>
							<th scope="col"><label for="orgNote2">주요제품</label></th>
							<td colspan="3"><textarea id="orgNote2" name="orgNote2" cols="50" rows="4" maxlength="500"></textarea></td>
						</tr>
						<tr>
							<th scope="col"><label for="orgNote3">보유기술현황</label></th>
							<td colspan="3"><textarea id="orgNote3" name="orgNote3" cols="50" rows="4" maxlength="500"></textarea></td>

						</tr>
						<tr>
							<th scope="col"><label for="orgNote4">연구분야</label></th>
							<td colspan="3"><textarea id="orgNote4" name="orgNote4" cols="50" rows="4" maxlength="500"></textarea></td>
						</tr>
						<tr>
							<th scope="col"><label for="<%=fileFullGrp%>File1">기업소개자료</label></th>
							<td colspan="3"><input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
							<input type="hidden" name="fileSn" value="1"/>
							</td>

						</tr>
						<tr>
							<th scope="col"><label for="<%=fileFullGrp%>File2">CI이미지</label></th>
							<td colspan="3"><input type="file" name="<%=fileFullGrp%>File2"  id="<%=fileFullGrp%>File2"  title="파일첨부" />
							<input type="hidden" name="fileSn" value="2"/>
							</td>
						</tr>
					</tbody>
				</table>
				</div>
			</div>

			</div>
			<div class="btn_box">
				<div class="btn_right_box">
					<button class="btn_inp_b_01" type="button" onclick="submitGo()">등록</button>
					<button class="btn_inp_w_01" type="button" onclick="pageListGo()">목록</button>
				</div>
			</div>
		</div>
</form>
<script type="text/javascript">


function popupWindow(listMode){
	var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';

	var popUrl="/sys/popup/"+listMode+".do";
	var popOption="width=500, height=550, resizable=no, scrollbars=no, status=no;";
	window.open(popUrl,"",popOption);
}

var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
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


			function submitGo(){

					var errMsg = "";

					if(!$("input[type=radio][name='orgType']").is(":checked")){
						errMsg+="기관구분 : 필수입력사항입니다."+"<br/>";
					}
					if(!$("input[type=radio][name='authCd']").is(":checked")){
						errMsg+="관리권한 : 필수입력사항입니다."+"<br/>";
					}
					if($("input[type=radio][name='authCd']:checked").val()==2){
						if($("#authOrgSite1").val()==null || $("#authOrgSite1").val()==""||$("#authOrgSite2").val()==null || $("#authOrgSite2").val()==""||$("#authOrgSite3").val()==null || $("#authOrgSite3").val()==""){
							errMsg+="관리기관 : 필수입력사항입니다."+"<br/>";
						}
					}
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
					/*
					if($("#homepage").val()==null || $("#homepage").val()==""){
						errMsg+="홈페이지 : 필수입력사항입니다."+"<br/>";
					}
					*/
					if($("#addr1").val()==null || $("#addr1").val()==""||$("#zipcode").val()==null || $("#zipcode").val()==""){
						errMsg+="기관주소 : 필수입력사항입니다."+"<br/>";
					}
					if($("#addr2").val()==null || $("#addr2").val()==""){
						errMsg+="기관상세주소 : 필수입력사항입니다."+"<br/>";
					}

					if($("input[type=radio][name='orgType']:checked").val()==2){
						if($("#name").val()==null || $("#name").val()==""){
							errMsg+="기관관리자 : 필수입력사항입니다."+"<br/>";
						}
					}

					if($("#mapX").val()==null || $("#mapX").val()==""){
						errMsg+="지도(X좌표) : 필수입력사항입니다."+"<br/>";
					}

					if($("#mapY").val()==null || $("#mapY").val()==""){
						errMsg+="지도(Y좌표) : 필수입력사항입니다."+"<br/>";
					}
								////////////
								var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
								var infPattern = new Array("pdf");

								var fileName = $('#orgManageFile2').val();
								if(fileName != "" && fileName != null){
									fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
									if(imgPattern.indexOf(fileName)==-1){
										errMsg+="CI이미지는  bmp, gif, jpg, jpeg, png 확장자 파일만 업로드가능합니다."+"<br/>";
										//$('#orgManageFile2').val("");
									}/*else if(this.files[0].size<300000){
										alert("300kb 이상의 이미지를 등록해주세요.");
										$('#jnsptotalFile'+fileCount).val("");
									}*/
								}

								var fileName2 = $('#orgManageFile1').val();
								if(fileName2 != "" && fileName2 != null){
									fileName2 = fileName2.slice(fileName2.indexOf(".") + 1).toLowerCase();
									if(infPattern.indexOf(fileName2)==-1){
										errMsg+="기업소개자료는 pdf 확장자 파일만 업로드가능합니다."+"<br/>";
										//$('#orgManageFile1').val("");
									}/*else if(this.files[0].size<300000){
										alert("300kb 이상의 이미지를 등록해주세요.");
										$('#jnsptotalFile'+fileCount).val("");
									}*/
								}

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
//			 			$("#dataCheck").css("top",($(document).height()/2)-($("#dataCheck").height()/2)+"px");
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
			    	$('#authCdTr').hide();
			    }else{
			    	$('#userIdxTr').show();
			    	$('#authCdTr').show();
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
		</script>