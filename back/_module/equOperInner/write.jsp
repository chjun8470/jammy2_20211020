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
<script type="text/javascript">

$(document).on("keyup",".numberOnly",function(){
	if (!(event.keyCode >=37 && event.keyCode<=40)) {
        var inputVal = $(this).val();
        $(this).val(inputVal.replace(/[^0-9;]/gi,''));
    }
});

$("input:text[numberOnlyDot]").on("keyup", function() {
    $(this).val($(this).val().replace(/^[^0-9]|[^0-9\\.]|[\.]+[^0-9]|[0-9].[0-9]+[\D]/g,""));
});

$(document).on("change","#orgSe",function(){
	var selectVal = $(this).val();
	
	var equUserOrg = $("#equUserOrg").val();
	var equUserDept = $("#equUserDept").val();
	
	if(selectVal == "01"){
		$("#orgNm").val(equUserOrg);
		$("#deptNm").val(equUserDept);		
	}else if(selectVal == "02"){
		$("#orgNm").val(equUserOrg);
		$("#deptNm").val("");	
	}else{
		$("#orgNm").val("");
		$("#deptNm").val("");	
	}
});



$(document).ready(function() {
	
	
	
	$(function() {
	    $("input:text").keydown(function(evt) {
	        if (evt.keyCode == 13)
	            return false;
	    });
	});

	$('.innerUseTime').blur(function() {
		var useTimeA = parseFloat($('#innerUseTimeA').val());
		var useTimeB = parseFloat($('#innerUseTimeB').val());
		var useTimeC = parseFloat($('#innerUseTimeC').val());
		var useTime = useTimeA+useTimeB+useTimeC;
		$('#innerUseTime').val(useTime.toFixed(1))
	});

	$("#innerStartDate, #innerEndDate").datepicker({
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

	$('#innerStartDate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#innerEndDate").datepicker( "option", "minDate", selectedDate );
    });

	$('#innerEndDate').datepicker("option", "onClose", function ( selectedDate ) {
        $("#innerStartDate").datepicker( "option", "maxDate", selectedDate );
    });

	$("#sampleCnt, #rentalFee").keyup(function(event){
        if (!(event.keyCode >=37 && event.keyCode<=40)) {
            var inputVal = $(this).val();
            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
        }
    });
});

	function submitGo(mode){
		var sampleCnt = $('#innerSampleBox > div').size();

		if($('#equUserIdx').val() == "" || $('#equUserIdx').val() == null){
			alert("담당자를 선택해주세요.");
			$('#searchUser').focus();
			return false;
		};

		if($('#equIdx').val() == "" || $('#equIdx').val() == null){
			alert("장비를 선택해주세요.");
			$('#searchEqu').focus();
			return false;
		};

		if($('#innerStartDate').val() == '' || $('#innerStartDate').val() == null){
			alert("장비가동 기간을 입력해주세요.");
			$('#innerStartDate').focus();
			return false;
		}

		if($('#innerEndDate').val() == '' || $('#innerEndDate').val() == null){
			alert("장비가동 기간을 입력해주세요.");
			$('#innerEndDate').focus();
			return false;
		}

		if($('#innerUseTimeA').val() == ''){
			alert("사용시간을 입력해주세요.");
			$('#innerUseTimeA').focus();
			return false;
		}
		if($('#innerUseTimeB').val() == ''){
			alert("사용시간을 입력해주세요.");
			$('#innerUseTimeB').focus();
			return false;
		}
		if($('#innerUseTimeC').val() == ''){
			alert("사용시간을 입력해주세요.");
			$('#innerUseTimeC').focus();
			return false;
		}
		if($('#innerUseTime').val() == ''){
			alert("사용시간을 입력해주세요.");
			$('#innerUseTime').focus();
			return false;
		}

		for(i=1; i < sampleCnt+1; i++){
			if(checkSpace('innerSampleNm'+i) == ''  || $('#innerSampleNm'+i).val() == null){
				alert("시료명을 입력해주세요.");
				$('#innerSampleNm'+i).focus();
				return false;
			}
			if(checkSpace('innerSampleNo'+i) == '' || $('#innerSampleNo'+i).val() == null){
				alert("시료수를 입력해주세요.");
				$('#innerSampleNo'+i).focus();
				return false;
			}else if(isNaN($('#innerSampleNo'+i).val())){
				alert("시료수는 숫자만 입력해주세요.");
				$('#innerSampleNo'+i).focus();
				return false;
			};
		}

		if($('#innerUseNote').val() == '' || $('#innerUseNote').val() == null){
			alert("장비운영 내용을 입력해주세요.");
			$('#useNote').focus();
			return false;
		}

		$('#fwrite').submit();
	}




	//시료 추가, 삭제버튼 클릭시
	function innerSampleBox( state ){
		var innerSample_cnt = $('#innerSampleBox > div').length;

		if(innerSample_cnt < 1){
			innerSample_cnt = 1;
		}
		if( state == 'p' ){
			if( innerSample_cnt < 10){
				innerSample_cnt++;
				var sampleHtml = "<div id='innerSampleItem"+(innerSample_cnt)+"' >";
				sampleHtml += "<label>"+(innerSample_cnt)+". 시료명 : </label><input type='text' class='inp_txt' name='innerSampleNm' id='innerSampleNm"+(innerSample_cnt)+"' value='' size='20'/>";
				sampleHtml += "&nbsp;&nbsp;<label>"+(innerSample_cnt)+". 시료수 : </label><input type='text' class='inp_txt numberOnly' name='innerSampleNo' id='innerSampleNo"+(innerSample_cnt)+"' value='' size='2'/>";
				sampleHtml += "</div>";
				$( '#innerSampleCnt').val(innerSample_cnt);
				$( '#innerSampleBox' ).append(sampleHtml);
			}else{
				alert("최대 10개의 시료 정보를 입력하실수 있습니다.");
			}
		}else{
			if( innerSample_cnt > 1){
				$( '#innerSampleItem'+innerSample_cnt ).remove();
				innerSample_cnt--;
				$( '#innerSampleCnt').val(innerSample_cnt);
			}else{
				alert("최소 1개의 시료 정보는 입력하셔야 됩니다.");
			}
		}
	};

  	function popupWindow(mode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/eqReservation.do?mode="+mode;
		var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,mode+"popup",popOption);
	}

  	function popupWindowTest(mode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/equOperInner.do?mode="+mode;
		var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,"",popOption);
	}

	function setPopup(obj){
		if(obj['pop_mode'] == "equ") {
			var ntisNo = obj['ntis_no'];
			if(obj['ntis_no'] == ""){
				ntisNo = "NTIS 미등록 장비"
			}

			var etubeNo = obj['etube_no'];
			if(obj['etube_no'] == ""){
				etubeNo = "e-Tube 미등록 장비"
			}

			$("#eqNm").text(obj['equ_nm']);
			$("#equIdx").val(obj['rnd_equ_idx']);

			$("#jeinetNo").text(obj['rnd_equ_idx']);
			$("#ntisNo").text(ntisNo);
			$("#etubeNo").text(etubeNo);
			$("#orgName").text(obj['org_nm']);
			
			$("#equUserIdx").val(obj['equ_user_idx']);
			$("#equUserOrg").val(obj['org_grp_nm']);
			$("#equUserDept").val(obj['org_sub_nm']);
			$("#equUserName").val(obj['psn_nm']);
			$("#equUserPosition").val(obj['oper_position']);
			$("#equUserPhone").val(obj['oper_tel']);
			$("#equUserEmail").val(obj['oper_email']);
			
		} else if(obj['pop_mode'] == "subUserPop") {
			$("#equUserIdx").val(obj['user_idx']);
			$("#equUserOrg").val(obj['org_grp_nm']);
			$("#equUserDept").val(obj['dept_nm']);
			$("#equUserName").val(obj['user_nm']);
			$("#equUserPosition").val(obj['position_nm']);
			$("#equUserPhone").val(obj['cp_no']);
			$("#equUserEmail").val(obj['email']);
			$("#orgNm").val(obj['org_grp_nm']);
			$("#deptNm").val(obj['dept_nm']);
			
		} else if(obj['pop_mode'] == "org") {
			$("#orgCd").val(obj['org_grp_cd']);
			$("#orgNm").val(obj['org_grp_nm']);
		}
	}

	//공백제거
	function checkSpace(id){
		var str = $('#'+id).val();
		if(str.search(/\s/) != -1){
			$('#'+id).val(str.trim());
			//$('#'+id).val(str.replace(/ /g, ""));
		}
		return $('#'+id).val();
	}

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


