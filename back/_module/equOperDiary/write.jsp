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
	function submitGo(){

	if($('#eqNm').val() == ''){
		alert("장비를 선택 해주세요");
		return false;
	}
	if($('#equUserName').val() == ''){
		alert("담당자를 입력해주세요");
		$('#equUserName').focus();
		return false;
	}
	if($('#startDate').val() == '' || $('endDate').val() == ''){
		alert("사용기간를 입력해주세요");
		return false;
	}
	if($('#useTime').val() == ''){
		alert("사용시간을 선택해주세요");
		$('#useTime').focus();
		return false;
	}
	if($('#orgNm').val() == ''){
		alert("기관을 선택해주세요");
		return false;
	}
	if($('#userNm').val() == ''){
		alert("사용자를 입력해주세요");
		$('#userNm').focus();
		return false;
	}
	if($('#phone').val() == ''){
		alert("연락처를 입력해주세요");
		$('#phone').focus();
		return false;
	}
	if($('#purpose').val() == ''){
		alert("사용목적을 입력해주세요");
		$('#purpose').focus();
		return false;
	}
	if($('#useNote').val() == ''){
		alert("사용목적을 입력해주세요");
		$('#userNote').focus();
		return false;
	}
	if($('#sampleCnt').val() == ''){
		alert("시료수를 입력해주세요");
		$('#sampleCnt').focus();
		return false;
	}
	if($('#rentalFee').val() == ''){
		alert("사용료를 입력해주세요");
		$('#rentalFee').focus();
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

		$("#startDate, #endDate").datepicker({
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
    		maxDate:'+0d'
		});

		$('#startDate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#endDate").datepicker( "option", "minDate", selectedDate );
	    });

		$('#endDate').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#startDate").datepicker( "option", "maxDate", selectedDate );
	    });

		$("#sampleCnt, #rentalFee").keyup(function(event){
	        if (!(event.keyCode >=37 && event.keyCode<=40)) {
	            var inputVal = $(this).val();
	            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
	        }
	    });
	});

	function popupWindow(mode){
		var settings ='toolbar=0,directories=0,status=no,menubar=0,scrollbars=auto,resizable=no,height=400,width=300,left=0,top=0';
		var popUrl="/sys/equOperDiary.do?mode="+mode;
		var popOption="width=750, height=600, resizable=no, scrollbars=yes, status=no;";
		window.open(popUrl,"",popOption);

	}

	function setPopup(obj){
		if(obj['pop_mode'] == "equ") {
			$("#eqNm").val(obj['equ_nm']);
			$("#eqserial").val(obj['fixed_aset_no']);
			$("#equIdx").val(obj['rnd_equ_idx']);
			$("#equUserName").val(obj['psn_nm']);
		} else if(obj['pop_mode'] == "org") {
			$("#orgCd").val(obj['org_grp_cd']);
			$("#orgNm").val(obj['org_grp_nm']);
		}
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
	  <form name="fwrite" id="fwrite" action="./equOperDiaryProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
	  	<input type="hidden" name="startTime" id="startTime"  value="" />
	  	<input type="hidden" name="endTime" id="endTime"  value="" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />

		<div class="skin_bbs_write" style="margin-top:30px">
			<table class="skin_basic_write">

			<!-- colgroup s -->

			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 30%;" />
				<col style="width: 20%;" />
				<col style="width: 30%;" />
			</colgroup>

			<!-- colgroup e -->

			<tr>
				<th scope="col">연구시설장비</th>
				<td scope="col">
					<input type="hidden" name="equIdx" id="equIdx" />
					<input type="text" class="inp_txt" name="eqNm" id="eqNm" readonly="readonly"/>
					<button type="button" class="btn_inp_b_01" id="searchEqu" onclick="popupWindow('equPop')">장비검색</button>
				</td>
				<th scope="col"><label for="eqserial">고정자산번호</label></th>
				<td scope="col"><input type="text" class="inp_txt" name="eqserial" id="eqserial" readonly="readonly"/></td>
			</tr>
			<tr>
				<th colspan="4">담당자 정보</th>
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
			<tr>
				<th colspan="4">사용정보</th>
			</tr>
			<tr>
				<th scope="col">사용기간</th>
				<td colspan="3">
					<input type="text"  class="inp_txt" name="startDate" id="startDate" title="시작날짜"/>
					 ~
					<input type="text"  class="inp_txt" name="endDate" id="endDate" title="종료날짜"/>
				</td>
			</tr>
			<tr>
				<th scope="col">사용시간</th>
				<td colspan="3">
					<input type="text"  class="inp_txt" name="useTime" id="useTime" value="0" title="사용시간"/>ex) 5.6시간 > 5.6
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
					<button type="button" class="btn_inp_b_01" onclick="popupWindow('orgPop')">찾기</button>
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
				<th scope="col">사용목적</th>
				<td colspan="3"><input type="text" class="inp_txt" name="purpose" id="purpose" /></td>
			</tr>
			<tr>
				<th scope="col"><label for="useNote">사용내용</label></th>
				<td colspan="3">
<!-- 					<textarea class="inp_txt" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;"></textarea> -->
					<textarea class="inp_txt" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"></textarea>
					<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
				</td>
			</tr>
			<tr>
				<th scope="col">시료수</th>
				<td colspan="3"><input type="text" class="inp_txt" name="sampleCnt" id="sampleCnt" />건</td>
			</tr>
			<tr>
				<th scope="col">사용료</th>
				<td>
					<input type="text" name="rentalFee" class="inp_txt" id="rentalFee" />원
				</td>
			</tr>

			</table>


	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_right_box">
		        	<input type="submit" class="btn_inp_b_01" value="등록완료" id="btn_submit"  class="btn_submit" style="cursor: pointer;" />
		        	<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">취소</a>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>


