<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*"%>
<%
	String display = "sub";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");
	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> loginUserInfo = request.getAttribute("loginUserInfo") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("loginUserInfo");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	ArrayList<HashMap<String, String>> eventTypeList = request.getAttribute("eventTypeList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("eventTypeList");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");

	String mode = util.getStr(paramMap.get("mode"));
	String nowPage = util.getIntStr(paramMap.get("nowPage"));

	if("".equals(mode)) mode = "write";

	String fileGrp = "event";
	String fileSubGrp = "";
	String fileFullGrp =fileGrp+fileSubGrp;
%>

<form name="fwrite" id="fwrite" action="<%=myPage%>" method="post" enctype="multipart/form-data">
	<input type="hidden" name="mode" id="mode" value="<%=mode%>" />
	<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage()%>" />
	<input type="hidden" name="reUrl" id="reUrl" value="<%=myPage%>" />


	<div class="skin_bbs_write" style="margin-top: 30px; width: 1000px;">
		<span style="color:red; font-size:10pt;"> * 필수 입력사항입니다.</span>
        <table class="skin_basic_write">
        	<caption>작성하기</caption>
            <colgroup>
				<col style="width: 15%;" />
				<col style="width: 50%;" />
				<col style="width: 10%;" />
				<col style="width: 25%;" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventNm"> 행사명</label>
					</th>
					<td>
						<input type="text" class="inp_text" name="eventNm" id="eventNm" value="" style="width: 98%;" maxlength="100" />
                    </td>
                    <th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventType"> 행사분류</label>
					</th>
					<td>
						<select class="select" name="eventType" id="eventType" style="width:225px; height:24px;">
						<%for(HashMap rs:eventTypeList){%>
							<option value="<%=util.getStr(rs.get("CODE_CD")) %>"><%=util.getStr(rs.get("CODE_NM")) %></option>
						<%}%>
	              		</select>
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventAuspicesNm"> 행사주최</label>
					</th>
					<td colspan="3">
						<input type="text" class="inp_text" name="eventAuspicesNm" id="eventAuspicesNm" value="" style="width: 98%;" maxlength="100" />
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventManagementNm"> 행사주관</label>
					</th>
					<td colspan="3">
						<span id="eventManageOrgTd">
							<input type="hidden" name="eventManageOrgCd" id="eventManageOrgCd" value="" />
							<input type="text" class="inp_text" name="eventManageOrgNm" id="eventManageOrgNm" value="" style="width: 70%;" maxlength="100" placeholder=" 기관검색버튼을 클릭해주세요." />
							<input type="button" name="blngOrgNm" value="기관검색" id="blngOrgNm" class="btn_inp_g_01" onclick="popupWindow('orgList')" >
						</span>
						<span id="eventManageOrgSubTd"></span>
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="recDt"> 행사신청기간</label>
					</th>
					<td colspan="3">
						<input type="text" class="inp_text" name="reqStDt" id="reqStDt" value="" /> <select class="select" name="reqSt" id="reqSt" style="height:24px;"><%=util.timeOption("") %></select>시 ~
						<input type="text" class="inp_text" name="reqEdDt" id="reqEdDt" value="" /> <select class="select" name="reqEt" id="reqEt" style="height:24px;"><%=util.timeOption("") %></select>시
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="proDt"> 행사기간</label>
					</th>
					<td colspan="3">
						<input type="text" class="inp_text" name="eventStDt" id="eventStDt" value="" /> <select class="select" name="eventSt" id="eventSt" style="height:24px;"><%=util.timeOption("") %></select>시 ~
						<input type="text" class="inp_text" name="eventEdDt" id="eventEdDt" value="" /> <select class="select" name="eventEt" id="eventEt" style="height:24px;"><%=util.timeOption("") %></select>시
					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventPlace"> 행사장소</label>
					</th>
					<td colspan="3">
						<input type="text" class="inp_text" name="eventPlace" id="eventPlace" value="" style="width: 70%;" maxlength="100" />
						<input type="button" id="eduPostButton" value="찾아보기" class="btn_inp_g_01" onclick="eduPost()">
						<br>
						<input type="text" class="inp_text" name="eventPlaceDetail" id="eventPlaceDetail" value="" style="width: 70%;" maxlength="100" />
					</td>
				</tr>

				<!-- 지도구현 -->
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventPlace"> 지도</label>
					</th>
					<td colspan="3">
						<!--X축 -->
						<input type="hidden" class="inputBox_1" id="mapX" name="mapX" maxlength="20"  value=""/>
						<!--Y축 -->
						<input type="hidden" class="inputBox_1" id="mapY" name="mapY" maxlength="20"  value=""/>
						<div id="map" style="width:100%;height:300px;margin-top:10px;"></div>
					</td>
				</tr>


				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventTarget"> 참여대상</label>
					</th>
					<td>
						<input type="text" class="inp_text" name="eventTarget" id="eventTarget" value="" style="width: 98%;" maxlength="100" />
                    </td>
                    <th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventPeople"> 참가인원</label>
					</th>
					<td>
						<input type="text" class="inp_text" name="eventPeople" id=eventPeople value="" style="width: 110px;" maxlength="100" /> 명
					</td>
				</tr>
				<tr>
					<th class="tit">
						<span style="color:red; font-size:11pt;">*</span><label for="eventFreeYn"> 행사참가비</label>
					</th>
					<td colspan="3">
							<input type="checkbox" id="eventFree_N" name="eventFreeYn" value="N" checked="checked" onclick="check_only(this)"/>
							<label for="eventFree_N"> 무료</label>&nbsp;&nbsp;
							<input type="checkbox" id="eventFree_Y" name="eventFreeYn" value="Y" onclick="check_only(this);" />
							<label for="eventFree_Y"> 유료</label>&nbsp;&nbsp;
							<!--참가비-->
							<span id="eventPay_box" style="display:none;" >
								<input type="text" class="inp_text" name="eventPay" id="eventPay" value="" style="width: 190px;" maxlength="100" placeholder=" ex. 10000" />원
							</span>
					</td>
				</tr>
				<tr>
                    <th scope="row" class="tit">
                        <label for="eventContents"> 행사내용</label>
                    </th>
                    <td class="con-txt" colspan="3">
                        <textarea name="eventContents" id="eventContents" style="width: 100%; height: 350px; font-size:10pt;"></textarea>
                    </td>
                </tr>

				<!-- 행사안내문 = 파일첨부  -->
				<tr>
                    <th scope="row" class="tit"> 행사안내문</th>
                    <td colspan="3">
	                	<div style="display:inline-block;" id="<%=fileFullGrp%>fileGrpBox">
		                	<div>
		                    	<input type="file" name="<%=fileFullGrp%>File1"  id="<%=fileFullGrp%>File1"  title="파일첨부" />
		                    </div>
		                </div>

                        <div style="display:inline-block;vertical-align:bottom;">
	                       	<input class="addImageBtn" type="button" value="+" style="width: 30px; height: 20px;" onclick="addRowFile('<%=fileFullGrp%>');" />
	                        <input class="delImageBtn" type="button" value="-" style="width: 30px; height: 20px;" onclick="delRowFile('<%=fileFullGrp%>');" />
	                    </div>

	              	<script type="text/javascript">
						var arrfileCnt = new Array();
						arrfileCnt['<%=fileFullGrp%>'] = 2;
			            function addRowFile(fileGrpnm){
		            		var fileHtml = "<div>";
		            		fileHtml += "<input type='file' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  title='파일첨부' />";
		            		fileHtml += "</div>";

	            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
	            			arrfileCnt[fileGrpnm]++;
		            	}

			            function delRowFile(fileGrpnm){
			            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
			            		return;
			            	}
			            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
			            	arrfileCnt[fileGrpnm]--;
			            }
		        	</script>

					</td>
				</tr>
				<tr>
					<th scope="row" class="tit">
						<span style="color:red; font-size:11pt;">*</span> 문의처
					</th>
					<td colspan="3">
						<div>
							<span style="font-size:9pt;"> * 로그인 정보로 기본 입력되어있습니다.</span><br>
							<span style="font-size:9pt;"> * 문의처 정보가 다를경우 수정하시기 바랍니다.</span>
							<table class="skin_basic_write">
								<caption>작성하기</caption>
					            <colgroup>
									<col style="width: 15%;" />
									<col style="width: 85%;" />
								</colgroup>
								<tbody>
									<tr>
										<th>기관명</th>
										<td>
											<input type="text" class="inp_text" name="referenceOrgNm" id="referenceOrgNm" value="<%=util.getStr(loginUserInfo.get("ORG_GRP_NM"))%>" style="width: 100%;" maxlength="100" />
										</td>
									</tr>
									<tr>
										<th>부서명</th>
										<td>
											<input type="text" class="inp_text" name="referenceOrgSubNm" id="referenceOrgSubNm" value="<%=util.getStr(loginUserInfo.get("DEPT_NM"))%>" style="width: 100%;" maxlength="100" />
										</td>
									</tr>
									<tr>
										<th>담당자명</th>
										<td>
											<input type="text" class="inp_text" name="referenceCharger" id="referenceCharger" value="<%=util.getStr(loginUserInfo.get("PSN_NM"))%>" style="width: 100%;" maxlength="100" />
										</td>
									</tr>
									<tr>
										<th>전화번호</th>
										<td>
											<input type="text" class="inp_text" name="referencePhone" id="referencePhone" value="<%=util.getStr(loginUserInfo.get("TEL_NO"))%>" style="width: 100%;" maxlength="100" placeholder=" ex. 010-1234-5678" />
										</td>
									</tr>
									<tr>
										<th>이메일</th>
										<td>
											<input type="text" class="inp_text" name="referenceEmail" id="referenceEmail" value="<%=util.getStr(loginUserInfo.get("EMAIL"))%>" style="width: 100%;" maxlength="100" placeholder=" ex. jntis@jntis.kr" />
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</td>
				</tr>

			</tbody>
		</table>
		<!-- bo_btn  -->
		<div class="btn_right_box" style="text-align: right; width: 980px;">
			<% if(util.loginCheck() == true){ %>
			<input type="button" class="btn_inp_b_01" value="등록" onclick="goSubmit('writeProc')"/>
			<% } %>
			<input type="button" class="btn_inp_w_01" value="목록" onclick="goSubmit('list')"/>
		</div>
		<!--// bo_btn -->
	</div>
