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

	String m = util.getStr(request.getQueryString());
	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	LoginVO loginVO = request.getAttribute("loginVO") == null ? new LoginVO(): (LoginVO)request.getAttribute("loginVO");
	String mode = util.getStr(paramMap.get("mode"));
%>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript">
//<![CDATA[
var korPattern = /[가-힣]/;
var onlyKorPattern = /[^가-힣]/;
var engPattern = /[a-zA-Z]/;
var numPattern = /[\d]/;
var imgPattern = new Array("bmp","gif","jpg","jpeg","png");
var telPattern = /^\d{2,3}\-\d{3,4}\-\d{4}$/;
var emailPattern = /[\w]*@([0-9a-zA-Z][\-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9}/;

	//이용희망시간 달력
 	$(document).ready(function(){
		$('#userType1').attr('checked', 'checked');

		$(document).scroll(function(){
			$("input:text").blur();
		});

		datepicker_f();
	});

	function datepicker_f(){
		$( "input:text[name='useStDt']" ).datepicker({
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
			//minDate: 0,
			onClose: function( selectedDate ) {
				if(selectedDate != "" && selectedDate != null){
					$("#useEdDt"+$(this).attr('id').replace('useStDt','')).datepicker( "option", "minDate", selectedDate );
				}

			}
		});
		$( "input:text[name='useEdDt']" ).datepicker({
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
    		monthNamesShort : ['1','2','3','4','5','6','7','8','9','10','11','12']
			//minDate: 0
		});
	}

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

	function pageListGo(){
		$('#mode').val('list');
		$('#fwrite').submit();
	}


function reservationGo(){ //submit
		if($('#userIdx').val() == ''){
			alert("신청자를 선택해주세요");
			$('#searchUser').focus();
			return false;
		}
/*
		if($('#corpIdx').val() == ''){
			alert("소속기관을 선택해주세요");
			$('#searchUser').focus();
			return false;
		}
 */
 
 		/*
		if($('#deptNm').val() == ''){
			alert("소속부서/센터를 입력해주세요");
			$('#deptNm').focus();
			return false;
		}

		if($('#corpPosition').val() == ''){
			alert("신청자 직책를 입력해주세요");
			$('#corpPosition').focus();
			return false;
		}
		
		*/
		
		if($('#phone').val() == ''){
			alert("전화번호를 입력해 주세요");
			$('#phone').focus();
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
		
		/*
		if($('#corpResponsibleUser').val() == ''){
			alert("대표자를 입력해주세요");
			$('#corpResponsibleUser').focus();
			return false;
		}
		*/
		var userTypeCheck = $(":input:radio[name=userTypeCheck]:checked").val();
		$('#userType').val(userTypeCheck);

		for(var i=1; i < equ_cnt+1; i++){
			if($('#rndEquIdx'+i).val() == "" || $('#rndEquIdx'+i).val() == null){
				alert("이용희망 장비를 선택해주세요.");
				$('#searchEqu'+i).focus();
				return false;
			};

			if($('#useStDt'+i).val() == "" || $('#useStDt'+i).val() == null){
				alert("이용희망기간 시작일(년/월/일)을 입력해주세요.");
				$('#useStDt'+i).focus();
				return false;
			};

			if($('#useEdDt'+i).val() == "" || $('#useEdDt'+i).val() == null){
				alert("이용희망기간 종료일(년/월/일)을 입력해주세요.");
				$('#useEdDt'+i).focus();
				return false;
			};

			if($('#usePurpose'+i).val() == "" || $('#usePurpose'+i).val() == null){
				alert("이용목적을 입력해주세요.");
				$('#usePurpose'+i).focus();
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

		$('#mode').val('writeProc');
		$('#fwrite').submit();
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

		}
	}

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


	var equ_cnt = 1;
	function equBox( state ){
		if( state == 'p' ){
			if( equ_cnt < 10){
				equ_cnt++;
				var equHtml = "<table id='equItem"+(equ_cnt)+"' class='skin_basic_write'>";
				equHtml += "<colgroup>";
				equHtml += "	<col style='width: 20%;' />";
				equHtml += "	<col style='width: 26.6%;' />";
				equHtml += "	<col style='width: 26.6%;' />";
				equHtml += "	<col style='width: 26.6%;' />";
				equHtml += "</colgroup>";

				equHtml += "<tr>";
				equHtml += "	<th scope='col'>장비명</th>";
				equHtml += "	<td scope='col' colspan='3'>";
				equHtml += "		<input type='hidden' name='rndEquIdx' id='rndEquIdx"+(equ_cnt)+"' />";
				equHtml += "		<span id='eqNm"+(equ_cnt)+"'></span>";
				equHtml += "		<input type='button' id='searchEqu"+(equ_cnt)+"' class='btn_inp_b_01' onclick='popupWindow(\"equPop\",\""+(equ_cnt)+"\")' value='장비검색' />";
				equHtml += "	</td>";
				equHtml += "</tr>";


				equHtml += "<tr>";
				equHtml += "	<th scope='col'>등록번호</th>";
				equHtml += "	<td scope='col'>";
				equHtml += "		JEINET 등록번호 : <span id='jeinetNo"+(equ_cnt)+"'></span>";
				equHtml += "	</td>";
				equHtml += "	<td scope='col'>";
				equHtml += "		Zeus 등록번호 : <span id='ntisNo"+(equ_cnt)+"'></span>";
				equHtml += "	</td>";
				equHtml += "	<td scope='col'>";
				equHtml += "		i-Tube 등록번호 : <span id='etubeNo"+(equ_cnt)+"'></span>";
				equHtml += "	</td>";
				equHtml += "</tr>";
				equHtml += "<tr>";
				equHtml += "	<th scope='col'>보유기관</th>";
				equHtml += "	<td scope='col' colspan='3'>";
				equHtml += "		<span id='orgName"+(equ_cnt)+"'></span>";
				equHtml += "	</td>";
				equHtml += "</tr>";

				equHtml += "<tr>";
				equHtml += "	<th scope='col'><font color='red'>*</font> 이용희망기간</th>";
				equHtml += "	<td colspan='3'>";
				equHtml += "		<input type='text' class='inp_txt' name='useStDt' id='useStDt"+(equ_cnt)+"' value='' size='15' readonly='readonly' />";
				equHtml += "		~";
				equHtml += "		<input type='text' class='inp_txt' name='useEdDt' id='useEdDt"+(equ_cnt)+"' value='' size='15' readonly='readonly' />";
				equHtml += "		<br /><font color='red'>* 이용희망기간은 실제 이용기간과 다를수 있습니다. 담당자가 접수처리시 실제 이용기간을 확정하게 됩니다.</font>";
				equHtml += "	</td>";
				equHtml += "</tr>";
				equHtml += "<tr>";
				equHtml += "	<th scope='col'><font color='red'>*</font> 사용구분</th>";
				equHtml += "	<td colspan='3'><select name='useMean' id='useMean"+(equ_cnt)+"' class='select' >";
				equHtml += "			<option value='1'>분석시험의뢰</option>";
				equHtml += "			<option value='2'>이용자직접사용</option>";
				equHtml += "			<option value='3'>야간및휴일사용</option>";
				equHtml += "		</select></td>";
				equHtml += "</tr>";
				equHtml += "<tr>";
				equHtml += "	<th scope='col'><font color='red'>*</font> 이용목적</th>";
				equHtml += "	<td colspan='3'>";
				equHtml += "		<input type='text' class='inp_txt' name='usePurpose' id='usePurpose"+(equ_cnt)+"' value='' size='70'/>";
				equHtml += "	</td>";
				equHtml += "</tr>";
				equHtml += "<tr>";

				equHtml += "<tr>";
				equHtml += "	<th scope='col'><font color='red'>*</font> 시료예약정보</th>";
				equHtml += "	<td id='sampleBox"+(equ_cnt)+"' colspan='3'>";
				equHtml += "		<div id='sampleItem"+(equ_cnt)+"_1' >";
				equHtml += "			<label>1. 시료명 : </label><input type='text' class='inp_txt' name='sampleNm"+(equ_cnt)+"' id='sampleNm"+(equ_cnt)+"_1' value='' size='30' />";
				equHtml += "			&nbsp;<label>1. 시료수 : </label><input type='text' class='inp_txt' name='sampleNo"+(equ_cnt)+"' id='sampleNo"+(equ_cnt)+"_1' value='' size='10' />";
				equHtml += "			<button class='btn_inp_y_01' type='button' style='min-width:26px;' onclick='sampleBox(\"p\","+(equ_cnt)+");' title='시료항목 추가'>+</button>";
				equHtml += "			<button class='btn_inp_y_01' type='button' style='min-width:26px;' onclick='sampleBox(\"m\","+(equ_cnt)+");' title='시료항목 감소'>-</button>";
				equHtml += "		</div>";
				equHtml += "	</td>";
				equHtml += "</tr>";

				equHtml += "<tr>";
				equHtml += "	<th scope='col'>장비사용신청서 등록</th>";
				equHtml += "	<td scope='col' colspan='3'>";
				equHtml += "		<div style='display:inline-block;' id='offlineReservation"+(equ_cnt)+"fileGrpBox'>";
				equHtml += "			<div>";
				equHtml += "				<input type='file' class='inp_txt' name='offlineReservation"+(equ_cnt)+"File1'  id='offlineReservation"+(equ_cnt)+"File1' title='파일첨부' onchange='getFileExtCkCheck(\"offlineReservation"+(equ_cnt)+"File1\",\"gAll\",50)' />";
				equHtml += "			</div>";
				equHtml += "		</div>";

				equHtml += "		<div style='display:inline-block;vertical-align:bottom;'>";
				equHtml += "			<input class='btn_inp_y_01' type='button' value='+' style='min-width: 30px;' onclick=\"addRowFile('offlineReservation"+(equ_cnt)+"');\" />";
				equHtml += "			<input class='btn_inp_y_01' type='button' value='-' style='min-width: 30px;' onclick=\"delRowFile('offlineReservation"+(equ_cnt)+"');\" />";
				equHtml += "		</div>";
				equHtml += "	</td>";
				equHtml += "</tr>";

				equHtml += "<tr>";
				equHtml += "	<th scope='col'>특이사항</th>";
				equHtml += "	<td colspan='3'>";
				equHtml += "		<textarea class='inp_txt' id='contents"+(equ_cnt)+"' name='sampleMatter' rows='10' cols='100' style='width:100%; overflow: auto; resize:none;' ></textarea>";
				equHtml += "		<br /><font color='red'>* 시험항목 및 예상치, 분석조건/시료특성/분석방법/분석성분/사용용매/결과회신방법 등</font>";
				equHtml += "	</td>";
				equHtml += "</tr>";
				equHtml += "</table>";

				$( '#equBox' ).append(equHtml);

				arrfileCnt['offlineReservation'+(equ_cnt)] = 2;
				sample_cnt[equ_cnt-1] = 1;

			}else{
				alert("최대 10개의 장비를 예약할 수 있습니다.");
			}
		}else{
			if( equ_cnt > 1){
				$( '#equItem'+equ_cnt ).remove();
				sample_cnt[equ_cnt-1] = 1;
				equ_cnt--;
			}else{
				alert("최소 1개의 장비를 예약 하셔야 됩니다.");
			}
		}

		datepicker_f();

	};

	var arrfileCnt = new Array();
	arrfileCnt['offlineReservation1'] = 2;

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
	function contains(char1,char2) {
		if (char1.indexOf(char2) != -1){
			return true;
		} else {
			return false;
		}
	}
//]]>
</script>

	  <form name="fwrite" id="fwrite" action="/sys/sys_eq_reservation.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode %>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

		<div class="skin_bbs_write" style="margin-top:30px">
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
					<th scope="col">기업/기관명</th>
					<td>
						<input type="hidden" name="corpNm" id="corpNm" />
						<span id="corpNmText"></span>
					</td>
				</tr>
				<tr>
					<th scope="col">대표자명</th>
					<td>
						<input type="hidden" class="inp_txt" name="corpResponsibleUser" id="corpResponsibleUser" value="" size="30"/>
						<span id="ornerNmText"></span>
					</td>
				</tr>
				<tr>
					<th scope="col">사업자등록번호</th>
					<td>
						<span id="corpNoText"></span>
					</td>
				</tr>
				<tr>
					<th scope="col">소속부서/센터</th>
					<td>
						<span id="deptNmText"></span>
						<input type="hidden" class="inp_txt" name="deptNm" id="deptNm" value="" size="50" readonly = "readonly" />
					</td>
				</tr>
				<tr>
					<th scope="col">신청자 직위</th>
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
					<th scope="col">휴대전화</th>
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

			<div style="margin:10px; "><h3><b>[장비 예약 정보]</b></h3></div>

			<div id="equBox">
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
							<input type="hidden" name="rndEquIdx" id="rndEquIdx1" />
							<span id="eqNm1"></span>
							<input type="button" id="searchEqu1" class="btn_inp_b_01" onclick="popupWindow('equPop','1')" value="장비검색" />
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
							i-Tube 등록번호 : <span id="etubeNo1"></span>
						</td>
					</tr>
					<tr>
						<th scope="col">보유기관</th>
						<td scope="col" colspan="3">
							<span id="orgName1"></span>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> 이용희망기간</th>
						<td scope="col" colspan="3">
				 			<input type="text" class="inp_txt" name="useStDt" id="useStDt1" value="" size="15" readonly="readonly" />
						~
				 		<input type="text" class="inp_txt" name="useEdDt" id="useEdDt1" value="" size="15" readonly="readonly" />
						<br /><font color="red">* 이용희망기간은 실제 이용기간과 다를수 있습니다. 담당자가 접수처리시 실제 이용기간을 확정하게 됩니다.</font>
						</td>
					</tr>
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
						<th scope="col"><font color="red">*</font> 이용목적</th>
						<td scope="col" colspan="3">
							<input type="text" class="inp_txt" name="usePurpose" id="usePurpose1" value="" size="70"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> 시료예약정보</th>
						<td id="sampleBox1" colspan="3">
							<div id="sampleItem1_1" >
								<label>1. 시료명 : </label><input type="text" class="inp_txt" name="sampleNm1" id="sampleNm1_1" value="" size="30" />
								&nbsp;<label>1. 시료수 : </label><input type="text" class="inp_txt" name="sampleNo1" id="sampleNo1_1" value="" size="10" />
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('p',1);" title="시료항목 추가">+</button>
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="sampleBox('m',1);" title="시료항목 감소">-</button>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="col">장비사용신청서 등록</th>
						<td scope="col" colspan="3">
							<div style="display:inline-block;" id="offlineReservation1fileGrpBox">
								<div>
									<input type="file" class='inp_txt' name="offlineReservation1File1"  id="offlineReservation1File1"  title="파일첨부" onchange="getFileExtCkCheck('offlineReservation1File1','gAll',50)" />
								</div>
							</div>

							<div style="display:inline-block;vertical-align:bottom;">
								<input class="btn_inp_y_01" type="button" value="+" style="min-width: 30px;" onclick="addRowFile('offlineReservation1');" />
								<input class="btn_inp_y_01" type="button" value="-" style="min-width: 30px;" onclick="delRowFile('offlineReservation1');" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="col">특이사항</th>
						<td colspan="3">
							<textarea class="inp_txt" id="contents1" name="sampleMatter" rows="10" cols="100" style="width:100%; overflow: auto; resize:none;" ></textarea>
							<br /><font color='red'>* 시험항목 및 예상치, 분석조건/시료특성/분석방법/분석성분/사용용매/결과회신방법 등</font>
						</td>
					</tr>
				</table>
			</div>
			<div class="btn_box" style="margin-bottom:10px;">
				<div class="btn_right_box" >
					<button class="btn_inp_y_01" type="button" onclick="equBox('p');" title="장비 추가">장비 추가</button>
					<button class="btn_inp_y_01" type="button" onclick="equBox('m');" title="장비 제거">장비 제거</button>
				</div>
			</div>

	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_right_box">
		        	<!-- <input type="submit" class="btn_inp_b_01" value="등록" id="btn_submit"  class="btn_submit" style="cursor: pointer;" /> -->
		        	<button class="btn_inp_b_01" type="button" onclick="reservationGo()">이용승인</button>
		        	<button class="btn_inp_w_01" type="button" onclick="pageListGo()">취소</button>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>


