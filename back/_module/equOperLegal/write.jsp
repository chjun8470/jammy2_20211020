<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>
<%
	String display = "main";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");

	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));

%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript">
	function submitGo(){

		if($('#userIdx').val() == ''){
			alert("신청자를 선택해주세요");
			$('#searchUser').focus();
			return false;
		}

		if($('#zipCode').val() == ''){
			alert("우편번호를 입력해 주세요");
			$('#zipCode').focus();
			return false;
		}
		if($('#addr1').val() == ''){
			alert("주소를 입력해 주세요");
			$('#addr1').focus();
			return false;
		}

		var userTypeCheck = $(":input:radio[name=userTypeCheck]:checked").val();
		$('#userType').val(userTypeCheck);

		if($('#legalNm').val() == ''){
			alert("법정검사명을 입력해 주세요");
			$('#legalNm').focus();
			return false;
		}

		if($('#reqStartDate').val() == "" || $('#reqStartDate').val() == null){
			alert("처리요청기간 시작일(년/월/일)을 입력해주세요.");
			$('#reqStartDate').focus();
			return false;
		};

		if($('#reqEndDate').val() == "" || $('#reqEndDate').val() == null){
			alert("처리요청기간 종료일(년/월/일)을 입력해주세요.");
			$('#reqEndDate').focus();
			return false;
		};

		if($('#equStartDate').val() == "" || $('#equStartDate').val() == null){
			alert("장비가동기간 시작일(년/월/일)을 입력해주세요.");
			$('#equStartDate').focus();
			return false;
		};

		if($('#equEndDate').val() == "" || $('#equEndDate').val() == null){
			alert("장비가동기간 종료일(년/월/일)을 입력해주세요.");
			$('#equEndDate').focus();
			return false;
		};

		for(var i=1; i < equ_cnt+1; i++){
			if($('#rndEquIdx'+i).val() == "" || $('#rndEquIdx'+i).val() == null){
				alert("이용희망 장비를 선택해주세요.");
				$('#searchEqu'+i).focus();
				return false;
			};

			if($('#equUserName'+i).val() == "" || $('#equUserName'+i).val() == null){
				alert("담당자를 선택해주세요.");
				$('#searchUser'+i).focus();
				return false;
			};

			if($('#useTimeA'+i).val() == "" || $('#useTimeA'+i).val() == null){
				alert("장비보조가동시간(A)을 입력해주세요.");
				$('#useTimeA'+i).focus();
				return false;
			};

			if($('#useTimeB'+i).val() == "" || $('#useTimeB'+i).val() == null){
				alert("예비실험등 가동시간(B)을 입력해주세요.");
				$('#useTimeB'+i).focus();
				return false;
			};

			if($('#useTimeC'+i).val() == "" || $('#useTimeC'+i).val() == null){
				alert("장비실질가동시간(C)을 입력해주세요.");
				$('#useTimeC'+i).focus();
				return false;
			};

			for(var j=1; j < sample_cnt[i-1]+1; j++){

				if($('#sampleNm'+i+'_'+j).val() == "" || $('#sampleNm'+i+'_'+j).val() == null){
					alert("시료명을 입력해주세요");
					$('#sampleNm'+i+'_'+j).focus();
					return false;
				};

				if($('#sampleNo'+i+'_'+j).val() == "" || $('#sampleNo'+i+'_'+j).val() == null){
					alert("시료수를 입력해주세요");
					$('#sampleNo'+i+'_'+j).focus();
					return false;
				}else if(isNaN($('#sampleNo'+i+'_'+j).val())){
					alert("시료수는 숫자만 입력해주세요.");
					$('#sampleNo'+i+'_'+j).focus();
					return false;
				};
			}

		}

		for(var j=1; j < inspec_cnt+1; j++){
			if($('#inspecNm'+j).val() == "" || $('#inspecNm'+j).val() == null){
				alert("시험검사항목을 입력해주세요");
				$('#inspecNm'+j).focus();
				return false;
			};

			if($('#inspecFee'+j).val() == "" || $('#inspecFee'+j).val() == null){
				alert("수수료를 입력해주세요");
				$('#inspecFee'+j).focus();
				return false;
			}else if(isNaN($('#inspecFee'+j).val())){
				alert("수수료는 숫자만 입력해주세요.");
				$('#inspecFee'+j).focus();
				return false;
			};
		}
		if(confirm("등록하시겠습니까?")){
			$('#mode').val('write');
			$('#fwrite').submit();
		}
	}
	$(document).ready(function() {
		$('#userType1').attr('checked', 'checked');

		/* $(document).scroll(function(){
			$("input:text").blur();
		}); */

		$(function() {
		    $("input:text").keydown(function(evt) {
		        if (evt.keyCode == 13)
		            return false;
		    });
		});

		$("#reqStartDate, #reqEndDate, #equStartDate, #equEndDate").datepicker({
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
    		maxDate: '0'
		});

		$('#reqStartDate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#reqEndDate").datepicker( "option", "minDate", selectedDate );
	    });

		$('#reqEndDate').datepicker("option", "onClose", function ( selectedDate ) {
			if(selectedDate != null && selectedDate != ""){
				$("#reqStartDate").datepicker( "option", "maxDate", selectedDate );
			}
	    });

		$('#equStartDate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#equEndDate").datepicker( "option", "minDate", selectedDate );
	    });

		$('#equEndDate').datepicker("option", "onClose", function ( selectedDate ) {
			if(selectedDate != null && selectedDate != ""){
				$("#equStartDate").datepicker( "option", "maxDate", selectedDate );
			}
	    });

		$("#sampleCnt, #rentalFee").keyup(function(event){
	        if (!(event.keyCode >=37 && event.keyCode<=40)) {
	            var inputVal = $(this).val();
	            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
	        }
	    });

		$('.useTime1').blur(function() {
			var useTimeA = parseFloat($('#useTimeA1').val());
			var useTimeB = parseFloat($('#useTimeB1').val());
			var useTimeC = parseFloat($('#useTimeC1').val());
			var useTime = useTimeA+useTimeB+useTimeC;
			$('#useTime1').val(useTime.toFixed(1))
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

	function popupWindow(mode, order){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/eqReservation.do?mode="+mode+"&order="+order;
		var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,"popup"+order,popOption);

	}

	function setPopup(obj){
		if(obj['pop_mode'] == "equ") {
			var order = obj['order'];

			for(var i=1; i < equ_cnt+1; i++){
				if($('#rndEquIdx'+i).val() == obj['rnd_equ_idx']){
					alert("이미 선택한 장비입니다.");
					return false;
				};
			}

			var ntisNo = obj['ntis_no'];
			if(obj['ntis_no'] == ""){
				ntisNo = "NTIS 미등록 장비"
			}

			var etubeNo = obj['etube_no'];
			if(obj['etube_no'] == ""){
				etubeNo = "e-Tube 미등록 장비"
			}

			$("#eqNm"+order).text(obj['equ_nm']);
			$("#rndEquIdx"+order).val(obj['rnd_equ_idx']);

			$("#jeinetNo"+order).text(obj['rnd_equ_idx']);
			$("#ntisNo"+order).text(ntisNo);
			$("#etubeNo"+order).text(etubeNo);
			$("#orgName"+order).text(obj['org_nm']);

			$("#equUserOrg"+order).val(obj['org_grp_nm']);
			$("#equUserDept"+order).val(obj['org_sub_nm']);
			$("#equUserName"+order).val(obj['psn_nm']);
			$("#equUserPosition"+order).val(obj['oper_position']);
			$("#equUserPhone"+order).val(obj['oper_tel']);
			$("#equUserEmail"+order).val(obj['oper_email']);

		}else if(obj['pop_mode'] == "user"){

			$("#userNm").val(obj['user_nm']);
			$("#userNmText").text(obj['user_nm']);
			$("#userIdx").val(obj['user_idx']);
			$("#corpNm").val(obj['org_grp_nm']);
			$("#corpNmText").text(obj['corpName']);
			$("#corpResponsibleUser").val(obj['orner_nm']);
			$("#ornerNmText").text(obj['orner_nm']);
			$("#corpNoText").text(obj['corp_no']);
			$("#deptNm").val(obj['dept_nm']);
			$("#deptNmText").text(obj['dept_nm']);
			$("#corpPosition").val(obj['position_nm']);
			$("#corpPositionText").text(obj['position_nm']);
			$("#phone").val(obj['tel_no']);
			$("#cpNoText").text(obj['cp_no']);
			$("#emailText").text(obj['email']);
			$("#zipCode").val(obj['zipcode']);
			$("#addr1").val(obj['addr1']);
			$("#addr2").val(obj['addr2']);

		}else if(obj['pop_mode'] == "subUserPop"){

			var order = obj['order'];

			$("#equUserOrg"+order).val(obj['org_grp_nm']);
			$("#equUserDept"+order).val(obj['dept_nm']);
			$("#equUserName"+order).val(obj['user_nm']);
			$("#equUserPosition"+order).val(obj['position_nm']);
			$("#equUserPhone"+order).val(obj['cp_no']);
			$("#equUserEmail"+order).val(obj['email']);
		}
	}


	var equ_cnt = 1;
	function equBox( state ){
		if( state == 'p' ){
			if( equ_cnt < 30){
				equ_cnt++;

				var equHtml = "<div id='equItem"+(equ_cnt)+"'>";
				equHtml += "<div style='margin:0 10px 10px 10px'><h3><b>[장비 "+(equ_cnt)+"]</b></h3></div>";
				equHtml += "<table class='skin_basic_write'>";
				equHtml += "	<colgroup>";
				equHtml += "		<col style='width: 25%;' />";
				equHtml += "		<col style='width: 25%;' />";
				equHtml += "		<col style='width: 25%;' />";
				equHtml += "		<col style='width: 25%;' />";
				equHtml += "	</colgroup>";
				equHtml += "	<tbody>";
				equHtml += "		<tr>";
				equHtml += "			<th colspan='4'>장비 정보 <input type='button' id='searchEqu"+(equ_cnt)+"' class='btn_inp_b_01' onclick='popupWindow(\"equPop\",\""+(equ_cnt)+"\")' value='장비검색' /></th>";
				equHtml += "		</tr>";
				equHtml += "		<tr>";
				equHtml += "			<th scope='col'>장비명</th>";
				equHtml += "			<td scope='col' colspan='3'>";
				equHtml += "				<input type='hidden' name='rndEquIdx' id='rndEquIdx"+(equ_cnt)+"' />";
				equHtml += "				<span id='eqNm"+(equ_cnt)+"'></span>";
				equHtml += "				";
				equHtml += "			</td>";
				equHtml += "		</tr>";

				equHtml += "		<tr>";
				equHtml += "			<th scope='col'>등록번호</th>";
				equHtml += "			<td scope='col'>";
				equHtml += "				JEINET 등록번호 : <span id='jeinetNo"+(equ_cnt)+"'></span>";
				equHtml += "			</td>";
				equHtml += "			<td scope='col'>";
				equHtml += "				Zeus 등록번호 : <span id='ntisNo"+(equ_cnt)+"'></span>";
				equHtml += "			</td>";
				equHtml += "			<td scope='col'>";
				equHtml += "				e-Tube 등록번호 : <span id='etubeNo"+(equ_cnt)+"'></span>";
				equHtml += "			</td>";
				equHtml += "		</tr>";

				equHtml += "		<tr>";
				equHtml += "			<th scope='col'>보유기관</th>";
				equHtml += "			<td scope='col' colspan='3'>";
				equHtml += "				<span id='orgName"+(equ_cnt)+"'></span>";
				equHtml += "			</td>";
				equHtml += "		</tr>";

				equHtml += "		<tr>";
				equHtml += "			<th colspan='4'>담당자 정보 <input type='button' id='searchUser"+(equ_cnt)+"' class='btn_inp_b_01' onclick='popupWindow(\"subUserPop\", \""+(equ_cnt)+"\")' value='담당자 검색'></th>";
				equHtml += "		</tr>";
				equHtml += "		<tr>";
				equHtml += "			<th scope='col'>기관</th>";
				equHtml += "			<td scope='col'><input type='text' class='inp_txt' id='equUserOrg"+(equ_cnt)+"' name='equUserOrg' value='' readonly='readonly'/></td>";
				equHtml += "			<th scope='col'>부서</th>";
				equHtml += "			<td scope='col'><input type='text' class='inp_txt' id='equUserDept"+(equ_cnt)+"' name='equUserDept' value='' readonly='readonly'/></td>";
				equHtml += "		</tr>";
				equHtml += "		<tr>";
				equHtml += "			<th scope='col'>담당자</th>";
				equHtml += "			<td scope='col'><input type='text' class='inp_txt' id='equUserName"+(equ_cnt)+"' name='equUserName' value='' readonly='readonly'/></td>";
				equHtml += "			<th scope='col'>직위</th>";
				equHtml += "			<td scope='col'><input type='text' class='inp_txt' id='equUserPosition"+(equ_cnt)+"' name='equUserPosition' value='' readonly='readonly'/></td>";
				equHtml += "		</tr>";
				equHtml += "		<tr>";
				equHtml += "			<th scope='col'>전화번호</th>";
				equHtml += "			<td scope='col'><input type='text' class='inp_txt' id='equUserPhone"+(equ_cnt)+"' name='equUserPhone' value='' readonly='readonly'/></td>";
				equHtml += "			<th scope='col'>이메일</th>";
				equHtml += "			<td scope='col'><input type='text' class='inp_txt' id='equUserEmail"+(equ_cnt)+"' name='equUserEmail' value='' readonly='readonly'/></td>";
				equHtml += "		</tr>";

				equHtml += "		<tr>";
				equHtml += "			<th colspan='4'>장비 사용 정보</th>";
				equHtml += "		</tr>";

				equHtml += "		<tr>";
				equHtml += "			<th scope='col'><font color='red'>*</font>장비보조가동시간(A)</th>";
				equHtml += "			<td colspan='3'><input type='text'  class='inp_txt useTime"+(equ_cnt)+"' name='useTimeA' id='useTimeA"+(equ_cnt)+"'  value='0'  title='사용시간' numberOnlyDot />ex)5.6시간 > 5.6</td>";
				equHtml += "		</tr>";
				equHtml += "		<tr>";
				equHtml += "			<th scope='col'><font color='red'>*</font>예비실험등 가동시간(B)</th>";
				equHtml += "			<td colspan='3'><input type='text'  class='inp_txt useTime"+(equ_cnt)+"' name='useTimeB' id='useTimeB"+(equ_cnt)+"'  value='0'  title='사용시간' numberOnlyDot />ex)5.6시간 > 5.6</td>";
				equHtml += "		</tr>";
				equHtml += "		<tr>";
				equHtml += "			<th scope='col'><font color='red'>*</font>장비실질가동시간(C)</th>";
				equHtml += "			<td colspan='3'><input type='text'  class='inp_txt useTime"+(equ_cnt)+"' name='useTimeC' id='useTimeC"+(equ_cnt)+"'  value='0'  title='사용시간' numberOnlyDot />ex)5.6시간 > 5.6</td>";
				equHtml += "		</tr>";
				equHtml += "		<tr>";
				equHtml += "			<th scope='col'><font color='red'>*</font>장비가동시간</th>";
				equHtml += "			<td colspan='3'><input type='text'  class='inp_txt' name='useTime' id='useTime"+(equ_cnt)+"'  value='0'  title='사용시간' readonly />ex)5.6시간 > 5.6</td>";
				equHtml += "		</tr>";

				equHtml += "		<tr>";
				equHtml += "			<th scope='col'><font color='red'>*</font> 시료예약정보</th>";
				equHtml += "			<td id='sampleBox"+(equ_cnt)+"' colspan='3'>";
				equHtml += "				<div id='sampleItem"+(equ_cnt)+"_1' >";
// 				equHtml += "					<input type='hidden' name='sampleCnt' id='sampleCnt"+(equ_cnt)+"' value=''/>";
				equHtml += "					<label>1. 시료명 : </label><input type='text' class='inp_txt' name='sampleNm"+(equ_cnt)+"' id='sampleNm"+(equ_cnt)+"_1' value='' size='30' />";
				equHtml += "					&nbsp;<label>1. 시료수 : </label><input type='text' class='inp_txt' name='sampleNo"+(equ_cnt)+"' id='sampleNo"+(equ_cnt)+"_1' value='' size='10' />";
				equHtml += "					<button class='btn_inp_y_01' type='button' style='min-width:26px;' onclick='sampleBox(\"p\","+(equ_cnt)+");' title='시료항목 추가'>+</button>";
				equHtml += "					<button class='btn_inp_y_01' type='button' style='min-width:26px;' onclick='sampleBox(\"m\","+(equ_cnt)+");' title='시료항목 감소'>-</button>";
				equHtml += "				</div>";
				equHtml += "			</td>";
				equHtml += "		</tr>";

				equHtml += "	</tbody>";
				equHtml += "</table></div>";

				$( '#equBox' ).append(equHtml);
				sample_cnt[equ_cnt-1] = 1;

				$('.useTime'+(equ_cnt)).blur(function() {
					var useTimeA = parseFloat($('#useTimeA'+(equ_cnt)).val());
					var useTimeB = parseFloat($('#useTimeB'+(equ_cnt)).val());
					var useTimeC = parseFloat($('#useTimeC'+(equ_cnt)).val());
					var useTime = useTimeA+useTimeB+useTimeC;
					$('#useTime'+(equ_cnt)).val(useTime.toFixed(1))
				});

			}else{
				alert("최대 30개의 장비를 선택 할 수 있습니다.");
			}
		}else{
			if( equ_cnt > 1){
				$( '#equItem'+equ_cnt ).remove();
				sample_cnt[equ_cnt-1] = 1;
				equ_cnt--;
			}else{
				alert("최소 1개의 장비를 선택 하셔야 됩니다.");
			}
		}
	};

	//시료 추가, 삭제버튼 클릭시
	var sample_cnt = new Array();
	sample_cnt[0] = 1;

	function sampleBox( state, equcnt ){
		if( state == 'p' ){
			if( sample_cnt[equcnt-1] < 10){
			sample_cnt[equcnt-1]++;
				var sampleHtml = "<div id='sampleItem"+ equcnt + "_" + sample_cnt[equcnt-1] +"' style='margin-top:5px;'>";
				sampleHtml += "<label>" + sample_cnt[equcnt-1] +". 시료명 : </label><input type='text' class='inp_txt' name='sampleNm"+(equcnt)+"' id='sampleNm"+(equcnt)+"_"+(sample_cnt[equcnt-1])+"' value='' size='30'/>";
				sampleHtml += "&nbsp;&nbsp;<label>" + sample_cnt[equcnt-1] +". 시료수 : </label><input type='text' class='inp_txt' name='sampleNo"+(equcnt)+"' id='sampleNo"+(equcnt)+"_"+(sample_cnt[equcnt-1])+"' value='' size='10'/>";
				sampleHtml += "</div>";
				$( '#sampleBox' + equcnt).append(sampleHtml);
			}else{
				alert("최대 10개의 시료 정보를 입력하실수 있습니다..");
			}
		}else{
			if( sample_cnt[equcnt-1] > 1){
				$( '#sampleItem' + equcnt + "_" +sample_cnt[equcnt-1] ).remove();
				sample_cnt[equcnt-1]--;
			}else{
				alert("최소 1개의 시료 정보는 입력하셔야 됩니다.");
			}
		}
	};

	var inspec_cnt = 1;
	function inspecBox ( state){
		if( state == 'p' ){
			if( inspec_cnt < 30){
				inspec_cnt++;

				var sampleHtml = "<div id='inspec"+inspec_cnt + "' style='margin-top:5px;' >";
				sampleHtml += "	<label>시험검사항목 "+inspec_cnt + " : </label><input type='text' class='inp_txt' name='inspecNm' id='inspecNm"+(inspec_cnt)+"' value='' size='30'/>";
				sampleHtml += "	&nbsp;<input type='text' class='inp_txt' name='inspecFee' id='inspecFee"+(inspec_cnt)+"' value='' size='10' /> 원";
				sampleHtml += "</div>";

				$( '#inspecBox').append(sampleHtml);
			}else{
				alert("최대 30개의 시험검사항목을 입력하실수 있습니다..");
			}
		}else{
			if( inspec_cnt > 1){
				$( '#inspec' + inspec_cnt ).remove();
				inspec_cnt--;
			}else{
				alert("최소 1개의 시험검사항목은 입력하셔야 됩니다.");
			}
		}
	};
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

	var arrfileCnt = new Array();
	arrfileCnt['operLegal'] = 2;

	function addRowFile(fileGrpnm){
		if(arrfileCnt[fileGrpnm] < 11){
			var fileHtml = "<div>";
			fileHtml += "<input type='file' class='inp_txt' name='"+fileGrpnm+"File" + +arrfileCnt[fileGrpnm]+"'  id='"+fileGrpnm+"File" +arrfileCnt[fileGrpnm]+"' title='파일첨부' onchange='getFileExtCkCheck(\"" + fileGrpnm + "File" +arrfileCnt[fileGrpnm] + "\",\"gAll\",50)' />";
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
</script>
	  <form name="fwrite" id="fwrite" action="./equOperLegalProc.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
	  	<input type="hidden" name="startTime" id="startTime"  value="" />
	  	<input type="hidden" name="endTime" id="endTime"  value="" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />


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
						<input type="hidden" name="userIdx" id="userIdx" />
						<input type="hidden" name="userNm" id="userNm" />
						<span id="userNmText"></span>
						<input type="button" id="searchUser" class="btn_inp_b_01" onclick="popupWindow('userPop','')" value="사용자검색" />
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 기업/기관명</th>
					<td>
						<input type="hidden" name="corpNm" id="corpNm" />
						<span id="corpNmText"></span>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 대표자명</th>
					<td>
						<input type="hidden" class="inp_txt" name="corpResponsibleUser" id="corpResponsibleUser" value="" size="30"/>
						<span id="ornerNmText"></span>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 사업자등록번호</th>
					<td>
						<span id="corpNoText"></span>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 소속부서/센터</th>
					<td>
						<span id="deptNmText"></span>
						<input type="hidden" class="inp_txt" name="deptNm" id="deptNm" value="" size="50" readonly = "readonly" />
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 신청자 직위</th>
					<td>
						<span id="corpPositionText"></span>
						<input type="hidden" class="inp_txt" name="corpPosition" id="corpPosition" value="" size="30" readonly = "readonly" />
					</td>
				</tr>

				<tr>
					<th scope="col"><font color="red">*</font> 전화번호</th>
					<td>
						<input type="text" class="inp_txt" name="phone" id="phone" value="" size="12"/>
						* ex) 061-1234-4567
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 휴대전화</th>
					<td>
						<span id="cpNoText"></span>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 이메일</th>
					<td>
						<span id="emailText"></span>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 주소</th>
					<td>
						<input type="text" class="inp_txt" style="width:50px;" name="zipCode" maxlength="10" value="" id="zipCode"  title="신청자주소" readonly = "readonly" />
						<input type="text" class="inp_txt" style="width:250px;" name="addr1" maxlength="100" value="" id="addr1"  title="신청자주소" readonly="readonly"/>
						<input type="button" id = "deptPostButton" value="찾아보기" class="btn_inp_b_01"  onclick = "orgPost()" />
						<br/>
						<input type="text" class="inp_txt" style="width:400px;margin-top:5px;" name="addr2" maxlength="100" value="" id="addr2"  title="신청자주소" />
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 구분</th>
					<td>
						<input type="hidden" id="userType" name="userType" value="" />
						<input type="radio" id="userType1" name="userTypeCheck" value="A" /><label for="userType1">사업자</label>&nbsp;&nbsp;&nbsp;
						<input type="radio" id="userType2" name="userTypeCheck" value="B" /><label for="userType2">비사업자</label>
					</td>
				</tr>

			</table>

			<div style="margin:10px"><h3><b>[장비 운영일지]</b></h3></div>

			<table class="skin_basic_write">
				<colgroup>
					<col style="width: 20%;" />
					<col style="width: 80%;" />
				</colgroup>

				<tr>
					<th scope="col"><font color="red">*</font> 사용구분</th>
					<td scope="col" colspan="3">
						<select name="useMean" id="useMean1" class="select" >
							<option value="1">분석시험의뢰</option>
							<option value="2">이용자직접사용</option>
							<option value="3">야간및휴일사용</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 법정검사명</th>
					<td>
						<input type="text" class="inp_txt" name="legalNm" id="legalNm" value="" style="width:100%;"/>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 처리요청기간</th>
					<td colspan="3">
						<input type="text"  class="inp_txt" name="reqStartDate" id="reqStartDate" title="시작날짜" readonly="readonly" />
						 ~
						<input type="text"  class="inp_txt" name="reqEndDate" id="reqEndDate" title="종료날짜" readonly="readonly" />
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 장비가동기간</th>
					<td colspan="3">
						<input type="text"  class="inp_txt" name="equStartDate" id="equStartDate" title="시작날짜" readonly="readonly" />
						 ~
						<input type="text"  class="inp_txt" name="equEndDate" id="equEndDate" title="종료날짜" readonly="readonly" />
					</td>
				</tr>
				<tr>
<!-- 					<th scope="col"><font color="red">*</font> 장비명</th> -->
					<td colspan="4" style="padding: 15px 0px 0px 0px;">
						<div id="equBox">
							<div id="equItem1">
								<div style="margin:0 10px 10px 10px"><h3><b>[장비 1]</b></h3></div>
								<table class="skin_basic_write">
									<!-- colgroup s -->
									<colgroup>
										<col style="width: 25%;" />
										<col style="width: 25%;" />
										<col style="width: 25%;" />
										<col style="width: 25%;" />
									</colgroup>
									<!-- colgroup e -->
									<tbody>
										<tr>
											<th colspan="4">장비 정보 <input type="button" id="searchEqu1" class="btn_inp_b_01" onclick="popupWindow('equPop','1')" value="장비검색" /></th>
										</tr>
										<tr>
											<th scope="col">장비명</th>
											<td scope="col" colspan="3">
												<input type="hidden" name="rndEquIdx" id="rndEquIdx1" />
												<span id="eqNm1"></span>
											</td>
										</tr>
										<tr>
											<th scope="col">등록번호</th>
											<td scope="col">
												JEINET 등록번호 : <span id="jeinetNo1"></span>
											</td>
											<td scope="col">
												Zeus 등록번호 : <span id="ntisNo1"></span>
											</td>
											<td scope="col">
												e-Tube 등록번호 : <span id="etubeNo1"></span>
											</td>
										</tr>
										<tr>
											<th scope="col">보유기관</th>
											<td scope="col" colspan="3">
												<span id="orgName1"></span>
											</td>
										</tr>

										<tr>
											<th colspan="4">담당자 정보 <input type="button" id="searchUser1" class="btn_inp_b_01" onclick="popupWindow('subUserPop', '1')" value="담당자 검색"></th>
										</tr>
										<tr>
											<th scope="col">기관</th>
											<td scope="col"><input type="text" class="inp_txt" id="equUserOrg1" name="equUserOrg" value="" readonly="readonly"/></td>
											<th scope="col">부서</th>
											<td scope="col"><input type="text" class="inp_txt" id="equUserDept1" name="equUserDept" value="" readonly="readonly"/></td>
										</tr>
										<tr>
											<th scope="col">담당자</th>
											<td scope="col"><input type="text" class="inp_txt" id="equUserName1" name="equUserName" value="" readonly="readonly"/></td>
											<th scope="col">직위</th>
											<td scope="col"><input type="text" class="inp_txt" id="equUserPosition1" name="equUserPosition" value="" readonly="readonly"/></td>
										</tr>
										<tr>
											<th scope="col">전화번호</th>
											<td scope="col"><input type="text" class="inp_txt" id="equUserPhone1" name="equUserPhone" value="" readonly="readonly"/></td>
											<th scope="col">이메일</th>
											<td scope="col"><input type="text" class="inp_txt" id="equUserEmail1" name="equUserEmail" value="" readonly="readonly"/></td>
										</tr>

										<tr>
											<th colspan="4">장비 사용 정보</th>
										</tr>
										<tr>
											<th scope="col"><font color="red">*</font> 장비보조가동시간(A)</th>
											<td colspan="3"><input type="text"  class="inp_txt useTime1" name="useTimeA" id="useTimeA1"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
										</tr>
										<tr>
											<th scope="col"><font color="red">*</font> 예비실험등 가동시간(B)</th>
											<td colspan="3"><input type="text"  class="inp_txt useTime1" name="useTimeB" id="useTimeB1"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
										</tr>
										<tr>
											<th scope="col"><font color="red">*</font> 장비실질가동시간(C)</th>
											<td colspan="3"><input type="text"  class="inp_txt useTime1" name="useTimeC" id="useTimeC1"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
										</tr>
										<tr>
											<th scope="col"><font color="red">*</font> 장비가동시간</th>
											<td colspan="3"><input type="text"  class="inp_txt" name="useTime" id="useTime1"  value="0"  title="사용시간" readonly />ex)5.6시간 > 5.6</td>
										</tr>
										<tr>
											<th scope="col"><font color="red">*</font> 시료처리정보</th>
											<td id="sampleBox1" colspan="3">
<!-- 												<input type="hidden" name="sampleCnt" id="sampleCnt1" value=""/> -->
												<div id="sampleItem1_1" >
													<label>1. 시료명 : </label><input type="text" class="inp_txt" name="sampleNm1" id="sampleNm1_1" value="" size="30" />
													&nbsp;<label>1. 시료수 : </label><input type="text" class="inp_txt" name="sampleNo1" id="sampleNo1_1" value="" size="10" />
													<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('p',1);" title="시료항목 추가">+</button>
													<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('m',1);" title="시료항목 감소">-</button>
												</div>
											</td>
										</tr>
									</tbody>
								</table>

							</div>
						</div>
						<div class="btn_box" style="margin-bottom:10px;">
							<div class="btn_right_box" >
								<button class="btn_inp_y_01" type="button" onclick="equBox('p');" title="장비 추가">장비 추가</button>
								<button class="btn_inp_y_01" type="button" onclick="equBox('m');" title="장비 제거">장비 제거</button>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="col"><font color="red">*</font> 장비수수료(VAT제외)</th>
					<td colspan="3">
						<table class="skin_basic_write" style="margin-top:0px;margin-bottom:0px;">
							<colgroup>
								<col style="width: 25%;" />
								<col style="width: 75%;" />
							</colgroup>
							<tbody>
								<tr>
									<th><font color="red">*</font> 시험검사항목</th>
									<td id="inspecBox">
										<div id="inspec1" >
											<label>시험검사항목 1 : </label><input type="text" class="inp_txt" name="inspecNm" id="inspecNm1" value="" size="30" />
											&nbsp;<input type="text" class="inp_txt" name="inspecFee" id="inspecFee1" value="" size="10" /> 원
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="inspecBox('p');" title="시료항목 추가">+</button>
											<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="inspecBox('m');" title="시료항목 감소">-</button>
										</div>
									</td>
								</tr>
								<tr>
									<th><font color="red">*</font> 세금계산서 등 증빙문서 등록</th>
									<td>
										<div style="display:inline-block;" id="operLegalfileGrpBox">
											<div>
												<input type="file" class='inp_txt' name="operLegalFile1"  id="operLegalFile1"  title="파일첨부" onchange="getFileExtCkCheck('operLegalFile1','gAll',50)" />
											</div>
										</div>

										<div style="display:inline-block;vertical-align:bottom;">
											<input class="btn_inp_y_01" type="button" value="+" style="min-width: 30px;" onclick="addRowFile('operLegal');" />
											<input class="btn_inp_y_01" type="button" value="-" style="min-width: 30px;" onclick="delRowFile('operLegal');" />
										</div>
									</td>
								</tr>
							</tbody>
						</table>
					</td>
				</tr>
				<tr>
					<th scope="col"><label for="useNote">장비운영내용</label></th>
					<td colspan="3">
						<textarea class="inp_txt" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"></textarea>
						<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
					</td>
				</tr>
			</table>

			<!-- bo_btn  -->
			<div class="btn_box">
				<div class="btn_right_box">
					<input type="button" class="btn_inp_b_01" value="등록완료" id="btn_submit" class="btn_submit" onclick="submitGo();" style="cursor: pointer;" />
					<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">취소</a>
				</div>
			</div>
			<!--// bo_btn -->
		</form>