</form>


<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript">

	$(document).ready(function(){

		$("#reqStDt, #reqEdDt, #eventStDt, #eventEdDt").datepicker({
			showMonthAfterYear : true,
			showButtonPanel : true,
			changeMonth : true,
			changeYear : true,
			nextText : '다음 달',
			prevText : '이전 달',
			currentText : '오늘 날짜',
			closeText : '닫기',
			dateFormat : "yy-mm-dd",
			dayNames : [ '월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일' ],
			dayNamesMin : [ '월', '화', '수', '목', '금', '토', '일' ],
			monthNames : [ '1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월' ],
			monthNamesShort : [ '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12' ]
		});

		// 시작일 값에 따른 종료일 선택 값 제한
	    $('#reqStDt').datepicker("option", "maxDate", $("#reqEdDt").val());
	    $('#reqStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#reqEdDt").datepicker( "option", "minDate", selectedDate );
	    });
		// 종료일 값에 따른 시작일 선택 값 제한
	    $('#reqEdDt').datepicker("option", "minDate", $("#reqStDt").val());
	    $('#reqEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#reqStDt").datepicker( "option", "maxDate", selectedDate );
		});

	 	// 시작일 값에 따른 종료일 선택 값 제한
	    $('#eventStDt').datepicker("option", "maxDate", $("#eventEdDt").val());
	    $('#eventStDt').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#eventEdDt").datepicker( "option", "minDate", selectedDate );
	    });
	 	// 종료일 값에 따른 시작일 선택 값 제한
	    $('#eventEdDt').datepicker("option", "minDate", $("#eventStDt").val());
	    $('#eventEdDt').datepicker("option", "onClose", function ( selectedDate ) {
	    $("#eventStDt").datepicker( "option", "maxDate", selectedDate );
		});

	});

	function goSubmit(mode){

		//작성 클릭시(mode = writeProc일때) 필수값 체크
		if(mode == "writeProc"){

			if (confirm("정말 등록하시겠습니까??") == true){ //확인

					if($('#eventNm').val() == ""){
						alert("행사명을 입력해주세요");
						$("#eventNm").focus();
						return false;
					}
					if($('#eventAuspicesNm').val() == ""){
						alert("행사주최를 입력해주세요");
						$("#eventAuspicesNm").focus();
						return false;
					}
					if($('#eventManageOrgNm').val() == ""){
						alert("행사주관 기관명을 입력해주세요");
						$("#eventManageOrgNm").focus();
						return false;
					}
					if($('#eventManageOrgSubNm').val() == ""){
						alert("행사주관 부서명을 입력해주세요");
						$("#eventManageOrgSubNm").focus();
						return false;
					}
					if($('#reqStDt').val() == "" || $('#reqEdDt').val() == ""){
						alert("행사신청기간을 입력해주세요");
						$("#reqStDt").focus();
						return false;
					}
					if($('#eventStDt').val() == "" || $('#eventEdDt').val() == ""){
						alert("행사시간을 입력해주세요");
						$("#eventStDt").focus();
						return false;
					}
					if($('#eventPlace').val() == ""){
						alert("행사장소를 입력해주세요");
						$("#eventPlace").focus();
						return false;
					}
					if($('#mapX').val() == "" || $('#mapY').val() == ""){
						alert("지도에서 좌표를 선택해주세요");
						return false;
					}
					if($('#eventTarget').val() == ""){
						alert("참여대상을 입력해주세요");
						$("#eventTarget").focus();
						return false;
					}
					if($('#eventPeople').val() == ""){
						alert("참여인원을 입력해주세요");
						$("#eventPeople").focus();
						return false;
					}
					if($('#eventFree_Y:checked').val() == 'Y') {
						if($('#eventPay').val() == ""){
						alert("행사참가비를 입력해주세요");
						$("#eventPay").focus();
						return false;
						}
					}
					if($('#referenceOrgNm').val() == ""){
						alert("문의처 기관명을 입력해주세요");
						$("#referenceOrgNm").focus();
						return false;
					}
					if($('#referenceOrgSubNm').val() == ""){
						alert("문의처 부서명을 입력해주세요");
						$("#referenceOrgSubNm").focus();
						return false;
					}
					if($('#referenceCharger').val() == ""){
						alert("문의처 담당자명을 입력해주세요");
						$("#referenceCharger").focus();
						return false;
					}
					if($('#referencePhone').val() == ""){
						alert("문의처 전화번호를 입력해주세요");
						$("#referencePhone").focus();
						return false;
					}
					if($('#referenceEmail').val() == ""){
						alert("문의처 이메일을 입력해주세요");
						$("#referenceEmail").focus();
						return false;
					}


					oEditors.getById["eventContents"].exec("UPDATE_CONTENTS_FIELD", []);

		            if((oEditors[0].getIR()).length < 15){
		         	  alert("행사내용을 다시 입력해주세요");
		         	  return false;
		            }


		           //행사신청기간 오류 체크
		    	   if($('#reqStDt').val() == $('#reqEdDt').val()){
		    			if($('#reqSt').val() >= $('#reqEt').val()){
		    		    	alert("행사신청기간의 시간이 잘못 입력되었습니다.");
		    		    	$("#reqEt").focus();
		    		    	return false;
		    		    }
		    	   }
		    	   //행사기간 오류 체크
		    	   if($('#eventStDt').val() == $('#eventEdDt').val()){
		    			if($('#eventSt').val() >= $('#eventEt').val()){
		    		    	alert("행사기간의 시간이 잘못 입력되었습니다.");
		    		    	$("#eventEt").focus();
		    		    	return false;
		    		    }
		    	   }

	        	$('#mode').val(mode);
	        	$('#fwrite').submit();

	 		}else{ //취소
	 			return;
	 		}
		}

		$('#mode').val(mode);
    	$('#fwrite').submit();

     }

	 //Editor
	 var oEditors = [];
	 $(function(){
		//추가 글꼴 목록
		//var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sans MS"],["TEST","TEST"]];
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "eventContents",
			sSkinURI: "/js/webeditor_nhn/SmartEditor2Skin.html",
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : true,		// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true,			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				//aAdditionalFontList : aAdditionalFontSet,		// 추가 글꼴 목록
			},  //boolean
			fCreator : "createSEditor2"
		});
	 });

	//행사참가비 checkBox
 	function check_only(chk){
        var obj = document.getElementsByName("eventFreeYn");
        for(var i=0; i<obj.length; i++){
            if(obj[i] != chk){
                obj[i].checked = false;
            }
        }

        if($('#eventFree_Y:checked').val() == 'Y') {

        	$('#eventPay_box').show();

        }else {

        	$('#eventPay_box').hide();
        	$('#eventPay').val('');

        }
    }

 	/*---------기관검색 S----------*/
	//기관검색 팝업
	function popupWindow(listMode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/popup/"+listMode+".do";
		var popOption="width=500, height=650, resizable=no, scrollbars=no, status=no;";
		window.open(popUrl,"",popOption);
	}

	//기관정보
	function orgInfo(orgGrpCd){
		var orgGrpCd = orgGrpCd;
		var orgGrpNm;
		var result = "";
		var params = {
				"orgGrpCd": orgGrpCd
		};
		$.post("/sys/getOrgInfo.do",$.param(params),

		function(data){
			orgGrpNm = data.dataMap.ORG_GRP_NM; //기관명
			orgGrpCd = data.dataMap.ORG_GRP_CD; //기관코드
			$("#eventManageOrgNm").val(orgGrpNm);
			$("#eventManageOrgCd").val(orgGrpCd);


			$("#eventManageOrgSubNm").remove();
			result = "<input id=\"eventManageOrgSubNm\" name=\"eventManageOrgSubNm\" class=\"inp_text\" style=\"width: 70%;\" maxlength=\"30\" placeholder=\" 부서명을 직접입력해주세요.\" >";
			$("#eventManageOrgSubTd").append(result)
		});
	}
	/*---------기관검색 E----------*/


	/*---------지도 S-----------*/
	var korPattern = /[가-힣]/;
	var onlyKorPattern = /[^가-힣]/;
	var engPattern = /[a-zA-Z]/;
	var numPattern = /[\d]/;
	var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
	var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
	var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

		//검색관련
		function eduPost(){
			new daum.Postcode({
				oncomplete: function(data) {

					//$("#zipcode").val(data.zonecode);
					$("#eventPlace").val(data.address);
					$("#eventPlaceDetail").focus();

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
					geocoder.addressSearch(data.address, function(result, status) {
						// 정상적으로 검색이 완료됐으면
						if (status === kakao.maps.services.Status.OK) {
							// 해당 주소에 대한 좌표를 받아서
							//var coords = new kakao.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
							var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
							   $("#mapX").val(result[0].y);
							   $("#mapY").val(result[0].x);
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
		//지도

		var mapContainer = document.getElementById('map'), // 지도를 표시할 div
			mapOption = {
				center: new kakao.maps.LatLng(35.2268795, 126.8429492),
				level: 5 // 지도의 확대 레벨
			};

		//지도를 미리 생성
		var map = new kakao.maps.Map(mapContainer, mapOption);
		//주소-좌표 변환 객체를 생성
		var geocoder = new kakao.maps.services.Geocoder();
		//마커를 미리 생성
		var marker = new kakao.maps.Marker({
			position: new kakao.maps.LatLng(35.2268795, 126.8429492),
			map: map
		});

		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
			   searchDetailAddrFromCoords(mouseEvent.latLng, function(status, result) {
					if (status === kakao.maps.services.Status.OK) {

						  // 클릭한 위도, 경도 정보를 가져옵니다
						  var latlng = mouseEvent.latLng;
						  // 마커 위치를 클릭한 위치로 옮깁니다
						  marker.setPosition(latlng);

						  // 페이지에 값 넣어주기(상세주소, X좌표, Y좌표)
					   	  // $("#location").val(result[0].jibunAddress.name);
						  $("#mapX").val(latlng.getLat());
					   	  $("#mapY").val(latlng.getLng());
						  marker.setMap(map);
					}
			   });
		 });

		 // 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		 kakao.maps.event.addListener(map, 'idle', function() {
			   searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		 });

		 function searchAddrFromCoords(coords, callback) {
			   // 좌표로 행정동 주소 정보를 요청합니다
			   geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);  
		 }

		 function searchDetailAddrFromCoords(coords, callback) {
			   // 좌표로 법정동 상세 주소 정보를 요청합니다
			   geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		 }

		 // 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		 function displayCenterInfo(status, result) {
			   if (status === kakao.maps.services.Status.OK) {
					$("#centerAddr").html(result[0].fullName);
			   }
		 }
		 /*---------지도 E-----------*/

</script>