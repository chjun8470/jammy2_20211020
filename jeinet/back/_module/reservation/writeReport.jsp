<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@page import="org.springframework.ui.Model"%>
<%@ page import = "java.io.*,java.util.*,java.util.regex.*,java.text.*,java.net.*" %>
<%@page import="info.elsys.jnsp.util.ComUtil"%>
<%@page import="info.elsys.jnsp.comm.vo.StaticVO"%>

<!DOCTYPE html>
<html lang="ko" >
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<title>전남과학기술센터</title>

		<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_tpl.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/basic_grid.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board_3.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />

		<!-- <link rel="stylesheet" type="text/css" href="/css/cms/back/contents.css" /> -->

		<!-- <link rel="stylesheet" type="text/css" href="/css/cms/back/board.css" />
		<link rel="stylesheet" type="text/css" href="/css/cms/back/board_2.css" /> -->
		<link href="/css/cms/sub.css" media="all" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/js/cms/back/jquery-1.11.1.min.js"></script>
		<script type="text/javascript" src="/js/cms/back/func_sys.js"></script>

		<script type="text/javascript" src="/js/board.js"></script>
		<script type="text/javascript" src="/js/webeditor_nhn/js/HuskyEZCreator.js"></script>

		<!--그래프  -->
		<script src="https://code.highcharts.com/highcharts.js"></script>
		<script src="https://code.highcharts.com/highcharts-3d.js"></script>
		<script src="https://code.highcharts.com/modules/exporting.js"></script>

		<!-- 날짜 선택 위젯 jQuery datepicker S -->
		<!-- jQuery UI CSS파일 -->
		<link rel="stylesheet" type="text/css" href="/js/jquery-ui/jquery-ui.min.css" />
		<!-- jQuery UI 라이브러리 js파일 -->
		<script type="text/javascript" src="/js/jquery-ui/jquery-ui.min.js"></script>
		<!-- 날짜 선택 위젯 jQuery datepicker E -->

		<script src="/js/amcharts/amcharts.js" type="text/javascript"></script>
        <script src="/js/amcharts/serial.js" type="text/javascript"></script>
	</head>
<body>