</script>
	  <form name="fwrite" id="fwrite" action="./equOperInnerProc.do" method="post" enctype="multipart/form-data" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
	  	<!-- <input type="hidden" name="startTime" id="startTime"  value="" />
	  	<input type="hidden" name="endTime" id="endTime"  value="" /> -->
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

			<h3>장비담당자 정보</h3>
				<table id="step1"  class="skin_basic_write">
			        <colgroup>
						<col style="width: 20%;" />
						<col style="width: 30%;" />
						<col style="width: 20%;" />
						<col style="width: 30%;" />
					</colgroup>
					<tbody>
						<tr>
							<!-- <th colspan="4">담당자 정보<input type="button" id="searchUser" class="btn_inp_b_01" onclick="popupWindow('subUserPop', 'inner')" value="담당자 검색"></th> -->
							<th colspan="4">담당자 정보<input type="button" id="searchUser" class="btn_inp_b_01" onclick="popupWindow('subUserPop')" value="담당자 검색"></th>
							<input type="hidden" class="inp_txt" name="equUserIdx" id="equUserIdx" />
						</tr>
						<tr>
							<th scope="col">기관</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserOrg" id="equUserOrg" readonly="readonly"/>
							</td>
							<th scope="col">부서</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserDept" id="equUserDept" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th scope="col">담당자</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserName" id="equUserName" readonly="readonly"/>
							</td>
							<th scope="col">직위</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserPosition" id="equUserPosition" readonly="readonly"/>
							</td>
						</tr>
						<tr>
							<th scope="col">전화번호</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserPhone" id="equUserPhone" readonly="readonly"/>
							</td>
							<th scope="col">이메일</th>
							<td scope="col">
								<input type="text" class="inp_txt" name="equUserEmail" id="equUserEmail" readonly="readonly"/>
							</td>
						</tr>
					</tbody>
				</table>

				<h3>장비 운영일지 작성</h3>
				<table class="skin_basic_write">
					<colgroup>
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
						<col style="width: 25%;" />
					</colgroup>
					<tr>
						<th scope="col">장비명</th>
						<td scope="col" colspan="3">
							<input type="hidden" name="equIdx" id="equIdx" />
							<span id="eqNm"></span>
							<!-- <input type="button" id="searchEqu1" class="btn_inp_b_01" onclick="popupWindow('equPop','1')" value="장비검색" /> -->
							<button type="button" class="btn_inp_b_01" id="searchEqu" onclick="popupWindow('equPop')">장비검색</button>
						</td>
					</tr>
					<tr>
						<th scope="col">등록번호</th>
						<td scope="col">
							JEINET 등록번호 : <span id="jeinetNo"></span>
						</td>
						<td scope="col">
							Zeus 등록번호 : <span id="ntisNo"></span>
						</td>
						<td scope="col">
							e-Tube 등록번호 : <span id="etubeNo"></span>
						</td>
					</tr>
					<tr>
						<th scope="col">보유기관</th>
						<td scope="col" colspan="3">
							<span id="orgName"></span>
						</td>
					</tr>
					<tr>
						<th scope="col">사용기관</th>
						<td colspan="3">
							<label for="orgSe">구분 : </label>
							<select name="orgSe" id="orgSe" class="select" >
								<option value="01">기관  내 동일부서</option>
								<option value="02">기관 내 타부서</option>
								<option value="03">외부기관</option>
							</select>
							<label for="orgNm">기관명 : </label><input type="hidden" name="orgCd" id="orgCd" /><input type="text" class="inp_txt" name="orgNm" id="orgNm" readonly="readonly"/>
							<button type="button" class="btn_inp_b_01" onclick="popupWindowTest('orgPop')">찾기</button>
							<label for="depNm">부서명 : </label><input type="text" class="inp_txt" name="deptNm" id="deptNm" />
						</td>
					</tr>
					<tr>
						<th scope="col">사용자</th>
						<td scope="col"><input type="text" class="inp_txt" name="userNm" id="userNm" /></td>
						<th scope="col">연락처</th>
						<td scope="col"><input type="text" class="inp_txt" name="phone" id="phone" /></td>
					</tr>
					<tr>
						<th scope="col"> 이용목적</th>
						<td scope="col" colspan="3">
							<input type="text" class="inp_txt" name="purpose" id="purpose" value="" size="70"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> 장비가동기간</th>
						<td colspan="3">
							<input type="text"  class="inp_txt" name="startDate" id="innerStartDate" value="" autocomplete="off" title="시작날짜"/>
							 ~
							<input type="text"  class="inp_txt" name="endDate" id="innerEndDate" value="" autocomplete="off" title="종료날짜"/>
						</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> 장비보조가동시간(A)</th>
						<td colspan="3"><input type="text"  class="inp_txt innerUseTime" name="useTimeA" id="innerUseTimeA"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> 예비실험등 가동시간(B)</th>
						<td colspan="3"><input type="text"  class="inp_txt innerUseTime" name="useTimeB" id="innerUseTimeB"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col"><font color="red">*</font> 장비실질가동시간(C)</th>
						<td colspan="3"><input type="text"  class="inp_txt innerUseTime" name="useTimeC" id="innerUseTimeC"  value="0"  title="사용시간" numberOnlyDot />ex)5.6시간 > 5.6</td>
					</tr>
					<tr>
						<th scope="col">장비가동시간</th>
						<td colspan="3"><input type="text"  class="inp_txt" name="useTime" id="innerUseTime"  value="0"  title="사용시간" readonly />ex)5.6시간 > 5.6</td>
					</tr>

					<tr>
						<th scope="col"><font color="red">*</font> 시료처리정보</th>
						<td id="innerSampleBox" colspan="3">
						<input type="hidden" name="innerSampleCnt" id="innerSampleCnt" value="1"/>
							<div id="sampleItem1" >
								<label>1. 시료명 : </label><input type="text" class="inp_txt" name="innerSampleNm" id="innerSampleNm1" value="" size="20" />
								&nbsp;<label>1. 시료수 : </label><input type="text" class="inp_txt numberOnly" name="innerSampleNo" id="innerSampleNo1" value="" size="2" />
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="innerSampleBox('p');" title="시료항목 추가">+</button>
								<button class="btn_inp_y_01" type="button" style="min-width:26px;" onclick="innerSampleBox('m');" title="시료항목 감소">-</button>
							</div>
						</td>
					</tr>
					<tr style="display: none;">
						<th scope="col">사용료(VAT 제외)</th>
						<td><input type="text" class="inp_txt" name="rentalFee" id="innerRentalFee" value="0" />원</td>
					</tr>
					<tr>
						<th scope="col"><label for="useNote"><font color="red">*</font> 장비운영내용</label></th>
						<td colspan="3">
							<textarea class="inp_txt" name="useNote" id="innerUseNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"></textarea>
							<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
						</td>
					</tr>
				</table>

	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_right_box">
		        	<input type="button" class="btn_inp_b_01" value="등록완료" id="btn_submit"  class="btn_submit" style="cursor: pointer;" onclick="submitGo()" />
		        	<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">취소</a>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>


