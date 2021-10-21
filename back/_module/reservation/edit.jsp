<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="org.springframework.ui.Model"%>
<%@ page import="info.elsys.jnsp.util.ComUtil"%>
<%@ page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%@ page import="info.elsys.jnsp.comm.vo.LoginVO"%>
<%@ page import="java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%
	String display = "main";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userMap");
	ArrayList<HashMap<String, String>> fileList = request.getAttribute("fileList") == null ? new ArrayList<HashMap<String, String>>(): (ArrayList<HashMap<String, String>>)request.getAttribute("fileList");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));

	String sampleNm = util.getStr(dataMap.get("SAMPLE_NM"));
	String sampleNo = util.getStr(dataMap.get("SAMPLE_NO"));
	String sampleNmArr[] = sampleNm.split("\\|\\|");
	String sampleNoArr[] = sampleNo.split("\\|\\|");

%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript">

var korPattern = /[가-힣]/;
var onlyKorPattern = /[^가-힣]/;
var engPattern = /[a-zA-Z]/;
var numPattern = /[\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
var telPattern = /^\d{2,4}\-\d{3,4}\-\d{4}|\d{4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

//이용희망시간 달력
	$(document).ready(function(){
		$( "#realUseStDt" ).datepicker({
    		showMonthAfterYear : true,
    		changeMonth : true,
    		changeYear : true,
    		nextText : '다음 달',
    		prevText : '이전 달',
    		currentText : '오늘 날짜',
    		closeText : '닫기',
    		dateFormat : "yy-mm-dd",
    		dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
    		dayNamesMin : ['월','화','수','목','금','토','일'],
    		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
			minDate: 0,
			onClose: function( selectedDate ) {
				if(selectedDate != "" && selectedDate != null){
					$("#realUseEdDt").datepicker( "option", "minDate", selectedDate );
				}
			}
	  });
	  	$( "#realUseEdDt" ).datepicker({
    		showMonthAfterYear : true,
    		changeMonth : true,
    		changeYear : true,
    		nextText : '다음 달',
    		prevText : '이전 달',
    		currentText : '오늘 날짜',
    		closeText : '닫기',
    		dateFormat : "yy-mm-dd",
    		dayNames : ['월요일','화요일','수요일','목요일','금요일','토요일','일요일'],
    		dayNamesMin : ['월','화','수','목','금','토','일'],
    		monthNames : ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
    		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12'],
			minDate: 0
	  });

});


function orgPost(){
	new daum.Postcode({
		oncomplete: function(data) {
			document.getElementById('zipCode').value = data.zonecode;

			if (data.userSelectedType === 'R') {
				// 도로명 주소 선택시
				var adrs = data.roadAddress;
				if (data.buildingName != undefined && data.buildingName.length > 0) {
					adrs += ' (' + data.buildingName + ')';
				}
				document.getElementById('addr1').value = adrs;
			} else {
				// 지번 주소 선택시
				document.getElementById('addr1').value = data.jibunAddress;
			}
			document.getElementById('addr2').focus();
		}
	}).open();
}

function reservationGo(){

	$('#mode').val('editSubmit');

	if($('#zipCode').val() == ''  || $("#zipCode").val()=="" ){
		alert("우편번호를 입력해주세요");
		$('#zipCode').focus();
		return false;
	}
	if($('#addr1').val() == ''  || $("#addr1").val()=="" ){
		alert("주소를 입력해주세요");
		$('#addr').focus();
		return false;
	}

	for(var j=1; j < sample_cnt+1; j++){
		if($('#sampleNm'+j).val() == "" || $('#sampleNm'+j).val() == null){
			alert("시료명을 입력해주세요");
			$('#sampleNm'+j).focus();
			return false;
		};

		if($('#sampleNo'+j).val() == "" || $('#sampleNo'+j).val() == null){
			alert("시료수를 입력해주세요");
			$('#sampleNo'+j).focus();
			return false;
		}else if(isNaN($('#sampleNo'+j).val())){
			alert("시료수는 숫자만 입력해주세요.");
			$('#sampleNo'+j).focus();
			return false;
		};
	}

	var userTypeCheck = $(":input:radio[name=userTypeCheck]:checked").val();
	$('#userType').val(userTypeCheck);



	if(confirm("정말 수정하시겠습니까?")){
		$('#fedit').submit();
	} else {
		return false;
	}
}


	$(document).ready(function() {
		$(function() {
		    $("input:text").keydown(function(evt) {
		        if (evt.keyCode == 13)
		            return false;
		    });
		});

	});

	 function bytecheck(obj, maxByte){
		 var str = obj.value;
		 var str_len = str.length;

		 var rbyte = 0;
		 var rlen = 0;
		 var one_char = "";
		 var str2 = "";

		 for(var i=0; i<str_len; i++){
		 one_char = str.charAt(i);
		 if(escape(one_char).length > 4){
		     rbyte += 2;                                         //한글2Byte
		 }else{
		     rbyte++;                                            //영문 등 나머지 1Byte
		 }

		 if(rbyte <= maxByte){
		     rlen = i+1;                                          //return할 문자열 갯수
		 }
		 }

		 if(rbyte > maxByte){
		     alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
		     str2 = str.substr(0,rlen);                                  //문자열 자르기
		     obj.value = str2;
		     bytecheck(obj, maxByte);
		 }else{
		     document.getElementById('byteInfo').innerText = rbyte;
		 }
	};
	var sample_cnt = <%=sampleNmArr.length-1%>;

	if(sample_cnt < 1){
		sample_cnt = 1;
	}

	function sampleBox( state ){
		if( state == 'p' ){
			if( sample_cnt < 10){
				sample_cnt++;
				var sampleHtml = "<div id='sampleItem"+(sample_cnt)+"' >";
				sampleHtml += "<label>"+(sample_cnt)+". 시료명 : </label><input type='text' class='inp_txt' name='sampleNm' id='sampleNm"+(sample_cnt)+"' value='' size='20'/>";
				sampleHtml += "&nbsp;&nbsp;<label>"+(sample_cnt)+". 시료수 : </label><input type='text' class='inp_txt' name='sampleNo' id='sampleNo"+(sample_cnt)+"' value='' size='2'/>";
				sampleHtml += "</div>";
				$( '#sampleBox' ).append(sampleHtml);
			}else{
				alert("최대 10개의 시료 정보를 입력하실수 있습니다..");
			}
		}else{
			if( sample_cnt > 1){
				$( '#sampleItem'+sample_cnt ).remove();
				sample_cnt--;
			}else{
				alert("최소 1개의 시료 정보는 입력하셔야 됩니다.");
			}
		}
	};

	function getFileExtCkCheck(filePath,fileExtCk,fileSizeMbCk){
		var fileValue = document.getElementById(filePath).value;
		// 현재 파일 확장자 체크
		var ext = fileValue.substring((fileValue.lastIndexOf(".") + 1),fileValue.length).toLowerCase();
		var gZip = ['zip','alz','arh','rar','lzh','ice','ace','cab','gz','hqx','tar','z','tgz'];
		var gImg = ['jpg','png','gif','jpeg','bmp','apng'];
		var gText = ['txt','hwp','doc','docx','hwt','xls','xlsx','ppt','pptx','pdf'];
		var gMov = ['mp4','mov','avi','flv','swf','mkv','wmv','dpg','asf'];
		var gMp3 = ['mp1','mp2','mp3','ogg','mmf','wav','aac','wma','ac3','m4a','m4r','aiff','caf','flac'];
		var gAll = ['txt','hwp','doc','docx','ppt','pptx','hwt','xls','xlsx','pdf','jpg','png','gif','jpeg','bmp','apng','zip','alz','arh','rar','lzh','ice','ace','cab','gz','hqx','tar','z','tgz'];

		if(fileExtCk == "gzip"){
			if(!contains(gZip,ext)){
				alert("압축 파일만 등록이 가능합니다.");
				document.getElementById(filePath).value = "";
				return false;
			}
		} else if(fileExtCk == "gimg"){
			if(!contains(gImg,ext)){
				alert("이미지 파일만 등록이 가능합니다.");
				document.getElementById(filePath).value = "";
				return false;
			}
		} else if(fileExtCk == "gtext"){
			if(!contains(gText,ext)){
				alert("텍스트 파일만 등록이 가능합니다.");
				document.getElementById(filePath).value = "";
			    return false;
			}
		} else if(fileExtCk == "gmov"){
			if(!contains(gMov,ext)){
				alert("동영상 파일만 등록이 가능합니다.");
				document.getElementById(filePath).value = "";
			    return false;
			}
		} else if(fileExtCk == "gmp3"){
			if(!contains(gMp3,ext)){
				alert("음악 파일만 등록이 가능합니다.");
				document.getElementById(filePath).value = "";
			    return false;
			}
		} else {
			if(!contains(gAll,ext)){
				alert("압축, 이미지, 텍스트, 동영상, 음악 파일만 등록이 가능합니다.");
				document.getElementById(filePath).value = "";
			    return false;
			}
		}

		// 현재 파일 사이즈 체크 (50MB)
		if(fileSizeMbCk == 0 || fileSizeMbCk == null || fileSizeMbCk > 50){
			fileSizeMbCk = 50;
		}

		var maxSize  = fileSizeMbCk*1048576;
		var fileSize = Math.round(document.getElementById(filePath).files[0].size);
		if(fileSize > maxSize){
		    alert("첨부파일 사이즈는 "+fileSizeMbCk+"MB 이내로 등록 가능합니다.");
		    document.getElementById(filePath).value = "";
	        return false;
	    }
	    return true;
	}
function contains(char1,char2) {
	if (char1.indexOf(char2) != -1){
		return true;
	} else {
		return false;
	}
}
</script>
	  <form name="fedit" id="fedit" action="./eqReservationProc.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOrderIdx" name = "equOrderIdx" value="<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>

			<h2>장비이용 예약 처리상태</h2>
				<div class="box_in">
					<table id="step1"  class="skin_basic_write">
	                	<colgroup>
	               			<col width="20%">
	               			<col width="30%">
	               			<col width="20%">
	               			<col width="30%">
	                	</colgroup>
	                	<tbody>
							<tr>
	                			<th scope="col">JEINET 예약번호</th>
	                			<td scope="col">
	                				J-<%=util.getStr(paramMap.get("equOrderIdx"))%>
	                			</td>
	                			<th scope="col">처리상태</th>
	                			<td colspan="3">
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> <img alt="승인요청" src="/img/back/comm/order_state_img_1.png"> <% } %>
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> <img alt="이용승인" src="/img/back/comm/order_state_img_2.png"> <% } %>
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %>
	                				<img alt="승인거절" src="/img/back/comm/order_state_img_3.png"> <br /> 반려사유 :&nbsp;<%=util.getStr(dataMap.get("REJECT"))%> <% } %>
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> <img alt="이용완료" src="/img/back/comm/order_state_img_4.png"> <% } %>
	                				<%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> <img alt="승인취소" src="/img/back/comm/order_state_img_5.png"> <% } %>
	                			</td>
                			</tr>
							<tr>
	                			<th scope="col">처리부서</th>
	                			<td scope="col">
	                				<%=util.getStr(dataMap.get("ORDER_DEPT_NM"))%>
	                			</td>
	                			<th scope="col">처리자</th>
	                			<td scope="col">
	                				<%=util.getStr(dataMap.get("ORDER_OPERATOR"))%>
	                			</td>
                			</tr>
							<tr>
	                			<th scope="col">처리시간</th>
	                			<td scope="col">
	                				<%=util.getStr(dataMap.get("ORDER_OPERATOR_DT"))%>
	                			</td>
	                			<th scope="col">예약정보 인쇄</th>
	                			<td scope="col">
 									<button class="btn_inp_y_01" onclick="printPop('<%=dataMap.get("RND_EQU_IDX")%>','<%=dataMap.get("USER_IDX")%>','<%=util.getStr(paramMap.get("equOrderIdx"))%>')">인쇄하기</button>
	                			</td>
	                		</tr>
                		</tbody>
                	</table>

			<div style="margin:10px"><h3><b>[장비 사용자 정보]</b></h3></div>

			<!-- 신청자 정보 -->
			<table class="skin_basic_write">
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 80%;" />
				</colgroup>

				<tr>
					<th scope="col"><font color="red">*</font> 신청자명</th>
					<td>
						<%=util.getStr(userMap.get("PSN_NM"))%>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 기업/기관명</th>
					<td>
						<%=util.getStr(userMap.get("ORG_GRP_NM"))%> ( <%=util.getStr(userMap.get("ORG_GRP_TYPE"))%> )
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 대표자명</th>
					<td>
						<input type="hidden" name="corpResponsibleUser" maxlength="50" value="<%=util.getStr(dataMap.get("CORP_RESPONSIBLE_USER"))%>" id="corpResponsibleUser"  class="inp_txt" title="대표자" style="width:200px" >
						<%=util.getStr(userMap.get("OWNER_NM"))%>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 사업자등록번호</th>
					<td>
						<%=util.getStr(userMap.get("CORP_NO"))%>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 소속부서/센터</th>
					<td>
						<input type="hidden" name="deptNm" maxlength="100" value="<%=util.getStr(userMap.get("DEPT_NM"))%>" id="deptNm"  class="inp_txt" title="부서센터" style="width:300px" >
						<%=util.getStr(userMap.get("DEPT_NM"))%>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 신청자 직위</th>
					<td>
						<input type="hidden" name="corpPosition" maxlength="50" value="<%=util.getStr(userMap.get("POSITION_NM"))%>" id="corpPosition"  class="inp_txt" title="직위" style="width:200px" >
						<%=util.getStr(userMap.get("POSITION_NM"))%>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 전화번호</th>
					<td>
						<input type="text" class="inp_txt" name="phone" id="phone" value="<%=util.getStr(dataMap.get("PHONE"))%>" size="12"/>
						* ex) 061-1234-4567
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 휴대전화</th>
					<td>
						<%=util.getStr(userMap.get("CP_NO"))%>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 이메일</th>
					<td>
						<%=util.getStr(userMap.get("EMAIL"))%>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 주소</th>
					<td>
						<input type="text" class="inp_txt" style="width:50px;" name="zipCode" maxlength="10" value="<%=util.getStr(dataMap.get("ZIPCODE"))%>" id="zipCode"  title="신청자주소" readonly = "readonly" />
						<input type="text" class="inp_txt" style="width:250px;" name="addr1" maxlength="100" value="<%=util.getStr(dataMap.get("ADDR1"))%>" id="addr1"  title="신청자주소" readonly="readonly"/>
						<input type="button" id = "deptPostButton" value="찾아보기" class="btn_inp_b_01"  onclick = "orgPost()" />
						<br/>
						<input type="text" class="inp_txt" style="width:400px;margin-top:5px;" name="addr2" maxlength="100" value="<%=util.getStr(dataMap.get("ADDR2"))%>" id="addr2"  title="신청자주소" />
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 구분</th>
					<td>
						<input type="hidden" id="userType" name="userType" value="">
						<input type="radio" id="userType1" name="userTypeCheck" value="A"
						<%if(util.getStr(dataMap.get("USER_TYPE")).equals("A")) { %> checked="checked" <% } %>>사업자&nbsp;&nbsp;&nbsp;
						<input type="radio" id="userType2" name="userTypeCheck" value="B"
						<%if(util.getStr(dataMap.get("USER_TYPE")).equals("B")) { %> checked="checked" <% } %>>비사업자
               			</td>
					</td>
				</tr>
			</table>

		<div style="margin:10px; "><h3><b>[장비 예약 정보]</b></h3></div>

			<table class="skin_basic_write">
				<!-- colgroup s -->
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 26.6%;" />
					<col style="width: 26.6%;" />
					<col style="width: 26.6%;" />
				</colgroup>
				<!-- colgroup e -->

				<tr>
					<th scope="col">장비명</th>
					<td scope="col" colspan="3">
						<%=util.getStr(dataMap.get("KOR_NM"))%>(<%=util.getStr(dataMap.get("ENG_NM"))%>)
					</td>
				</tr>
				<tr>
					<th scope="col">등록번호</th>
					<td scope="col">
						JEINET 등록번호 : <%=util.getStr(dataMap.get("RND_EQU_IDX"))%>
					</td>
					<td scope="col">
						Zeus 등록번호 : <%if(!util.getStr(dataMap.get("NTIS_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("NTIS_EQUIP_INFO")));}else {out.print("Zeus 미등록 장비");}%>
					</td>
					<td scope="col">
						i-Tube 등록번호 : <%if(!util.getStr(dataMap.get("ETUBE_EQUIP_INFO")).equals("")){out.print(util.getStr(dataMap.get("ETUBE_EQUIP_INFO")));}else {out.print("i-Tube 미등록 장비");}%>
					</td>
				</tr>
				<tr>
					<th scope="col">보유기관</th>
					<td scope="col" colspan="3">
						<%=util.getStr(dataMap.get("OWN_ORG_NM"))%>(<%=util.getStr(dataMap.get("OWN_ORG_SUB_NM"))%>)
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 이용희망기간</th>
					<td scope="col" colspan="3">
			 			<%=util.getStr(dataMap.get("USE_ST_DT"))%> ~ <%=util.getStr(dataMap.get("USE_ED_DT"))%>
					</td>
				</tr>
				<tr>
					<th scope="col">실사용기간</th>
					<td scope="col" colspan="3">
						<input type="text" class="inp_txt" name="realUseStDt" id="realUseStDt" value="<%=util.getStr(dataMap.get("REAL_USE_ST_DT"))%>" size="15" readonly="readonly" />
						~
						<input type="text" class="inp_txt" name="realUseEdDt" id="realUseEdDt" value="<%=util.getStr(dataMap.get("REAL_USE_ED_DT"))%>" size="15" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 사용구분</th>
					<td scope="col" colspan="3">
						<select id="useMean" name="useMean" class="select" >
							<option value=""  >사용구분선택</option>
							<option value="1" <%if(util.getStr(dataMap.get("USE_MEAN")).equals("1")) { %> selected="selected" <% } %>>서비스의뢰</option>
							<option value="2" <%if(util.getStr(dataMap.get("USE_MEAN")).equals("2")) { %> selected="selected" <% } %>>직접사용</option>
							<option value="3" <%if(util.getStr(dataMap.get("USE_MEAN")).equals("3")) { %> selected="selected" <% } %>>야간및휴일사용</option>
              				</select>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 이용목적</th>
					<td scope="col" colspan="3">
						<input type="text" name="usePurpose" maxlength="150" value="<%=util.getStr(dataMap.get("USE_PURPOSE"))%>" id="usePurpose"  class="inp_txt" title="부서센터" style="width:300px" >
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 시료예약정보</th>
					<td id="sampleBox" colspan="3">
						<%
		                			if(sampleNmArr.length > 1){
	                					for(int i = 1 ; i < sampleNmArr.length ; i++ ){
	                			%>
									<div id="sampleItem<%=i%>" style="margin-top:5px;">
										<label><%=i%>. 시료명 : </label><input type="text" class="inp_txt" name="sampleNm" id="sampleNm<%=i%>" value="<%=sampleNmArr[i]%>" size="20" />
										&nbsp;<label><%=i%>. 시료수 : </label><input type="text" class="inp_txt" name="sampleNo" id="sampleNo<%=i%>" value="<%=sampleNoArr[i]%>" size="2" />
										<% if( i == 1 ){ %>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('p');" title="시료항목 추가">+</button>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('m');" title="시료항목 감소">-</button>
										<% } %>
									</div>
								<%
										}
	                				}else{
                				%>
	                				<div id="sampleItem1" style="margin-top:5px;">
										<label>1. 시료명 : </label><input type="text" class="inp_txt" name="sampleNm" id="sampleNm1" value="" size="20" />
										&nbsp;<label>1. 시료수 : </label><input type="text" class="inp_txt" name="sampleNo" id="sampleNo1" value="" size="2" />
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('p');" title="시료항목 추가">+</button>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('m');" title="시료항목 감소">-</button>
									</div>
                				<%
	                				}
								%>
					</td>
				</tr>
			<%if(util.getStr(dataMap.get("ORDER_TYPE")).equals("OFFLINE")){ %>
				<tr>
                    <th scope="col">장비사용신청서 등록</th>
                    <td colspan="3">
	                	<%
					if(fileList.size() > 0){
				%>
						<ul class="file" style="line-height: 30px; text-align: left; vertical-align: middle; padding: 5px;">
						<%
							int fileCnt = 1;
							for(HashMap rs:fileList){
								String fileParam = "?dataGrp="+util.getStr(rs.get("DATA_GRP"))
													+"&amp;fileId="+util.getStr(rs.get("FILE_ID"))
													+"&amp;dataIdx="+util.getStr(rs.get("DATA_IDX"));
						%>
							<li class="text">
								<input type="checkbox" name="fileFlog" id="fileFlog_<%=fileCnt%>"
										value="<%=util.getStr(rs.get("FILE_ID"))%>" onclick="fileSet('<%=fileCnt%>')" />&nbsp;
								<label for="fileFlog_<%=fileCnt%>">파일삭제</label>&nbsp;&nbsp;
								<a href="/cmm/fms/ComFileDown.do<%=fileParam%>"><%=util.deStr(rs.get("TITLE_ORG"))%> (<%=util.getStr(rs.get("FILE_SIZE")) %> Byte)</a>
								<div id="fileBox_<%=fileCnt%>" style="display:none">
									<input type="file" name="offlineReservationFile<%=fileCnt%>" id="offlineReservationFile<%=fileCnt%>" title="파일첨부" onchange="getFileExtCkCheck('offlineReservationFile<%=fileCnt%>','gAll',50)" />
								</div>
							</li>
						<% fileCnt++; }%>
						</ul>
						<div style="display: inline-block;" id="offlineReservationfileGrpBox">
							<div>
								<input type="file" class='inp_txt' name="offlineReservationFile<%=fileCnt%>" id="offlineReservationFile<%=fileCnt%>" title="파일첨부" onchange="getFileExtCkCheck('offlineReservationFile<%=fileCnt%>','gAll',50)" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input class="btn_inp_y_01" type="button" value="+" style="min-width: 30px;" onclick="addRowFile('offlineReservation');" />
							<input class="btn_inp_y_01" type="button" value="-" style="min-width: 30px;" onclick="delRowFile('offlineReservation');" />
						</div>
							<script type="text/javascript">
								var arrfileCnt = new Array();
								arrfileCnt['offlineReservation'] = '<%=(fileCnt + 1)%>';
					            function addRowFile(fileGrpnm){
					            	if(arrfileCnt[fileGrpnm] < 11){
					            		var fileHtml = "<div>";
					            		fileHtml += "<input type='file' class='inp_txt' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"' title='파일첨부' onchange='getFileExtCkCheck(\""+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"\",\"gAll\",50)' />";
					            		fileHtml += "</div>";

				            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
				            			arrfileCnt[fileGrpnm]++;
					            	}else{
					            		alert("첨부파일은 최대 10개 등록 가능합니다." );
					            	}
				            	}

					            function delRowFile(fileGrpnm){
					            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
					            		return;
					            	}
					            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
					            	arrfileCnt[fileGrpnm]--;
					            }

								function fileSet(fileCnt){
									if($('#fileFlog_'+fileCnt).is(':checked')){
										$('#fileBox_'+fileCnt).show();
									}else{
										$('#fileBox_'+fileCnt).hide();
									}
								}
				            </script>

	            <% }else{ %>
						<div style="display: inline-block;" id="offlineReservationfileGrpBox">
							<div>
								<input type="file" class='inp_txt' name="offlineReservationFile1" id="offlineReservationFile1" title="파일첨부" onchange="getFileExtCkCheck('offlineReservationFile1','gAll',50)" />
							</div>
						</div>
						<div style="display: inline-block; vertical-align: bottom;">
							<input class="btn_inp_y_01" type="button" value="+" style="min-width: 30px;" onclick="addRowFile('offlineReservation');" />
							<input class="btn_inp_y_01" type="button" value="-" style="min-width: 30px;" onclick="delRowFile('offlineReservation');" />
						</div>
						<script type="text/javascript">
							var arrfileCnt = new Array();
							arrfileCnt['offlineReservation'] = 2;
				            function addRowFile(fileGrpnm){
				            	if(arrfileCnt[fileGrpnm] < 11){
				            		var fileHtml = "<div>";
				            		fileHtml += "<input type='file' class='inp_txt' name='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"' title='파일첨부' onchange='getFileExtCkCheck(\""+fileGrpnm+"File"+arrfileCnt[fileGrpnm]+"\",\"gAll\",50)' />";
				            		fileHtml += "</div>";

			            			$('#'+fileGrpnm+'fileGrpBox').append(fileHtml);
			            			arrfileCnt[fileGrpnm]++;
				            	}else{
				            		alert("첨부파일은 최대 10개 등록 가능합니다." );
				            	}
			            	}

				            function delRowFile(fileGrpnm){
				            	if($('#'+fileGrpnm+'fileGrpBox > div').size() <= 1){
				            		return;
				            	}
				            	$('#'+fileGrpnm+'fileGrpBox > div').eq($('#'+fileGrpnm+'fileGrpBox > div').size() - 1).remove();
				            	arrfileCnt[fileGrpnm]--;
				            }
			            </script>
			      <% } %>
					</td>
				</tr>
			<%} %>
				<tr>
					<th scope="col">특이사항</th>
					<td colspan="3">
						<textarea class="inp_txt" id="sampleMatter" name="sampleMatter" rows="10" cols="100" style="width:100%; overflow: auto; resize:none;" ><%=util.getStr(dataMap.get("SAMPLE_MATTER"))%></textarea>
						<br /><font color='red'>* 시험항목 및 예상치, 분석조건/시료특성/분석방법/분석성분/사용용매/결과회신방법 등</font>
					</td>
				</tr>
              		<% if(util.loginCheck() && util.getInt(loginVO.getAuthLv()) >= 70) { %> <!-- 기관담당자 이상 -->
               		<tr>
               			<th scope="col"><font color="red">*</font>예약현황</th>
               			<td colspan="3">
               			<select id="orderState" name="orderState" class="select" >
							<option value="1" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("1")) { %> selected="selected" <% } %> >승인요청</option>
							<option value="3" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("3")) { %> selected="selected" <% } %> >승인요청 거절</option>
							<option value="2" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("2")) { %> selected="selected" <% } %> >이용승인</option>
							<option value="5" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("5")) { %> selected="selected" <% } %> >이용승인 취소</option>
							<option value="4" <%if(util.getStr(dataMap.get("ORDER_STATE")).equals("4")) { %> selected="selected" <% } %> >이용완료</option>
               			</td>
               		</tr>
              		<% } %>
			</table>

	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_right_box">
		        	<input type="button" class="btn_inp_b_01" value="수정" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="reservationGo()"/>
		        	<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">취소</a>
	        	</div>
	        </div>
	        <!--// bo_btn -->

      </form>