<%
	String display = "main";
	request.setCharacterEncoding("utf-8");
	ComUtil util = new ComUtil();

	String myPage = util.getUrlPage(util.getStr(request.getRequestURI())).replaceAll(".jsp", ".do");

	HashMap<String, String> paramMap = request.getAttribute("paramMap") == null ? new HashMap(): (HashMap<String, String>)request.getAttribute("paramMap");
	HashMap<String, String> dataMap = request.getAttribute("dataMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("dataMap");
	HashMap<String, String> userMap = request.getAttribute("userMap") == null ? new HashMap<String, String>(): (HashMap<String, String>)request.getAttribute("userMap");
	StaticVO staticVO = request.getAttribute("staticVO") == null ? new StaticVO(): (StaticVO)request.getAttribute("staticVO");
	String mode = util.getStr(paramMap.get("mode"));
	System.out.println("mode :::::::::::::::::::" + mode);

%>
<script type="text/javascript">
	function submitGo(){

		if($('#eqNm').val() == ''){
			alert("장비를 선택 해주세요");
			return false;
		}
		if($('#equUserName').val() == ''){
			alert("책임자를 입력해주세요");
			$('#equUserName').focus();
			return false;
		}
		if($('#startDate').val() == '' || $('endDate').val() == ''){
			alert("사용일시를 입력해주세요");
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
			alert("사용내용을 입력해주세요");
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

		$('#startTime').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#endTime").datepicker( "option", "minDate", selectedDate );
	    });

		$('#endTime').datepicker("option", "onClose", function ( selectedDate ) {
	        $("#startTime").datepicker( "option", "maxDate", selectedDate );
	    });

		$("#sampleCnt, #rentalFee").keyup(function(event){
	        if (!(event.keyCode >=37 && event.keyCode<=40)) {
	            var inputVal = $(this).val();
	            $(this).val(inputVal.replace(/[^0-9;]/gi,''));
	        }
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

</script>
	  <form name="fwrite" id="fwrite" action="./eqReservationProc.do" method="post" enctype="multipart/form-data" onsubmit="return submitGo();" >
	  	<input type="hidden" name="mode" id="mode"  value="<%=mode%>" />
	  	<input type="hidden" name="reUrl" id="reUrl"  value="<%=myPage%>" />
		<input type="hidden" name="nowPage" id="nowPage" value="<%=staticVO.getNowPage() %>" />
		<input type="hidden" id = "equOrderIdx" name = "equOrderIdx" value = "<%=util.getStr(paramMap.get("equOrderIdx"))%>"/>

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
				<td scope="col"><input type="text" class="inp_text" name="eqNm" id="eqNm" value="<%=util.getStr(dataMap.get("KOR_NM")) %>" /></td>
				<th scope="col">고정자산번호</th>
				<td scope="col"><input type="text" class="inp_text" name="eqserial" id="eqserial" value="<%=util.getStr(dataMap.get("FIXED_ASET_NO")) %>" /></td>
			</tr>
			<tr>
				<th colspan="4">담당자 정보</th>
			</tr>
			<tr>
				<th scope="col">기관</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserOrg" id="equUserOrg" value="<%=util.getStr(dataMap.get("OWN_ORG_NM")) %>" readonly="readonly"/>
				</td>
				<th scope="col">부서</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserDept" id="equUserDept" value="<%=util.getStr(dataMap.get("OWN_ORG_SUB_NM")) %>" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th scope="col">담당자</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserName" id="equUserName" value="<%=util.getStr(dataMap.get("OPER_CHARGER")) %>" readonly="readonly"/>
				</td>
				<th scope="col">직위</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserPosition" id="equUserPosition" value="<%=util.getStr(dataMap.get("OPER_POSITION")) %>" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th scope="col">전화번호</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserPhone" id="equUserPhone" value="<%=util.getStr(dataMap.get("OPER_TEL")) %>" readonly="readonly"/>
				</td>
				<th scope="col">이메일</th>
				<td scope="col">
					<input type="text" class="inp_text" name="equUserEmail" id="equUserEmail" value="<%=util.getStr(dataMap.get("OPER_EMAIL")) %>" readonly="readonly"/>
				</td>
			</tr>
			<tr>
				<th colspan="4">사용정보</th>
			</tr>
			<tr>
				<th scope="col">사용일시</th>
				<td colspan="3">
					<input type="text"  class="inp_text" name="startDate" id="startDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ST_DT")))) { %> <%=util.getStr(dataMap.get("USE_ST_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ST_DT")) %> <% } %>" title="시작날짜"/>
					<select title="시작시간" name="startTime" id="startTime">
						<%for(int i = 0; i <= 23; i++) {
							if(i < 10) {%>
								<option value="0<%=i%>">0<%=i%></option>
							<%} else { %>
								<option vlaue="<%=i %>"><%=i%></option>
							<%} %>
						<% } %>
					</select> ~
					<input type="text"  class="inp_text" name="endDate" id="endDate" value="<%if("".equals(util.getStr(dataMap.get("REAL_USE_ED_DT")))) { %> <%=util.getStr(dataMap.get("USE_ED_DT")) %> <% }else{ %> <%=util.getStr(dataMap.get("REAL_USE_ED_DT")) %> <% } %>"  title="종료날짜"/>
					<select title="종료시간" name="endTime" id="endTime">
						<%for(int i = 0; i <= 23; i++) {
							if(i < 10) {%>
								<option value="0<%=i%>">0<%=i%></option>
							<%} else { %>
								<option vlaue="<%=i %>"><%=i%></option>
							<%} %>
						<% } %>
					</select>
				</td>
			</tr>
			<tr>
				<th scope="col">사용기관</th>
				<td colspan="3">
					<label for="orgSe">구분 : </label>
					<select name="orgSe" id="orgSe" >
						<option value="01" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기업")){ %>checked<%} %>>기관  내 동일부서</option>
						<option value="02>" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("기관/센터")){ %>checked<%} %>>기관 내 타부서</option>
						<option value="03" <%if(util.getStr(userMap.get("ORG_TYPE")).equals("")){ %>checked<%} %>>외부기관</option>
					</select>
					<label for="orgNm">기관명 : </label><input type="hidden" name="orgCd" id="orgCd" value="<%=util.getStr(userMap.get("ORG_GRP_CD")) %>" />
					<input type="text" name="orgNm" id="orgNm" readonly="readonly" value="<%=util.getStr(userMap.get("ORG_GRP_NM")) %>"/>
					<label for="depNm">부서명 : </label><input type="text" name="deptNm" id="deptNm"  value="<%=util.getStr(dataMap.get("DEPT_NM")) %>" />
				</td>
			</tr>
			<tr>
				<th scope="col">사용자</th>
				<td scope="col"><input type="text" name="userNm" id="userNm" value="<%=util.getStr(userMap.get("PSN_NM")) %>" /></td>
				<th scope="col">연락처</th>
				<td scope="col"><input type="text" name="phone" id="phone" value="<%=util.getStr(userMap.get("CP_NO")) %>"  /></td>
			</tr>
			<tr>
				<th scope="col">사용목적</th>
				<td colspan="3"><input type="text" name="purpose" id="purpose" value="<%=util.getStr(dataMap.get("USE_PURPOSE")) %>" /></td>
			</tr>
			<tr>
				<th scope="col">시료수</th>
				<td colspan="3"><input type="text" name="sampleCnt" id="sampleCnt" value="<%=util.getStr(dataMap.get("SAMPLE_NO")) %>"  />건</td>
			</tr>
			<tr>
				<th scope="col">사용료</th>
				<td>
					<input type="text" name="rentalFee" id="rentalFee" />원
				</td>
			</tr>
			<tr>
				<th scope="col"><label for="useNote">사용내용</label></th>
				<td colspan="3">
					<textarea class="inp_text" name="useNote" id="useNote" style="width:100%; height:200px; overflow: auto; resize:none;" onkeyup="bytecheck(this,'1000')"></textarea>
					<p id="text_count">(<strong id="byteInfo">0</strong> / 1000Byte)</p>
				</td>
			</tr>
			</table>


	        <!-- bo_btn  -->
	        <div class="btn_box">
	        	<div class="btn_left_box">
		        	<input type="submit" class="btn_inp_b_01" value="등록완료" id="btn_submit"  class="btn_submit" style="cursor: pointer;" />
		        	<a href="./<%=myPage%>" class="btn_inp_w_01" style="text-align: center;">취소</a>
	        	</div>
	        </div>
	        <!--// bo_btn -->

        	</div>
      </form>

</body>
</html>
